/*
  Warnings:

  - You are about to drop the column `dis_createdAt` on the `SchDistrict` table. All the data in the column will be lost.
  - You are about to drop the column `dis_deletedAt` on the `SchDistrict` table. All the data in the column will be lost.
  - You are about to drop the column `dis_updatedAt` on the `SchDistrict` table. All the data in the column will be lost.
  - You are about to drop the column `prv_createdAt` on the `SchProvince` table. All the data in the column will be lost.
  - You are about to drop the column `prv_deletedAt` on the `SchProvince` table. All the data in the column will be lost.
  - You are about to drop the column `prv_updatedAt` on the `SchProvince` table. All the data in the column will be lost.
  - You are about to drop the column `subd_createdAt` on the `SchSubDistrict` table. All the data in the column will be lost.
  - You are about to drop the column `subd_deletedAt` on the `SchSubDistrict` table. All the data in the column will be lost.
  - You are about to drop the column `subd_updatedAt` on the `SchSubDistrict` table. All the data in the column will be lost.
  - Added the required column `dis_createdat` to the `SchDistrict` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dis_updatedat` to the `SchDistrict` table without a default value. This is not possible if the table is not empty.
  - Added the required column `prv_createdat` to the `SchProvince` table without a default value. This is not possible if the table is not empty.
  - Added the required column `prv_updatedat` to the `SchProvince` table without a default value. This is not possible if the table is not empty.
  - Added the required column `subd_createdat` to the `SchSubDistrict` table without a default value. This is not possible if the table is not empty.
  - Added the required column `subd_updatedat` to the `SchSubDistrict` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "SchDistrict" DROP COLUMN "dis_createdAt",
DROP COLUMN "dis_deletedAt",
DROP COLUMN "dis_updatedAt",
ADD COLUMN     "dis_createdat" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "dis_deletedat" TIMESTAMP(3),
ADD COLUMN     "dis_updatedat" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "SchProvince" DROP COLUMN "prv_createdAt",
DROP COLUMN "prv_deletedAt",
DROP COLUMN "prv_updatedAt",
ADD COLUMN     "prv_createdat" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "prv_deletedat" TIMESTAMP(3),
ADD COLUMN     "prv_updatedat" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "SchSubDistrict" DROP COLUMN "subd_createdAt",
DROP COLUMN "subd_deletedAt",
DROP COLUMN "subd_updatedAt",
ADD COLUMN     "subd_createdat" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "subd_deletedat" TIMESTAMP(3),
ADD COLUMN     "subd_updatedat" TIMESTAMP(3) NOT NULL;
