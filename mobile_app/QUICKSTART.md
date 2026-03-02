# HRMS Mobile App - Quick Start Guide

Get the HRMS mobile app up and running in minutes!

## Prerequisites

Before you begin, ensure you have:

- [ ] Flutter SDK 3.0.0+ installed ([Install Flutter](https://docs.flutter.dev/get-started/install))
- [ ] Android Studio or Xcode (for iOS)
- [ ] A Firebase project with Cloud Messaging enabled
- [ ] Access to your HRMS backend URL

## 5-Minute Setup

### 1. Install Flutter (if not already installed)

```bash
# Check if Flutter is installed
flutter --version

# If not installed, follow: https://docs.flutter.dev/get-started/install
```

### 2. Navigate to Project

```bash
cd /path/to/hrms_frappe_original_code/mobile_app
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Configure Backend URL

Edit `lib/config/app_config.dart`:

```dart
static const String baseUrl = 'https://your-hrms-site.com';
```

Replace `'https://your-hrms-site.com'` with your actual HRMS backend URL.

### 5. Configure Firebase (Basic Setup)

For now, the app will work without Firebase, but push notifications won't function. To enable push notifications:

1. Create a Firebase project: https://console.firebase.google.com
2. Add Android/iOS app
3. Download config files:
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/Runner/`
4. Update `lib/config/firebase_options.dart` with your credentials

**Skip this step for initial testing** - the app will work without it!

### 6. Run the App

```bash
# List available devices
flutter devices

# Run on connected device
flutter run

# Or run on specific device
flutter run -d <device-id>
```

## Testing Without Backend

If you don't have a backend URL yet, you can still test the UI:

1. Update `lib/config/app_config.dart`:
   ```dart
   static const String baseUrl = 'http://localhost:8000';
   ```

2. The login will fail, but you can explore the UI design

## Default Test Credentials

When connecting to your HRMS instance, use your Frappe credentials:

- **Username:** Your Frappe user email
- **Password:** Your Frappe password

## App Features

Once logged in, you can:

✅ **Dashboard** - Quick overview and actions  
✅ **Leaves** - Apply for and manage leaves  
✅ **Expenses** - Submit expense claims  
✅ **Attendance** - Check in/out and view history  
✅ **Profile** - View and manage your profile  
✅ **Notifications** - Receive push notifications (with Firebase)  

## Troubleshooting

### "flutter: command not found"
- Flutter is not installed or not in PATH
- Install Flutter: https://docs.flutter.dev/get-started/install

### "No devices found"
- Connect an Android device or start an emulator
- For iOS, open Simulator from Xcode

### "Gradle build failed" (Android)
- Update Android SDK in Android Studio
- Run `flutter clean && flutter pub get`

### "Pod install failed" (iOS)
- Run `cd ios && pod install`
- Update CocoaPods: `sudo gem install cocoapods`

### "API connection error"
- Verify `baseUrl` in `app_config.dart`
- Ensure backend is accessible from device
- Check firewall/network settings

## Next Steps

1. ✅ Run the app
2. ✅ Test login with your credentials
3. ✅ Explore the features
4. ⬜ Set up Firebase for push notifications
5. ⬜ Configure for production
6. ⬜ Build APK/IPA for distribution

## Full Documentation

For detailed setup and configuration, see:
- [Complete README](README.md)
- [PWA Implementation](../PWA_IMPLEMENTATION.md)

## Need Help?

- 📧 GitHub Issues: https://github.com/frappe/hrms/issues
- 💬 Forum: https://discuss.erpnext.com/
- 📱 Telegram: https://t.me/frappehr

---

**Ready to build?**

```bash
# Android APK
flutter build apk --release

# iOS IPA (requires Mac)
flutter build ios --release
```

Happy coding! 🚀
