#!/bin/bash

# iOS Setup Script for Nostradamus Mobile App
# This script automates the iOS project setup on macOS

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo ""
}

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    print_error "This script must be run on macOS"
    exit 1
fi

print_header "Nostradamus iOS Setup Script"

# Check for Xcode
print_info "Checking for Xcode..."
if ! command -v xcodebuild &> /dev/null; then
    print_error "Xcode is not installed. Please install from the Mac App Store"
    exit 1
fi
XCODE_VERSION=$(xcodebuild -version | head -1)
print_success "Found: $XCODE_VERSION"

# Check for Command Line Tools
print_info "Checking for Xcode Command Line Tools..."
if ! xcode-select -p &> /dev/null; then
    print_warning "Installing Xcode Command Line Tools..."
    xcode-select --install
    print_info "Please complete the installation and run this script again"
    exit 0
fi
print_success "Xcode Command Line Tools installed"

# Check for Node.js
print_info "Checking for Node.js..."
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed. Please install from https://nodejs.org/"
    exit 1
fi
NODE_VERSION=$(node -v)
print_success "Found: Node.js $NODE_VERSION"

# Check for npm
print_info "Checking for npm..."
if ! command -v npm &> /dev/null; then
    print_error "npm is not installed"
    exit 1
fi
NPM_VERSION=$(npm -v)
print_success "Found: npm $NPM_VERSION"

# Check for CocoaPods
print_info "Checking for CocoaPods..."
if ! command -v pod &> /dev/null; then
    print_warning "CocoaPods is not installed. Installing..."
    sudo gem install cocoapods
    print_success "CocoaPods installed"
else
    POD_VERSION=$(pod --version)
    print_success "Found: CocoaPods $POD_VERSION"
fi

# Navigate to iOS directory
cd "$(dirname "$0")"

# Clean previous installations if they exist
if [ -d "Pods" ] || [ -f "Podfile.lock" ]; then
    print_info "Cleaning previous CocoaPods installation..."
    rm -rf Pods
    rm -f Podfile.lock
    print_success "Cleaned previous installation"
fi

# Install CocoaPods dependencies
print_header "Installing CocoaPods Dependencies"
print_info "Running 'pod install'..."
print_info "This may take several minutes on first run..."

if pod install; then
    print_success "CocoaPods dependencies installed successfully"
else
    print_error "Failed to install CocoaPods dependencies"
    print_info "Trying to update CocoaPods repo and retry..."
    pod repo update
    if pod install; then
        print_success "CocoaPods dependencies installed successfully after repo update"
    else
        print_error "Failed to install CocoaPods dependencies even after repo update"
        exit 1
    fi
fi

# Verify workspace was created
if [ ! -d "NostradamusMobile.xcworkspace" ]; then
    print_error "Workspace file was not created"
    exit 1
fi
print_success "Workspace created: NostradamusMobile.xcworkspace"

# Check for available simulators
print_header "Available iOS Simulators"
print_info "Listing available simulators..."
xcrun simctl list devices available | grep -E "iPhone|iPad" | head -10

print_header "Setup Complete!"
print_success "iOS project setup completed successfully"
echo ""
print_info "Next steps:"
echo "  1. Open the project: open NostradamusMobile.xcworkspace"
echo "  2. Configure code signing in Xcode (Signing & Capabilities)"
echo "  3. Build and test on simulator or device"
echo ""
print_info "To build from command line:"
echo "  ./build-ios.sh"
echo ""
print_info "To generate IPA:"
echo "  ./generate-ipa.sh"
echo ""
