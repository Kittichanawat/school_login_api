const express = require('express');
const { PrismaClient } = require('@prisma/client');
const jwt = require('jsonwebtoken');

const prisma = new PrismaClient();
const router = express.Router();

router.get('/roles', async (req, res) => {
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

router.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;

        console.log('Login attempt for username:', username);

        if (!username || !password) {
            return res.status(400).json({
                status: 'error',
                message: 'กรุณากรอก username และ password'
            });
        }

        const userStatus = await prisma.schLoginUsers.findUnique({
            where: {
                username: username,
            },
            select: {
                login_status: true,
                password: true
            }
        });

        if (!userStatus || userStatus.password !== password) {
            return res.status(401).json({
                status: 'error',
                message: 'ชื่อผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง'
            });
        }

        if (userStatus.login_status === 0) {
            return res.status(403).json({
                status: 'error',
                message: 'บัญชีถูกระงับการใช้งาน'
            });
        }

        const userBasicInfo = await prisma.schLoginUsers.findUnique({
            where: { username }
        });

        if (userBasicInfo) {
            const teacherInfo = await prisma.schTeachers.findFirst({
                where: {
                    user_id: userBasicInfo.user_id,
                    tea_status: 1
                },
                include: {
                    SchTeacherClass: {
                        where: {
                            term: {
                                term_status: 'active'
                            }
                        }
                    }
                }
            });
        }

        const user = await prisma.schLoginUsers.findUnique({
            where: {
                username: username,
                login_status: 1
            },
            include: {
                SchAdmins: {
                    where: {
                        adm_status: 1,
                        NOT: {
                            user_id: null
                        }
                    }
                },
                SchTeachers: {
                    where: {
                        tea_status: 1,
                        NOT: {
                            user_id: null
                        }
                    },
                    include: {
                        SchTeacherClass: {
                            where: {
                                term: {
                                    term_status: 'active'
                                }
                            },
                            include: {
                                class: {
                                    select: {
                                        class_id: true,
                                        class_name: true,
                                        class_status: true
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
                SchExecutives: {
                    where: {
                        exec_status: 1,
                        NOT: {
                            user_id: null
                        }
                    }
                },
                SchRegistrars: {
                    where: {
                        reg_status: 1,
                        NOT: {
                            user_id: null
                        }
                    }
                },
                SchParents: {
                    where: {
                        par_status: 1,
                        NOT: {
                            user_id: null
                        }
                    },
                    include: {
                        SchParentStudent: {
                            include: {
                                student: {
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
                },
                SchStudents: {
                    where: {
                        status: 1,
                        NOT: {
                            user_id: null
                        }
                    },
                    include: {
                        class: {
                            select: {
                                class_id: true,
                                class_name: true,
                                class_status: true,
                                SchTeacherClass: {
                                    where: {
                                        term: {
                                            term_status: 'active'
                                        }
                                    },
                                    include: {
                                        teacher: {
                                            select: {
                                                tea_id: true,
                                                user: {
                                                    select: {
                                                        user_fname: true,
                                                        user_lname: true
                                                    }
                                                }
                                            }
                                        },
                                        term: true
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
                }
            }
        });

        const roles = [];
        if (user.SchAdmins.length > 0) roles.push('admin');
        if (user.SchTeachers.length > 0) roles.push('teacher');
        if (user.SchExecutives.length > 0) roles.push('executive');
        if (user.SchRegistrars.length > 0) roles.push('registrar');
        if (user.SchParents.length > 0) roles.push('parent');
        if (user.SchStudents.length > 0) roles.push('student');

        if (roles.length === 0) {
            return res.status(403).json({
                status: 'error',
                message: 'บัญชีผู้ใช้นี้ไม่มีสิทธิใช้งาน'
            });
        }

        let userProfile = {
            user_id: user.user_id,
            username: user.username,
            user_fname: user.user_fname,
            user_lname: user.user_lname,
            roles: roles,
            profiles: {
                admin: user?.SchAdmins?.length > 0 ? {
                    adm_id: user.SchAdmins[0]?.adm_id,
                    adm_status: user.SchAdmins[0]?.adm_status
                } : null,
                teacher: user?.SchTeachers?.length > 0 ? {
                    tea_id: user.SchTeachers[0]?.tea_id,
                    tea_status: user.SchTeachers[0]?.tea_status,
                    teacher_classes: user.SchTeachers[0]?.SchTeacherClass || []
                } : null,
                executive: user.SchExecutives.length > 0 ? user.SchExecutives[0] : null,
                registrar: user.SchRegistrars.length > 0 ? user.SchRegistrars[0] : null,
                parent: user?.SchParents?.length > 0 ? {
                    par_id: user.SchParents[0].par_id,
                    par_status: user.SchParents[0].par_status,
                    students: user.SchParents[0].SchParentStudent?.map(ps => ({
                        student_name: ps?.student?.user ? 
                            `${ps.student.user.user_fname || ''} ${ps.student.user.user_lname || ''}` : 
                            'ไม่ระบุ'
                    })) || []
                } : null,
                student: user?.SchStudents?.length > 0 ? {
                    ...user.SchStudents[0],
                    class: user.SchStudents[0]?.class ?? null,
                    parents: user.SchStudents[0]?.SchParentStudent?.map(ps => ({
                        parent_name: ps?.parent?.user ?
                            `${ps.parent.user.user_fname || ''} ${ps.parent.user.user_lname || ''}` :
                            'ไม่ระบุ'
                    })) || []
                } : null
            }
        };

        const token = jwt.sign(
            {
                user_id: user.user_id,
                username: user.username,
                roles: roles
            },
            process.env.JWT_SECRET,
            { expiresIn: '1d' }
        );

        res.json({
            status: 'success',
            message: 'เข้าสู่ระบบสำเร็จ',
            data: {
                user: userProfile,
                token
            }
        });

    } catch (error) {
        console.error('Login error details:', {
            message: error.message,
            code: error.code,
            meta: error.meta
        });
        
        if (error.code === 'P2025') {
            return res.status(404).json({
                status: 'error',
                message: 'ไม่พบข้อมูลผู้ใช้'
            });
        }
        
        res.status(500).json({
            status: 'error',
            message: 'เกิดข้อผิดพลาดในการเข้าสู่ระบบ',
            error: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
});

module.exports = router;
