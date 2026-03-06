#!/bin/bash
set -e

# Build Next.js
npm ci
npm run build

# Generate products.json
node scripts/build-products-json.js

# Assemble everything in 'deploy'
mkdir -p deploy/public/api

# Copy Next.js static export
cp -r out/* deploy/public/

# Copy PHP API files
cp php/api/*.php deploy/public/api/
cp php/api/products.json deploy/public/api/

# Copy .htaccess
cp php/.htaccess deploy/public/.htaccess

# Copy Composer vendor (outside public for security) if it exists
if [ -d "vendor" ]; then
  cp -r vendor deploy/vendor
fi
