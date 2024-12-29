/*
  Warnings:

  - You are about to drop the column `bhv_desc` on the `SchBehaviors` table. All the data in the column will be lost.
  - You are about to drop the column `bhv_type` on the `SchBehaviors` table. All the data in the column will be lost.
  - Made the column `user_id` on table `SchAdmins` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `bhv_type_id` to the `SchBehaviors` table without a default value. This is not possible if the table is not empty.
  - Made the column `class_level` on table `SchClasses` required. This step will fail if there are existing NULL values in that column.
  - Made the column `class_room` on table `SchClasses` required. This step will fail if there are existing NULL values in that column.
  - Made the column `user_id` on table `SchExecutives` required. This step will fail if there are existing NULL values in that column.
  - Made the column `user_email` on table `SchLoginUsers` required. This step will fail if there are existing NULL values in that column.
  - Made the column `user_phone` on table `SchLoginUsers` required. This step will fail if there are existing NULL values in that column.
  - Made the column `user_id` on table `SchParents` required. This step will fail if there are existing NULL values in that column.
  - Made the column `user_id` on table `SchRegistrars` required. This step will fail if there are existing NULL values in that column.
  - Made the column `class_id` on table `SchStudents` required. This step will fail if there are existing NULL values in that column.
  - Made the column `user_id` on table `SchStudents` required. This step will fail if there are existing NULL values in that column.
  - Made the column `class_id` on table `SchTeacherClass` required. This step will fail if there are existing NULL values in that column.
  - Made the column `user_id` on table `SchTeachers` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "SchAdmins" DROP CONSTRAINT "SchAdmins_user_id_fkey";

-- DropForeignKey
ALTER TABLE "SchExecutives" DROP CONSTRAINT "SchExecutives_user_id_fkey";

-- DropForeignKey
ALTER TABLE "SchParents" DROP CONSTRAINT "SchParents_user_id_fkey";

-- DropForeignKey
ALTER TABLE "SchRegistrars" DROP CONSTRAINT "SchRegistrars_user_id_fkey";

-- DropForeignKey
ALTER TABLE "SchStudents" DROP CONSTRAINT "SchStudents_class_id_fkey";

-- DropForeignKey
ALTER TABLE "SchStudents" DROP CONSTRAINT "SchStudents_user_id_fkey";

-- DropForeignKey
ALTER TABLE "SchTeacherClass" DROP CONSTRAINT "SchTeacherClass_class_id_fkey";

-- DropForeignKey
ALTER TABLE "SchTeachers" DROP CONSTRAINT "SchTeachers_user_id_fkey";

-- AlterTable
ALTER TABLE "SchAdmins" ALTER COLUMN "user_id" SET NOT NULL;

-- AlterTable
ALTER TABLE "SchBehaviors" DROP COLUMN "bhv_desc",
DROP COLUMN "bhv_type",
ADD COLUMN     "bhv_detail_id" INTEGER,
ADD COLUMN     "bhv_type_id" INTEGER NOT NULL,
ADD COLUMN     "custom_behavior" TEXT;

-- AlterTable
ALTER TABLE "SchClasses" ALTER COLUMN "class_level" SET NOT NULL,
ALTER COLUMN "class_room" SET NOT NULL;

-- AlterTable
ALTER TABLE "SchExecutives" ALTER COLUMN "user_id" SET NOT NULL;

-- AlterTable
ALTER TABLE "SchLoginUsers" ALTER COLUMN "user_email" SET NOT NULL,
ALTER COLUMN "user_phone" SET NOT NULL;

-- AlterTable
ALTER TABLE "SchParents" ALTER COLUMN "user_id" SET NOT NULL;

-- AlterTable
ALTER TABLE "SchRegistrars" ALTER COLUMN "user_id" SET NOT NULL;

-- AlterTable
ALTER TABLE "SchStudents" ALTER COLUMN "class_id" SET NOT NULL,
ALTER COLUMN "user_id" SET NOT NULL;

-- AlterTable
ALTER TABLE "SchTeacherClass" ALTER COLUMN "class_id" SET NOT NULL;

-- AlterTable
ALTER TABLE "SchTeachers" ALTER COLUMN "user_id" SET NOT NULL;

-- CreateTable
CREATE TABLE "SchBehaviorTypes" (
    "bhv_type_id" SERIAL NOT NULL,
    "bhv_type_name" TEXT NOT NULL,
    "bhv_type_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "SchBehaviorTypes_pkey" PRIMARY KEY ("bhv_type_id")
);

-- CreateTable
CREATE TABLE "SchBehaviorDetails" (
    "bhv_detail_id" SERIAL NOT NULL,
    "bhv_type_id" INTEGER NOT NULL,
    "bhv_detail_name" TEXT NOT NULL,
    "bhv_detail_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "SchBehaviorDetails_pkey" PRIMARY KEY ("bhv_detail_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "SchBehaviorTypes_bhv_type_name_key" ON "SchBehaviorTypes"("bhv_type_name");

-- CreateIndex
CREATE UNIQUE INDEX "SchBehaviorDetails_bhv_detail_name_key" ON "SchBehaviorDetails"("bhv_detail_name");

-- AddForeignKey
ALTER TABLE "SchParents" ADD CONSTRAINT "SchParents_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchTeachers" ADD CONSTRAINT "SchTeachers_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchAdmins" ADD CONSTRAINT "SchAdmins_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchExecutives" ADD CONSTRAINT "SchExecutives_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchRegistrars" ADD CONSTRAINT "SchRegistrars_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchStudents" ADD CONSTRAINT "SchStudents_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "SchClasses"("class_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchStudents" ADD CONSTRAINT "SchStudents_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchTeacherClass" ADD CONSTRAINT "SchTeacherClass_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "SchClasses"("class_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchBehaviors" ADD CONSTRAINT "SchBehaviors_bhv_type_id_fkey" FOREIGN KEY ("bhv_type_id") REFERENCES "SchBehaviorTypes"("bhv_type_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchBehaviors" ADD CONSTRAINT "SchBehaviors_bhv_detail_id_fkey" FOREIGN KEY ("bhv_detail_id") REFERENCES "SchBehaviorDetails"("bhv_detail_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchBehaviorDetails" ADD CONSTRAINT "SchBehaviorDetails_bhv_type_id_fkey" FOREIGN KEY ("bhv_type_id") REFERENCES "SchBehaviorTypes"("bhv_type_id") ON DELETE RESTRICT ON UPDATE CASCADE;
