#!/bin/bash

# Update all HTML template files from Sudomy to OmniDiscovery
TEMPLATE_DIR="OmniDiscovery/templates"

echo "Updating HTML template files..."

find "$TEMPLATE_DIR" -name "*.html" -type f | while read file; do
    echo "Updating $file..."
    
    # Update page titles
    sed -i '' 's/Sudomy | Dashboard/OmniDiscovery | Dashboard/g' "$file"
    
    # Update CSS asset paths
    sed -i '' 's/assets\/sudomy\/sudomy\//assets\/omnidiscovery\/omnidiscovery\//g' "$file"
    
    # Update any other sudomy references in paths
    sed -i '' 's/sudomy\.css/omnidiscovery.css/g' "$file"
    
    echo "Updated $file"
done

echo "All HTML template files updated!"