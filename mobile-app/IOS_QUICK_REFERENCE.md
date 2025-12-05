# iOS Quick Reference Card

**Quick reference for common iOS tasks**

## 🚀 First Time Setup

```bash
cd mobile-app/ios
./complete-setup.sh
```

This runs everything automatically. If you prefer manual steps, see [MACOS_SETUP.md](docs/MACOS_SETUP.md).

## 📱 Daily Development

### Start Development
```bash
cd mobile-app
npm run ios
```

### Build Specific Simulator
```bash
npm run ios -- --simulator="iPhone 14 Pro"
```

### Clear Cache and Restart
```bash
npm start -- --reset-cache
```

## 🔨 Build Commands

### Debug Build (Simulator)
```bash
cd mobile-app/ios
./build-ios.sh
```

### Release Build
```bash
./build-ios.sh --release
```

### Build for Device
```bash
./build-ios.sh --device
```

## 📦 Distribution

### Development IPA (Testing)
```bash
cd mobile-app/ios
./generate-ipa.sh --development
```

### App Store / TestFlight
```bash
./generate-ipa.sh --app-store
```

### Ad-Hoc (100 Devices)
```bash
./generate-ipa.sh --ad-hoc
```

## 🐛 Troubleshooting

### Clean Everything
```bash
cd mobile-app/ios
rm -rf Pods Podfile.lock
pod install
rm -rf build
cd ..
npm start -- --reset-cache
```

### Fix Pods
```bash
cd ios
pod cache clean --all
rm -rf Pods Podfile.lock
pod install
```

### Fix Build
```bash
rm -rf ~/Library/Developer/Xcode/DerivedData/*
cd mobile-app
npm start -- --reset-cache
```

## 📂 Common Files

| File | Purpose |
|------|---------|
| `ios/NostradamusMobile.xcworkspace` | **Always open this** (not .xcodeproj) |
| `ios/Podfile` | CocoaPods dependencies |
| `ios/ExportOptions.plist` | IPA export settings (update Team ID!) |
| `mobile-app/package.json` | JavaScript dependencies |

## 🔧 Xcode Tasks

### Open Project
```bash
cd mobile-app/ios
open NostradamusMobile.xcworkspace
```

### Configure Signing
1. Open workspace in Xcode
2. Select project > Target > Signing & Capabilities
3. Enable "Automatically manage signing"
4. Select Team

### Create Archive
1. Xcode > Product > Archive
2. Wait for build (2-5 min)
3. Click "Distribute App"
4. Choose method and follow wizard

## 📚 Documentation

- **Quick Setup**: [docs/MACOS_SETUP.md](docs/MACOS_SETUP.md)
- **Current Status**: [IOS_COMPLETION_STATUS.md](IOS_COMPLETION_STATUS.md)
- **Full Details**: [docs/IOS_BUILD_GUIDE.md](docs/IOS_BUILD_GUIDE.md)
- **Validation**: [docs/IOS_VALIDATION_CHECKLIST.md](docs/IOS_VALIDATION_CHECKLIST.md)
- **Before Release**: [docs/IOS_DEPLOYMENT_CHECKLIST.md](docs/IOS_DEPLOYMENT_CHECKLIST.md)

## ⚠️ Remember

- ✅ **Always** use `.xcworkspace`, never `.xcodeproj`
- ✅ **Always** update Team ID in `ExportOptions.plist` before IPA
- ✅ **Always** test on real device before release
- ✅ **Always** increment build number for uploads

## 🆘 Need Help?

1. Check [MACOS_SETUP.md](docs/MACOS_SETUP.md) troubleshooting
2. Run `./check-environment.sh` to verify prerequisites
3. Review full guides in `docs/` directory
4. Open GitHub issue with error details

---

**Tip**: Bookmark this file for quick access to common commands!
