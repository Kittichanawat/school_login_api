/*
  Warnings:

  - You are about to drop the column `adm_fname` on the `SchAdmins` table. All the data in the column will be lost.
  - You are about to drop the column `adm_lname` on the `SchAdmins` table. All the data in the column will be lost.
  - You are about to drop the column `exec_fname` on the `SchExecutives` table. All the data in the column will be lost.
  - You are about to drop the column `exec_lname` on the `SchExecutives` table. All the data in the column will be lost.
  - You are about to drop the column `par_fname` on the `SchParents` table. All the data in the column will be lost.
  - You are about to drop the column `par_lastname` on the `SchParents` table. All the data in the column will be lost.
  - You are about to drop the column `reg_fname` on the `SchRegistrars` table. All the data in the column will be lost.
  - You are about to drop the column `reg_lname` on the `SchRegistrars` table. All the data in the column will be lost.
  - You are about to drop the column `std_fname` on the `SchStudents` table. All the data in the column will be lost.
  - You are about to drop the column `std_lname` on the `SchStudents` table. All the data in the column will be lost.
  - You are about to drop the column `tea_fname` on the `SchTeachers` table. All the data in the column will be lost.
  - You are about to drop the column `tea_lname` on the `SchTeachers` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "SchAdmins" DROP COLUMN "adm_fname",
DROP COLUMN "adm_lname";

-- AlterTable
ALTER TABLE "SchExecutives" DROP COLUMN "exec_fname",
DROP COLUMN "exec_lname";

-- AlterTable
ALTER TABLE "SchParents" DROP COLUMN "par_fname",
DROP COLUMN "par_lastname";

-- AlterTable
ALTER TABLE "SchRegistrars" DROP COLUMN "reg_fname",
DROP COLUMN "reg_lname";

-- AlterTable
ALTER TABLE "SchStudents" DROP COLUMN "std_fname",
DROP COLUMN "std_lname";

-- AlterTable
ALTER TABLE "SchTeachers" DROP COLUMN "tea_fname",
DROP COLUMN "tea_lname";
