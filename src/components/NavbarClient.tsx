'use client'

import { ThemeToggle } from './ThemeToggle'
import { Suspense } from 'react'

function ThemeToggleWrapper() {
  return (
    <Suspense fallback={<div className='w-9 h-9' />}>
      <ThemeToggle />
    </Suspense>
  )
}

export function NavbarThemeToggle() {
  return <ThemeToggleWrapper />
}
