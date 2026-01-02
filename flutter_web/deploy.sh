#!/bin/bash

# Deployment script for Firebase/GitHub Pages

echo "🚀 Deploying Regisse Business Solutions..."

# Check if build exists
if [ ! -d "build/web" ]; then
  echo "❌ No build found. Run ./build.sh first."
  exit 1
fi

# Deploy to Firebase (uncomment if using Firebase)
# echo "🔥 Deploying to Firebase..."
# firebase deploy --only hosting

# Deploy to GitHub Pages (alternative)
echo "🐙 Deploying to GitHub Pages..."
cp build/web CNAME 2>/dev/null || true

# Or deploy to any static hosting
echo "📤 Build ready for deployment:"
echo "   Directory: build/web"
echo "   Size: $(du -sh build/web | cut -f1)"
echo ""
echo "📋 Deployment options:"
echo "   1. Firebase: firebase deploy"
echo "   2. Netlify: netlify deploy --prod"
echo "   3. Vercel: vercel --prod"
echo "   4. AWS S3: aws s3 sync build/web s3://your-bucket"
echo ""
echo "✅ Deployment preparation complete!"