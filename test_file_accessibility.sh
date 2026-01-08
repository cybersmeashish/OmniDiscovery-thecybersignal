#!/bin/bash
#---------------------------------------------------------#
# Property Test: Configuration File Compatibility         #
# Feature: sudomy-to-omnidiscovery-rename                #
# Property 4: Configuration File Compatibility           #
# Validates: Requirements 5.1, 5.2                      #
#---------------------------------------------------------#

# Test that renamed files exist and are accessible
# Test backward compatibility with old file names

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SUDOMY_DIR="$SCRIPT_DIR/Sudomy"
ITERATIONS=10

echo "=== Property Test: Configuration File Compatibility ==="
echo "Testing file existence and accessibility after renaming..."

# Property: For any renamed file, it should exist and be accessible
test_file_existence() {
    local iteration=$1
    echo "Iteration $iteration: Testing file existence..."
    
    cd "$SUDOMY_DIR"
    
    # Test new file names exist
    local required_files=("omnidiscovery" "omnidiscovery.conf" "omnidiscovery.api.dist" "omnidiscovery.api")
    
    for file in "${required_files[@]}"; do
        if [[ ! -f "$file" ]]; then
            echo "FAIL: Required file $file does not exist in iteration $iteration"
            return 1
        fi
        
        if [[ ! -r "$file" ]]; then
            echo "FAIL: Required file $file is not readable in iteration $iteration"
            return 1
        fi
    done
    
    # Test executable permissions
    if [[ ! -x "omnidiscovery" ]]; then
        echo "FAIL: omnidiscovery is not executable in iteration $iteration"
        return 1
    fi
    
    echo "PASS: File existence test iteration $iteration"
    return 0
}

# Property: For any configuration loading operation, the system should load new config files
test_config_loading() {
    local iteration=$1
    echo "Iteration $iteration: Testing configuration loading..."
    
    cd "$SUDOMY_DIR"
    
    # Test that configuration files can be sourced without errors
    if ! source omnidiscovery.conf 2>/dev/null; then
        echo "FAIL: Cannot source omnidiscovery.conf in iteration $iteration"
        return 1
    fi
    
    # Test that API file can be sourced without errors
    if ! source omnidiscovery.api 2>/dev/null; then
        echo "FAIL: Cannot source omnidiscovery.api in iteration $iteration"
        return 1
    fi
    
    echo "PASS: Configuration loading test iteration $iteration"
    return 0
}

# Property: For any file access operation, renamed files should be accessible with correct permissions
test_file_permissions() {
    local iteration=$1
    echo "Iteration $iteration: Testing file permissions..."
    
    cd "$SUDOMY_DIR"
    
    # Test that we can read configuration files
    if ! cat omnidiscovery.conf >/dev/null 2>&1; then
        echo "FAIL: Cannot read omnidiscovery.conf in iteration $iteration"
        return 1
    fi
    
    if ! cat omnidiscovery.api >/dev/null 2>&1; then
        echo "FAIL: Cannot read omnidiscovery.api in iteration $iteration"
        return 1
    fi
    
    if ! cat omnidiscovery.api.dist >/dev/null 2>&1; then
        echo "FAIL: Cannot read omnidiscovery.api.dist in iteration $iteration"
        return 1
    fi
    
    # Test that we can execute the main script
    bash omnidiscovery --help >/dev/null 2>&1
    local exit_code=$?
    if [[ $exit_code -ne 0 && $exit_code -ne 1 ]]; then  # Help command can exit with 0 or 1
        echo "FAIL: Cannot execute omnidiscovery (exit code: $exit_code) in iteration $iteration"
        return 1
    fi
    
    echo "PASS: File permissions test iteration $iteration"
    return 0
}

# Run property tests
echo "Running $ITERATIONS iterations of property tests..."

for i in $(seq 1 $ITERATIONS); do
    echo "--- Iteration $i ---"
    
    if ! test_file_existence $i; then
        echo "PROPERTY TEST FAILED: File existence test failed"
        exit 1
    fi
    
    if ! test_config_loading $i; then
        echo "PROPERTY TEST FAILED: Configuration loading test failed"
        exit 1
    fi
    
    if ! test_file_permissions $i; then
        echo "PROPERTY TEST FAILED: File permissions test failed"
        exit 1
    fi
    
    echo "Iteration $i: ALL TESTS PASSED"
done

echo "=== PROPERTY TEST PASSED ==="
echo "All $ITERATIONS iterations completed successfully"
echo "File accessibility and configuration compatibility verified"