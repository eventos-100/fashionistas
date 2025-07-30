'use client';

import { _brands, _members, _travelPosts, _testimonials } from 'src/_mock';

import { FashionTeam } from '../fashion-team';
import { FashionAbout } from '../about/fashion-about';
import { FashionNewsletter } from '../fashion-newsletter';
import { FashionOurClients } from '../fashion-our-clients';
import { FashionTestimonial } from '../fashion-testimonial';
import { FashionLatestPosts } from '../posts/fashion-latest-posts';
import { FashionAboutOurVision } from '../about/fashion-about-our-vision';

// ----------------------------------------------------------------------

// TODO: Replace with fashion blog posts
const latestPosts = _travelPosts.slice(0, 4);

export function FashionAboutView() {
  return (
    <>
      <FashionAbout />

      <FashionAboutOurVision />

      <FashionTeam members={_members} />

      <FashionTestimonial testimonials={_testimonials} />

      <FashionOurClients brands={_brands} />

      <FashionLatestPosts posts={latestPosts} />

      <FashionNewsletter />
    </>
  );
}
