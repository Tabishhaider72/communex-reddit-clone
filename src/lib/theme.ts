// Theme management utility
export type Theme = 'light' | 'dark' | 'system'

export const STORAGE_KEY = 'theme-preference'

export function getSystemTheme(): 'light' | 'dark' {
  if (typeof window === 'undefined') return 'light'
  return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
}

export function getStoredTheme(): Theme | null {
  if (typeof window === 'undefined') return null
  return (localStorage.getItem(STORAGE_KEY) as Theme) || null
}

export function setStoredTheme(theme: Theme): void {
  if (typeof window === 'undefined') return
  localStorage.setItem(STORAGE_KEY, theme)
}

export function getEffectiveTheme(theme: Theme): 'light' | 'dark' {
  if (theme === 'system') {
    return getSystemTheme()
  }
  return theme
}

export function applyTheme(theme: Theme): void {
  const effectiveTheme = getEffectiveTheme(theme)
  const htmlElement = document.documentElement

  if (effectiveTheme === 'dark') {
    htmlElement.classList.add('dark')
  } else {
    htmlElement.classList.remove('dark')
  }

  setStoredTheme(theme)
}

export function initializeTheme(): void {
  const storedTheme = getStoredTheme()
  const theme = storedTheme || 'system'
  applyTheme(theme)
}
