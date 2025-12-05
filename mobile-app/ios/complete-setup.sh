#!/bin/bash

# iOS Complete Setup and Validation Script
# This is the master script that runs the complete iOS setup and validation

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ ${NC}$1"
}

print_success() {
    echo -e "${GREEN}✓ ${NC}$1"
}

print_warning() {
    echo -e "${YELLOW}⚠ ${NC}$1"
}

print_error() {
    echo -e "${RED}✗ ${NC}$1"
}

print_header() {
    echo ""
    echo -e "${MAGENTA}═══════════════════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  $1${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════════════════${NC}"
    echo ""
}

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    print_error "This script must be run on macOS"
    echo ""
    print_info "Current environment: $(uname)"
    print_info "iOS development requires macOS with Xcode"
    echo ""
    print_info "What you can do:"
    echo "  1. Review the documentation that has been created"
    echo "  2. Run this script on a macOS machine"
    echo "  3. Follow the manual steps in MACOS_SETUP.md"
    exit 1
fi

print_header "Nostradamus iOS - Complete Setup & Validation"

# Navigate to iOS directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Check if we're in the ios directory
if [[ ! -f "Podfile" ]]; then
    print_error "Not in iOS directory. Please run from mobile-app/ios/"
    exit 1
fi

# Phase 1: Environment Check
print_header "Phase 1: Environment Verification"
cd ..
if [[ -f "check-environment.sh" ]]; then
    ./check-environment.sh
else
    print_warning "check-environment.sh not found, skipping environment check"
fi
cd ios

# Phase 2: Setup
print_header "Phase 2: iOS Setup"
if [[ -f "setup-ios.sh" ]]; then
    print_info "Running iOS setup..."
    ./setup-ios.sh
else
    print_error "setup-ios.sh not found"
    exit 1
fi

# Verify workspace was created
if [[ ! -d "NostradamusMobile.xcworkspace" ]]; then
    print_error "Workspace was not created. Setup may have failed."
    exit 1
fi
print_success "Workspace created successfully"

# Phase 3: Code Signing Check
print_header "Phase 3: Code Signing Verification"
print_info "Opening Xcode to verify code signing..."
print_warning "Please configure code signing in Xcode:"
echo "  1. Select project > Target > Signing & Capabilities"
echo "  2. Enable 'Automatically manage signing'"
echo "  3. Select your Team"
echo "  4. Verify no errors appear"
echo ""
read -p "Press Enter when code signing is configured..." -r
echo ""

# Phase 4: Build Test
print_header "Phase 4: Build Verification"
print_info "Testing build on simulator..."

# Get first available simulator
SIMULATOR=$(xcrun simctl list devices available | grep "iPhone" | head -1 | sed 's/.*(\(.*\)).*/\1/')
if [[ -z "$SIMULATOR" ]]; then
    print_error "No simulator found"
    exit 1
fi
print_info "Using simulator: $SIMULATOR"

if [[ -f "build-ios.sh" ]]; then
    print_info "Running build test..."
    ./build-ios.sh --simulator "$SIMULATOR"
else
    print_warning "build-ios.sh not found, attempting direct build..."
    cd ..
    npm run ios
    cd ios
fi

# Phase 5: Verification
print_header "Phase 5: Final Verification"

CHECKS_PASSED=0
CHECKS_TOTAL=0

# Check 1: Workspace exists
CHECKS_TOTAL=$((CHECKS_TOTAL + 1))
if [[ -d "NostradamusMobile.xcworkspace" ]]; then
    print_success "Workspace exists"
    CHECKS_PASSED=$((CHECKS_PASSED + 1))
else
    print_error "Workspace missing"
fi

# Check 2: Pods installed
CHECKS_TOTAL=$((CHECKS_TOTAL + 1))
if [[ -d "Pods" ]]; then
    print_success "CocoaPods dependencies installed"
    CHECKS_PASSED=$((CHECKS_PASSED + 1))
else
    print_error "Pods directory missing"
fi

# Check 3: Podfile.lock exists
CHECKS_TOTAL=$((CHECKS_TOTAL + 1))
if [[ -f "Podfile.lock" ]]; then
    print_success "Podfile.lock present"
    CHECKS_PASSED=$((CHECKS_PASSED + 1))
else
    print_error "Podfile.lock missing"
fi

# Check 4: Build directory created (indicates successful build)
CHECKS_TOTAL=$((CHECKS_TOTAL + 1))
if [[ -d "build" ]]; then
    print_success "Build directory present (build attempted)"
    CHECKS_PASSED=$((CHECKS_PASSED + 1))
else
    print_warning "Build directory not found (build may not have run)"
fi

print_header "Validation Results"
echo "Checks passed: $CHECKS_PASSED / $CHECKS_TOTAL"

if [[ $CHECKS_PASSED -eq $CHECKS_TOTAL ]]; then
    print_success "All checks passed!"
    echo ""
    print_info "Setup is complete! Next steps:"
    echo "  1. Test on a physical device (recommended)"
    echo "  2. Generate IPA: ./generate-ipa.sh --development"
    echo "  3. Review deployment checklist: ../docs/IOS_DEPLOYMENT_CHECKLIST.md"
    echo ""
elif [[ $CHECKS_PASSED -ge 3 ]]; then
    print_warning "Most checks passed, but some issues remain"
    echo ""
    print_info "Review the errors above and:"
    echo "  1. Check troubleshooting in MACOS_SETUP.md"
    echo "  2. Verify all prerequisites are installed"
    echo "  3. Try running individual scripts manually"
else
    print_error "Setup incomplete. Please review errors above."
    echo ""
    print_info "Troubleshooting steps:"
    echo "  1. Review MACOS_SETUP.md"
    echo "  2. Check that all prerequisites are installed"
    echo "  3. Try running setup-ios.sh again"
    echo "  4. Check for error messages in the output"
    exit 1
fi

print_header "Setup Complete!"
echo ""
print_success "The iOS project is ready for development"
echo ""
print_info "Documentation:"
echo "  - Complete guide: ../docs/MACOS_SETUP.md"
echo "  - Quick start: ../docs/IOS_QUICK_START.md"
echo "  - Validation checklist: ../docs/IOS_VALIDATION_CHECKLIST.md"
echo ""
print_info "Scripts available:"
echo "  - Build: ./build-ios.sh"
echo "  - Generate IPA: ./generate-ipa.sh"
echo ""
