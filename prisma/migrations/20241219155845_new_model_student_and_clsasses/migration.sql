-- CreateTable
CREATE TABLE "SchStudents" (
    "std_id" SERIAL NOT NULL,
    "std_fname" TEXT NOT NULL,
    "std_lname" TEXT NOT NULL,
    "gender" TEXT NOT NULL,
    "dob" TIMESTAMP(3) NOT NULL,
    "class_id" INTEGER,
    "user_id" INTEGER,
    "status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "SchStudents_pkey" PRIMARY KEY ("std_id")
);

-- CreateTable
CREATE TABLE "SchClasses" (
    "class_id" SERIAL NOT NULL,
    "class_name" TEXT NOT NULL,
    "class_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "SchClasses_pkey" PRIMARY KEY ("class_id")
);

-- AddForeignKey
ALTER TABLE "SchStudents" ADD CONSTRAINT "SchStudents_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "SchClasses"("class_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchStudents" ADD CONSTRAINT "SchStudents_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;
