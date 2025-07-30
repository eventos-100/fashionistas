import { MainLayout } from '../layouts/main';
import { TravelLandingView } from '../sections/_travel/view/travel-landing-view';

// ----------------------------------------------------------------------

export const metadata = { 
  title: 'FashionOS | Luxury Fashion Events',
  description: 'Discover luxury fashion experiences and events in Medellín.'
};

export default function HomePage() {
  return (
    <MainLayout
      sx={{}}
      cssVars={{}}
      slotProps={{
        header: {
          sx: {
            position: { md: 'fixed' },
            bgcolor: { 
              xs: 'background.paper', 
              md: 'rgba(22, 28, 36, 0.8)' 
            },
            backdropFilter: { md: 'blur(8px)' },
            color: { 
              xs: 'text.primary', 
              md: 'common.white' 
            },
          },
        },
      }}
    >
      <TravelLandingView />
    </MainLayout>
  );
}
