'use client';

import { useMemo } from 'react';
import CssBaseline from '@mui/material/CssBaseline';
import { ThemeProvider as ThemeVarsProvider } from '@mui/material/styles';

import { useSettingsContext } from 'src/components/settings';
import { defaultSettings } from 'src/components/settings/settings-config';

import { createTheme } from './create-theme';
import { Rtl } from './with-settings/right-to-left';

// ----------------------------------------------------------------------

export function ThemeProvider({ themeOverrides, children, ...other }) {
  const settingsContext = useSettingsContext();
  
  // CRITICAL FIX: Provide fallback during SSR/SSG
  const settings = settingsContext || {
    state: defaultSettings,
    setState: () => {},
    setField: () => {}
  };

  const theme = useMemo(
    () => createTheme({
      settingsState: settings.state,
      themeOverrides,
    }),
    [settings.state, themeOverrides]
  );

  const direction = settings.state?.direction || 'ltr';

  return (
    <ThemeVarsProvider disableTransitionOnChange theme={theme} {...other}>
      <CssBaseline />
      <Rtl direction={direction}>{children}</Rtl>
    </ThemeVarsProvider>
  );
}
