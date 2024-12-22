-- CreateTable
CREATE TABLE "SchTeacherClass" (
    "teaclas_id" SERIAL NOT NULL,
    "tea_id" INTEGER NOT NULL,
    "class_id" INTEGER,
    "term_id" INTEGER NOT NULL,

    CONSTRAINT "SchTeacherClass_pkey" PRIMARY KEY ("teaclas_id")
);

-- CreateTable
CREATE TABLE "SchTerms" (
    "term_id" SERIAL NOT NULL,
    "term_name" TEXT NOT NULL,
    "academic_year" TEXT NOT NULL,
    "term_status" TEXT NOT NULL,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "SchTerms_pkey" PRIMARY KEY ("term_id")
);

-- AddForeignKey
ALTER TABLE "SchTeacherClass" ADD CONSTRAINT "SchTeacherClass_tea_id_fkey" FOREIGN KEY ("tea_id") REFERENCES "SchTeachers"("tea_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchTeacherClass" ADD CONSTRAINT "SchTeacherClass_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "SchClasses"("class_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchTeacherClass" ADD CONSTRAINT "SchTeacherClass_term_id_fkey" FOREIGN KEY ("term_id") REFERENCES "SchTerms"("term_id") ON DELETE RESTRICT ON UPDATE CASCADE;
