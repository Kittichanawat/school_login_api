/*
  Warnings:

  - You are about to drop the column `password` on the `SchLoginUsers` table. All the data in the column will be lost.
  - You are about to drop the column `username` on the `SchLoginUsers` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[user_uname]` on the table `SchLoginUsers` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "SchLoginUsers_username_key";

-- AlterTable
ALTER TABLE "SchLoginUsers" DROP COLUMN "password",
DROP COLUMN "username",
ADD COLUMN     "user_password" TEXT,
ADD COLUMN     "user_uname" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "SchLoginUsers_user_uname_key" ON "SchLoginUsers"("user_uname");
