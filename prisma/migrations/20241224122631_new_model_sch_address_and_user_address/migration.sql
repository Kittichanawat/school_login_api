-- CreateTable
CREATE TABLE "SchAddress" (
    "addr_id" SERIAL NOT NULL,
    "addr_h_num" TEXT NOT NULL,
    "addr_moo" TEXT,
    "addr_road" TEXT,
    "addr_sub_dist" TEXT NOT NULL,
    "addr_dist" TEXT NOT NULL,
    "addr_prov" TEXT NOT NULL,
    "addr_zip_code" TEXT NOT NULL,
    "addr_tel_home" TEXT,
    "house_reg_num" TEXT,

    CONSTRAINT "SchAddress_pkey" PRIMARY KEY ("addr_id")
);

-- CreateTable
CREATE TABLE "UserAddress" (
    "user_addr_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "addr_id" INTEGER NOT NULL,
    "address_type" TEXT NOT NULL DEFAULT 'current',

    CONSTRAINT "UserAddress_pkey" PRIMARY KEY ("user_addr_id")
);

-- AddForeignKey
ALTER TABLE "UserAddress" ADD CONSTRAINT "UserAddress_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAddress" ADD CONSTRAINT "UserAddress_addr_id_fkey" FOREIGN KEY ("addr_id") REFERENCES "SchAddress"("addr_id") ON DELETE RESTRICT ON UPDATE CASCADE;
