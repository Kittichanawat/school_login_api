/*
  Warnings:

  - You are about to drop the column `dob` on the `SchStudents` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "SchStudents" DROP COLUMN "dob",
ADD COLUMN     "std_dob" TIMESTAMP(3);
