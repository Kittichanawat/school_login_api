/*
  Warnings:

  - You are about to drop the column `gender` on the `SchStudents` table. All the data in the column will be lost.
  - Added the required column `gen` to the `SchStudents` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "SchStudents" DROP COLUMN "gender",
ADD COLUMN     "gen" TEXT NOT NULL;
