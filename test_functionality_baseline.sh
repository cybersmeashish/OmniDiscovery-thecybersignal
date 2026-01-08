#!/bin/bash
#---------------------------------------------------------#
# Property Test: Functionality Preservation Baseline     #
# Feature: sudomy-to-omnidiscovery-rename                #
# Property 5: Functionality Preservation                 #
# Validates: Requirements 2.4, 3.4, 6.1, 6.2           #
#---------------------------------------------------------#

# Test that core functionality works before renaming
# This establishes a baseline for comparison after renaming

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OMNIDISCOVERY_DIR="$SCRIPT_DIR/OmniDiscovery"
TEST_DOMAIN="example.com"
ITERATIONS=5

echo "=== Property Test: Functionality Preservation Baseline ==="
echo "Testing core Sudomy functionality before renaming..."

# Property: For any core functionality, the system should execute without critical errors
test_basic_execution() {
    local iteration=$1
    echo "Iteration $iteration: Testing basic execution..."
    
    cd "$OMNIDISCOVERY_DIR"
    
    # Ensure API file exists
    if [[ ! -f "omnidiscovery.api" && -f "omnidiscovery.api.dist" ]]; then
        cp omnidiscovery.api.dist omnidiscovery.api
    fi
    
    # Test help functionality (help command may exit with code 1, which is normal)
    bash omnidiscovery --help >/dev/null 2>&1
    local help_exit_code=$?
    if [[ $help_exit_code -ne 0 && $help_exit_code -ne 1 ]]; then
        echo "FAIL: Help command failed with unexpected exit code $help_exit_code in iteration $iteration"
        return 1
    fi
    
    # Test banner display
    if ! bash omnidiscovery --help 2>/dev/null | grep -q "OmniDiscovery"; then
        echo "FAIL: Banner not displaying correctly in iteration $iteration"
        return 1
    fi
    
    # Test configuration file loading
    if [[ -f "omnidiscovery.conf" ]]; then
        if ! source omnidiscovery.conf 2>/dev/null; then
            echo "FAIL: Configuration loading failed in iteration $iteration"
            return 1
        fi
    fi
    
    echo "PASS: Basic execution test iteration $iteration"
    return 0
}

# Property: For any engine file, it should be loadable without syntax errors
test_engine_loading() {
    local iteration=$1
    echo "Iteration $iteration: Testing engine loading..."
    
    cd "$OMNIDISCOVERY_DIR"
    
    local engine_count=0
    local failed_engines=0
    
    for engine_file in engine/*.my; do
        if [[ -f "$engine_file" ]]; then
            engine_count=$((engine_count + 1))
            if ! bash -n "$engine_file" 2>/dev/null; then
                echo "FAIL: Engine $engine_file has syntax errors in iteration $iteration"
                failed_engines=$((failed_engines + 1))
            fi
        fi
    done
    
    if [[ $failed_engines -gt 0 ]]; then
        echo "FAIL: $failed_engines out of $engine_count engines failed syntax check in iteration $iteration"
        return 1
    fi
    
    echo "PASS: All $engine_count engines passed syntax check in iteration $iteration"
    return 0
}

# Property: For any plugin file, it should be loadable without syntax errors
test_plugin_loading() {
    local iteration=$1
    echo "Iteration $iteration: Testing plugin loading..."
    
    cd "$OMNIDISCOVERY_DIR"
    
    local plugin_count=0
    local failed_plugins=0
    
    for plugin_file in plugin/exec_*; do
        if [[ -f "$plugin_file" ]]; then
            plugin_count=$((plugin_count + 1))
            if ! bash -n "$plugin_file" 2>/dev/null; then
                echo "FAIL: Plugin $plugin_file has syntax errors in iteration $iteration"
                failed_plugins=$((failed_plugins + 1))
            fi
        fi
    done
    
    if [[ $failed_plugins -gt 0 ]]; then
        echo "FAIL: $failed_plugins out of $plugin_count plugins failed syntax check in iteration $iteration"
        return 1
    fi
    
    echo "PASS: All $plugin_count plugins passed syntax check in iteration $iteration"
    return 0
}

# Run property tests
echo "Running $ITERATIONS iterations of property tests..."

for i in $(seq 1 $ITERATIONS); do
    echo "--- Iteration $i ---"
    
    if ! test_basic_execution $i; then
        echo "PROPERTY TEST FAILED: Basic execution test failed"
        exit 1
    fi
    
    if ! test_engine_loading $i; then
        echo "PROPERTY TEST FAILED: Engine loading test failed"
        exit 1
    fi
    
    if ! test_plugin_loading $i; then
        echo "PROPERTY TEST FAILED: Plugin loading test failed"
        exit 1
    fi
    
    echo "Iteration $i: ALL TESTS PASSED"
done

echo "=== PROPERTY TEST PASSED ==="
echo "All $ITERATIONS iterations completed successfully"
echo "Baseline functionality preserved across all test scenarios"