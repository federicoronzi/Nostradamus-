#!/bin/bash

# iOS Build Script for Nostradamus Mobile App
# This script builds the iOS app for testing

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

# Navigate to iOS directory
cd "$(dirname "$0")"

# Check if workspace exists
if [ ! -d "NostradamusMobile.xcworkspace" ]; then
    print_error "Workspace not found. Please run ./setup-ios.sh first"
    exit 1
fi

# Parse command line arguments
CONFIGURATION="Debug"
BUILD_TYPE="simulator"
SIMULATOR_NAME="iPhone 14 Pro"
DEVICE_NAME=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --release)
            CONFIGURATION="Release"
            shift
            ;;
        --device)
            BUILD_TYPE="device"
            shift
            ;;
        --simulator)
            BUILD_TYPE="simulator"
            SIMULATOR_NAME="$2"
            shift 2
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Usage: $0 [--release] [--device | --simulator \"iPhone 14 Pro\"]"
            exit 1
            ;;
    esac
done

print_header "Building iOS App"
print_info "Configuration: $CONFIGURATION"
print_info "Build Type: $BUILD_TYPE"

# Create build directory
mkdir -p build

if [ "$BUILD_TYPE" = "simulator" ]; then
    print_info "Target: iOS Simulator ($SIMULATOR_NAME)"
    print_info "Building for simulator..."
    
    # Build for simulator
    xcodebuild \
        -workspace NostradamusMobile.xcworkspace \
        -scheme NostradamusMobile \
        -configuration "$CONFIGURATION" \
        -sdk iphonesimulator \
        -destination "platform=iOS Simulator,name=$SIMULATOR_NAME" \
        -derivedDataPath build/DerivedData \
        clean build \
        | xcpretty || true
    
    BUILD_EXIT_CODE=${PIPESTATUS[0]}
    
    if [ $BUILD_EXIT_CODE -eq 0 ]; then
        print_success "Build completed successfully"
        print_info "App is ready to run on simulator"
        echo ""
        print_info "To launch the app:"
        echo "  1. Open simulator: open -a Simulator"
        echo "  2. Boot device: xcrun simctl boot \"$SIMULATOR_NAME\" (if not running)"
        echo "  3. Install app: xcrun simctl install booted build/DerivedData/Build/Products/$CONFIGURATION-iphonesimulator/NostradamusMobile.app"
        echo "  4. Launch app: xcrun simctl launch booted com.federicoronzi.nostradamus.NostradamusMobile"
    else
        print_error "Build failed"
        exit 1
    fi
    
elif [ "$BUILD_TYPE" = "device" ]; then
    print_info "Target: Physical iOS Device"
    print_warning "Make sure a device is connected via USB"
    print_info "Building for device..."
    
    # Build for device
    xcodebuild \
        -workspace NostradamusMobile.xcworkspace \
        -scheme NostradamusMobile \
        -configuration "$CONFIGURATION" \
        -sdk iphoneos \
        -destination generic/platform=iOS \
        -derivedDataPath build/DerivedData \
        clean build \
        CODE_SIGN_IDENTITY="" \
        CODE_SIGNING_REQUIRED=NO \
        CODE_SIGNING_ALLOWED=NO \
        | xcpretty || true
    
    BUILD_EXIT_CODE=${PIPESTATUS[0]}
    
    if [ $BUILD_EXIT_CODE -eq 0 ]; then
        print_success "Build completed successfully"
        print_warning "Note: Code signing was disabled for this build"
        print_info "To install on device, configure code signing in Xcode and build from there"
    else
        print_error "Build failed"
        exit 1
    fi
fi

print_header "Build Summary"
echo "Configuration: $CONFIGURATION"
echo "Build Type: $BUILD_TYPE"
echo "Build Output: build/DerivedData/Build/Products/"
echo ""
