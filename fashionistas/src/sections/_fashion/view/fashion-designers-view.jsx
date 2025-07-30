'use client';

import Container from '@mui/material/Container';

import { FashionNewsletter } from '../fashion-newsletter';
import { FashionDesignerHero } from '../fashion-designer-hero';
import { FashionDesignerSpotlight } from '../fashion-designer-spotlight';
import { FashionDesignerFilters } from '../filters/fashion-designer-filters';
import { FashionDesignerList } from '../list/fashion-designer-list';
import { FashionCitiesGrid } from '../fashion-cities-grid';
import { FashionDesignerServices } from '../fashion-designer-services';

// ----------------------------------------------------------------------

export function FashionDesignersView({ designers }) {
  return (
    <>
      <FashionDesignerHero />
      
      <Container sx={{ mt: -8, position: 'relative', zIndex: 9 }}>
        <FashionDesignerSpotlight />
      </Container>
      
      <Container>
        <FashionDesignerFilters
          sx={{
            mt: { xs: 3, md: 5 },
            mb: { xs: 3, md: 5 },
          }}
        />
        <FashionDesignerList designers={designers || []} />
      </Container>

      <FashionCitiesGrid />
      
      <FashionDesignerServices />

      <FashionNewsletter />
    </>
  );
}
