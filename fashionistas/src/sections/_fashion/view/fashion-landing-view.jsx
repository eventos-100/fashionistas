'use client';

import { varAlpha } from 'minimal-shared/utils';

import Box from '@mui/material/Box';
import Container from '@mui/material/Container';

// Import fashion events data
import { _tours } from 'src/_mock';
import { _travelPosts, _testimonials } from 'src/_mock';
import { _designers } from 'src/_mock/_designers';
import { _partners } from 'src/_mock/_partners';

// Import existing components
import { TravelNewsletter } from '../../_travel/travel-newsletter';
import { TravelTestimonial } from '../../_travel/travel-testimonial';
import { TravelLandingHero } from '../../_travel/landing/travel-landing-hero';
import { TravelLandingPosts } from '../../_travel/posts/travel-landing-posts';
import { TravelLandingSummary } from '../../_travel/landing/travel-landing-summary';
import { TravelLandingIntroduce } from '../../_travel/landing/travel-landing-introduce';
import { TravelLandingToursByCity } from '../../_travel/landing/travel-landing-tours-by-city';
import { TravelLandingTourFeatured } from '../../_travel/landing/travel-landing-tour-featured';
import { TravelLandingFavoriteDestinations } from '../../_travel/landing/travel-landing-favorite-destinations';

// ----------------------------------------------------------------------

// Transform tour data into fashion events
const fashionEventNames = [
  'Valentino Runway Show',
  'Versace Fashion Week',
  'Chanel Designer Showcase',
  'Dior Fashion Gala',
  'Gucci Trunk Show',
  'Prada Runway Show',
  'Armani Fashion Week',
  'YSL Designer Showcase'
];

const fashionCities = ['Milan', 'Paris', 'New York', 'London', 'Tokyo', 'Miami', 'Los Angeles', 'Dubai'];

// Transform tours into fashion events
const fashionEvents = _tours.map((tour, index) => ({
  ...tour,
  name: fashionEventNames[index % fashionEventNames.length],
  location: fashionCities[index % fashionCities.length],
  slug: fashionEventNames[index % fashionEventNames.length], // Use fashion name as slug
  price: 99 + (index * 50) % 400,
  description: `Experience the elegance and innovation of ${fashionEventNames[index % fashionEventNames.length].split(' ')[0]}'s latest collection at this exclusive fashion event in ${fashionCities[index % fashionCities.length]}.`
}));

// Use fashion events instead of tours
const heroEvents = fashionEvents.slice(0, 5);
const cityEvents = fashionEvents.slice(0, 8);
const featuredEvents = fashionEvents.slice(0, 4);
const favoriteEvents = fashionEvents.slice(0, 4);
const posts = _travelPosts.slice(5, 8);

export function FashionLandingView() {
  return (
    <>
      {/* Hero Section - Reuse travel hero with fashion events */}
      <Box component="section" sx={{ position: 'relative' }}>
        <TravelLandingHero tours={heroEvents} />
        
        {/* Search/Filter Bar */}
        <Container
          sx={(theme) => ({
            pt: 3,
            pb: 10,
            [theme.breakpoints.up('md')]: {
              pt: 0,
              mb: 10,
              left: 0,
              right: 0,
              bottom: 0,
              position: 'absolute',
            },
          })}
        >
          {/* This would contain fashion event search filters */}
        </Container>
      </Box>

      {/* Introduce Fashion Events */}
      <TravelLandingIntroduce />

      {/* Summary Stats */}
      <TravelLandingSummary />

      {/* Fashion Destinations */}
      <TravelLandingFavoriteDestinations tours={favoriteEvents} />

      {/* Featured Fashion Events */}
      <TravelLandingTourFeatured tours={featuredEvents} />

      {/* Fashion Events by City */}
      <TravelLandingToursByCity tours={cityEvents} />

      {/* Fashion Blog Posts */}
      <Box sx={{ py: { xs: 10, md: 15 } }}>
        <Container>
          <TravelLandingPosts posts={posts} />
        </Container>
      </Box>

      {/* Testimonials */}
      <TravelTestimonial testimonials={_testimonials} />

      {/* Newsletter */}
      <TravelNewsletter />
    </>
  );
}
