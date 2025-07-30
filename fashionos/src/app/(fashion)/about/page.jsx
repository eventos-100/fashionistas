import { CONFIG } from 'src/global-config';

import { FashionAboutView } from 'src/sections/_fashion/view/fashion-about-view';

// ----------------------------------------------------------------------

export const metadata = { title: `About us | Fashion - ${CONFIG.appName}` };

export default function Page() {
  return <FashionAboutView />;
}
