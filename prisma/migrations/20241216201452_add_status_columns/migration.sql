/*
  Warnings:

  - You are about to drop the column `email` on the `SchParents` table. All the data in the column will be lost.
  - You are about to drop the column `phone_number` on the `SchParents` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `SchParents` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `UserRole` table. All the data in the column will be lost.
  - Added the required column `userRole_status` to the `UserRole` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "SchLoginUsers" ADD COLUMN     "login_status" INTEGER NOT NULL DEFAULT 1;

-- AlterTable
ALTER TABLE "SchParents" DROP COLUMN "email",
DROP COLUMN "phone_number",
DROP COLUMN "status",
ADD COLUMN     "par_email" TEXT,
ADD COLUMN     "par_phone" TEXT,
ADD COLUMN     "par_status" INTEGER NOT NULL DEFAULT 1;

-- AlterTable
ALTER TABLE "UserRole" DROP COLUMN "status",
ADD COLUMN     "userRole_status" INTEGER NOT NULL;
