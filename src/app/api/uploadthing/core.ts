import { getToken } from 'next-auth/jwt'
import { createUploadthing, type FileRouter } from 'uploadthing/next'

const f = createUploadthing()

export const ourFileRouter = {
  imageUploader: f({ image: { maxFileSize: '4MB' } })
    .middleware(async (req) => {
      const user = await getToken({ req: req.req })

      if (!user) throw new Error('Unauthorized')

      return { userId: user.sub }
    })
    .onUploadComplete(async ({ metadata, file }) => {
      // Handle upload completion (optional logging, cleanup, etc.)
      console.log(`Upload completed for user ${metadata.userId}:`, file.url)
    }),
} satisfies FileRouter

export type OurFileRouter = typeof ourFileRouter
