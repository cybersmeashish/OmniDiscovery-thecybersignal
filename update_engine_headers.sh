#!/bin/bash

# Update all engine file headers from Sudomy to OmniDiscovery
ENGINE_DIR="OmniDiscovery/engine"

echo "Updating engine file headers..."

for file in "$ENGINE_DIR"/*.my; do
    if [ -f "$file" ]; then
        echo "Updating $file..."
        
        # Update the filename line
        sed -i '' 's/Filename: Sudomy - Subdomain Enumeration & Analysis/Filename: OmniDiscovery - Subdomain Enumeration \& Analysis/g' "$file"
        
        # Update the project reference
        sed -i '' 's/This file is part of Sudomy project/This file is part of OmniDiscovery project/g' "$file"
        
        echo "Updated $file"
    fi
done

echo "All engine files updated!"