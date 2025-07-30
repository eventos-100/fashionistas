import { MainLayout } from 'src/layouts/main';

// ----------------------------------------------------------------------

export default function FashionLayout({ children }) {
  return (
    <MainLayout
      slotProps={{
        header: {
          sx: {
            position: { md: 'fixed' },
            color: { md: 'common.white' },
          },
        },
      }}
    >
      {children}
    </MainLayout>
  );
}
