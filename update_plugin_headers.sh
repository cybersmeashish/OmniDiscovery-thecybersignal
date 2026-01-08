#!/bin/bash

# Update all plugin file headers from Sudomy to OmniDiscovery
PLUGIN_DIR="OmniDiscovery/plugin"

echo "Updating plugin file headers..."

for file in "$PLUGIN_DIR"/*; do
    if [ -f "$file" ]; then
        echo "Updating $file..."
        
        # Update the filename line
        sed -i '' 's/Filename: Sudomy - Subdomain Enumeration & Analysis/Filename: OmniDiscovery - Subdomain Enumeration \& Analysis/g' "$file"
        
        # Update the project reference
        sed -i '' 's/This file is part of Sudomy project/This file is part of OmniDiscovery project/g' "$file"
        
        # Update any example commands in comments
        sed -i '' 's/Sudomy  -d example.com/OmniDiscovery  -d example.com/g' "$file"
        sed -i '' 's/Sudomy -d example.com/OmniDiscovery -d example.com/g' "$file"
        
        echo "Updated $file"
    fi
done

echo "All plugin files updated!"