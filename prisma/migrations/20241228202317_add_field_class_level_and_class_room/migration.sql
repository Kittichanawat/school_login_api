/*
  Warnings:

  - You are about to drop the column `addr_h_num` on the `SchAddress` table. All the data in the column will be lost.
  - You are about to drop the column `addr_moo` on the `SchAddress` table. All the data in the column will be lost.
  - You are about to drop the column `addr_road` on the `SchAddress` table. All the data in the column will be lost.
  - You are about to drop the column `class_name` on the `SchClasses` table. All the data in the column will be lost.
  - You are about to drop the column `address_type` on the `UserAddress` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[class_level]` on the table `SchClasses` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[class_room]` on the table `SchClasses` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `addr_etc` to the `SchAddress` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "SchClasses_class_name_key";

-- AlterTable
ALTER TABLE "SchAddress" DROP COLUMN "addr_h_num",
DROP COLUMN "addr_moo",
DROP COLUMN "addr_road",
ADD COLUMN     "addr_etc" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "SchClasses" DROP COLUMN "class_name",
ADD COLUMN     "class_level" TEXT,
ADD COLUMN     "class_room" TEXT;

-- AlterTable
ALTER TABLE "UserAddress" DROP COLUMN "address_type",
ADD COLUMN     "addr_type" TEXT NOT NULL DEFAULT 'current';

-- CreateIndex
CREATE UNIQUE INDEX "SchClasses_class_level_key" ON "SchClasses"("class_level");

-- CreateIndex
CREATE UNIQUE INDEX "SchClasses_class_room_key" ON "SchClasses"("class_room");
