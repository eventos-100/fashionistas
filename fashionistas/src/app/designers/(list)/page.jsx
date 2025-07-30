import { _designers } from 'src/_mock';
import { CONFIG } from 'src/global-config';

import { FashionDesignersView } from 'src/sections/_fashion/view/fashion-designers-view';

// ----------------------------------------------------------------------

export const metadata = { title: `Designer Directory | Fashion - ${CONFIG.appName}` };

export default function Page() {
  return <FashionDesignersView designers={_designers} />;
}
