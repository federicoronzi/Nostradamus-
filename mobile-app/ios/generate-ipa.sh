#!/bin/bash

# IPA Generation Script for Nostradamus Mobile App
# This script creates an IPA file for distribution

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
EXPORT_METHOD="ad-hoc"
CONFIGURATION="Release"

while [[ $# -gt 0 ]]; do
    case $1 in
        --app-store)
            EXPORT_METHOD="app-store"
            shift
            ;;
        --development)
            EXPORT_METHOD="development"
            shift
            ;;
        --ad-hoc)
            EXPORT_METHOD="ad-hoc"
            shift
            ;;
        --enterprise)
            EXPORT_METHOD="enterprise"
            shift
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Usage: $0 [--app-store | --development | --ad-hoc | --enterprise]"
            exit 1
            ;;
    esac
done

print_header "Generating IPA for Distribution"
print_info "Export Method: $EXPORT_METHOD"
print_info "Configuration: $CONFIGURATION"

# Check ExportOptions.plist
if [ ! -f "ExportOptions.plist" ]; then
    print_error "ExportOptions.plist not found"
    exit 1
fi

# Check if Team ID is configured
if grep -q "YOUR_TEAM_ID" ExportOptions.plist; then
    print_warning "ExportOptions.plist contains placeholder Team ID"
    print_info "Please update YOUR_TEAM_ID in ExportOptions.plist with your actual Team ID"
    print_info "You can find your Team ID in Xcode: Signing & Capabilities > Team"
    echo ""
    read -p "Do you want to continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Update ExportOptions.plist with the selected method
print_info "Updating ExportOptions.plist with method: $EXPORT_METHOD"
sed -i '' "s/<string>ad-hoc<\/string>/<string>$EXPORT_METHOD<\/string>/g" ExportOptions.plist

# Create build directory
ARCHIVE_PATH="./build/NostradamusMobile.xcarchive"
EXPORT_PATH="./build/ipa"
mkdir -p build
mkdir -p "$EXPORT_PATH"

# Clean previous builds
print_info "Cleaning previous builds..."
rm -rf build/DerivedData
rm -rf "$ARCHIVE_PATH"
rm -rf "$EXPORT_PATH"/*

# Step 1: Create Archive
print_header "Step 1: Creating Archive"
print_info "This may take several minutes..."

xcodebuild \
    -workspace NostradamusMobile.xcworkspace \
    -scheme NostradamusMobile \
    -configuration "$CONFIGURATION" \
    -archivePath "$ARCHIVE_PATH" \
    -sdk iphoneos \
    -destination "generic/platform=iOS" \
    archive \
    | xcpretty || true

ARCHIVE_EXIT_CODE=${PIPESTATUS[0]}

if [ $ARCHIVE_EXIT_CODE -ne 0 ]; then
    print_error "Archive creation failed"
    print_info "Common issues:"
    echo "  - Code signing not configured"
    echo "  - Team ID not set correctly"
    echo "  - Provisioning profile issues"
    echo ""
    print_info "Try opening Xcode and configuring signing:"
    echo "  open NostradamusMobile.xcworkspace"
    exit 1
fi

print_success "Archive created successfully"

# Verify archive was created
if [ ! -d "$ARCHIVE_PATH" ]; then
    print_error "Archive directory not found"
    exit 1
fi

# Step 2: Export IPA
print_header "Step 2: Exporting IPA"
print_info "Exporting archive to IPA file..."

xcodebuild \
    -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath "$EXPORT_PATH" \
    -exportOptionsPlist ExportOptions.plist \
    | xcpretty || true

EXPORT_EXIT_CODE=${PIPESTATUS[0]}

if [ $EXPORT_EXIT_CODE -ne 0 ]; then
    print_error "IPA export failed"
    print_info "Check that:"
    echo "  - Your Team ID is correct in ExportOptions.plist"
    echo "  - You have the necessary provisioning profiles"
    echo "  - Code signing is properly configured"
    exit 1
fi

# Verify IPA was created
IPA_FILE="$EXPORT_PATH/NostradamusMobile.ipa"
if [ ! -f "$IPA_FILE" ]; then
    print_error "IPA file not found"
    exit 1
fi

# Get IPA file size
IPA_SIZE=$(du -h "$IPA_FILE" | cut -f1)

print_header "IPA Generation Complete!"
print_success "IPA file created successfully"
echo ""
echo "  Location: $IPA_FILE"
echo "  Size: $IPA_SIZE"
echo "  Export Method: $EXPORT_METHOD"
echo ""

print_info "Next steps based on export method:"
case $EXPORT_METHOD in
    app-store)
        echo "  1. Upload to App Store Connect using Xcode or Transporter"
        echo "  2. Go to App Store Connect and configure your app"
        echo "  3. Submit for review or distribute to TestFlight"
        ;;
    development)
        echo "  1. Install on registered development devices"
        echo "  2. Use Xcode or Apple Configurator to install"
        ;;
    ad-hoc)
        echo "  1. Distribute to registered devices (up to 100)"
        echo "  2. Use TestFlight, diawi.com, or direct installation"
        echo "  3. Users must have their UDID registered in your provisioning profile"
        ;;
    enterprise)
        echo "  1. Host the IPA on a secure server"
        echo "  2. Create a manifest.plist file"
        echo "  3. Distribute the installation link to your organization"
        ;;
esac
echo ""

# Create a manifest file for ad-hoc distribution
if [ "$EXPORT_METHOD" = "ad-hoc" ] || [ "$EXPORT_METHOD" = "enterprise" ]; then
    MANIFEST_FILE="$EXPORT_PATH/manifest.plist"
    print_info "Creating manifest.plist for OTA distribution..."
    
    cat > "$MANIFEST_FILE" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>items</key>
    <array>
        <dict>
            <key>assets</key>
            <array>
                <dict>
                    <key>kind</key>
                    <string>software-package</string>
                    <key>url</key>
                    <string>https://YOUR_SERVER/NostradamusMobile.ipa</string>
                </dict>
            </array>
            <key>metadata</key>
            <dict>
                <key>bundle-identifier</key>
                <string>com.federicoronzi.nostradamus.NostradamusMobile</string>
                <key>bundle-version</key>
                <string>1.0.0</string>
                <key>kind</key>
                <string>software</string>
                <key>title</key>
                <string>Nostradamus Mobile</string>
            </dict>
        </dict>
    </array>
</dict>
</plist>
EOF
    
    print_success "Manifest file created: $MANIFEST_FILE"
    print_info "Update the URL in manifest.plist with your IPA hosting location"
    echo ""
fi

print_info "Archive location: $ARCHIVE_PATH"
print_info "You can upload the archive to App Store Connect from Xcode:"
echo "  1. Open Xcode > Window > Organizer"
echo "  2. Select the archive"
echo "  3. Click 'Distribute App'"
echo ""
