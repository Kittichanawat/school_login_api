-- Step 1: Create new tables
CREATE TABLE "SchAdmins" AS TABLE "sch_admins";
CREATE TABLE "SchParents" AS TABLE "sch_parents";
CREATE TABLE "SchTeachers" AS TABLE "sch_teachers";

-- Step 2: Copy data
INSERT INTO "SchAdmins" SELECT * FROM "sch_admins";
INSERT INTO "SchParents" SELECT * FROM "sch_parents";
INSERT INTO "SchTeachers" SELECT * FROM "sch_teachers";

-- Step 3: Drop old tables
DROP TABLE "sch_admins";
DROP TABLE "sch_parents";
DROP TABLE "sch_teachers"; 