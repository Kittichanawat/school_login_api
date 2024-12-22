/*
  Warnings:

  - The `std_state` column on the `SchStudents` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "SchStudents" DROP COLUMN "std_state",
ADD COLUMN     "std_state" TEXT NOT NULL DEFAULT 'normal';

-- DropEnum
DROP TYPE "StudentState";
