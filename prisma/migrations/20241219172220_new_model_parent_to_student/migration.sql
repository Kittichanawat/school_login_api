-- CreateTable
CREATE TABLE "sch_parent_student" (
    "parstd_id" SERIAL NOT NULL,
    "par_id" INTEGER NOT NULL,
    "std_id" INTEGER NOT NULL,

    CONSTRAINT "sch_parent_student_pkey" PRIMARY KEY ("parstd_id")
);

-- AddForeignKey
ALTER TABLE "sch_parent_student" ADD CONSTRAINT "sch_parent_student_par_id_fkey" FOREIGN KEY ("par_id") REFERENCES "SchParents"("par_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sch_parent_student" ADD CONSTRAINT "sch_parent_student_std_id_fkey" FOREIGN KEY ("std_id") REFERENCES "SchStudents"("std_id") ON DELETE RESTRICT ON UPDATE CASCADE;
