/*
  Warnings:

  - You are about to drop the column `addr_prov` on the `SchAddress` table. All the data in the column will be lost.
  - You are about to drop the column `addr_zip_code` on the `SchAddress` table. All the data in the column will be lost.
  - You are about to drop the `SchDistrict` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SchProvince` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SchSubDistrict` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `addr_pos_code` to the `SchAddress` table without a default value. This is not possible if the table is not empty.
  - Added the required column `addr_prv` to the `SchAddress` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "SchDistrict" DROP CONSTRAINT "SchDistrict_province_id_fkey";

-- DropForeignKey
ALTER TABLE "SchSubDistrict" DROP CONSTRAINT "SchSubDistrict_district_id_fkey";

-- AlterTable
ALTER TABLE "SchAddress" DROP COLUMN "addr_prov",
DROP COLUMN "addr_zip_code",
ADD COLUMN     "addr_pos_code" TEXT NOT NULL,
ADD COLUMN     "addr_prv" TEXT NOT NULL;

-- DropTable
DROP TABLE "SchDistrict";

-- DropTable
DROP TABLE "SchProvince";

-- DropTable
DROP TABLE "SchSubDistrict";
