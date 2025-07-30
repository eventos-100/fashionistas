import { _tours } from '../../../../_mock';
import { CONFIG } from '../../../../global-config';

import { TravelToursView } from '../../../../sections/_travel/view/travel-tours-view';

// ----------------------------------------------------------------------

export const metadata = { title: `Tour list | Travel - ${CONFIG.appName}` };

export default function Page() {
  return <TravelToursView tours={_tours} />;
}
