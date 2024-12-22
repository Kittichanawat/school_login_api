-- Step 1: Add columns as nullable first
ALTER TABLE "SchLoginUsers" ADD COLUMN "user_fname" TEXT;
ALTER TABLE "SchLoginUsers" ADD COLUMN "user_lname" TEXT;

-- Step 2: Update existing rows with default values if needed
UPDATE "SchLoginUsers" 
SET "user_fname" = 'Default FirstName',
    "user_lname" = 'Default LastName'
WHERE "user_fname" IS NULL OR "user_lname" IS NULL;

-- Step 3: Make the columns nullable in schema
-- ไม่ต้องทำขั้นตอนนี้เพราะในไฟล์ schema.prisma เรากำหนดให้เป็น nullable แล้ว (String?) 