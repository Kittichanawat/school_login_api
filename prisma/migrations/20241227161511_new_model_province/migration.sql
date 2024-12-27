-- CreateTable
CREATE TABLE "SchProvince" (
    "province_id" SERIAL NOT NULL,
    "province_name" TEXT NOT NULL,

    CONSTRAINT "SchProvince_pkey" PRIMARY KEY ("province_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "SchProvince_province_name_key" ON "SchProvince"("province_name");
