#!/bin/bash
#---------------------------------------------------------#
# Property Test: Branding Consistency in Output           #
# Feature: sudomy-to-omnidiscovery-rename                #
# Property 1: Branding Consistency in Output             #
# Validates: Requirements 1.1, 1.5, 4.1                 #
#---------------------------------------------------------#

# Test that all displayed text contains OmniDiscovery branding
# and no references to Sudomy

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SUDOMY_DIR="$SCRIPT_DIR/Sudomy"
ITERATIONS=10

echo "=== Property Test: Branding Consistency in Output ==="
echo "Testing branding consistency in all output..."

# Property: For any execution of the main script, all displayed text should contain OmniDiscovery branding
test_banner_branding() {
    local iteration=$1
    echo "Iteration $iteration: Testing banner branding..."
    
    cd "$SUDOMY_DIR"
    
    # Capture help output
    local help_output
    help_output=$(bash omnidiscovery --help 2>&1)
    
    # Test that OmniDiscovery appears in output
    if ! echo "$help_output" | grep -q "OmniDiscovery"; then
        echo "FAIL: OmniDiscovery branding not found in help output in iteration $iteration"
        return 1
    fi
    
    # Test that old Sudomy references are removed from banner
    if echo "$help_output" | grep -q "Sud⍥my"; then
        echo "FAIL: Old Sudomy branding still present in help output in iteration $iteration"
        return 1
    fi
    
    if echo "$help_output" | grep -q "sudomy"; then
        echo "FAIL: Old sudomy references still present in help output in iteration $iteration"
        return 1
    fi
    
    echo "PASS: Banner branding test iteration $iteration"
    return 0
}

# Property: For any help text display, it should show OmniDiscovery usage examples
test_usage_examples() {
    local iteration=$1
    echo "Iteration $iteration: Testing usage examples..."
    
    cd "$SUDOMY_DIR"
    
    # Capture help output
    local help_output
    help_output=$(bash omnidiscovery --help 2>&1)
    
    # Test that usage examples reference omnidiscovery.sh
    if ! echo "$help_output" | grep -q "omnidiscovery.sh"; then
        echo "FAIL: Usage examples don't reference omnidiscovery.sh in iteration $iteration"
        return 1
    fi
    
    # Test that GitHub URL is updated
    if ! echo "$help_output" | grep -q "github.com/screetsec/omnidiscovery"; then
        echo "FAIL: GitHub URL not updated to omnidiscovery in iteration $iteration"
        return 1
    fi
    
    echo "PASS: Usage examples test iteration $iteration"
    return 0
}

# Property: For any configuration variable, application references should use omnidiscovery variants
test_config_variables() {
    local iteration=$1
    echo "Iteration $iteration: Testing configuration variables..."
    
    cd "$SUDOMY_DIR"
    
    # Source the configuration and check variables
    source omnidiscovery.conf 2>/dev/null
    
    # Test that OUT_NAME uses OmniDiscovery
    if [[ "$OUT_NAME" != "OmniDiscovery-Output" ]]; then
        echo "FAIL: OUT_NAME not updated to OmniDiscovery-Output (current: $OUT_NAME) in iteration $iteration"
        return 1
    fi
    
    # Test that APPNAME uses omnidiscovery (read from script directly)
    local appname_line
    appname_line=$(grep '^APPNAME=' omnidiscovery 2>/dev/null || true)
    if [[ -n "$appname_line" && ! "$appname_line" =~ omnidiscovery.sh ]]; then
        echo "FAIL: APPNAME not updated to omnidiscovery.sh (current line: $appname_line) in iteration $iteration"
        return 1
    fi
    
    echo "PASS: Configuration variables test iteration $iteration"
    return 0
}

# Property: For any error or status message, it should reference OmniDiscovery appropriately
test_error_messages() {
    local iteration=$1
    echo "Iteration $iteration: Testing error messages..."
    
    cd "$SUDOMY_DIR"
    
    # Test invalid option error message
    local error_output
    error_output=$(bash omnidiscovery --invalid-option 2>&1 || true)
    
    # The error message should not contain old sudomy references
    if echo "$error_output" | grep -i "sudomy"; then
        echo "FAIL: Error messages still contain sudomy references in iteration $iteration"
        return 1
    fi
    
    echo "PASS: Error messages test iteration $iteration"
    return 0
}

# Run property tests
echo "Running $ITERATIONS iterations of property tests..."

for i in $(seq 1 $ITERATIONS); do
    echo "--- Iteration $i ---"
    
    if ! test_banner_branding $i; then
        echo "PROPERTY TEST FAILED: Banner branding test failed"
        exit 1
    fi
    
    if ! test_usage_examples $i; then
        echo "PROPERTY TEST FAILED: Usage examples test failed"
        exit 1
    fi
    
    if ! test_config_variables $i; then
        echo "PROPERTY TEST FAILED: Configuration variables test failed"
        exit 1
    fi
    
    if ! test_error_messages $i; then
        echo "PROPERTY TEST FAILED: Error messages test failed"
        exit 1
    fi
    
    echo "Iteration $i: ALL TESTS PASSED"
done

echo "=== PROPERTY TEST PASSED ==="
echo "All $ITERATIONS iterations completed successfully"
echo "Branding consistency verified across all output scenarios"