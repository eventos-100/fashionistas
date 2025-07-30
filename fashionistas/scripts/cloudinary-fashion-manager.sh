#!/bin/bash

# FashionOS Cloudinary Management Script
# Manages fashion images for production-ready deployment

# Set Cloudinary credentials
export CLOUDINARY_URL=cloudinary://314599957976619:aoiYMvb6YMjgF4IfBvbt9yhauiY@dzqy2ixl0

echo "🎨 FashionOS Cloudinary Management Tool"
echo "======================================="

# Function to display menu
show_menu() {
    echo ""
    echo "Available Commands:"
    echo "1. List fashion images by folder"
    echo "2. Generate optimized URLs for hero section"
    echo "3. Generate URLs for event images"
    echo "4. Generate URLs for lifestyle/designer images"
    echo "5. Create fashion image reference file"
    echo "6. Upload new images to fashion folder"
    echo "7. Search for specific images"
    echo "8. Generate production-ready image URLs"
    echo "9. Exit"
    echo ""
}

# Function to generate production URLs with all optimizations
generate_production_urls() {
    echo "🚀 PRODUCTION-READY URLS FOR FASHIONOS"
    echo "======================================="
    echo ""
    
    echo "Copy these optimized URLs into your React components:"
    echo ""
    
    echo "# 1. HERO SECTION IMAGES (1920x1080 optimized)"
    echo "https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_1920,h_1080,c_fill,g_center/v1753881164/fu_044_jekphp.jpg"
    echo "https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_1920,h_1080,c_fill,g_center/v1753881165/fu_051_ot4esa.jpg"
    echo "https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_1920,h_1080,c_fill,g_center/v1753881163/fu_045_xp9jln.jpg"
    echo "https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_1920,h_1080,c_fill,g_center/v1753881161/fu_032_rho9fv.jpg"
    echo "https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_1920,h_1080,c_fill,g_center/v1753881161/fu_014_kplkhu.jpg"
    echo ""
    
    echo "# 2. INTRODUCTION SECTION (1200x800)"
    echo "https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_1200,h_800,c_fill,g_center/v1753881164/fu_048_lncqda.jpg"
    echo ""
    
    echo "# 3. FEATURED EVENTS (800x600)"
    echo "https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_800,h_600,c_fill,g_center/v1753881238/fu_020_qvzsyb.jpg"
    echo "https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_800,h_600,c_fill,g_center/v1753881241/fu_041_w7ejur.jpg"
    echo "https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_800,h_600,c_fill,g_center/v1753881240/fu_040_jf3cqa.jpg"
    echo "https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_800,h_600,c_fill,g_center/v1753881239/fu_034_t4qeyk.jpg"
    echo ""
    
    echo "# 4. DESIGNER PROFILES (400x400 square)"
    echo "https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_400,h_400,c_fill,g_face/v1753881098/style_023_hgpv3i.jpg"
    echo "https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_400,h_400,c_fill,g_face/v1753881097/style_019_rk96sv.jpg"
    echo "https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_400,h_400,c_fill,g_face/v1753881096/style_012_au1j7m.jpg"
    echo ""
}

# Quick production URLs generation
generate_production_urls

echo "🎯 NEXT STEPS:"
echo "1. Update your hero carousel with these optimized images"
echo "2. Replace introduction section image"
echo "3. Update featured events with fashion venue photos"
echo "4. Add designer profile images"
echo ""
echo "All URLs are production-optimized with:"
echo "✅ Auto format (WebP/AVIF for modern browsers)"
echo "✅ Auto quality optimization"
echo "✅ Proper sizing for each section"  
echo "✅ Smart cropping (face detection for profiles)"
echo "✅ Fast CDN delivery"
