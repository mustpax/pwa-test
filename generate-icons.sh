#!/bin/bash

# Create icons directory if it doesn't exist
mkdir -p public/icons

# Generate icons in different sizes
sizes=(72 96 128 144 152 192 384 512)

for size in "${sizes[@]}"; do
    rsvg-convert -w "${size}" -h "${size}" public/favicon.svg -o "public/icons/icon-${size}x${size}.png"
done

echo "Icons generated successfully!"