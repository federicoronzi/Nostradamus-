# iOS Build Troubleshooting Guide

Comprehensive guide to resolve common iOS build and development issues for Nostradamus Mobile.

## 📋 Table of Contents

1. [Pod Install Issues](#pod-install-issues)
2. [Build Failures](#build-failures)
3. [Code Signing Issues](#code-signing-issues)
4. [Runtime Errors](#runtime-errors)
5. [Device Installation Issues](#device-installation-issues)
6. [Performance Issues](#performance-issues)
7. [Network and API Issues](#network-and-api-issues)
8. [General Tips](#general-tips)

---

## 🔧 Pod Install Issues

### Error: "Unable to find a specification for..."

```
[!] Unable to find a specification for `React-Core`
```

**Causes:**
- CocoaPods cache is corrupted
- Specs repo needs updating

**Solutions:**

```bash
cd ios

# Clean pod cache
pod cache clean --all

# Remove old pods
rm -rf Pods
rm Podfile.lock

# Update specs repo
pod repo update

# Reinstall
pod install

cd ..
```

### Error: "CDN: trunk Repo update failed"

**Causes:**
- Network issues with CocoaPods CDN
- Firewall or corporate proxy blocking access

**Solutions:**

**Option 1: Use GitHub Specs Repo**

Edit `ios/Podfile`, add at the top:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
```

Then:
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
```

**Option 2: Configure Proxy**

```bash
# Set proxy environment variables
export HTTP_PROXY=http://proxy.company.com:8080
export HTTPS_PROXY=http://proxy.company.com:8080

cd ios
pod install
cd ..
```

### Error: "The platform of the target...is not compatible"

```
The platform of the target `NostradamusMobile` (iOS 12.0) is not compatible with `SomeLibrary` which has a minimum requirement of iOS 13.0
```

**Solution:**

Update minimum iOS version in `ios/Podfile`:

```ruby
platform :ios, '13.0'  # or whatever version is required
```

Then:
```bash
cd ios
pod install
cd ..
```

Also update in Xcode:
- Project → Target → General → Deployment Info → iOS Deployment Target

### Slow `pod install`

**Solutions:**

```bash
# Use faster CDN (already default in newer versions)
pod install --verbose  # See what's taking time

# Clean and update specific pods only
pod update React-Core --no-repo-update

# Skip CocoaPods repo update
pod install --no-repo-update
```

---

## 🏗️ Build Failures

### Error: "Command PhaseScriptExecution failed"

Common with React Native builds.

**Solution 1: Clean Build Folder**

In Xcode:
1. **Product** → **Clean Build Folder** (Shift + Cmd + K)
2. Quit Xcode
3. Delete derived data:
   ```bash
   rm -rf ~/Library/Developer/Xcode/DerivedData/*
   ```
4. Restart Xcode and rebuild

**Solution 2: Reset Metro Cache**

```bash
# Clean Metro cache
npm start -- --reset-cache

# Or
watchman watch-del-all
rm -rf node_modules
rm -rf $TMPDIR/react-*
npm install
```

**Solution 3: Verify Node Environment**

```bash
# Check node is accessible from Xcode
which node

# If installed via nvm, Xcode might not find it
# Create .xcode.env.local (already configured in .xcode.env)
cat ios/.xcode.env
```

### Error: "Multiple commands produce..."

```
Multiple commands produce 'Info.plist'
```

**Causes:**
- Duplicate files in Build Phases
- Conflicting Copy Bundle Resources

**Solution:**

1. In Xcode, select Target
2. Go to **Build Phases**
3. Expand **Copy Bundle Resources**
4. Remove duplicate `Info.plist` entries
5. Ensure Info.plist is ONLY in the app bundle, not copied separately

### Error: "Framework not found"

```
ld: framework not found Pods_NostradamusMobile
```

**Solution:**

```bash
cd ios

# Clean and reinstall pods
rm -rf Pods Podfile.lock
pod deintegrate
pod install

cd ..
```

In Xcode:
1. Open `.xcworkspace` (NOT `.xcodeproj`)
2. Clean Build Folder
3. Rebuild

### Error: "Undefined symbol" or "Linker command failed"

**Solution 1: Clear Build Cache**

```bash
cd ios
rm -rf build/
rm -rf ~/Library/Developer/Xcode/DerivedData/*
cd ..
npm start -- --reset-cache
```

**Solution 2: Verify Architecture Settings**

In Xcode:
1. Target → Build Settings
2. Search for "Excluded Architectures"
3. For Debug, add `arm64` for Simulator if on Apple Silicon Mac
4. Clean and rebuild

### Build Succeeds but App Doesn't Launch

**Solution:**

Check Console for errors:
1. Xcode → **Window** → **Devices and Simulators**
2. Select device/simulator
3. View logs for crash information

Common causes:
- Missing assets
- JavaScript errors
- Native module configuration issues

---

## 🔐 Code Signing Issues

See [IOS_CODE_SIGNING_GUIDE.md](IOS_CODE_SIGNING_GUIDE.md) for detailed code signing troubleshooting.

### Quick Fixes

**"No signing certificate found"**
```bash
# In Xcode Preferences → Accounts
# Remove and re-add Apple ID
# Download Manual Profiles
```

**"Provisioning profile expired"**
```bash
# In Xcode → Target → Signing & Capabilities
# Uncheck "Automatically manage signing"
# Check it again to regenerate profiles
```

**"App ID not found"**
```bash
# Change Bundle Identifier to something unique
# Format: com.yourname.nostradamus
```

---

## 🏃 Runtime Errors

### Error: "Could not connect to development server"

**Causes:**
- Metro bundler not running
- Device/simulator can't reach development machine
- Firewall blocking port 8081

**Solutions:**

**Check Metro is Running:**
```bash
# Start Metro explicitly
npm start

# In new terminal
npm run ios
```

**Verify Connection:**
```bash
# Check if port 8081 is open
lsof -i :8081

# If something else is using it:
kill -9 <PID>
npm start
```

**On Physical Device:**

1. Ensure device and computer are on same network
2. Shake device → **Dev Settings**
3. **Configure Bundler**
4. Enter your computer's IP: `192.168.1.xxx:8081`

### Error: "Invariant Violation: Module AppRegistry is not a registered callable module"

**Solution:**

```bash
# Clear all caches
watchman watch-del-all
rm -rf node_modules
rm -rf $TMPDIR/react-*
rm -rf $TMPDIR/metro-*
npm cache clean --force
npm install

# Clear Metro
npm start -- --reset-cache

# Rebuild
npm run ios
```

### App Crashes on Launch

**Solution:**

1. Check crash logs:
   ```bash
   # View simulator logs
   log stream --predicate 'processImagePath contains "NostradamusMobile"'
   ```

2. Common causes:
   - Missing native dependencies
   - Unlinked libraries
   - JS bundle not found

3. Verify bundle is loaded:
   - Check `ios/build/` for main.jsbundle
   - Ensure Bundle React Native code phase is in Build Phases

### Red Screen Errors

JavaScript errors displayed in app.

**Solution:**

1. Read error message carefully
2. Check source file and line number
3. Common issues:
   - Syntax errors
   - Undefined variables
   - Import errors
4. Fix in JavaScript code, app will hot reload

---

## 📱 Device Installation Issues

### Error: "App installation failed"

**Solution 1: Trust Developer Certificate**

On device:
1. **Settings** → **General** → **VPN & Device Management**
2. Tap your developer certificate
3. Tap **Trust**

**Solution 2: Clear Device Storage**

If device is low on storage:
1. Delete unused apps
2. Clear Photos and Videos
3. Retry installation

**Solution 3: Reset Location & Privacy**

Sometimes device settings block installation:
1. **Settings** → **General** → **Transfer or Reset iPhone**
2. **Reset** → **Reset Location & Privacy**
3. Reconnect device and retry

### Device Not Detected

**Solution:**

```bash
# Unplug and replug device
# Trust this computer prompt on device

# Check if device is visible
xcrun xctrace list devices

# Reset USB connection
# Try different USB cable/port
```

If still not working:
1. Restart device
2. Restart Mac
3. Update iOS to latest version
4. Update Xcode to latest version

### Error: "Device Locked"

Device must be unlocked during installation.

**Solution:**
1. Unlock device
2. Retry installation
3. Keep device awake during process

---

## ⚡ Performance Issues

### Slow Build Times

**Solutions:**

1. **Enable Build Time Warnings:**
   ```bash
   # Add to Build Settings
   OTHER_SWIFT_FLAGS = -Xfrontend -warn-long-function-bodies=100
   ```

2. **Disable Unnecessary Build Phases:**
   - Remove unused scripts
   - Optimize run scripts

3. **Use Pre-built Frameworks:**
   ```ruby
   # In Podfile
   use_frameworks! :linkage => :static
   ```

4. **Incremental Builds:**
   - Don't clean unless necessary
   - Use `xcodebuild build` not `clean build`

### Slow App Launch

**Solution:**

1. **Reduce Bundle Size:**
   ```bash
   # Check bundle size
   ls -lh ios/build/NostradamusMobile.app/main.jsbundle
   
   # Enable Hermes (already enabled in template)
   # Verify in ios/Podfile: hermes_enabled => true
   ```

2. **Optimize Images:**
   - Use appropriate image sizes
   - Compress images
   - Use WebP format where possible

3. **Lazy Load Components:**
   - Use React.lazy() for non-critical screens
   - Load heavy libraries only when needed

### App Freezes or Crashes

**Solution:**

1. **Check Memory Usage:**
   - Xcode → Debug → Memory Report
   - Look for memory leaks
   - Use Instruments for profiling

2. **Profile Performance:**
   ```bash
   # Enable performance monitor
   # In app, shake device → Show Perf Monitor
   ```

3. **Common Issues:**
   - Infinite loops in render
   - Memory leaks from listeners not cleaned up
   - Large data structures in state

---

## 🌐 Network and API Issues

### API Calls Fail on Device

**Solution:**

1. **Check App Transport Security:**

   Edit `ios/NostradamusMobile/Info.plist`:
   ```xml
   <key>NSAppTransportSecurity</key>
   <dict>
       <key>NSAllowsArbitraryLoads</key>
       <true/>
       <!-- For development only! Remove for production -->
   </dict>
   ```

   For production, whitelist specific domains:
   ```xml
   <key>NSAppTransportSecurity</key>
   <dict>
       <key>NSExceptionDomains</key>
       <dict>
           <key>your-api-domain.com</key>
           <dict>
               <key>NSExceptionAllowsInsecureHTTPLoads</key>
               <true/>
               <key>NSIncludesSubdomains</key>
               <true/>
           </dict>
       </dict>
   </dict>
   ```

2. **Test API Separately:**
   ```bash
   # From Mac terminal
   curl https://your-api.com/endpoint
   
   # If fails, check:
   # - API is running
   # - URL is correct
   # - Firewall/VPN not blocking
   ```

3. **Use Charles Proxy:**
   - Install Charles Proxy
   - Configure device to use Mac as proxy
   - See all network requests
   - Debug request/response issues

### Localhost Not Working on Device

**Causes:**
- Device can't access Mac's localhost
- Need to use computer's IP address

**Solution:**

1. Find your Mac's IP:
   ```bash
   ifconfig | grep "inet "
   # Look for 192.168.x.x or 10.x.x.x
   ```

2. Update API configuration:
   ```javascript
   // In src/services/NostradamusService.js
   const API_BASE_URL = __DEV__ 
     ? 'http://192.168.1.100:5000/api'  // Your Mac's IP
     : 'https://production-api.com/api';
   ```

3. On simulator, can still use `localhost`:
   ```javascript
   const API_BASE_URL = Platform.select({
     ios: __DEV__ ? 'http://localhost:5000/api' : 'https://production-api.com/api',
     android: __DEV__ ? 'http://10.0.2.2:5000/api' : 'https://production-api.com/api',
   });
   ```

---

## 💡 General Tips

### Useful Commands

```bash
# Check Xcode and simulator status
xcrun simctl list devices

# Boot a specific simulator
xcrun simctl boot "iPhone 14 Pro"

# Install app on simulator
xcrun simctl install booted path/to/App.app

# Open simulator logs
log stream --predicate 'processImagePath contains "NostradamusMobile"' --level debug

# Check signing identities
security find-identity -v -p codesigning

# List provisioning profiles
ls -la ~/Library/MobileDevice/Provisioning\ Profiles/
```

### Xcode Keyboard Shortcuts

- **Clean Build Folder**: Shift + Cmd + K
- **Build**: Cmd + B
- **Run**: Cmd + R
- **Stop**: Cmd + .
- **Open Quickly**: Cmd + Shift + O
- **Show/Hide Navigator**: Cmd + 0
- **Show/Hide Console**: Cmd + Shift + Y

### Best Practices for Debugging

1. **Use Xcode Console**
   - See native logs
   - View crash reports
   - Monitor memory usage

2. **Use React Native Debugger**
   ```bash
   # Install React Native Debugger
   brew install --cask react-native-debugger
   
   # In app, shake device → Debug
   ```

3. **Enable JavaScript Debugging**
   - Shake device → Debug
   - Opens Chrome DevTools
   - Set breakpoints, inspect variables

4. **Use Flipper** (already configured)
   ```bash
   # Install Flipper
   brew install --cask flipper
   
   # Open Flipper and connect to app
   # View network requests, logs, databases
   ```

### When All Else Fails

**Nuclear Option - Complete Clean:**

```bash
#!/bin/bash
# Complete clean and reset

# Clean Node
watchman watch-del-all
rm -rf node_modules
rm -rf package-lock.json
rm -rf $TMPDIR/react-*
rm -rf $TMPDIR/metro-*

# Clean iOS
cd ios
rm -rf Pods
rm -rf Podfile.lock
rm -rf build/
cd ..

# Clean Xcode
rm -rf ~/Library/Developer/Xcode/DerivedData/*
rm -rf ~/Library/Caches/CocoaPods

# Reinstall everything
npm install
cd ios
pod repo update
pod install
cd ..

# Reset Metro
npm start -- --reset-cache

# In new terminal, rebuild
npm run ios
```

---

## 📚 Additional Resources

### Official Documentation
- [React Native Debugging](https://reactnative.dev/docs/debugging)
- [Xcode Help](https://help.apple.com/xcode/)
- [CocoaPods Troubleshooting](https://guides.cocoapods.org/using/troubleshooting)

### Community Resources
- [React Native GitHub Issues](https://github.com/facebook/react-native/issues)
- [Stack Overflow - React Native iOS](https://stackoverflow.com/questions/tagged/react-native+ios)
- [React Native Community](https://reactnative.dev/community/overview)

### Tools
- [React Native Debugger](https://github.com/jhen0409/react-native-debugger)
- [Flipper](https://fbflipper.com/)
- [Charles Proxy](https://www.charlesproxy.com/)
- [Instruments](https://help.apple.com/instruments/)

---

## 🆘 Getting More Help

If you're still stuck:

1. **Check Error Message Carefully**
   - Often contains solution
   - Google the exact error
   
2. **Search GitHub Issues**
   - [React Native Issues](https://github.com/facebook/react-native/issues)
   - Check if others had same problem

3. **Ask Community**
   - Stack Overflow with full error details
   - React Native Discord
   - Include: OS version, Xcode version, RN version, full error log

4. **File an Issue**
   - [Project GitHub Issues](https://github.com/federicoronzi/Nostradamus-/issues)
   - Include steps to reproduce
   - Attach relevant logs

---

**Last Updated**: December 2024  
**React Native Version**: 0.72.0  
**Xcode Version**: 14.0+  
**iOS Version**: 12.0+
