const express = require('express');
const { PrismaClient } = require('@prisma/client');
const jwt = require('jsonwebtoken');

const prisma = new PrismaClient();
const app = express.Router();

// Middleware ตรวจสอบ token
const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.status(401).json({
            status: 'error',
            message: 'กรุณาเข้าสู่ระบบ'
        });
    }

    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) {
            return res.status(403).json({
                status: 'error',
                message: 'Token ไม่ถูกต้องหรือหมดอายุ'
            });
        }
        req.user = user;
        next();
    });
};

// Route สำหรับบันทึกที่อยู่
app.post('/', authenticateToken, async (req, res) => {
    try {
        const {
            addr_etc,
            addr_sub_dist,
            addr_dist,
            addr_prv,
            addr_pos_code,
            addr_tel_home,
            house_reg_num,
            addr_type
        } = req.body;

        // Log ข้อมูลที่ได้รับ
        console.log('Received data:', {
            addr_etc,
            addr_sub_dist,
            addr_dist,
            addr_prv,
            addr_pos_code,
            addr_tel_home,
            house_reg_num,
            addr_type,
            user_id: req.user.user_id
        });

        // ตรวจสอบข้อมูลที่จำเป็น
        if (!addr_etc || !addr_sub_dist || !addr_dist || !addr_prv || !addr_pos_code) {
            return res.status(400).json({
                status: 'error',
                message: 'กรุณากรอกข้อมูลที่อยู่ให้ครบถ้วน'
            });
        }

        // สร้างที่อยู่ใหม่
        const address = await prisma.schAddress.create({
            data: {
                addr_etc,
                addr_sub_dist,
                addr_dist,
                addr_prv,
                addr_pos_code,
                addr_tel_home: addr_tel_home || null,
                house_reg_num: house_reg_num || null
            }
        });

        // สร้างความสัมพันธ์กับผู้ใช้
        const userAddress = await prisma.userAddress.create({
            data: {
                user_id: req.user.user_id,
                addr_id: address.addr_id,
                addr_type: addr_type || 'current'
            }
        });

        res.json({
            status: 'success',
            message: 'บันทึกข้อมูลที่อยู่สำเร็จ',
            data: {
                address,
                userAddress
            }
        });

    } catch (error) {
        console.error('Error details:', {
            message: error.message,
            code: error.code,
            meta: error.meta,
            stack: error.stack
        });

        res.status(500).json({
            status: 'error',
            message: error.message,
            error: process.env.NODE_ENV === 'development' ? {
                message: error.message,
                code: error.code,
                meta: error.meta
            } : undefined
        });
    }
});

// Route สำหรับดึงข้อมูลที่อยู่ของผู้ใช้
app.get('/', authenticateToken, async (req, res) => {
    try {
        const addresses = await prisma.userAddress.findMany({
            where: {
                user_id: req.user.user_id
            },
            include: {
                address: true
            }
        });

        res.json({
            status: 'success',
            data: addresses
        });

    } catch (error) {
        console.error('Error fetching addresses:', error);
        res.status(500).json({
            status: 'error',
            message: 'เกิดข้อผิดพลาดในการดึงข้อมูลที่อยู่',
            error: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
});

module.exports = app; 