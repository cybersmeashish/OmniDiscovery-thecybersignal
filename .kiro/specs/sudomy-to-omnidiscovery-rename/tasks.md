# Implementation Plan: Sudomy to OmniDiscovery Rename

## Overview

This implementation plan provides a systematic approach to rename Sudomy to OmniDiscovery while preserving all functionality. The tasks are organized to minimize disruption and ensure thorough testing at each stage.

## Tasks

- [x] 1. Prepare backup and setup validation environment
  - Create backup of original Sudomy codebase
  - Set up testing environment for validation
  - Document current functionality baseline
  - _Requirements: All requirements (safety measure)_

- [x] 1.1 Write property test for functionality preservation baseline
  - **Property 5: Functionality Preservation**
  - **Validates: Requirements 2.4, 3.4, 6.1, 6.2**

- [ ] 2. Rename core executable and primary files
  - [x] 2.1 Rename main executable from "sudomy" to "omnidiscovery"
    - Update file name and ensure executable permissions
    - _Requirements: 2.1_

  - [x] 2.2 Rename configuration files
    - Rename sudomy.conf to omnidiscovery.conf
    - Rename sudomy.api.dist to omnidiscovery.api.dist
    - _Requirements: 2.2, 5.1_

  - [x] 2.3 Write property test for file existence and accessibility
    - **Property 4: Configuration File Compatibility**
    - **Validates: Requirements 5.1, 5.2**

- [ ] 3. Update main script branding and variables
  - [x] 3.1 Update application name and version variables
    - Change APPNAME from "sud⍥my.sh" to "omnidiscovery.sh"
    - Update banner and ASCII art with OmniDiscovery branding
    - _Requirements: 1.4, 1.5_

  - [x] 3.2 Update output directory naming conventions
    - Change OUT_NAME from "Sudomy-Output" to "OmniDiscovery-Output"
    - Update any hardcoded path references
    - _Requirements: 2.3, 5.3_

  - [ ] 3.3 Write property test for branding consistency in output
    - **Property 1: Branding Consistency in Output**
    - **Validates: Requirements 1.1, 1.5, 4.1**

- [ ] 4. Update configuration system and file references
  - [ ] 4.1 Update configuration file loading logic
    - Modify source statements to reference new file names
    - Add backward compatibility for old configuration files
    - _Requirements: 5.1, 5.2_

  - [ ] 4.2 Update all internal file path references
    - Search and replace hardcoded file references
    - Update engine and plugin path configurations
    - _Requirements: 2.5_

  - [ ] 4.3 Write property test for configuration loading
    - **Property 4: Configuration File Compatibility**
    - **Validates: Requirements 5.1, 5.2**

- [ ] 5. Checkpoint - Verify core functionality works
  - Ensure all tests pass, ask the user if questions arise.

- [ ] 6. Update documentation and user-facing text
  - [ ] 6.1 Update README.md and documentation files
    - Replace all "Sudomy" references with "OmniDiscovery"
    - Update usage examples and descriptions
    - Update repository URLs and links
    - _Requirements: 1.2, 4.2, 4.4_

  - [ ] 6.2 Update help text and usage examples
    - Modify goHelp() function with new branding
    - Update command examples and descriptions
    - _Requirements: 4.1_

  - [ ] 6.3 Write property test for documentation branding
    - **Property 2: Documentation Branding Completeness**
    - **Validates: Requirements 1.2, 4.2**

- [ ] 7. Update engine modules and metadata
  - [ ] 7.1 Update engine file headers and metadata
    - Update all files in engine/ directory
    - Replace tool references in comments and headers
    - _Requirements: 6.3_

  - [ ] 7.2 Verify engine functionality preservation
    - Test each engine module individually
    - Ensure API integrations continue working
    - _Requirements: 6.1, 6.4_

  - [ ] 7.3 Write property test for engine integration
    - **Property 7: Engine and Plugin Integration**
    - **Validates: Requirements 6.1, 6.2, 6.4, 6.5**

- [ ] 8. Update plugin system and functionality
  - [ ] 8.1 Update plugin file headers and references
    - Update all files in plugin/ directory
    - Replace tool references in plugin code
    - _Requirements: 6.2_

  - [ ] 8.2 Update plugin execution and loading
    - Verify all plugins load and execute correctly
    - Test plugin system architecture
    - _Requirements: 6.5_

  - [ ] 8.3 Write property test for plugin functionality
    - **Property 7: Engine and Plugin Integration**
    - **Validates: Requirements 6.1, 6.2, 6.4, 6.5**

- [ ] 9. Update reporting and output systems
  - [ ] 9.1 Update HTML report templates
    - Modify templates in templates/ directory
    - Replace branding in report headers and titles
    - _Requirements: 7.1, 7.4_

  - [ ] 9.2 Update output file generation
    - Modify file header generation
    - Update Slack notification messages
    - _Requirements: 7.2, 7.3_

  - [ ] 9.3 Write property test for report branding
    - **Property 8: Report Template Branding**
    - **Validates: Requirements 7.1, 7.4**

- [ ] 10. Update variable and function names
  - [ ] 10.1 Search and replace variable naming patterns
    - Update variables containing "sudomy" references
    - Update function names with tool references
    - _Requirements: 3.1, 3.2_

  - [ ] 10.2 Update comments and internal documentation
    - Replace tool references in code comments
    - Update metadata and attribution
    - _Requirements: 3.3, 8.4, 8.5_

  - [ ] 10.3 Write property test for variable naming consistency
    - **Property 6: Variable Naming Consistency**
    - **Validates: Requirements 3.1, 3.2**

- [ ] 11. Update Docker and deployment configuration
  - [ ] 11.1 Update Dockerfile and container references
    - Modify Docker configuration files
    - Update container naming and labels
    - _Requirements: 8.3_

  - [ ] 11.2 Update version and license information
    - Update version display functionality
    - Update license headers with new tool name
    - _Requirements: 8.1, 8.2_

  - [ ] 11.3 Write property test for metadata updates
    - **Property 10: Metadata and Attribution Updates**
    - **Validates: Requirements 8.2, 8.4, 8.5**

- [ ] 12. Comprehensive testing and validation
  - [ ] 12.1 Execute end-to-end functionality tests
    - Test complete subdomain enumeration workflow
    - Verify all engines and plugins work correctly
    - Test report generation and output formats
    - _Requirements: All functionality requirements_

  - [ ] 12.2 Test backward compatibility
    - Test with existing sudomy.api configuration files
    - Verify migration scenarios work correctly
    - _Requirements: 5.2, 5.4_

  - [ ] 12.3 Write integration tests for complete workflow
    - **Property 5: Functionality Preservation**
    - **Validates: Requirements 2.4, 3.4, 6.1, 6.2**

- [ ] 13. Final validation and cleanup
  - [ ] 13.1 Perform final codebase scan for missed references
    - Search for any remaining "sudomy" references
    - Verify all branding is consistent
    - _Requirements: All branding requirements_

  - [ ] 13.2 Update any remaining documentation
    - Check for missed documentation files
    - Verify all URLs and links are updated
    - _Requirements: 4.4, 4.5_

- [ ] 14. Final checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Each task references specific requirements for traceability
- Checkpoints ensure incremental validation
- Property tests validate universal correctness properties
- Unit tests validate specific examples and edge cases
- All testing tasks are required for comprehensive validation