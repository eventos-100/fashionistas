import { addCollection } from '@iconify/react';

import allIcons from './icon-sets';
import { additionalIcons } from './icon-sets-additions';

// ----------------------------------------------------------------------

// Merge all icons with additional icons
const mergedIcons = { ...allIcons, ...additionalIcons };

export const iconSets = Object.entries(mergedIcons).reduce((acc, [key, value]) => {
  const [prefix, iconName] = key.split(':');
  const existingPrefix = acc.find((item) => item.prefix === prefix);

  if (existingPrefix) {
    existingPrefix.icons[iconName] = value;
  } else {
    acc.push({
      prefix,
      icons: {
        [iconName]: value,
      },
    });
  }

  return acc;
}, []);

export const allIconNames = Object.keys(mergedIcons);

// ----------------------------------------------------------------------

let areIconsRegistered = false;

export function registerIcons() {
  if (areIconsRegistered) {
    return;
  }

  iconSets.forEach((iconSet) => {
    const iconSetConfig = {
      ...iconSet,
      width: (iconSet.prefix === 'carbon' && 32) || 24,
      height: (iconSet.prefix === 'carbon' && 32) || 24,
    };

    addCollection(iconSetConfig);
  });

  areIconsRegistered = true;
}
