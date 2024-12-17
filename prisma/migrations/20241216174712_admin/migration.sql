-- CreateTable
CREATE TABLE "sch_admins" (
    "adm_id" SERIAL NOT NULL,
    "adm_fname" TEXT NOT NULL,
    "adm_lname" TEXT NOT NULL,
    "user_id" INTEGER,
    "adm_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "sch_admins_pkey" PRIMARY KEY ("adm_id")
);

-- AddForeignKey
ALTER TABLE "sch_admins" ADD CONSTRAINT "sch_admins_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;
