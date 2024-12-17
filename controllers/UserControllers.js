const express = require('express');
const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const prisma = new PrismaClient();
const router = express.Router();

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

        const user = await prisma.schLoginUsers.findUnique({
            where: {
                username: username
            },
            include: {
                userRoles: {
                    where: {
                        userRole_status: 1
                    },
                    include: {
                        role: true
                    }
                },
                SchParents: true,
                SchTeachers: true,
                SchAdmins: true
            }
        });

        if (!user) {
            return res.status(401).json({
                status: 'error',
                message: 'ไม่พบผู้ใช้งานในระบบ'
            });
        }

        const isValidPassword = password === user.password;

        if (!isValidPassword) {
            return res.status(401).json({
                status: 'error',
                message: 'รหัสผ่านไม่ถูกต้อง'
            });
        }

        if (user.userRoles.length === 0) {
            return res.status(403).json({
                status: 'error',
                message: 'บัญชีผู้ใช้นี้ไม่มีสิทธิใช้งาน'
            });
        }

        let userProfile = {
            parent: user.SchParents.length > 0 ? user.SchParents[0] : null,
            teacher: user.SchTeachers.length > 0 ? user.SchTeachers[0] : null,
            admin: user.SchAdmins.length > 0 ? user.SchAdmins[0] : null
        };

        const token = jwt.sign(
            {
                user_id: user.user_id,
                username: user.username,
                roles: user.userRoles.map(ur => ur.role.role_name)
            },
            process.env.JWT_SECRET,
            { expiresIn: '1d' }
        );

        res.json({
            status: 'success',
            message: 'เข้าสู่ระบบสำเร็จ',
            data: {
                user: {
                    user_id: user.user_id,
                    username: user.username,
                    roles: user.userRoles.map(ur => ({
                        role_id: ur.role.role_id,
                        role_name: ur.role.role_name,
                        userRole_status: ur.userRole_status
                    })),
                    profiles: {
                        parent: userProfile.parent,
                        teacher: userProfile.teacher,
                        admin: userProfile.admin
                    }
                },
                token
            }
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

module.exports = router;
