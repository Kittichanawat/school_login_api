/*
  Warnings:

  - You are about to drop the `sch_admins` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sch_parents` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sch_teachers` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "sch_admins" DROP CONSTRAINT "sch_admins_user_id_fkey";

-- DropForeignKey
ALTER TABLE "sch_parents" DROP CONSTRAINT "sch_parents_user_id_fkey";

-- DropForeignKey
ALTER TABLE "sch_teachers" DROP CONSTRAINT "sch_teachers_user_id_fkey";

-- DropTable
DROP TABLE "sch_admins";

-- DropTable
DROP TABLE "sch_parents";

-- DropTable
DROP TABLE "sch_teachers";

-- CreateTable
CREATE TABLE "SchParents" (
    "par_id" SERIAL NOT NULL,
    "par_fname" TEXT NOT NULL,
    "par_lastname" TEXT NOT NULL,
    "phone_number" TEXT,
    "email" TEXT,
    "user_id" INTEGER,
    "status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "SchParents_pkey" PRIMARY KEY ("par_id")
);

-- CreateTable
CREATE TABLE "SchTeachers" (
    "tea_id" SERIAL NOT NULL,
    "tea_fname" TEXT NOT NULL,
    "tea_lname" TEXT NOT NULL,
    "tea_email" TEXT,
    "tea_phone" TEXT,
    "user_id" INTEGER,
    "tea_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "SchTeachers_pkey" PRIMARY KEY ("tea_id")
);

-- CreateTable
CREATE TABLE "SchAdmins" (
    "adm_id" SERIAL NOT NULL,
    "adm_fname" TEXT NOT NULL,
    "adm_lname" TEXT NOT NULL,
    "user_id" INTEGER,
    "adm_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "SchAdmins_pkey" PRIMARY KEY ("adm_id")
);

-- AddForeignKey
ALTER TABLE "SchParents" ADD CONSTRAINT "SchParents_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchTeachers" ADD CONSTRAINT "SchTeachers_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchAdmins" ADD CONSTRAINT "SchAdmins_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;
