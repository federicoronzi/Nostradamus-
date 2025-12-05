# iOS Project Setup Validation Checklist

Use this checklist to verify that the iOS project setup has been completed successfully.

## 📋 Pre-Setup Verification

Before starting the iOS setup on macOS:

### Environment
- [ ] Running on macOS 12.0 or later
- [ ] Xcode 14.0 or later installed
- [ ] Xcode Command Line Tools installed: `xcode-select -p`
- [ ] Node.js 16.0 or later installed: `node -v`
- [ ] npm installed: `npm -v`
- [ ] Git installed: `git --version`

### Repository
- [ ] Repository cloned successfully
- [ ] On correct branch: `copilot/complete-ios-project-setup`
- [ ] All files present in `mobile-app/ios/` directory
- [ ] `package.json` exists in `mobile-app/` directory

## 🔧 Setup Phase

### CocoaPods Installation
- [ ] CocoaPods installed: `pod --version`
- [ ] If not installed: `sudo gem install cocoapods` completed successfully

### Dependencies Installation
- [ ] JavaScript dependencies installed: `npm install` in `mobile-app/` completed
- [ ] No errors in npm install output
- [ ] `node_modules/` directory created

### iOS Native Dependencies
- [ ] Changed to ios directory: `cd mobile-app/ios`
- [ ] Ran `pod install` (or `./setup-ios.sh`)
- [ ] No errors in pod install output
- [ ] `Pods/` directory created in `ios/`
- [ ] `Podfile.lock` created in `ios/`
- [ ] `NostradamusMobile.xcworkspace` created in `ios/`

### Workspace Verification
- [ ] Workspace opens in Xcode: `open NostradamusMobile.xcworkspace`
- [ ] Project navigator shows NostradamusMobile project
- [ ] Pods project visible in workspace
- [ ] No immediate error messages in Xcode

## 🔐 Code Signing Configuration

### Xcode Signing Setup
- [ ] Opened NostradamusMobile project in Xcode
- [ ] Selected NostradamusMobile target
- [ ] Navigated to Signing & Capabilities tab
- [ ] "Automatically manage signing" is enabled
- [ ] Team is selected from dropdown
- [ ] No signing errors displayed
- [ ] Bundle Identifier is: `com.federicoronzi.nostradamus.NostradamusMobile`

### Certificate Verification
- [ ] Development certificate present (or automatically created)
- [ ] Provisioning profile shows "iOS Team Provisioning Profile"
- [ ] Status shows "Xcode Managed Profile" with ✓
- [ ] No "Fix Issue" buttons visible

### ExportOptions.plist Configuration (For IPA Generation)
- [ ] Opened `ios/ExportOptions.plist`
- [ ] Updated `YOUR_TEAM_ID` with actual Team ID
- [ ] Team ID format: 10 alphanumeric characters (e.g., `ABCDE12345`)
- [ ] Selected appropriate export method (ad-hoc, app-store, etc.)
- [ ] Saved changes

## 🧪 Build Verification - Simulator

### Simulator Build
- [ ] Simulators listed: `xcrun simctl list devices | grep iPhone`
- [ ] At least one iOS simulator available
- [ ] Selected target simulator in Xcode (e.g., iPhone 14 Pro)

### Build Test
Choose one method:

**Method A: React Native CLI**
- [ ] From `mobile-app/`: Ran `npm run ios`
- [ ] Metro bundler started
- [ ] Simulator launched automatically
- [ ] App installed on simulator
- [ ] App launched successfully
- [ ] No red error screen

**Method B: Xcode**
- [ ] Selected simulator in Xcode
- [ ] Clicked Build/Run (▶️) or pressed Cmd+R
- [ ] Build succeeded (green checkmark)
- [ ] Simulator launched
- [ ] App appeared on simulator home screen
- [ ] App launched and shows UI

**Method C: Build Script**
- [ ] From `ios/`: Ran `./build-ios.sh`
- [ ] Build completed without errors
- [ ] Output shows success message

### Simulator Runtime Verification
- [ ] App interface loads completely
- [ ] No crash on launch
- [ ] Can navigate between screens (if applicable)
- [ ] No console errors in Xcode or Metro

## 📱 Build Verification - Physical Device

### Device Preparation
- [ ] iOS device connected via USB
- [ ] Device appears in Xcode (Window > Devices and Simulators)
- [ ] Device is trusted: "Trust This Computer" accepted on device
- [ ] Device is unlocked

### Device Build
- [ ] Selected physical device in Xcode
- [ ] Signing still valid (no errors in Signing & Capabilities)
- [ ] Clicked Build/Run (▶️)
- [ ] Build succeeded
- [ ] App installed on device

### Device Trust (First Time Only)
- [ ] On device: Opened Settings > General > VPN & Device Management
- [ ] Developer App section shows your Apple ID
- [ ] Tapped on Apple ID
- [ ] Tapped "Trust [Apple ID]"
- [ ] Confirmed trust

### Device Runtime Verification
- [ ] App launched on device
- [ ] UI renders correctly
- [ ] Touch interactions work
- [ ] No crashes
- [ ] Performance is acceptable

## 📦 IPA Generation

### Archive Creation
Choose one method:

**Method A: Generation Script**
- [ ] From `ios/`: Ran `./generate-ipa.sh --development` (or other method)
- [ ] Script completed without errors
- [ ] Archive created in `ios/build/`
- [ ] IPA file created

**Method B: Xcode**
- [ ] Selected "Any iOS Device (arm64)" as target
- [ ] Product > Archive executed
- [ ] Archive process completed (may take 2-5 minutes)
- [ ] Organizer window opened automatically
- [ ] Archive appears in list with current date/time

### IPA Export
- [ ] In Organizer, clicked "Distribute App"
- [ ] Selected distribution method:
  - [ ] App Store Connect (for TestFlight/App Store)
  - [ ] Ad Hoc (for registered devices)
  - [ ] Development (for testing)
  - [ ] Enterprise (if applicable)
- [ ] Followed through wizard
- [ ] Export completed successfully
- [ ] IPA file saved to chosen location

### IPA Verification
- [ ] IPA file exists and has reasonable size (typically 20-50 MB)
- [ ] File name: `NostradamusMobile.ipa`
- [ ] Can view IPA info: Right-click > Show Package Contents (optional)

## 📄 Documentation Updates

### README Updates
- [ ] Main README.md reviewed
- [ ] iOS documentation links are correct
- [ ] Instructions are clear and accurate
- [ ] All referenced files exist

### Documentation Files
- [ ] MACOS_SETUP.md exists and is complete
- [ ] IOS_BUILD_GUIDE.md exists
- [ ] IOS_QUICK_START.md exists
- [ ] IOS_DEPLOYMENT_CHECKLIST.md exists
- [ ] All documentation is consistent

### Script Documentation
- [ ] `setup-ios.sh` has comments
- [ ] `build-ios.sh` has usage instructions
- [ ] `generate-ipa.sh` has clear options
- [ ] All scripts are executable (`chmod +x`)

## 🔍 Final Verification

### File Structure
- [ ] All necessary iOS files present
- [ ] No temporary files committed
- [ ] `.gitignore` properly excludes build artifacts
- [ ] Pods/ and Podfile.lock are gitignored

### Build Artifacts (Should NOT be committed)
- [ ] `ios/Pods/` not in git
- [ ] `ios/build/` not in git
- [ ] `*.xcuserstate` not in git
- [ ] `DerivedData/` not in git
- [ ] `.ipa` files not in git (unless intentional)

### Scripts and Automation
- [ ] All `.sh` scripts are executable
- [ ] Scripts run without errors on macOS
- [ ] Error handling works correctly
- [ ] Help messages are clear

### Configuration Files
- [ ] `Info.plist` has correct bundle ID
- [ ] `ExportOptions.plist` is properly formatted
- [ ] `Podfile` has correct dependencies
- [ ] `.xcode.env` is present

## 🎯 Success Criteria

All of the following must be true:

✅ **Setup Completed**
- CocoaPods installed
- All dependencies installed
- Workspace created successfully

✅ **Code Signing Works**
- No signing errors in Xcode
- Team configured correctly
- Can build for device

✅ **Builds Successfully**
- Builds on simulator without errors
- Builds on device without errors
- App launches and runs

✅ **IPA Generated**
- Archive created successfully
- IPA exported without errors
- IPA file is valid

✅ **Documentation Complete**
- All guides present and accurate
- Scripts documented
- README updated

## 📊 Test Results

Document your test results:

### Environment Information
```
macOS Version: _______________
Xcode Version: _______________
CocoaPods Version: _______________
Node.js Version: _______________
```

### Build Results
```
Simulator Build: [ PASS / FAIL ]
Device Build: [ PASS / FAIL ]
IPA Generation: [ PASS / FAIL ]
```

### Test Devices
```
Simulator: _______________
Physical Device: _______________
iOS Version: _______________
```

### Issues Encountered
```
List any issues and how they were resolved:
1. 
2. 
3. 
```

## 🚀 Ready for Production

Final checklist before considering the setup complete:

- [ ] All items above checked
- [ ] No critical errors remain
- [ ] App has been tested on at least one simulator
- [ ] App has been tested on at least one physical device
- [ ] IPA can be generated successfully
- [ ] Documentation is accurate and complete
- [ ] Setup can be reproduced by following the documentation

## 📝 Sign-Off

**Completed by**: _______________
**Date**: _______________
**Notes**: 
```
Add any additional notes or observations:


```

---

## 🆘 If Issues Occur

If any checklist item fails:

1. **Review Error Messages**: Carefully read any errors
2. **Check Documentation**: Refer to MACOS_SETUP.md
3. **Troubleshooting**: See troubleshooting section in guides
4. **Clean and Retry**: Often cleaning and rebuilding helps
5. **Ask for Help**: Open an issue with details

## 📚 Reference Documents

- [macOS Setup Guide](MACOS_SETUP.md) - Complete setup instructions
- [iOS Build Guide](IOS_BUILD_GUIDE.md) - Detailed build information
- [Quick Start Guide](IOS_QUICK_START.md) - Fast track setup
- [Deployment Checklist](IOS_DEPLOYMENT_CHECKLIST.md) - Pre-release checks

---

**Version**: 1.0
**Last Updated**: December 2024
