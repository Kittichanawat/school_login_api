/*
  Warnings:

  - You are about to drop the column `exec_email` on the `SchExecutives` table. All the data in the column will be lost.
  - You are about to drop the column `exec_phone` on the `SchExecutives` table. All the data in the column will be lost.
  - You are about to drop the column `par_email` on the `SchParents` table. All the data in the column will be lost.
  - You are about to drop the column `par_phone` on the `SchParents` table. All the data in the column will be lost.
  - You are about to drop the column `reg_email` on the `SchRegistrars` table. All the data in the column will be lost.
  - You are about to drop the column `reg_phone` on the `SchRegistrars` table. All the data in the column will be lost.
  - You are about to drop the column `tea_email` on the `SchTeachers` table. All the data in the column will be lost.
  - You are about to drop the column `tea_phone` on the `SchTeachers` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "SchExecutives" DROP COLUMN "exec_email",
DROP COLUMN "exec_phone";

-- AlterTable
ALTER TABLE "SchLoginUsers" ADD COLUMN     "user_email" TEXT,
ADD COLUMN     "user_phone" TEXT;

-- AlterTable
ALTER TABLE "SchParents" DROP COLUMN "par_email",
DROP COLUMN "par_phone";

-- AlterTable
ALTER TABLE "SchRegistrars" DROP COLUMN "reg_email",
DROP COLUMN "reg_phone";

-- AlterTable
ALTER TABLE "SchTeachers" DROP COLUMN "tea_email",
DROP COLUMN "tea_phone";
