# Getting Started with iOS Development - Nostradamus Mobile

Complete step-by-step guide to get your iOS development environment ready and build your first iOS app.

## 🎯 What You'll Accomplish

By the end of this guide, you will:
- ✅ Have a fully configured iOS development environment
- ✅ Successfully install all project dependencies
- ✅ Run the Nostradamus app on iOS Simulator
- ✅ Understand how to build and deploy to physical devices
- ✅ Know how to create IPA files for TestFlight/App Store

**Estimated Time**: 30-45 minutes (first time setup)

---

## 📋 Prerequisites Check

Before starting, ensure you have:

### Required (Must Have)
- [ ] **macOS 12.0+** (Monterey or later)
- [ ] **Xcode 14.0+** from Mac App Store
- [ ] **Node.js 16.0+** installed
- [ ] **Internet connection** for downloading dependencies

### Optional (Recommended)
- [ ] **Apple Developer Account** (free account is sufficient for simulators and personal device testing)
- [ ] **iPhone/iPad** for testing on real hardware
- [ ] **CocoaPods** (will be installed if missing)

---

## 🚀 Step-by-Step Setup

### Step 1: Install Required Software

#### 1.1 Install Xcode

1. Open **Mac App Store**
2. Search for "Xcode"
3. Click **Get** / **Install**
4. Wait for download and installation (may take 30-60 minutes, ~12GB)

After installation:
```bash
# Install Command Line Tools
xcode-select --install

# Accept license
sudo xcodebuild -license accept

# Verify installation
xcodebuild -version
```

Expected output: `Xcode 14.x` or later

#### 1.2 Install Node.js

**Option A: Download from website**
1. Visit https://nodejs.org
2. Download LTS version
3. Install

**Option B: Using Homebrew**
```bash
# Install Homebrew if not installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Node.js
brew install node
```

Verify installation:
```bash
node --version  # Should show v16.0.0 or higher
npm --version   # Should show 8.0.0 or higher
```

#### 1.3 Install CocoaPods

```bash
# Install CocoaPods
sudo gem install cocoapods

# Verify installation
pod --version
```

Expected: `1.11.0` or higher

---

### Step 2: Clone and Setup Project

#### 2.1 Clone Repository

```bash
# Navigate to your preferred directory
cd ~/Projects  # or wherever you keep your projects

# Clone the repository
git clone https://github.com/federicoronzi/Nostradamus-.git

# Navigate to mobile app directory
cd Nostradamus-/mobile-app
```

#### 2.2 Verify Environment

Run the environment check script:

```bash
chmod +x check-environment.sh
./check-environment.sh
```

This script will verify:
- ✓ macOS version
- ✓ Xcode installation
- ✓ Node.js and npm
- ✓ CocoaPods
- ✓ Project structure

**If any checks fail**, resolve them before continuing.

---

### Step 3: Install Dependencies

#### 3.1 Automated Installation (Recommended)

```bash
# This will install both npm and CocoaPods dependencies
./ios-build.sh install
```

#### 3.2 Manual Installation

If you prefer to install manually:

```bash
# Install JavaScript dependencies
npm install

# Install iOS native dependencies
cd ios
pod install
cd ..
```

**Expected result**:
- `node_modules/` directory created
- `ios/Pods/` directory created
- `ios/NostradamusMobile.xcworkspace` file created

⚠️ **Important**: The `pod install` step may take 5-15 minutes on first run.

---

### Step 4: Configure Apple Developer Account (Optional for Simulator)

#### For Simulator Only (Skip this step)
If you only want to test on iOS Simulator, you can skip this step.

#### For Physical Device Testing

1. **Open Xcode**:
   ```bash
   open ios/NostradamusMobile.xcworkspace
   ```

2. **Add Apple ID**:
   - Xcode menu → **Preferences** (Cmd + ,)
   - Go to **Accounts** tab
   - Click **+** button
   - Select **Apple ID**
   - Sign in with your Apple ID

3. **Configure Signing**:
   - In project navigator, select **NostradamusMobile** (blue icon)
   - Select **NostradamusMobile** target
   - Go to **Signing & Capabilities** tab
   - Check **"Automatically manage signing"**
   - Select your **Team** from dropdown

---

### Step 5: First Run - iOS Simulator

#### 5.1 Start Metro Bundler

In a terminal window:
```bash
npm start
```

This starts the Metro JavaScript bundler. Leave this running.

#### 5.2 Launch App on Simulator

In a **NEW** terminal window:
```bash
npm run ios
```

Or specify a specific simulator:
```bash
npm run ios -- --simulator="iPhone 14 Pro"
```

**What happens**:
1. Xcode builds the native iOS app
2. iOS Simulator launches
3. App installs on simulator
4. App launches automatically

**Expected result**: 
- iOS Simulator opens
- Nostradamus app launches
- You see the home screen

⏱️ **First build may take 3-5 minutes**

---

### Step 6: Run on Physical Device (Optional)

#### 6.1 Connect Device

1. Connect iPhone/iPad via USB cable
2. Unlock device
3. Tap **Trust** when prompted "Trust This Computer?"

#### 6.2 Select Device in Xcode

```bash
# Open workspace
open ios/NostradamusMobile.xcworkspace
```

1. In Xcode, top bar shows device selector
2. Click device selector dropdown
3. Select your connected iPhone/iPad
4. Click **Play** button (▶️) or press **Cmd + R**

#### 6.3 Trust Developer Certificate

First time only, on your device:
1. Go to **Settings** → **General** → **VPN & Device Management**
2. Tap on your developer certificate
3. Tap **Trust "[Your Name]"**
4. Return to home screen
5. Open Nostradamus app

---

## 🎉 Success! What's Next?

### You've completed the setup! Now you can:

#### Development Workflow

**Make code changes**:
1. Edit files in `src/` directory
2. Save changes
3. App automatically reloads (Hot Reload)

**View logs**:
- Metro bundler shows JavaScript logs
- Xcode console shows native logs

**Debug**:
- Shake device (or Cmd + D in simulator)
- Select **Debug** to open Chrome DevTools

#### Building for Distribution

When ready to distribute:

1. **Create Archive**:
   ```bash
   ./ios-build.sh archive
   ```

2. **Or use Xcode**:
   - Product → Archive
   - Follow distribution wizard

See [IOS_BUILD_GUIDE.md](IOS_BUILD_GUIDE.md) for complete distribution instructions.

---

## 📚 Next Steps and Resources

### Learn More

- **[Quick Start Guide](IOS_QUICK_START.md)** - Quick reference
- **[Complete Build Guide](IOS_BUILD_GUIDE.md)** - In-depth documentation
- **[Code Signing Guide](IOS_CODE_SIGNING_GUIDE.md)** - Certificate setup
- **[Troubleshooting Guide](IOS_TROUBLESHOOTING_GUIDE.md)** - Problem solving
- **[Assets Guide](IOS_ASSETS_GUIDE.md)** - Customize app appearance

### Common Tasks

**Run on different simulator**:
```bash
npm run ios -- --simulator="iPhone SE"
npm run ios -- --simulator="iPad Pro (12.9-inch)"
```

**List available simulators**:
```bash
xcrun simctl list devices available
```

**Clean and rebuild**:
```bash
# Clean everything
rm -rf ios/Pods ios/Podfile.lock
rm -rf node_modules package-lock.json
npm install
cd ios && pod install && cd ..

# Clean Xcode cache
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# Restart Metro
npm start -- --reset-cache
```

**Update dependencies**:
```bash
# Update npm packages
npm update

# Update pods
cd ios
pod update
cd ..
```

---

## 🐛 Troubleshooting Common Issues

### Issue: "Command not found: pod"

**Solution**:
```bash
sudo gem install cocoapods
```

### Issue: "xcrun: error: SDK "iphoneos" cannot be located"

**Solution**:
```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

### Issue: "Unable to boot simulator"

**Solution**:
```bash
# Reset all simulators
xcrun simctl erase all

# Or use Xcode: Device → Erase All Content and Settings
```

### Issue: Build succeeds but app crashes on launch

**Solution**:
1. Check Metro bundler is running
2. Verify JavaScript bundle loaded:
   ```bash
   npm start -- --reset-cache
   ```
3. Check Xcode console for crash logs

### Issue: "The operation couldn't be completed"

**Solution**:
```bash
# Clean build folder
cd ios
rm -rf build/
cd ..

# In Xcode: Product → Clean Build Folder (Shift + Cmd + K)
```

**For more help**: See [IOS_TROUBLESHOOTING_GUIDE.md](IOS_TROUBLESHOOTING_GUIDE.md)

---

## ✅ Verification Checklist

Before moving to development, verify:

- [ ] ✅ Environment check script passes all tests
- [ ] ✅ `npm install` completed without errors
- [ ] ✅ `pod install` completed successfully
- [ ] ✅ `ios/NostradamusMobile.xcworkspace` file exists
- [ ] ✅ App runs on iOS Simulator
- [ ] ✅ Metro bundler starts without errors
- [ ] ✅ Can make code changes and see hot reload
- [ ] ✅ (Optional) App runs on physical device

---

## 🎓 Understanding the Project Structure

### Key Directories

```
mobile-app/
├── ios/                           # iOS native code
│   ├── NostradamusMobile/        # Main app target
│   ├── NostradamusMobile.xcodeproj/   # Xcode project
│   ├── NostradamusMobile.xcworkspace/ # Xcode workspace (use this!)
│   ├── Pods/                      # CocoaPods dependencies
│   └── Podfile                    # CocoaPods configuration
├── src/                           # React Native JavaScript code
│   ├── screens/                   # App screens
│   └── services/                  # API services
├── docs/                          # Documentation
├── check-environment.sh           # Environment verification
├── ios-build.sh                   # Build automation script
├── package.json                   # npm dependencies
└── README.md                      # Main documentation
```

### Important Files

- **ios/NostradamusMobile.xcworkspace** - Always open this in Xcode (not .xcodeproj)
- **ios/Podfile** - Lists iOS native dependencies
- **package.json** - Lists JavaScript dependencies
- **app.json** - React Native app configuration

---

## 💡 Pro Tips

### Productivity Tips

1. **Use Automatic Signing**
   - Let Xcode manage certificates automatically
   - Saves time and reduces errors

2. **Keep Dependencies Updated**
   ```bash
   npm outdated          # Check for updates
   cd ios && pod outdated && cd ..  # Check pod updates
   ```

3. **Use Xcode Shortcuts**
   - Cmd + B: Build
   - Cmd + R: Run
   - Cmd + .: Stop
   - Shift + Cmd + K: Clean

4. **Debug Efficiently**
   - Use console.log() for quick debugging
   - Use React Native Debugger for advanced debugging
   - Check Xcode console for native errors

### Best Practices

1. ✅ Always use `.xcworkspace` after pod install
2. ✅ Keep Node.js and npm updated
3. ✅ Clean derived data periodically
4. ✅ Test on both simulator and real device
5. ✅ Commit `Podfile` and `Podfile.lock` to git
6. ❌ Don't commit `Pods/` directory
7. ❌ Don't commit `node_modules/`
8. ❌ Don't commit certificates or private keys

---

## 🆘 Getting Help

### Documentation
- [Complete iOS Build Guide](IOS_BUILD_GUIDE.md)
- [Troubleshooting Guide](IOS_TROUBLESHOOTING_GUIDE.md)
- [React Native Docs](https://reactnative.dev/docs/getting-started)

### Community Support
- [GitHub Issues](https://github.com/federicoronzi/Nostradamus-/issues)
- [React Native Community](https://reactnative.dev/community/overview)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/react-native)

### Report Issues
If you encounter bugs or issues:
1. Check [Troubleshooting Guide](IOS_TROUBLESHOOTING_GUIDE.md)
2. Search [GitHub Issues](https://github.com/federicoronzi/Nostradamus-/issues)
3. Create new issue with:
   - macOS version
   - Xcode version
   - Node.js version
   - Full error message
   - Steps to reproduce

---

## 🎊 Congratulations!

You're now ready to develop iOS apps with React Native!

**Happy coding!** 🚀

---

**Last Updated**: December 2024  
**React Native Version**: 0.72.0  
**Xcode Version Required**: 14.0+  
**iOS Version Target**: 12.0+
