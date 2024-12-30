-- CreateTable
CREATE TABLE "SchProvince" (
    "prv_id" SERIAL NOT NULL,
    "prv_name_th" TEXT NOT NULL,
    "prv_name_en" TEXT NOT NULL,
    "prv_geo_id" INTEGER NOT NULL,
    "prv_createdAt" TIMESTAMP(3) NOT NULL,
    "prv_updatedAt" TIMESTAMP(3) NOT NULL,
    "prv_deletedAt" TIMESTAMP(3),

    CONSTRAINT "SchProvince_pkey" PRIMARY KEY ("prv_id")
);

-- CreateTable
CREATE TABLE "SchDistrict" (
    "dis_id" SERIAL NOT NULL,
    "dis_name_th" TEXT NOT NULL,
    "dis_name_en" TEXT NOT NULL,
    "prv_id" INTEGER NOT NULL,
    "dis_createdAt" TIMESTAMP(3) NOT NULL,
    "dis_updatedAt" TIMESTAMP(3) NOT NULL,
    "dis_deletedAt" TIMESTAMP(3),

    CONSTRAINT "SchDistrict_pkey" PRIMARY KEY ("dis_id")
);

-- CreateTable
CREATE TABLE "SchSubDistrict" (
    "subd_id" SERIAL NOT NULL,
    "subd_name_th" TEXT NOT NULL,
    "subd_name_en" TEXT NOT NULL,
    "dis_id" INTEGER NOT NULL,
    "pos_code" TEXT NOT NULL,
    "subd_createdAt" TIMESTAMP(3) NOT NULL,
    "subd_updatedAt" TIMESTAMP(3) NOT NULL,
    "subd_deletedAt" TIMESTAMP(3),

    CONSTRAINT "SchSubDistrict_pkey" PRIMARY KEY ("subd_id")
);

-- AddForeignKey
ALTER TABLE "SchDistrict" ADD CONSTRAINT "SchDistrict_prv_id_fkey" FOREIGN KEY ("prv_id") REFERENCES "SchProvince"("prv_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchSubDistrict" ADD CONSTRAINT "SchSubDistrict_dis_id_fkey" FOREIGN KEY ("dis_id") REFERENCES "SchDistrict"("dis_id") ON DELETE RESTRICT ON UPDATE CASCADE;
