-- CreateEnum
CREATE TYPE "VoteType" AS ENUM ('UP', 'DOWN');

-- CreateTable
CREATE TABLE "Account" (
    "id" VARCHAR NOT NULL,
    "userId" VARCHAR NOT NULL,
    "type" VARCHAR NOT NULL,
    "provider" VARCHAR NOT NULL,
    "providerAccountId" VARCHAR NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" VARCHAR,
    "scope" VARCHAR,
    "id_token" TEXT,
    "session_state" VARCHAR,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Session" (
    "id" VARCHAR NOT NULL,
    "sessionToken" VARCHAR NOT NULL,
    "userId" VARCHAR NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" VARCHAR NOT NULL,
    "name" VARCHAR,
    "email" VARCHAR,
    "emailVerified" TIMESTAMP(3),
    "username" VARCHAR,
    "image" VARCHAR,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Subreddit" (
    "id" VARCHAR NOT NULL,
    "name" VARCHAR NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "creatorId" VARCHAR,

    CONSTRAINT "Subreddit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Subscription" (
    "userId" VARCHAR NOT NULL,
    "subredditId" VARCHAR NOT NULL,

    CONSTRAINT "Subscription_pkey" PRIMARY KEY ("userId","subredditId")
);

-- CreateTable
CREATE TABLE "Post" (
    "id" VARCHAR NOT NULL,
    "title" VARCHAR NOT NULL,
    "content" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "authorId" VARCHAR NOT NULL,
    "subredditId" VARCHAR NOT NULL,

    CONSTRAINT "Post_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Comment" (
    "id" VARCHAR NOT NULL,
    "text" VARCHAR NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authorId" VARCHAR NOT NULL,
    "postId" VARCHAR NOT NULL,
    "replyToId" VARCHAR,
    "commentId" VARCHAR,

    CONSTRAINT "Comment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Vote" (
    "userId" VARCHAR NOT NULL,
    "postId" VARCHAR NOT NULL,
    "type" "VoteType" NOT NULL,

    CONSTRAINT "Vote_pkey" PRIMARY KEY ("userId","postId")
);

-- CreateTable
CREATE TABLE "CommentVote" (
    "userId" VARCHAR NOT NULL,
    "commentId" VARCHAR NOT NULL,
    "type" "VoteType" NOT NULL,

    CONSTRAINT "CommentVote_pkey" PRIMARY KEY ("userId","commentId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON "Account"("provider", "providerAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "Session_sessionToken_key" ON "Session"("sessionToken");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Subreddit_name_key" ON "Subreddit"("name");

-- CreateIndex
CREATE INDEX "Subreddit_name_idx" ON "Subreddit"("name");

-- CreateIndex
CREATE INDEX "Comment_replyToId_idx" ON "Comment"("replyToId");
