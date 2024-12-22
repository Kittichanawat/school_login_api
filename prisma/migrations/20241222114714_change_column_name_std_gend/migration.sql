/*
  Warnings:

  - You are about to drop the column `gen` on the `SchStudents` table. All the data in the column will be lost.
  - Added the required column `std_gend` to the `SchStudents` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "SchStudents" DROP COLUMN "gen",
ADD COLUMN     "std_gend" TEXT NOT NULL;
