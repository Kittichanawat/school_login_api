/*
  Warnings:

  - You are about to drop the column `national_id` on the `SchStudents` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[std_nat_id]` on the table `SchStudents` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[std_code]` on the table `SchStudents` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `std_code` to the `SchStudents` table without a default value. This is not possible if the table is not empty.
  - Added the required column `std_nat_id` to the `SchStudents` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "StudentState" AS ENUM ('normal', 'suspended', 'transferred', 'graduated', 'dropped_out');

-- DropIndex
DROP INDEX "SchStudents_national_id_key";

-- AlterTable
ALTER TABLE "SchStudents" DROP COLUMN "national_id",
ADD COLUMN     "std_code" TEXT NOT NULL,
ADD COLUMN     "std_nat_id" TEXT NOT NULL,
ADD COLUMN     "std_state" "StudentState" NOT NULL DEFAULT 'normal';

-- CreateIndex
CREATE UNIQUE INDEX "SchStudents_std_nat_id_key" ON "SchStudents"("std_nat_id");

-- CreateIndex
CREATE UNIQUE INDEX "SchStudents_std_code_key" ON "SchStudents"("std_code");
