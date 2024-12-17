-- Step 1: Add column as nullable first
ALTER TABLE "UserRole" ADD COLUMN "userRole_status" INT;

-- Step 2: Update existing rows
UPDATE "UserRole" SET "userRole_status" = 1 WHERE "userRole_status" IS NULL;

-- Step 3: Make the column required
ALTER TABLE "UserRole" ALTER COLUMN "userRole_status" SET NOT NULL;

-- Step 4: Add default constraint for future inserts
ALTER TABLE "UserRole" ALTER COLUMN "userRole_status" SET DEFAULT 1;