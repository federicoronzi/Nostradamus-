# iOS Project - Nostradamus Mobile

This directory contains the native iOS project for the Nostradamus mobile app.

## 🚀 Quick Start (macOS Required)

### First Time Setup

```bash
# Install CocoaPods dependencies
./setup-ios.sh

# Or run the complete setup and validation
./complete-setup.sh
```

### Build and Test

```bash
# Build for simulator
./build-ios.sh

# Build for specific simulator
./build-ios.sh --simulator "iPhone 14 Pro"

# Build for device
./build-ios.sh --device

# Build release version
./build-ios.sh --release
```

### Generate IPA

```bash
# For development testing
./generate-ipa.sh --development

# For ad-hoc distribution (up to 100 devices)
./generate-ipa.sh --ad-hoc

# For App Store/TestFlight
./generate-ipa.sh --app-store
```

## 📁 Directory Structure

```
ios/
├── NostradamusMobile/           # Main app source
│   ├── AppDelegate.h           # iOS app delegate header
│   ├── AppDelegate.mm          # iOS app delegate implementation
│   ├── Info.plist              # App configuration
│   ├── Images.xcassets/        # App icons and images
│   ├── LaunchScreen.storyboard # Splash screen
│   └── main.m                  # App entry point
├── NostradamusMobile.xcodeproj/ # Xcode project (don't use directly)
├── NostradamusMobile.xcworkspace/ # Xcode workspace (use this!)
├── NostradamusMobileTests/      # Unit tests
├── Pods/                        # CocoaPods dependencies (generated)
├── Podfile                      # CocoaPods configuration
├── Podfile.lock                 # CocoaPods lock file (generated)
├── ExportOptions.plist          # IPA export configuration
├── .xcode.env                   # Xcode environment variables
├── setup-ios.sh                 # Setup script
├── build-ios.sh                 # Build script
├── generate-ipa.sh              # IPA generation script
├── complete-setup.sh            # Complete setup and validation
└── README.md                    # This file
```

## ⚠️ Important Notes

### Always Use Workspace

After running `pod install`, **always** open the `.xcworkspace` file, **never** the `.xcodeproj`:

```bash
# ✅ Correct
open NostradamusMobile.xcworkspace

# ❌ Wrong
open NostradamusMobile.xcodeproj
```

### Prerequisites

- **macOS 12.0+** - Required for iOS development
- **Xcode 14.0+** - Install from Mac App Store
- **CocoaPods** - Install with `sudo gem install cocoapods`
- **Node.js 16.0+** - Required for React Native

### Code Signing

Before building for device or generating IPA:

1. Open `NostradamusMobile.xcworkspace` in Xcode
2. Select project > Target > Signing & Capabilities
3. Enable "Automatically manage signing"
4. Select your Team (Apple Developer account)
5. Update Team ID in `ExportOptions.plist`

## 🛠️ Available Scripts

### setup-ios.sh
Automates the initial iOS setup:
- Verifies prerequisites (Xcode, Node.js, CocoaPods)
- Installs CocoaPods if needed
- Runs `pod install`
- Creates workspace
- Lists available simulators

**Usage**: `./setup-ios.sh`

### build-ios.sh
Builds the app for testing:
- Supports simulator and device builds
- Debug and Release configurations
- Automatic cleaning before build

**Usage**: 
```bash
./build-ios.sh                              # Debug on simulator
./build-ios.sh --release                     # Release build
./build-ios.sh --simulator "iPhone 14 Pro"  # Specific simulator
./build-ios.sh --device                      # For physical device
```

### generate-ipa.sh
Generates IPA file for distribution:
- Creates archive
- Exports IPA with proper signing
- Supports multiple distribution methods
- Creates manifest for OTA distribution

**Usage**:
```bash
./generate-ipa.sh --development   # Development build
./generate-ipa.sh --ad-hoc       # Ad-hoc distribution
./generate-ipa.sh --app-store    # App Store/TestFlight
./generate-ipa.sh --enterprise   # Enterprise distribution
```

**Before using**: Update `YOUR_TEAM_ID` in `ExportOptions.plist`

### complete-setup.sh
Master script that runs complete setup and validation:
- Runs environment checks
- Executes iOS setup
- Verifies code signing
- Tests build
- Validates installation

**Usage**: `./complete-setup.sh`

## 🔧 Configuration Files

### Podfile
Defines CocoaPods dependencies for React Native. Automatically configured for React Native 0.72.0.

**When to modify**: When adding new native iOS dependencies.

### ExportOptions.plist
Configuration for IPA export. Contains:
- Distribution method (app-store, ad-hoc, development, enterprise)
- Team ID (**must be updated**)
- Signing style (automatic/manual)
- Other export options

**Required change**: Replace `YOUR_TEAM_ID` with your Apple Developer Team ID.

### .xcode.env
Environment variables for Xcode builds. Automatically configured by React Native.

### Info.plist
iOS app configuration:
- Bundle identifier: `com.federicoronzi.nostradamus.NostradamusMobile`
- Display name: "Nostradamus"
- Version and build numbers
- Permissions and capabilities

## 🧪 Testing

### Test on Simulator

```bash
# From mobile-app directory
npm run ios

# Or specific simulator
npm run ios -- --simulator="iPhone 14 Pro"
```

### Test on Device

1. Connect iPhone/iPad via USB
2. Open Xcode: `open NostradamusMobile.xcworkspace`
3. Select your device
4. Ensure code signing is configured
5. Click Run (▶️) or press Cmd+R
6. Trust developer certificate on device (Settings > General > Device Management)

### Run Tests

```bash
# Unit tests
npm test

# Or from Xcode
# Product > Test (Cmd+U)
```

## 📦 Distribution

### TestFlight (Beta Testing)

1. Generate IPA: `./generate-ipa.sh --app-store`
2. Upload to App Store Connect:
   - Xcode: Window > Organizer > Distribute
   - Or use Transporter app
3. Configure TestFlight in App Store Connect
4. Invite testers

### App Store

1. Generate IPA for App Store
2. Upload to App Store Connect
3. Complete app metadata
4. Submit for review

### Ad-Hoc (Direct Distribution)

1. Register device UDIDs in Apple Developer portal
2. Generate IPA: `./generate-ipa.sh --ad-hoc`
3. Distribute via email, web, or third-party service

## 🐛 Troubleshooting

### Pod Install Fails

```bash
# Clear cache and retry
pod cache clean --all
rm -rf Pods Podfile.lock
pod install
```

### Build Fails

```bash
# Clean build
rm -rf ~/Library/Developer/Xcode/DerivedData/*
rm -rf build
cd ..
npm start -- --reset-cache
```

### Signing Issues

1. Open Xcode
2. Signing & Capabilities
3. Enable "Automatically manage signing"
4. Select valid Team

### Workspace Not Found

Run `pod install` first:
```bash
./setup-ios.sh
```

## 📚 Documentation

Complete documentation available in `../docs/`:

- [macOS Setup Guide](../docs/MACOS_SETUP.md) - Complete setup instructions
- [iOS Build Guide](../docs/IOS_BUILD_GUIDE.md) - Detailed build documentation
- [Quick Start Guide](../docs/IOS_QUICK_START.md) - Fast track setup
- [Validation Checklist](../docs/IOS_VALIDATION_CHECKLIST.md) - Verify setup
- [Deployment Checklist](../docs/IOS_DEPLOYMENT_CHECKLIST.md) - Pre-release checks
- [Assets Guide](../docs/IOS_ASSETS_GUIDE.md) - Icons and splash screens
- [Completion Status](../IOS_COMPLETION_STATUS.md) - Current project status

## 🔍 Verification

To verify your setup:

1. Run complete setup: `./complete-setup.sh`
2. Or check manually:
   ```bash
   pod --version                    # CocoaPods installed
   ls NostradamusMobile.xcworkspace # Workspace exists
   ls Pods                          # Pods installed
   ```

## 🆘 Getting Help

- Check troubleshooting section above
- Review [macOS Setup Guide](../docs/MACOS_SETUP.md)
- Open issue on GitHub
- Check React Native documentation

## 📋 Checklist Before Release

- [ ] All dependencies installed (`pod install` successful)
- [ ] Code signing configured correctly
- [ ] App builds without errors
- [ ] Tested on simulator
- [ ] Tested on physical device
- [ ] Version and build numbers updated
- [ ] Icons and splash screen customized
- [ ] IPA generated successfully
- [ ] Reviewed [Deployment Checklist](../docs/IOS_DEPLOYMENT_CHECKLIST.md)

---

**React Native Version**: 0.72.0  
**iOS Minimum Version**: 12.0  
**Xcode Minimum Version**: 14.0  
**Bundle ID**: com.federicoronzi.nostradamus.NostradamusMobile
