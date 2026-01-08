# Design Document

## Overview

This design document outlines the systematic approach for renaming Sudomy to OmniDiscovery while preserving all existing functionality. The renaming process will be executed through a structured, file-by-file approach that ensures consistency and maintains the tool's operational integrity.

## Architecture

The renaming process follows a layered approach that addresses different aspects of the codebase:

### Layer 1: Core Identity
- Main executable and primary scripts
- Application name variables and constants
- Banner and branding elements

### Layer 2: Configuration System
- Configuration file names and references
- API configuration files
- Output directory naming conventions

### Layer 3: Documentation and User Interface
- README files and documentation
- Help text and usage examples
- Error messages and user feedback

### Layer 4: Internal References
- Variable names and function identifiers
- Comments and metadata
- Engine and plugin references

## Components and Interfaces

### File Renaming Strategy

**Primary Files:**
- `sudomy` → `omnidiscovery` (main executable)
- `sudomy.conf` → `omnidiscovery.conf` (configuration)
- `sudomy.api` → `omnidiscovery.api` (API keys)

**Configuration Interface:**
The system will maintain backward compatibility by checking for both old and new configuration file names, allowing gradual migration.

### Text Replacement Patterns

**Brand Name Replacements:**
- "Sudomy" → "OmniDiscovery"
- "sudomy" → "omnidiscovery"
- "Sud⍥my" → "OmniDiscovery"
- "SUDOMY" → "OMNIDISCOVERY"

**Application Identifier Updates:**
- `APPNAME="sud⍥my.sh"` → `APPNAME="omnidiscovery.sh"`
- `OUT_NAME="Sudomy-Output"` → `OUT_NAME="OmniDiscovery-Output"`

### Engine Module Updates

Each engine file in the `engine/` directory will be updated to reflect the new tool name in:
- Header comments and metadata
- Function documentation
- Output file references

### Plugin System Modifications

Plugin files will be updated to:
- Reference OmniDiscovery in headers
- Update any tool-specific messaging
- Maintain all existing functionality

## Data Models

### Configuration Structure
```bash
# Main configuration variables
APPNAME="omnidiscovery.sh"
VERSION="1.2.1#dev"
OUT_NAME="OmniDiscovery-Output"

# File naming patterns
omnidiscovery.conf    # Main configuration
omnidiscovery.api     # API keys
omnidiscovery.api.dist # Distribution template
```

### Output File Structure
```
output/
├── MM-DD-YYYY/
│   └── domain.com/
│       ├── subdomain.txt
│       ├── OmniDiscovery-Report.html
│       └── ...
```

## Error Handling

### Backward Compatibility Strategy
1. **Configuration File Fallback**: Check for new names first, then fall back to old names
2. **Gradual Migration**: Support both naming conventions during transition period
3. **User Notification**: Inform users about configuration file migration

### Validation Approach
1. **Functionality Testing**: Verify all engines and plugins work after renaming
2. **Output Verification**: Ensure all output formats remain consistent
3. **Integration Testing**: Test with various command-line options and configurations

## Testing Strategy

### Unit Testing Approach
- **File Existence Tests**: Verify renamed files are accessible
- **Configuration Loading**: Test both old and new configuration file names
- **Output Generation**: Validate output files use new naming conventions

### Integration Testing
- **End-to-End Workflow**: Test complete subdomain enumeration process
- **Plugin Functionality**: Verify all plugins work with renamed tool
- **Report Generation**: Ensure HTML reports display correct branding

### Property-Based Testing Configuration
- **Minimum 100 iterations** per property test
- **Testing Framework**: Bash-based testing with validation scripts
- **Tag Format**: Feature: sudomy-to-omnidiscovery-rename, Property {number}: {property_text}

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system-essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property 1: Branding Consistency in Output
*For any* execution of the main script, all displayed text should contain "OmniDiscovery" branding and no references to "Sudomy"
**Validates: Requirements 1.1, 1.5, 4.1**

### Property 2: Documentation Branding Completeness
*For any* documentation file in the system, the content should reference "OmniDiscovery" as the tool name and contain no "Sudomy" references
**Validates: Requirements 1.2, 4.2**

### Property 3: Output File Naming Convention
*For any* generated output file, the file name or header should contain "OmniDiscovery" references where tool branding is expected
**Validates: Requirements 1.3, 7.2**

### Property 4: Configuration File Compatibility
*For any* configuration loading operation, the system should successfully load from both new (omnidiscovery.*) and old (sudomy.*) configuration file names
**Validates: Requirements 5.1, 5.2**

### Property 5: Functionality Preservation
*For any* core functionality (enumeration, analysis, reporting), the renamed system should produce equivalent results to the original system
**Validates: Requirements 2.4, 3.4, 6.1, 6.2**

### Property 6: Variable Naming Consistency
*For any* variable or function name in the codebase, references to the application should use "omnidiscovery" variants instead of "sudomy" variants
**Validates: Requirements 3.1, 3.2**

### Property 7: Engine and Plugin Integration
*For any* engine or plugin execution, all third-party integrations and analysis capabilities should function identically to the original system
**Validates: Requirements 6.1, 6.2, 6.4, 6.5**

### Property 8: Report Template Branding
*For any* generated HTML report, the template should display "OmniDiscovery" branding in titles, headers, and metadata
**Validates: Requirements 7.1, 7.4**

### Property 9: Error Message Consistency
*For any* error condition, displayed messages should reference "OmniDiscovery" in context where tool identification is relevant
**Validates: Requirements 4.3**

### Property 10: Metadata and Attribution Updates
*For any* file containing metadata or attribution, the tool references should be updated to "OmniDiscovery" while preserving original author credits
**Validates: Requirements 8.2, 8.4, 8.5**