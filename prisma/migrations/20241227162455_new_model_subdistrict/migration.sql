-- CreateTable
CREATE TABLE "SchSubDistrict" (
    "sub_district_id" SERIAL NOT NULL,
    "sub_district_name" TEXT NOT NULL,
    "district_id" INTEGER NOT NULL,
    "postal_code" TEXT NOT NULL,

    CONSTRAINT "SchSubDistrict_pkey" PRIMARY KEY ("sub_district_id")
);

-- AddForeignKey
ALTER TABLE "SchSubDistrict" ADD CONSTRAINT "SchSubDistrict_district_id_fkey" FOREIGN KEY ("district_id") REFERENCES "SchDistrict"("district_id") ON DELETE RESTRICT ON UPDATE CASCADE;
