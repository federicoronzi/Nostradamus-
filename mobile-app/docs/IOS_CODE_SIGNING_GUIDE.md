# iOS Code Signing Guide for Nostradamus Mobile

Complete guide to configure code signing for iOS app distribution.

## 📋 Table of Contents

1. [Understanding Code Signing](#understanding-code-signing)
2. [Apple Developer Account Setup](#apple-developer-account-setup)
3. [Automatic Code Signing](#automatic-code-signing-recommended)
4. [Manual Code Signing](#manual-code-signing-advanced)
5. [Troubleshooting](#troubleshooting)
6. [Best Practices](#best-practices)

---

## 🔐 Understanding Code Signing

### What is Code Signing?

Code signing ensures that:
- Your app comes from a trusted source (you)
- The app hasn't been tampered with
- Users can verify the app's authenticity

### Types of Certificates

1. **Development Certificate**
   - For testing on physical devices during development
   - Can be created with free Apple ID
   - Limited to 7 days on device (free account)

2. **Distribution Certificate**
   - For distributing via TestFlight or App Store
   - Requires paid Apple Developer Program ($99/year)
   - No device limit

### Types of Provisioning Profiles

1. **Development Profile**
   - For development and testing
   - Includes list of authorized devices
   - Can install via Xcode on registered devices

2. **Ad Hoc Profile**
   - For distribution outside App Store
   - Limited to 100 devices per year
   - Requires device UDIDs to be registered

3. **App Store Profile**
   - For App Store and TestFlight distribution
   - No device limits
   - Requires paid Developer Program

---

## 👤 Apple Developer Account Setup

### Free Apple Developer Account

Good for:
- ✅ Development and testing on your own devices
- ✅ Running on iOS Simulator
- ❌ No TestFlight distribution
- ❌ No App Store distribution
- ❌ Certificates expire after 7 days

**Setup:**

1. Go to [Apple Developer](https://developer.apple.com)
2. Sign in with your Apple ID
3. Accept the Developer Agreement
4. That's it! No payment required

### Paid Apple Developer Program ($99/year)

Required for:
- ✅ TestFlight beta testing
- ✅ App Store distribution
- ✅ Extended certificate validity
- ✅ Access to advanced capabilities

**Enrollment:**

1. Visit [Apple Developer Program](https://developer.apple.com/programs/)
2. Click "Enroll"
3. Sign in with your Apple ID
4. Complete enrollment process
5. Pay $99 annual fee
6. Wait for approval (usually 24-48 hours)

---

## 🚀 Automatic Code Signing (Recommended)

Automatic signing is the easiest method. Xcode manages certificates and profiles for you.

### Step-by-Step Setup

#### 1. Open Project in Xcode

```bash
cd /path/to/Nostradamus-/mobile-app
open ios/NostradamusMobile.xcworkspace
```

**⚠️ Important**: Always open the `.xcworkspace` file, NOT `.xcodeproj`!

#### 2. Configure Signing

1. Select the project in the navigator (blue icon)
2. Select the **NostradamusMobile** target
3. Go to **Signing & Capabilities** tab
4. Check **"Automatically manage signing"**
5. Select your **Team** from dropdown:
   - If you see your name/email: You're using free account
   - If you see organization name: You're using paid account
   - If nothing appears: Add account in Xcode Preferences

#### 3. Add Apple ID to Xcode (if needed)

1. Open **Xcode > Preferences** (Cmd + ,)
2. Go to **Accounts** tab
3. Click **+** button
4. Select **Apple ID**
5. Sign in with your Apple ID
6. Wait for Xcode to fetch your teams

#### 4. Verify Configuration

After selecting a team, you should see:
- ✅ Green checkmark or "Ready to Run"
- ✅ Provisioning Profile: "Xcode Managed Profile"
- ✅ Signing Certificate: Your name or "Apple Development"

If you see errors:
- ❌ Red X with error message → See [Troubleshooting](#troubleshooting)

#### 5. Configure for Release (Optional)

If deploying to TestFlight or App Store:

1. Still in **Signing & Capabilities**
2. Under **Release** section
3. Ensure **"Automatically manage signing"** is also checked
4. Same team should be selected

### Testing Automatic Signing

#### On Simulator (No signing needed)
```bash
npm run ios
```

#### On Physical Device

1. Connect iPhone/iPad via USB
2. Unlock device and trust computer if prompted
3. In Xcode, select your device from the device dropdown
4. Press **Cmd + R** or click Play button
5. On device: **Settings > General > VPN & Device Management**
6. Tap your developer app certificate
7. Tap **Trust**
8. Go back to home screen and open app

---

## 🔧 Manual Code Signing (Advanced)

Use manual signing if:
- You need fine-grained control
- Working in CI/CD environment
- Sharing certificates across team
- Automatic signing has persistent issues

### Prerequisites

- Paid Apple Developer Program membership
- Access to Apple Developer Portal

### Step 1: Create Certificates

#### Development Certificate

1. Go to [Apple Developer Certificates](https://developer.apple.com/account/resources/certificates)
2. Click **+** button
3. Select **Apple Development**
4. Click **Continue**
5. Follow instructions to create CSR (Certificate Signing Request):
   - Open **Keychain Access** on Mac
   - Menu: **Keychain Access > Certificate Assistant > Request Certificate from Authority**
   - Enter your email
   - Select **"Saved to disk"**
   - Save `.certSigningRequest` file
6. Upload CSR file
7. Download certificate (`.cer` file)
8. Double-click to install in Keychain

#### Distribution Certificate (for TestFlight/App Store)

Same process but select **Apple Distribution** instead of Apple Development.

### Step 2: Register Devices (for Development/Ad Hoc)

1. Go to [Devices](https://developer.apple.com/account/resources/devices)
2. Click **+** button
3. Enter device name and UDID
   - Find UDID: Connect device → Open Finder → Select device → Click on serial number
4. Click **Continue** and **Register**

### Step 3: Create App ID

1. Go to [Identifiers](https://developer.apple.com/account/resources/identifiers)
2. Click **+** button
3. Select **App IDs** → **App**
4. Enter description: "Nostradamus Mobile"
5. Bundle ID: **Explicit** → `com.federicoronzi.nostradamus.NostradamusMobile`
6. Select capabilities needed (Push Notifications, etc.)
7. Click **Continue** and **Register**

### Step 4: Create Provisioning Profiles

#### Development Profile

1. Go to [Profiles](https://developer.apple.com/account/resources/profiles)
2. Click **+** button
3. Select **iOS App Development**
4. Select your App ID
5. Select your Development certificate
6. Select devices to include
7. Enter profile name: "Nostradamus Development"
8. Download profile (`.mobileprovision` file)

#### Distribution Profile (for TestFlight/App Store)

Same process but select **App Store** type and Distribution certificate.

### Step 5: Configure Xcode for Manual Signing

1. Open `ios/NostradamusMobile.xcworkspace` in Xcode
2. Select project → Target → **Signing & Capabilities**
3. **Uncheck** "Automatically manage signing"
4. For **Debug** configuration:
   - Provisioning Profile: Select "Nostradamus Development" (or import downloaded profile)
   - Signing Certificate: Select your Development certificate
5. For **Release** configuration:
   - Provisioning Profile: Select your Distribution profile
   - Signing Certificate: Select your Distribution certificate

### Step 6: Install Profiles

If profiles don't appear in Xcode:

```bash
# Copy profiles to Xcode provisioning directory
cp ~/Downloads/*.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
```

Or double-click `.mobileprovision` files to install.

### Update ExportOptions.plist

Edit `ios/ExportOptions.plist` for manual signing:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>app-store</string>
    
    <key>teamID</key>
    <string>YOUR_TEAM_ID_HERE</string>
    
    <key>signingStyle</key>
    <string>manual</string>
    
    <key>provisioningProfiles</key>
    <dict>
        <key>com.federicoronzi.nostradamus.NostradamusMobile</key>
        <string>Your Profile Name Here</string>
    </dict>
    
    <key>signingCertificate</key>
    <string>Apple Distribution</string>
</dict>
</plist>
```

---

## 🐛 Troubleshooting

### Error: "No signing certificate found"

**Solution:**

1. **Xcode Preferences** → **Accounts**
2. Select your Apple ID
3. Click **Download Manual Profiles**
4. If still not working:
   - Remove and re-add your Apple ID
   - Restart Xcode

### Error: "Provisioning profile doesn't include signing certificate"

**Causes:**
- Certificate was revoked or expired
- Profile doesn't include your certificate

**Solution:**

1. Go to Apple Developer Portal
2. Delete old provisioning profile
3. Create new profile with current certificate
4. Download and install new profile

### Error: "Failed to register bundle identifier"

**Causes:**
- Bundle ID already registered to another account
- Bundle ID contains invalid characters

**Solution:**

1. Change Bundle ID in Xcode:
   - Target → General → Bundle Identifier
   - Use reverse domain format: `com.yourname.nostradamus`
2. Update in `Info.plist` if hardcoded
3. Update in Apple Developer Portal if using manual signing

### Error: "App installation failed - A valid provisioning profile for this executable was not found"

**Solution:**

1. On device: **Settings → General → VPN & Device Management**
2. Find and tap your developer certificate
3. Tap **Trust**
4. Try installing app again

### Free Account: "App will expire in 7 days"

This is normal for free accounts. Options:

1. **Re-sign every 7 days**: Rebuild and reinstall app
2. **Upgrade to paid account**: Get persistent certificates
3. **Use TestFlight**: Requires paid account but gives 90-day builds

### Error: "This request is forbidden for security reasons"

**Causes:**
- Two-factor authentication not enabled
- App-specific password needed

**Solution:**

1. Enable 2FA: [Apple ID Security](https://appleid.apple.com)
2. Create app-specific password if using CI/CD
3. Use Xcode directly instead of command line tools

---

## ✅ Best Practices

### For Development

1. ✅ Use **automatic signing** whenever possible
2. ✅ Use **free Apple ID** for personal projects
3. ✅ Test on **simulator first**, then physical device
4. ✅ Keep Xcode and macOS updated
5. ❌ Don't commit certificates or private keys to Git

### For Distribution

1. ✅ Use **paid Developer Program** for TestFlight/App Store
2. ✅ Keep certificates backed up securely
3. ✅ Use **automatic signing** even for Release builds
4. ✅ Increment build number for each upload
5. ✅ Test on TestFlight before App Store submission

### For Teams

1. ✅ Use **manual signing** for consistency
2. ✅ Share certificates securely (not via Git!)
3. ✅ Document team ID and profile names
4. ✅ Use CI/CD for automated builds
5. ✅ Revoke certificates when team members leave

### Security

1. ❌ **Never** commit these to Git:
   - Private keys (`.p12` files)
   - Provisioning profiles
   - Apple ID passwords
   - API keys or secrets

2. ✅ Add to `.gitignore`:
   ```
   *.mobileprovision
   *.certSigningRequest
   *.p12
   *.cer
   ios/exportOptions.plist  # if contains team ID
   ```

3. ✅ Use environment variables for sensitive data
4. ✅ Rotate certificates periodically
5. ✅ Enable two-factor authentication on Apple ID

---

## 📚 Additional Resources

- [Apple Code Signing Guide](https://developer.apple.com/support/code-signing/)
- [React Native iOS Setup](https://reactnative.dev/docs/running-on-device)
- [Xcode Documentation](https://developer.apple.com/documentation/xcode)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)

---

## 🆘 Getting Help

### Check Signing Status

```bash
# View certificates in keychain
security find-identity -v -p codesigning

# List installed provisioning profiles
ls -la ~/Library/MobileDevice/Provisioning\ Profiles/

# View certificate details
security find-certificate -a -c "Apple Development"
```

### Xcode Logs

1. **Window** → **Devices and Simulators**
2. Select your device
3. Click **View Device Logs**
4. Look for signing-related errors

### Clean and Reset

If all else fails:

```bash
# Clean Xcode derived data
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# Clean build folder
cd ios
rm -rf build/
cd ..

# Clean and rebuild
npm start -- --reset-cache
```

---

**Last Updated**: December 2024  
**App Version**: 0.1.0  
**React Native Version**: 0.72.0  
**Minimum iOS Version**: 12.0
