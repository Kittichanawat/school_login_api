/*
  Warnings:

  - You are about to drop the `SchoolRoles` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "UserRole" DROP CONSTRAINT "UserRole_role_id_fkey";

-- DropTable
DROP TABLE "SchoolRoles";

-- CreateTable
CREATE TABLE "SchRoles" (
    "role_id" SERIAL NOT NULL,
    "role_name" TEXT NOT NULL,

    CONSTRAINT "SchRoles_pkey" PRIMARY KEY ("role_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "SchRoles_role_name_key" ON "SchRoles"("role_name");

-- AddForeignKey
ALTER TABLE "UserRole" ADD CONSTRAINT "UserRole_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "SchRoles"("role_id") ON DELETE RESTRICT ON UPDATE CASCADE;
