-- CreateTable
CREATE TABLE "sch_grades" (
    "grd_id" SERIAL NOT NULL,
    "std_id" INTEGER NOT NULL,
    "file_path" TEXT NOT NULL,
    "uploaded_date" TIMESTAMP(3) NOT NULL,
    "term_id" INTEGER,
    "grd_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "sch_grades_pkey" PRIMARY KEY ("grd_id")
);

-- AddForeignKey
ALTER TABLE "sch_grades" ADD CONSTRAINT "sch_grades_std_id_fkey" FOREIGN KEY ("std_id") REFERENCES "SchStudents"("std_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sch_grades" ADD CONSTRAINT "sch_grades_term_id_fkey" FOREIGN KEY ("term_id") REFERENCES "SchTerms"("term_id") ON DELETE SET NULL ON UPDATE CASCADE;
