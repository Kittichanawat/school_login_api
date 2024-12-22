-- CreateTable
CREATE TABLE "SchExecutives" (
    "exec_id" SERIAL NOT NULL,
    "exec_fname" TEXT NOT NULL,
    "exec_lname" TEXT NOT NULL,
    "position" TEXT NOT NULL,
    "exec_email" TEXT,
    "exec_phone" TEXT,
    "user_id" INTEGER,
    "exec_status" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "SchExecutives_pkey" PRIMARY KEY ("exec_id")
);

-- AddForeignKey
ALTER TABLE "SchExecutives" ADD CONSTRAINT "SchExecutives_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SchLoginUsers"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;
