-- CreateTable
CREATE TABLE "SchStudentClassHistory" (
    "stdh_id" SERIAL NOT NULL,
    "std_id" INTEGER NOT NULL,
    "class_id" INTEGER NOT NULL,
    "term_id" INTEGER NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3),
    "stdh_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "SchStudentClassHistory_pkey" PRIMARY KEY ("stdh_id")
);

-- AddForeignKey
ALTER TABLE "SchStudentClassHistory" ADD CONSTRAINT "SchStudentClassHistory_std_id_fkey" FOREIGN KEY ("std_id") REFERENCES "SchStudents"("std_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchStudentClassHistory" ADD CONSTRAINT "SchStudentClassHistory_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "SchClasses"("class_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchStudentClassHistory" ADD CONSTRAINT "SchStudentClassHistory_term_id_fkey" FOREIGN KEY ("term_id") REFERENCES "SchTerms"("term_id") ON DELETE RESTRICT ON UPDATE CASCADE;
