-- CreateTable
CREATE TABLE "SchDistrict" (
    "district_id" SERIAL NOT NULL,
    "district_name" TEXT NOT NULL,
    "province_id" INTEGER NOT NULL,

    CONSTRAINT "SchDistrict_pkey" PRIMARY KEY ("district_id")
);

-- AddForeignKey
ALTER TABLE "SchDistrict" ADD CONSTRAINT "SchDistrict_province_id_fkey" FOREIGN KEY ("province_id") REFERENCES "SchProvince"("province_id") ON DELETE RESTRICT ON UPDATE CASCADE;
