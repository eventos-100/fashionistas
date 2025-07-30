import { fAdd } from 'src/utils/format-time';

import { CONFIG } from 'src/global-config';
import { countries } from 'src/assets/data';

import { _mock } from './_mock';
import { _tags } from './assets';

// ----------------------------------------------------------------------

export const TOUR_SERVICE_OPTIONS = [
  { value: 'Audio guide', label: 'Audio guide' },
  { value: 'Food and drinks', label: 'Food and drinks' },
  { value: 'Lunch', label: 'Lunch' },
  { value: 'Private tour', label: 'Private tour' },
  { value: 'Special activities', label: 'Special activities' },
  { value: 'Entrance fees', label: 'Entrance fees' },
  { value: 'Gratuities', label: 'Gratuities' },
  { value: 'Pick-up and drop off', label: 'Pick-up and drop off' },
  { value: 'Professional guide', label: 'Professional guide' },
  {
    value: 'Transport by air-conditioned',
    label: 'Transport by air-conditioned',
  },
];

const determineContinent = (index) => {
  if ([1, 2].includes(index)) return 'Asia';
  if ([3, 4].includes(index)) return 'Europe';
  if ([5, 6].includes(index)) return 'Africa';
  if ([7, 8].includes(index)) return 'Australia';
  if ([9, 10].includes(index)) return 'South America';
  return 'Africa';
};

const generateServices = (index) => {
  if (index % 2 === 0) return ['Audio guide', 'Food and drinks'];
  if (index % 3 === 0) return ['Lunch', 'Private tour'];
  if (index % 4 === 0) return ['Special activities', 'Entrance fees'];
  return [
    'Gratuities',
    'Pick-up and drop off',
    'Professional guide',
    'Transport by air-conditioned',
  ];
};

const generateProgram = () =>
  Array.from({ length: 3 }, (_, itemIndex) => ({
    label: `Day ${itemIndex + 1}`,
    text: _mock.description(itemIndex),
  }));

const generateGallery = () => Array.from({ length: 6 }, (_, index) => _mock.image.travel(index));

const generateHighlights = () => Array.from({ length: 6 }, (_, index) => _mock.sentence(index));

const generateHeroUrl = (index) =>
  [
    `${CONFIG.assetsDir}/assets/images/travel/travel-large-1.webp`,
    `${CONFIG.assetsDir}/assets/images/travel/travel-large-2.webp`,
    `${CONFIG.assetsDir}/assets/images/travel/travel-large-3.webp`,
    `${CONFIG.assetsDir}/assets/images/travel/travel-large-4.webp`,
    `${CONFIG.assetsDir}/assets/images/travel/travel-large-5.webp`,
  ][index];

// ----------------------------------------------------------------------

// Fashion Events Data
const fashionEvents = [
  {
    id: '1',
    slug: 'Runway Collection',
    location: 'Skybox Medellín',
    price: 99,
    coverUrl: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/v1738223985/cruise-fashion_f1gaxb.jpg',
    heroUrl: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/v1753554437/RUNWAy-4_mv4pll.jpg',
    favorited: false,
    description: 'High-fashion runway showcasing contemporary designers and emerging talent',
    continent: 'South America',
    priceSale: 0,
  },
  {
    id: '2',
    slug: 'Fashion Party',
    location: 'Teatro Metropolitano',
    price: 149,
    coverUrl: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/v1738223218/june-fashion_jya3sr.jpg',
    heroUrl: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/v1753554437/RUNWAy-4_mv4pll.jpg',
    favorited: false,
    description: 'Elegant intimate apparel collection showcasing contemporary design',
    continent: 'South America',
    priceSale: 0,
  },
  {
    id: '3',
    slug: 'VIP Experience',
    location: 'Hotel Intercontinental',
    price: 299,
    coverUrl: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/v1738223082/May-fashion_kbkveb.jpg',
    heroUrl: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/v1753554437/RUNWAy-4_mv4pll.jpg',
    favorited: false,
    description: 'Exclusive VIP experience with designer meet & greet and premium seating',
    continent: 'South America',
    priceSale: 0,
  },
  {
    id: '4',
    slug: 'Designer Showcase',
    location: 'Centro Colombo Americano',
    price: 199,
    coverUrl: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/v1738223985/cruise-fashion_f1gaxb.jpg',
    heroUrl: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/v1753554437/RUNWAy-4_mv4pll.jpg',
    favorited: false,
    description: 'Featured collections from top Colombian fashion designers',
    continent: 'South America',
    priceSale: 0,
  }
];

// Generate remaining events for compatibility
export const _tours = [
  ...fashionEvents,
  ...Array.from({ length: 8 }, (_, index) => {
    const realIndex = index + 4;
    const tourGuide = {
      verified: true,
      role: _mock.role(realIndex),
      name: _mock.fullName(realIndex),
      avatarUrl: _mock.image.avatar(realIndex),
      quotes: 'Member since Mar 15, 2021',
      phoneNumber: _mock.phoneNumber(realIndex),
      ratingNumber: _mock.number.rating(realIndex),
      totalReviews: _mock.number.nativeL(realIndex),
      about: 'Integer tincidunt. Nullam dictum felis eu pede mollis pretium.',
      shareLinks: {
        facebook: 'https://facebook.example.com',
        instagram: 'https://instagram.example.com',
        linkedin: 'https://linkedin.example.com',
        twitter: 'https://twitter.example.com',
      },
    };

    return {
      id: _mock.id(realIndex),
      tourGuide,
      tags: _tags.slice(0, 5),
      gallery: generateGallery(),
      program: generateProgram(),
      slug: _mock.tourName(realIndex),
      duration: '3 days 2 nights',
      createdAt: _mock.time(realIndex),
      heroUrl: generateHeroUrl(realIndex),
      favorited: _mock.boolean(realIndex),
      highlights: generateHighlights(),
      price: _mock.number.price(realIndex),
      services: generateServices(realIndex),
      coverUrl: _mock.image.travel(realIndex),
      continent: determineContinent(realIndex),
      description: _mock.description(realIndex),
      ratingNumber: _mock.number.rating(realIndex),
      totalReviews: _mock.number.nativeL(realIndex),
      languages: ['English', 'Russian', 'Spanish'],
      location: countries.map((option) => option.label)[realIndex + 1],
      priceSale: (realIndex === 2 && 89.99) || (realIndex === 5 && 69.99) || 0,
      available: {
        start: fAdd({ months: 2 }),
        end: fAdd({ months: 4 }),
      },
      shareLinks: {
        facebook: 'https://facebook.example.com',
        instagram: 'https://instagram.example.com',
        linkedin: 'https://linkedin.example.com',
        twitter: 'https://twitter.example.com',
      },
    };
  })
];
