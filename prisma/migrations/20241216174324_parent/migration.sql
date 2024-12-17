-- CreateTable
CREATE TABLE "sch_parents" (
    "par_id" SERIAL NOT NULL,
    "par_fname" TEXT NOT NULL,
    "par_lastname" TEXT NOT NULL,
    "phone_number" TEXT,
    "email" TEXT,
    "user_id" INTEGER,
    "status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "sch_parents_pkey" PRIMARY KEY ("par_id")
);

-- AddForeignKey
ALTER TABLE "sch_parents" ADD CONSTRAINT "sch_parents_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;
