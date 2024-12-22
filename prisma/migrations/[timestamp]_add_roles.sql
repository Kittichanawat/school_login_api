-- ลบข้อมูลเก่าใน UserRole (ถ้าจำเป็น)
DELETE FROM "UserRole";

-- เพิ่มข้อมูลใน SchRoles
INSERT INTO "SchRoles" (role_id, role_name) VALUES
(1, 'admin'),
(2, 'teacher'),
(3, 'parent'),
(4, 'executive'),
(5, 'registrar'),
(6, 'student'); 