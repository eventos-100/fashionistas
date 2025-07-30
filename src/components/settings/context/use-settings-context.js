'use client';

import { use } from 'react';

import { SettingsContext } from './settings-context';
import { defaultSettings } from '../settings-config';

// ----------------------------------------------------------------------

export function useSettingsContext() {
  // Handle SSR/SSG case
  if (typeof window === 'undefined') {
    return {
      state: defaultSettings,
      setState: () => {},
      setField: () => {},
      canReset: false,
      onReset: () => {},
      openDrawer: false,
      onCloseDrawer: () => {},
      onToggleDrawer: () => {}
    };
  }

  const context = use(SettingsContext);

  if (!context) throw new Error('useSettingsContext must be use inside SettingsProvider');

  return context;
}
