/*
  Warnings:

  - A unique constraint covering the columns `[national_id]` on the table `SchStudents` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `national_id` to the `SchStudents` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "SchStudents" ADD COLUMN     "national_id" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "SchStudents_national_id_key" ON "SchStudents"("national_id");
