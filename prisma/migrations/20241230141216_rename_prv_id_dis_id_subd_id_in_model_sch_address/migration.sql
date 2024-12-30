/*
  Warnings:

  - You are about to drop the column `addr_dist` on the `SchAddress` table. All the data in the column will be lost.
  - You are about to drop the column `addr_prv` on the `SchAddress` table. All the data in the column will be lost.
  - You are about to drop the column `addr_sub_dist` on the `SchAddress` table. All the data in the column will be lost.
  - Added the required column `dis_id` to the `SchAddress` table without a default value. This is not possible if the table is not empty.
  - Added the required column `prv_id` to the `SchAddress` table without a default value. This is not possible if the table is not empty.
  - Added the required column `subd_id` to the `SchAddress` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "SchAddress" DROP COLUMN "addr_dist",
DROP COLUMN "addr_prv",
DROP COLUMN "addr_sub_dist",
ADD COLUMN     "dis_id" INTEGER NOT NULL,
ADD COLUMN     "prv_id" INTEGER NOT NULL,
ADD COLUMN     "subd_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "SchAddress" ADD CONSTRAINT "SchAddress_prv_id_fkey" FOREIGN KEY ("prv_id") REFERENCES "SchProvince"("prv_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchAddress" ADD CONSTRAINT "SchAddress_dis_id_fkey" FOREIGN KEY ("dis_id") REFERENCES "SchDistrict"("dis_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchAddress" ADD CONSTRAINT "SchAddress_subd_id_fkey" FOREIGN KEY ("subd_id") REFERENCES "SchSubDistrict"("subd_id") ON DELETE RESTRICT ON UPDATE CASCADE;
