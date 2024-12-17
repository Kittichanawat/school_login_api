-- CreateTable
CREATE TABLE "sch_teachers" (
    "tea_id" SERIAL NOT NULL,
    "tea_fname" TEXT NOT NULL,
    "tea_lname" TEXT NOT NULL,
    "tea_email" TEXT,
    "tea_phone" TEXT,
    "user_id" INTEGER,
    "tea_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "sch_teachers_pkey" PRIMARY KEY ("tea_id")
);

-- AddForeignKey
ALTER TABLE "sch_teachers" ADD CONSTRAINT "sch_teachers_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;
