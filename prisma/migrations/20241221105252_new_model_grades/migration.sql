/*
  Warnings:

  - You are about to drop the `sch_grades` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sch_parent_student` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "sch_grades" DROP CONSTRAINT "sch_grades_std_id_fkey";

-- DropForeignKey
ALTER TABLE "sch_grades" DROP CONSTRAINT "sch_grades_term_id_fkey";

-- DropForeignKey
ALTER TABLE "sch_parent_student" DROP CONSTRAINT "sch_parent_student_par_id_fkey";

-- DropForeignKey
ALTER TABLE "sch_parent_student" DROP CONSTRAINT "sch_parent_student_std_id_fkey";

-- DropTable
DROP TABLE "sch_grades";

-- DropTable
DROP TABLE "sch_parent_student";

-- CreateTable
CREATE TABLE "SchParentStudent" (
    "parstd_id" SERIAL NOT NULL,
    "par_id" INTEGER NOT NULL,
    "std_id" INTEGER NOT NULL,

    CONSTRAINT "SchParentStudent_pkey" PRIMARY KEY ("parstd_id")
);

-- CreateTable
CREATE TABLE "SchGrades" (
    "grd_id" SERIAL NOT NULL,
    "std_id" INTEGER NOT NULL,
    "file_path" TEXT NOT NULL,
    "uploaded_date" TIMESTAMP(3) NOT NULL,
    "term_id" INTEGER,
    "grd_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "SchGrades_pkey" PRIMARY KEY ("grd_id")
);

-- AddForeignKey
ALTER TABLE "SchParentStudent" ADD CONSTRAINT "SchParentStudent_par_id_fkey" FOREIGN KEY ("par_id") REFERENCES "SchParents"("par_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchParentStudent" ADD CONSTRAINT "SchParentStudent_std_id_fkey" FOREIGN KEY ("std_id") REFERENCES "SchStudents"("std_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchGrades" ADD CONSTRAINT "SchGrades_std_id_fkey" FOREIGN KEY ("std_id") REFERENCES "SchStudents"("std_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchGrades" ADD CONSTRAINT "SchGrades_term_id_fkey" FOREIGN KEY ("term_id") REFERENCES "SchTerms"("term_id") ON DELETE SET NULL ON UPDATE CASCADE;
