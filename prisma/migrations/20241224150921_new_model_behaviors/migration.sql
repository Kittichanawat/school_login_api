-- CreateTable
CREATE TABLE "SchBehaviors" (
    "bhv_id" SERIAL NOT NULL,
    "std_id" INTEGER NOT NULL,
    "bhv_type" TEXT NOT NULL,
    "bhv_desc" TEXT,
    "reported_date" TIMESTAMP(3) NOT NULL,
    "tea_id" INTEGER NOT NULL,
    "bhv_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "SchBehaviors_pkey" PRIMARY KEY ("bhv_id")
);

-- AddForeignKey
ALTER TABLE "SchBehaviors" ADD CONSTRAINT "SchBehaviors_std_id_fkey" FOREIGN KEY ("std_id") REFERENCES "SchStudents"("std_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchBehaviors" ADD CONSTRAINT "SchBehaviors_tea_id_fkey" FOREIGN KEY ("tea_id") REFERENCES "SchTeachers"("tea_id") ON DELETE RESTRICT ON UPDATE CASCADE;
