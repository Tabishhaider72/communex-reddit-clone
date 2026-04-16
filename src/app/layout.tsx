import Navbar from '@/components/Navbar'
import { Inter } from 'next/font/google'
import Providers from '@/components/Providers'
import { Toaster } from '@/components/ui/Toaster'
import { ThemeProvider } from '@/hooks/use-theme'

import '@/styles/globals.css'

const inter = Inter({ subsets: ['latin'] })

export const metadata = {
  title: 'TalkSphere',
  description: 'A full-stack web application inspired by Reddit built with Next.js and TypeScript.',
}

export default function RootLayout({
  children,
  authModal,
}: {
  children: React.ReactNode
  authModal: React.ReactNode
}) {
  return (
    <html
      lang='en'
      suppressHydrationWarning
      className={inter.className}>
      <head>
        <script
          dangerouslySetInnerHTML={{
            __html: `
              try {
                const theme = localStorage.getItem('theme-preference') || 'system';
                const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
                const effectiveTheme = theme === 'system' ? systemTheme : theme;
                if (effectiveTheme === 'dark') {
                  document.documentElement.classList.add('dark');
                }
              } catch (e) {}
            `,
          }}
        />
      </head>
      <body className='min-h-screen pt-12 bg-background text-foreground antialiased'>
        <ThemeProvider>
          <Providers>
            {/* @ts-expect-error Server Component */}
            <Navbar />
            {authModal}

            <div className='container max-w-7xl mx-auto h-full pt-12'>
              {children}
            </div>
          </Providers>
        </ThemeProvider>
        <Toaster />
      </body>
    </html>
  )
}
