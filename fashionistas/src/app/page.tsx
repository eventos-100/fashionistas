import { MainLayout } from '../layouts/main';
import { FashionLandingView } from '../sections/_fashion/view/fashion-landing-view';

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
      <FashionLandingView />
    </MainLayout>
  );
}
