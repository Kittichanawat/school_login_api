/*
  Warnings:

  - A unique constraint covering the columns `[class_name]` on the table `SchClasses` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "SchClasses_class_name_key" ON "SchClasses"("class_name");
