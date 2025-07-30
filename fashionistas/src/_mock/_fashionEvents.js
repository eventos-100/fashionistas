import { fAdd } from 'src/utils/format-time';
import { _mock } from './_mock';

// Fashion event types
export const FASHION_EVENT_TYPES = [
  { value: 'runway-show', label: 'Runway Show' },
  { value: 'designer-showcase', label: 'Designer Showcase' },
  { value: 'fashion-week', label: 'Fashion Week' },
  { value: 'trunk-show', label: 'Trunk Show' },
  { value: 'pop-up-shop', label: 'Pop-up Shop' },
  { value: 'fashion-gala', label: 'Fashion Gala' },
  { value: 'designer-meet', label: 'Designer Meet & Greet' },
  { value: 'fashion-workshop', label: 'Fashion Workshop' },
];

// Fashion event ticket tiers
export const FASHION_TICKET_TIERS = [
  { value: 'general', label: 'General Admission', price: 99 },
  { value: 'vip', label: 'VIP Access', price: 249 },
  { value: 'platinum', label: 'Platinum Experience', price: 499 },
  { value: 'designer', label: 'Designer Circle', price: 999 },
];

// Generate fashion events
export const _fashionEvents = [...Array(24)].map((_, index) => {
  const eventTypes = ['Runway Show', 'Fashion Week', 'Designer Showcase', 'Fashion Gala', 'Trunk Show'];
  const designers = ['Valentino', 'Versace', 'Chanel', 'Dior', 'Gucci', 'Prada', 'Armani', 'YSL'];
  const cities = ['Milan', 'Paris', 'New York', 'London', 'Tokyo', 'Miami', 'Los Angeles', 'Dubai'];
  
  const city = cities[index % cities.length];
  const eventType = eventTypes[index % eventTypes.length];
  const designer = designers[index % designers.length];
  
  const event = {
    id: _mock.id(index),
    slug: `${designer.toLowerCase()}-${eventType.toLowerCase().replace(' ', '-')}-${city.toLowerCase()}`,
    name: `${designer} ${eventType}`,
    location: city,
    venue: `${city} Fashion Center`,
    
    // Dates
    startDate: fAdd({ months: index % 3 }),
    endDate: fAdd({ months: index % 3, days: index % 2 + 1 }),
    
    // Pricing
    price: 99 + (index * 50) % 400,
    priceSale: index % 3 === 0 ? 99 + (index * 30) % 300 : null,
    
    // Event details
    capacity: 200 + (index * 50) % 800,
    attendees: 150 + (index * 30) % 600,
    eventType: FASHION_EVENT_TYPES[index % FASHION_EVENT_TYPES.length].value,
    
    // Images
    coverUrl: _mock.image.travel(index),
    images: [...Array(4)].map((_, imgIndex) => _mock.image.travel(imgIndex + index)),
    gallery: [...Array(8)].map((_, imgIndex) => ({
      id: _mock.id(imgIndex),
      url: _mock.image.travel(imgIndex + index * 2),
      title: `${designer} Collection ${imgIndex + 1}`,
    })),
    
    // Description
    description: `Experience the elegance and innovation of ${designer}'s latest collection at this exclusive ${eventType.toLowerCase()} in ${city}. Join fashion enthusiasts and industry professionals for an unforgettable showcase of haute couture and ready-to-wear designs.`,
    
    highlights: [
      'Exclusive preview of new collection',
      'Meet the design team',
      'Champagne reception',
      'Gift bag with designer items',
      'Professional photography',
      'VIP after-party access',
    ].slice(0, 4 + (index % 3)),
    
    // Features
    includes: [
      'Front row seating',
      'Backstage access',
      'Designer meet & greet',
      'Complimentary drinks',
      'Event program',
      'Digital lookbook',
    ].slice(0, 3 + (index % 4)),
    
    // Ratings
    ratingNumber: 4.2 + (index % 8) * 0.1,
    totalReviews: 100 + index * 50,
    
    // Tags
    tags: [designer, eventType, city, 'Fashion', 'Luxury'],
    
    // Ticket tiers
    ticketTiers: FASHION_TICKET_TIERS.map((tier, tierIndex) => ({
      ...tier,
      available: tier.value === 'general' ? 100 - index * 5 : 50 - index * 2,
      benefits: [
        'Event access',
        ...(tierIndex > 0 ? ['Priority seating'] : []),
        ...(tierIndex > 1 ? ['VIP lounge access', 'Meet & greet'] : []),
        ...(tierIndex > 2 ? ['Private viewing', 'Exclusive gift bag'] : []),
      ],
    })),
    
    // Status
    available: index < 20,
    featured: index < 4,
    soldOut: index > 18,
    
    // SEO
    metaTitle: `${designer} ${eventType} ${city} | Fashion Events`,
    metaDescription: `Join us for ${designer}'s exclusive ${eventType.toLowerCase()} in ${city}. Experience luxury fashion at its finest.`,
  };
  
  return event;
});

// Helper functions
export const getFeaturedEvents = () => _fashionEvents.filter(event => event.featured);
export const getUpcomingEvents = () => _fashionEvents.filter(event => event.available && !event.soldOut);
export const getEventsByCity = (city) => _fashionEvents.filter(event => event.location === city);
export const getEventsByDesigner = (designer) => _fashionEvents.filter(event => event.tags.includes(designer));
