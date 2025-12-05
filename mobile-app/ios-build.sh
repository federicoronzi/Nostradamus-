#!/bin/bash

# iOS Build and Archive Script for Nostradamus Mobile
# This script automates the iOS build process
# Usage: ./ios-build.sh [simulator|device|archive]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
APP_NAME="NostradamusMobile"
WORKSPACE="ios/${APP_NAME}.xcworkspace"
SCHEME="${APP_NAME}"
CONFIGURATION="Release"
IOS_DIR="ios"

# Functions
print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script must be run on macOS"
        exit 1
    fi
    print_success "Running on macOS"
}

# Check if Xcode is installed
check_xcode() {
    if ! command -v xcodebuild &> /dev/null; then
        print_error "Xcode is not installed. Please install from Mac App Store."
        exit 1
    fi
    XCODE_VERSION=$(xcodebuild -version | head -1)
    print_success "Xcode found: $XCODE_VERSION"
}

# Check if workspace exists
check_workspace() {
    if [ ! -f "$WORKSPACE" ]; then
        print_error "Workspace not found: $WORKSPACE"
        print_info "Run 'cd ios && pod install' first"
        exit 1
    fi
    print_success "Workspace found: $WORKSPACE"
}

# Install dependencies
install_dependencies() {
    print_header "Installing Dependencies"
    
    # Install npm dependencies
    print_info "Installing npm dependencies..."
    npm install
    print_success "npm dependencies installed"
    
    # Install CocoaPods dependencies
    print_info "Installing CocoaPods dependencies..."
    cd "$IOS_DIR"
    pod install
    cd ..
    print_success "CocoaPods dependencies installed"
}

# Build for simulator
build_simulator() {
    print_header "Building for iOS Simulator"
    
    print_info "Cleaning build folder..."
    xcodebuild clean \
        -workspace "$WORKSPACE" \
        -scheme "$SCHEME" \
        -configuration Debug
    
    print_info "Building for simulator..."
    xcodebuild build \
        -workspace "$WORKSPACE" \
        -scheme "$SCHEME" \
        -configuration Debug \
        -sdk iphonesimulator \
        -destination 'platform=iOS Simulator,name=iPhone 14 Pro' \
        -quiet
    
    print_success "Build for simulator completed successfully"
}

# Build for device
build_device() {
    print_header "Building for iOS Device"
    
    print_info "Cleaning build folder..."
    xcodebuild clean \
        -workspace "$WORKSPACE" \
        -scheme "$SCHEME" \
        -configuration "$CONFIGURATION"
    
    print_info "Building for device..."
    xcodebuild build \
        -workspace "$WORKSPACE" \
        -scheme "$SCHEME" \
        -configuration "$CONFIGURATION" \
        -sdk iphoneos \
        -quiet
    
    print_success "Build for device completed successfully"
}

# Create archive
create_archive() {
    print_header "Creating Archive"
    
    ARCHIVE_PATH="$IOS_DIR/build/${APP_NAME}.xcarchive"
    
    print_info "Creating archive at: $ARCHIVE_PATH"
    xcodebuild archive \
        -workspace "$WORKSPACE" \
        -scheme "$SCHEME" \
        -configuration "$CONFIGURATION" \
        -archivePath "$ARCHIVE_PATH" \
        -quiet
    
    print_success "Archive created successfully: $ARCHIVE_PATH"
    
    # Export IPA
    print_info "Exporting IPA..."
    EXPORT_PATH="$IOS_DIR/build"
    
    if [ ! -f "$IOS_DIR/ExportOptions.plist" ]; then
        print_error "ExportOptions.plist not found"
        print_info "Please configure ExportOptions.plist with your Team ID"
        exit 1
    fi
    
    xcodebuild -exportArchive \
        -archivePath "$ARCHIVE_PATH" \
        -exportPath "$EXPORT_PATH" \
        -exportOptionsPlist "$IOS_DIR/ExportOptions.plist" \
        -quiet
    
    print_success "IPA exported successfully to: $EXPORT_PATH"
    
    # List generated files
    echo ""
    print_info "Generated files:"
    ls -lh "$EXPORT_PATH"/*.ipa 2>/dev/null || print_warning "No .ipa files found"
}

# Run app on simulator
run_simulator() {
    print_header "Running on iOS Simulator"
    
    print_info "Starting React Native..."
    npm start &
    METRO_PID=$!
    
    # Give Metro time to start
    sleep 5
    
    print_info "Installing and running app on simulator..."
    npx react-native run-ios --simulator="iPhone 14 Pro"
    
    print_success "App is running on simulator"
}

# Main script
main() {
    print_header "Nostradamus Mobile - iOS Build Script"
    
    # Check prerequisites
    check_macos
    check_xcode
    
    # Parse command
    COMMAND=${1:-"help"}
    
    case $COMMAND in
        "install")
            install_dependencies
            ;;
        "simulator")
            check_workspace
            build_simulator
            ;;
        "device")
            check_workspace
            build_device
            ;;
        "archive")
            check_workspace
            create_archive
            ;;
        "run")
            check_workspace
            run_simulator
            ;;
        "help"|*)
            echo ""
            echo "Usage: ./ios-build.sh [command]"
            echo ""
            echo "Commands:"
            echo "  install    - Install all dependencies (npm + CocoaPods)"
            echo "  simulator  - Build for iOS Simulator"
            echo "  device     - Build for iOS Device"
            echo "  archive    - Create archive and export IPA"
            echo "  run        - Run app on iOS Simulator"
            echo "  help       - Show this help message"
            echo ""
            echo "Examples:"
            echo "  ./ios-build.sh install    # First time setup"
            echo "  ./ios-build.sh run        # Run on simulator"
            echo "  ./ios-build.sh archive    # Create IPA for distribution"
            echo ""
            exit 0
            ;;
    esac
    
    echo ""
    print_success "All operations completed successfully!"
}

# Run main
main "$@"
