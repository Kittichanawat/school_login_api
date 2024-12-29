const express = require('express');
const { PrismaClient } = require('@prisma/client');
const jwt = require('jsonwebtoken');

const prisma = new PrismaClient();
const app = express.Router();

app.get('/roles', async (req, res) => {
    try {
        const roles = await prisma.schRoles.findMany({
            select: {
                role_id: true,
                role_name: true
            }
        });
        res.json({
            status: 'success',
            message: 'ดึงข้อมูล roles สำเร็จ',
            data: roles
        });
    } catch (error) {
        console.error('Error fetching roles:', error);
        res.status(500).json({
            status: 'error',
            message: 'เกิดข้อผิดพลาดในการดึงข้อมูล roles',
            error: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
});

app.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;

        console.log('Login request body:', req.body);

        if (!username || !password) {
            return res.status(400).json({
                status: 'error',
                message: 'กรุณากรอก username และ password'
            });
        }

        // 1. ตรวจสอบ username และ status
        const userAuth = await prisma.schLoginUsers.findFirst({
            where: { 
                OR: [
                    { user_uname: username },
                    { user_nat_id: username }
                ]
            },
            select: {
                user_id: true,
                user_uname: true,
                user_password: true,
                login_status: true
            }
        });

        // 2. ตรวจสอบการมีอยู่ของผู้ใช้และรหัสผ่าน
        if (!userAuth || userAuth.user_password !== password || userAuth.user_uname !== username) {
            return res.status(401).json({
                status: 'error',
                message: 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง'
            });
        }

        // 3. ตรวจสอบสถานะการใช้งาน
        if (userAuth.login_status === 0) {
            return res.status(403).json({
                status: 'error',
                message: 'บัญชีถูกระงับการใช้งาน'
            });
        }

        // 4. ดึงข้อมูลพื้นฐานของผู้ใช้
        const user = await prisma.schLoginUsers.findUnique({
            where: { user_id: userAuth.user_id },
            select: {
                user_id: true,
                user_uname: true,
                user_nat_id: true,
                user_fname: true,
                user_lname: true,
                user_email: true,
                user_phone: true
            }
        });

        // 5. ดึงข้อมูล roles แยกทีละส่วน
        const [admins, teachers, executives, registrars, parents, students] = await Promise.all([
            prisma.schAdmins.findMany({
                where: { user_id: userAuth.user_id, adm_status: 1 }
            }),
            prisma.schTeachers.findMany({
                where: { user_id: userAuth.user_id, tea_status: 1 },
                include: {
                    SchTeacherClass: {
                        where: { term: { term_status: 'active' } },
                        include: { class: true, term: true }
                    }
                }
            }),
            prisma.schExecutives.findMany({
                where: { user_id: userAuth.user_id, exec_status: 1 }
            }),
            prisma.schRegistrars.findMany({
                where: { user_id: userAuth.user_id, reg_status: 1 }
            }),
            prisma.schParents.findMany({
                where: { user_id: userAuth.user_id, par_status: 1 },
                include: {
                    SchParentStudent: {
                        include: {
                            student: {
                                include: {
                                    user: true
                                }
                            }
                        }
                    }
                }
            }),
            prisma.schStudents.findMany({
                where: { 
                    user_id: userAuth.user_id, 
                    status: 1 
                },
                include: {
                    class: {
                        include: {
                            SchTeacherClass: {
                                where: {
                                    term: {
                                        term_status: 'active'
                                    }
                                },
                                include: {
                                    teacher: {
                                        include: {
                                            user: {
                                                select: {
                                                    user_fname: true,
                                                    user_lname: true
                                                }
                                            }
                                        }
                                    },
                                    term: {
                                        select: {
                                            term_id: true,
                                            term_name: true,
                                            academic_year: true,
                                            term_status: true
                                        }
                                    }
                                }
                            }
                        }
                    },
                    SchParentStudent: {
                        include: {
                            parent: {
                                include: {
                                    user: {
                                        select: {
                                            user_fname: true,
                                            user_lname: true
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            })
        ]);

        // 6. สร้าง roles array
        const roles = [];
        if (admins.length > 0) roles.push('admin');
        if (teachers.length > 0) roles.push('teacher');
        if (executives.length > 0) roles.push('executive');
        if (registrars.length > 0) roles.push('registrar');
        if (parents.length > 0) roles.push('parent');
        if (students.length > 0) roles.push('student');

        if (roles.length === 0) {
            return res.status(403).json({
                status: 'error',
                message: 'บัญชีผู้ใช้นี้ไม่มีสิทธิใช้งาน'
            });
        }

        // 7. สร้าง userProfile
        let userProfile = {
            ...user,
            roles,
            profiles: {
                admin: admins[0] || null,
                teacher: teachers.length > 0 ? {
                    ...teachers[0],
                    teacher_classes: teachers[0].SchTeacherClass
                } : null,
                executive: executives[0] || null,
                registrar: registrars[0] || null,
                parent: parents.length > 0 ? {
                    ...parents[0],
                    students: parents[0].SchParentStudent.map(ps => ({
                        student_name: `${ps.student.user.user_fname} ${ps.student.user.user_lname}`
                    }))
                } : null,
                student: students.length > 0 ? {
                    ...students[0],
                    class: students[0].class,
                    homeroom_teachers: students[0].class?.SchTeacherClass?.map(tc => ({
                        teacher_name: tc.teacher?.user ? 
                            `${tc.teacher.user.user_fname} ${tc.teacher.user.user_lname}` : 
                            'ไม่ระบุ',
                        term: {
                            term_name: tc.term.term_name,
                            academic_year: tc.term.academic_year
                        }
                    })) || [],
                    parents: students[0].SchParentStudent?.map(ps => ({
                        parent_name: ps?.parent?.user ?
                            `${ps.parent.user.user_fname} ${ps.parent.user.user_lname}` :
                            'ไม่ระบุ'
                    })) || []
                } : null
            }
        };

        // 8. สร้าง token
        const token = jwt.sign(
            {
                user_id: user.user_id,
                user_uname: user.user_uname,
                roles: roles
            },
            process.env.JWT_SECRET,
            { expiresIn: '1d' }
        );

        res.json({
            status: 'success',
            message: 'เข้าสู่ระบบสำเร็จ',
            data: { user: userProfile, token }
        });

    } catch (error) {
        console.error('Login error:', error);
        res.status(500).json({
            status: 'error',
            message: 'เกิดข้อผิดพลาดในการเข้าสู่ระบบ',
            error: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
});

module.exports = app;
