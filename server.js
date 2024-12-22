const express = require('express');
const app = express();
const cors = require('cors');
const userController = require('./controllers/UserControllers');

// Middleware
app.use(cors());  // เพิ่ม CORS middleware
app.use(express.json());  // สำหรับ parse JSON
app.use(express.urlencoded({ extended: true }));  // สำหรับ parse URL-encoded bodies

// Routes
app.use('/user', userController);


// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send({
        status: 'error',
        message: 'เกิดข้อผิดพลาดในระบบ',
        error: process.env.NODE_ENV === 'development' ? err.message : undefined
    });
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});