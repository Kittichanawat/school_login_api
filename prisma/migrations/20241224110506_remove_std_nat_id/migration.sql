/*
  Warnings:

  - You are about to drop the column `std_nat_id` on the `SchStudents` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[user_nat_id]` on the table `SchLoginUsers` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "SchStudents_std_nat_id_key";

-- AlterTable
ALTER TABLE "SchLoginUsers" ADD COLUMN     "user_nat_id" TEXT;

-- AlterTable
ALTER TABLE "SchStudents" DROP COLUMN "std_nat_id";

-- CreateIndex
CREATE UNIQUE INDEX "SchLoginUsers_user_nat_id_key" ON "SchLoginUsers"("user_nat_id");
