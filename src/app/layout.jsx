import 'src/global.css';

import InitColorSchemeScript from '@mui/material/InitColorSchemeScript';

import { AppRouterCacheProvider } from '@mui/material-nextjs/v15-appRouter';

import { CONFIG } from 'src/global-config';
import { LocalizationProvider } from 'src/locales';
import { themeOverrides } from 'src/theme/theme-overrides';
import { themeConfig, ThemeProvider, primary as primaryColor } from 'src/theme';

import { ProgressBar } from 'src/components/progress-bar';
import { MotionLazy } from 'src/components/animate/motion-lazy';
import { SettingsDrawer, defaultSettings, SettingsProvider } from 'src/components/settings';

// ----------------------------------------------------------------------

export const viewport = {
  width: 'device-width',
  initialScale: 1,
  themeColor: primaryColor.main,
};

export const metadata = {
  title: 'Fashionistas - Fashion Event Management Platform',
  description: 'Premier platform for fashion shows, runway events, and industry gatherings',
  keywords: 'fashion events, runway shows, fashion week, event management',
  icons: [
    {
      rel: 'icon',
      url: '/fashionistas_icon.jpg',
    },
  ],
};

// ----------------------------------------------------------------------

export default function RootLayout({ children }) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body>
        <InitColorSchemeScript
          attribute="data-theme"
          defaultMode={defaultSettings.colorScheme}
        />

        <LocalizationProvider>
          <SettingsProvider settings={defaultSettings}>
            <AppRouterCacheProvider options={{ key: 'css' }}>
              <ThemeProvider
                defaultMode={defaultSettings.colorScheme}
                modeStorageKey="theme-color-scheme"
                themeOverrides={themeOverrides}
                themeConfig={themeConfig}
              >
                {/**
                 * If you want to set a default mode at the server side,
                 * add it as a prop like: `defaultMode="light"`
                 */}
                <MotionLazy>
                  <ProgressBar />
                  <SettingsDrawer />
                  {children}
                </MotionLazy>
              </ThemeProvider>
            </AppRouterCacheProvider>
          </SettingsProvider>
        </LocalizationProvider>
      </body>
    </html>
  );
}

