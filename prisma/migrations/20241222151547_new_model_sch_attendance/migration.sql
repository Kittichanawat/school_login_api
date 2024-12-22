-- CreateTable
CREATE TABLE "SchAttendance" (
    "atd_id" SERIAL NOT NULL,
    "std_id" INTEGER,
    "class_id" INTEGER,
    "tea_id" INTEGER NOT NULL,
    "term_id" INTEGER NOT NULL,
    "atd_date" DATE NOT NULL,
    "atd_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "SchAttendance_pkey" PRIMARY KEY ("atd_id")
);

-- AddForeignKey
ALTER TABLE "SchAttendance" ADD CONSTRAINT "SchAttendance_std_id_fkey" FOREIGN KEY ("std_id") REFERENCES "SchStudents"("std_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchAttendance" ADD CONSTRAINT "SchAttendance_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "SchClasses"("class_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchAttendance" ADD CONSTRAINT "SchAttendance_tea_id_fkey" FOREIGN KEY ("tea_id") REFERENCES "SchTeachers"("tea_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchAttendance" ADD CONSTRAINT "SchAttendance_term_id_fkey" FOREIGN KEY ("term_id") REFERENCES "SchTerms"("term_id") ON DELETE RESTRICT ON UPDATE CASCADE;
