# macOS Setup Guide - Nostradamus Mobile App

This guide provides step-by-step instructions for completing the iOS project setup on macOS.

## 📋 Prerequisites

Before starting, ensure you have:

- ✅ **macOS 12.0 or later**
- ✅ **Xcode 14.0 or later** (install from Mac App Store)
- ✅ **Node.js 16.0 or later** (from https://nodejs.org/)
- ✅ **Git** (included with Xcode Command Line Tools)
- ✅ **Apple Developer Account** (free or paid)

## 🚀 Quick Setup (Automated)

### Step 1: Clone and Navigate

```bash
git clone https://github.com/federicoronzi/Nostradamus-.git
cd Nostradamus-/mobile-app
```

### Step 2: Install JavaScript Dependencies

```bash
npm install
```

### Step 3: Run Automated iOS Setup

```bash
cd ios
./setup-ios.sh
```

This script will:
- ✓ Verify all prerequisites
- ✓ Install CocoaPods (if needed)
- ✓ Run `pod install`
- ✓ Create the Xcode workspace
- ✓ List available simulators

**Expected Duration**: 2-5 minutes (depending on network speed)

## 🔧 Manual Setup (Alternative)

If you prefer manual setup or if the automated script fails:

### Step 1: Install CocoaPods

```bash
sudo gem install cocoapods
```

### Step 2: Install iOS Dependencies

```bash
cd Nostradamus-/mobile-app/ios
pod install
```

**Important**: This creates `NostradamusMobile.xcworkspace`. Always use this file, not the `.xcodeproj`.

### Step 3: Verify Installation

```bash
ls -la NostradamusMobile.xcworkspace
```

You should see the workspace directory.

## 🎯 Code Signing Configuration

Code signing is required to run the app on simulators and physical devices.

### Option 1: Automatic Signing (Recommended)

1. Open the workspace:
   ```bash
   open NostradamusMobile.xcworkspace
   ```

2. Select the **NostradamusMobile** project in the navigator

3. Select the **NostradamusMobile** target

4. Go to **Signing & Capabilities** tab

5. Check **"Automatically manage signing"**

6. Select your **Team** from the dropdown
   - If you don't have a team, click "Add an Account..." and sign in with your Apple ID
   - A free Apple Developer account is sufficient for development and testing

7. Xcode will automatically:
   - Create development certificates
   - Generate provisioning profiles
   - Configure the bundle identifier if needed

### Option 2: Manual Signing (Advanced)

For production builds or specific requirements:

1. Open Xcode and go to **Signing & Capabilities**

2. Uncheck **"Automatically manage signing"**

3. Select **Provisioning Profile** manually:
   - Development profile for testing
   - Distribution profile for App Store/ad-hoc

4. Update `ExportOptions.plist` with your settings:
   ```bash
   nano ExportOptions.plist
   ```
   
   Update:
   - `teamID`: Your Apple Developer Team ID
   - `signingStyle`: Change to "manual"
   - Add provisioning profile details

## 🧪 Build and Test

### Test on iOS Simulator

#### Method 1: Using React Native CLI

```bash
cd Nostradamus-/mobile-app
npm run ios
```

Or specify a simulator:
```bash
npm run ios -- --simulator="iPhone 14 Pro"
```

#### Method 2: Using Xcode

1. Open workspace:
   ```bash
   open ios/NostradamusMobile.xcworkspace
   ```

2. Select a simulator from the device menu (e.g., "iPhone 14 Pro")

3. Click the **Play** button (▶️) or press `Cmd + R`

#### Method 3: Using Build Script

```bash
cd ios
./build-ios.sh --simulator "iPhone 14 Pro"
```

For release build:
```bash
./build-ios.sh --release --simulator "iPhone 14 Pro"
```

### Test on Physical Device

1. Connect your iPhone/iPad via USB

2. Open Xcode:
   ```bash
   open ios/NostradamusMobile.xcworkspace
   ```

3. Select your device from the device menu

4. Ensure **Signing & Capabilities** is configured (see above)

5. Click **Play** (▶️) or press `Cmd + R`

6. On first run, you may need to trust the developer certificate:
   - On device: **Settings > General > Device Management**
   - Tap your Apple ID
   - Tap **Trust**

7. Build and run again if needed

## 📦 Generate IPA File

### Method 1: Using Generation Script (Recommended)

For ad-hoc distribution:
```bash
cd ios
./generate-ipa.sh --ad-hoc
```

For App Store:
```bash
./generate-ipa.sh --app-store
```

For development:
```bash
./generate-ipa.sh --development
```

**Before running**: Update `ExportOptions.plist` with your Team ID!

### Method 2: Using Xcode (GUI)

1. Open workspace:
   ```bash
   open ios/NostradamusMobile.xcworkspace
   ```

2. Select **Any iOS Device (arm64)** as the build target

3. Go to **Product > Archive**

4. Wait for the archive process to complete (2-5 minutes)

5. In the Organizer window that appears:
   - Click **Distribute App**
   - Choose distribution method:
     - **App Store Connect**: For TestFlight or App Store
     - **Ad Hoc**: For registered devices (up to 100)
     - **Development**: For development devices only
     - **Enterprise**: For enterprise distribution (requires enterprise account)

6. Follow the wizard:
   - Choose options (usually keep defaults)
   - Re-sign if needed
   - Review distribution details
   - Export

7. Choose save location for IPA file

### Method 3: Command Line (Advanced)

```bash
cd ios

# Create archive
xcodebuild \
  -workspace NostradamusMobile.xcworkspace \
  -scheme NostradamusMobile \
  -configuration Release \
  -archivePath ./build/NostradamusMobile.xcarchive \
  -sdk iphoneos \
  -destination "generic/platform=iOS" \
  archive

# Export IPA
xcodebuild \
  -exportArchive \
  -archivePath ./build/NostradamusMobile.xcarchive \
  -exportPath ./build/ipa \
  -exportOptionsPlist ExportOptions.plist
```

IPA will be in: `ios/build/ipa/NostradamusMobile.ipa`

## 🔍 Verification Checklist

After setup, verify everything is working:

- [ ] **CocoaPods installed**: `pod --version`
- [ ] **Workspace created**: `ios/NostradamusMobile.xcworkspace` exists
- [ ] **Pods directory exists**: `ios/Pods/` directory present
- [ ] **App builds on simulator**: Run `npm run ios`
- [ ] **Code signing configured**: Check in Xcode Signing & Capabilities
- [ ] **App runs without crashes**: Launch and test basic functionality
- [ ] **Can create archive**: Test archiving in Xcode
- [ ] **IPA generation works**: Run `./generate-ipa.sh --development`

## 📱 Distribution Options

### TestFlight (Recommended for Beta Testing)

1. Generate IPA with `--app-store` method
2. Upload to App Store Connect:
   - Xcode: Window > Organizer > Upload
   - Or use Transporter app
3. Go to App Store Connect
4. Select your app > TestFlight
5. Add beta testers (internal or external)
6. Submit for review (external only)

### Ad-Hoc Distribution

For up to 100 registered devices:

1. Register device UDIDs in Apple Developer portal
2. Create Ad Hoc provisioning profile including these devices
3. Generate IPA with `--ad-hoc` method
4. Distribute via:
   - Email
   - Web hosting (use manifest.plist for OTA)
   - Third-party services (TestFlight, Firebase, etc.)

### App Store

1. Generate IPA with `--app-store` method
2. Upload to App Store Connect
3. Complete App Store metadata:
   - Screenshots
   - Description
   - Keywords
   - Age rating
4. Submit for review
5. Wait for approval (typically 1-3 days)

## 🐛 Troubleshooting

### CocoaPods Issues

**Problem**: `pod install` fails

**Solutions**:
```bash
# Update CocoaPods
sudo gem install cocoapods

# Clear cache and retry
cd ios
pod cache clean --all
rm -rf Pods Podfile.lock
pod install
```

### Code Signing Issues

**Problem**: "No signing certificate found"

**Solutions**:
1. Open Xcode preferences > Accounts
2. Add your Apple ID if not already there
3. Download Manual Profiles
4. Try automatic signing in project settings

**Problem**: "Provisioning profile doesn't match"

**Solutions**:
1. Enable "Automatically manage signing" in Xcode
2. Or update bundle identifier and provisioning profile to match

### Build Failures

**Problem**: Build fails with missing dependencies

**Solutions**:
```bash
# Clean and rebuild
cd ios
rm -rf ~/Library/Developer/Xcode/DerivedData/*
rm -rf build
pod deintegrate
pod install
cd ..
npm start -- --reset-cache
```

**Problem**: "Module not found" errors

**Solutions**:
```bash
# Reset React Native cache
cd mobile-app
npm start -- --reset-cache
```

### Simulator Issues

**Problem**: Simulator doesn't boot

**Solutions**:
```bash
# Reset simulator
xcrun simctl shutdown all
xcrun simctl erase all

# Reinstall Xcode Command Line Tools
sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install
```

### Archive/IPA Issues

**Problem**: Archive succeeds but export fails

**Solutions**:
1. Check `ExportOptions.plist` has correct Team ID
2. Verify provisioning profile exists for the bundle ID
3. Ensure certificate is not expired
4. Try exporting with different method (development vs. ad-hoc)

## 📚 Additional Resources

- **Apple Developer Documentation**: https://developer.apple.com/documentation/
- **React Native iOS Setup**: https://reactnative.dev/docs/environment-setup
- **CocoaPods Guides**: https://guides.cocoapods.org/
- **Xcode Help**: https://help.apple.com/xcode/

## 🆘 Getting Help

If you encounter issues:

1. Check the troubleshooting section above
2. Review [IOS_BUILD_GUIDE.md](IOS_BUILD_GUIDE.md) for detailed information
3. Open an issue on GitHub: https://github.com/federicoronzi/Nostradamus-/issues
4. Include:
   - macOS version
   - Xcode version
   - Error messages
   - Steps to reproduce

## ✅ Success Indicators

You're ready to proceed when:

✓ `pod install` completes without errors
✓ `NostradamusMobile.xcworkspace` opens in Xcode
✓ App builds and runs on simulator
✓ Code signing shows no warnings
✓ Archive can be created
✓ IPA file is generated successfully

## 🎉 Next Steps

Once setup is complete:

1. **Customize the app**:
   - Add app icon: Use https://appicon.co/
   - Modify splash screen
   - Configure API endpoints

2. **Test thoroughly**:
   - Test all features on simulator
   - Test on multiple physical devices
   - Check different iOS versions

3. **Prepare for release**:
   - Follow [IOS_DEPLOYMENT_CHECKLIST.md](IOS_DEPLOYMENT_CHECKLIST.md)
   - Test on real devices
   - Submit to TestFlight

---

**Last Updated**: December 2024
**React Native Version**: 0.72.0
**Minimum iOS Version**: 12.0
**Minimum Xcode Version**: 14.0
