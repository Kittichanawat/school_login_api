-- CreateTable
CREATE TABLE "SchRegistrars" (
    "reg_id" SERIAL NOT NULL,
    "reg_fname" TEXT NOT NULL,
    "reg_lname" TEXT NOT NULL,
    "reg_email" TEXT,
    "reg_phone" TEXT,
    "user_id" INTEGER,
    "reg_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "SchRegistrars_pkey" PRIMARY KEY ("reg_id")
);

-- AddForeignKey
ALTER TABLE "SchRegistrars" ADD CONSTRAINT "SchRegistrars_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;
