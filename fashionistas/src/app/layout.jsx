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
  title: 'FashionOS | Luxury Fashion Events in Colombia',
  description: 'Experience luxury fashion events, designer showcases, and VIP runway shows in Medellín. Book exclusive access to Colombia\'s premier fashion experiences.',
  keywords: 'fashion events, Medellín fashion, designer showcase, runway shows, fashion week Colombia, luxury events',
  icons: [
    {
      rel: 'icon',
      url: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_32,h_32,c_fit/v1753882356/branding/fashionistas-logo.png',
    },
    {
      rel: 'apple-touch-icon',
      url: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_180,h_180,c_fit/v1753882356/branding/fashionistas-logo.png',
    },
  ],
  openGraph: {
    title: 'FashionOS | Luxury Fashion Events in Colombia',
    description: 'Experience luxury fashion events, designer showcases, and VIP runway shows in Medellín.',
    url: 'https://fashionistas.one',
    siteName: 'FashionOS',
    images: [
      {
        url: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_1200,h_630,c_fill,g_center/v1753881164/fu_044_jekphp.jpg',
        width: 1200,
        height: 630,
        alt: 'FashionOS - Luxury Fashion Events',
      },
    ],
    locale: 'en_US',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'FashionOS | Luxury Fashion Events in Colombia',
    description: 'Experience luxury fashion events, designer showcases, and VIP runway shows in Medellín.',
    images: ['https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_1200,h_630,c_fill,g_center/v1753881164/fu_044_jekphp.jpg'],
  },
};

// ----------------------------------------------------------------------

export default async function RootLayout({ children }) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body>
        <InitColorSchemeScript
          attribute={themeConfig.cssVariables.colorSchemeSelector}
          modeStorageKey={themeConfig.modeStorageKey}
          defaultMode={themeConfig.defaultMode}
        />

        <SettingsProvider defaultSettings={defaultSettings}>
          <LocalizationProvider>
            <AppRouterCacheProvider options={{ key: 'css' }}>
              <ThemeProvider
                themeOverrides={themeOverrides}
                modeStorageKey={themeConfig.modeStorageKey}
                defaultMode={themeConfig.defaultMode}
              >
                <MotionLazy>
                  <ProgressBar />
                  <SettingsDrawer defaultSettings={defaultSettings} />
                  {children}
                </MotionLazy>
              </ThemeProvider>
            </AppRouterCacheProvider>
          </LocalizationProvider>
        </SettingsProvider>
      </body>
    </html>
  );
}

