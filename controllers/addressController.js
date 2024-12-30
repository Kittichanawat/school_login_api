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

// Route สำหรับบึงข้อมูลจังหวัด อำเภอ ตำบล
app.get('/provinces', async (req, res) => {
    try {
        const provinces = await prisma.schProvince.findMany({
            select: {
                prv_id: true,
                prv_name_th: true,
                prv_name_en: true,
                district: {
                    select: {
                        dis_id: true,
                        dis_name_th: true,
                        dis_name_en: true,
                        subdistrict: {
                            select: {
                                subd_id: true,
                                subd_name_th: true,
                                subd_name_en: true,
                                pos_code: true
                            }
                        }
                    }
                }
            },
            where: {
                prv_deletedat: null // เลือกเฉพาะข้อมูลที่ยังไม่ถูกลบ
            },
            orderBy: {
                prv_name_th: 'asc'
            }
        });

        // แปลงข้อมูลให้ตรงกับรูปแบบเดิม
        const formattedData = provinces.map(province => ({
            id: province.prv_id,
            name_th: province.prv_name_th,
            name_en: province.prv_name_en,
            amphure: province.district.map(district => ({
                id: district.dis_id,
                name_th: district.dis_name_th,
                name_en: district.dis_name_en,
                tambon: district.subdistrict.map(subdistrict => ({
                    id: subdistrict.subd_id,
                    name_th: subdistrict.subd_name_th,
                    name_en: subdistrict.subd_name_en,
                    zip_code: subdistrict.pos_code
                }))
            }))
        }));

        res.json({
            status: 'success',
            data: formattedData
        });

    } catch (error) {
        console.error('Error fetching provinces:', error);
        res.status(500).json({
            status: 'error',
            message: 'ไม่สามารถดึงข้อมูลจังหวัดได้',
            error: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
});

// Route สำหรับบันทึกที่อยู่
app.post('/', authenticateToken, async (req, res) => {
    try {
        const {
            addr_etc,
            subd_id,      // ID ตำบล
            dis_id,       // ID อำเภอ
            prv_id,       // ID จังหวัด
            addr_pos_code,
            addr_tel_home,
            house_reg_num,
            addr_type
        } = req.body;

        // Log ข้อมูลที่ได้รับ
        console.log('Received data:', {
            addr_etc,
            subd_id,
            dis_id,
            prv_id,
            addr_pos_code,
            addr_tel_home,
            house_reg_num,
            addr_type,
            user_id: req.user.user_id
        });

        // ตรวจสอบข้อมูลที่จำเป็น
        if (!addr_etc || !subd_id || !dis_id || !prv_id || !addr_pos_code) {
            return res.status(400).json({
                status: 'error',
                message: 'กรุณากรอกข้อมูลที่อยู่ให้ครบถ้วน'
            });
        }

        // สร้างที่อยู่ใหม่
        const address = await prisma.schAddress.create({
            data: {
                addr_etc,
                prv_id: parseInt(prv_id),
                dis_id: parseInt(dis_id),
                subd_id: parseInt(subd_id),
                addr_pos_code,
                addr_tel_home: addr_tel_home || null,
                house_reg_num: house_reg_num || null
            },
            include: {
                province: {
                    select: {
                        prv_name_th: true
                    }
                },
                district: {
                    select: {
                        dis_name_th: true
                    }
                },
                subdistrict: {
                    select: {
                        subd_name_th: true
                    }
                }
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
                address: {
                    ...address,
                    province_name: address.province.prv_name_th,
                    district_name: address.district.dis_name_th,
                    subdistrict_name: address.subdistrict.subd_name_th
                },
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
            message: 'เกิดข้อผิดพลาดในการบันทึกข้อมูล',
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