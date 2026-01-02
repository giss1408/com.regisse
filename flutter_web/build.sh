#!/bin/bash

# Build script for Regisse Business Solutions Flutter Web

echo "🚀 Building Regisse Business Solutions..."

# Clean previous build
flutter clean

# Get dependencies
flutter pub get

# Analyze code
echo "🔍 Analyzing code..."
flutter analyze

# Run tests
echo "🧪 Running tests..."
flutter test

# Build for web
echo "🌐 Building for web..."
flutter build web \
  --release \
  --web-renderer canvaskit \
  --dart-define=FLUTTER_WEB_CANVASKIT_URL=/canvaskit/ \
  --base-href / \
  --pwa-strategy offline-first

# Optimize images
echo "🖼️ Optimizing images..."
find build/web/assets/images -name "*.jpg" -exec jpegoptim --strip-all {} \;
find build/web/assets/images -name "*.png" -exec optipng -o7 {} \;

# Generate sitemap
echo "🗺️ Generating sitemap..."
cat > build/web/sitemap.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://regissebusiness.com/</loc>
    <lastmod>2024-01-15</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://regissebusiness.com/services</loc>
    <lastmod>2024-01-15</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.9</priority>
  </url>
  <url>
    <loc>https://regissebusiness.com/locations</loc>
    <lastmod>2024-01-15</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>
  <url>
    <loc>https://regissebusiness.com/blog</loc>
    <lastmod>2024-01-15</lastmod>
    <changefreq>daily</changefreq>
    <priority>0.7</priority>
  </url>
  <url>
    <loc>https://regissebusiness.com/contact</loc>
    <lastmod>2024-01-15</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.6</priority>
  </url>
</urlset>
EOF

# Generate robots.txt
echo "🤖 Generating robots.txt..."
cat > build/web/robots.txt << 'EOF'
User-agent: *
Allow: /
Sitemap: https://regissebusiness.com/sitemap.xml

# Disallow admin areas
Disallow: /admin/
Disallow: /api/
EOF

echo "✅ Build completed successfully!"
echo "📁 Output: build/web/"
echo "🌐 To run locally: flutter run -d chrome"