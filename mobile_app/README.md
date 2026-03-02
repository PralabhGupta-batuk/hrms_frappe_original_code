# HRMS Mobile App

A Flutter mobile application for HRMS (Human Resource Management System) based on the PWA implementation.

## Overview

This is a cross-platform mobile app built with Flutter that provides full access to the HRMS system features including:

- **Authentication** - Secure login with Frappe backend
- **Push Notifications** - Firebase Cloud Messaging integration
- **Leave Management** - Apply, view, and manage leave applications
- **Expense Claims** - Submit and track expense claims
- **Attendance** - Check-in/check-out and attendance tracking
- **Employee Profile** - View and manage employee information

## Architecture

The app is built using a clean architecture pattern with the following layers:

```
lib/
├── config/              # App configuration
│   ├── app_config.dart       # API endpoints and constants
│   ├── firebase_options.dart # Firebase configuration
│   ├── router.dart           # Navigation configuration
│   └── theme.dart            # App theme and colors
│
├── models/              # Data models
├── providers/           # State management (Provider pattern)
│   ├── auth_provider.dart           # Authentication state
│   └── notification_provider.dart   # Notification state
│
├── screens/             # UI screens
│   ├── auth/                  # Authentication screens
│   ├── home/                  # Home dashboard
│   ├── leave/                 # Leave management
│   ├── expense/               # Expense claims
│   ├── attendance/            # Attendance tracking
│   └── profile/               # User profile
│
├── services/            # Business logic and API calls
│   ├── api_client.dart            # HTTP client and API methods
│   └── notification_service.dart  # Push notification handling
│
├── utils/               # Utility functions
├── widgets/             # Reusable UI components
└── main.dart            # App entry point
```

## Features

### 1. Authentication
- Secure login with Frappe credentials
- Session management with secure storage
- Automatic token refresh

### 2. Push Notifications
- Firebase Cloud Messaging integration
- Real-time notifications for:
  - Leave application approvals
  - Expense claim updates
  - Shift requests
  - General announcements
- Deep linking to relevant documents
- Notification badge counters

### 3. Leave Management
- View leave balance
- Apply for new leave
- Track leave application status
- View leave history
- Approve/reject leave requests (for approvers)

### 4. Expense Claims
- Submit new expense claims
- Upload receipts
- Track claim status
- View expense history
- Approve/reject claims (for approvers)

### 5. Attendance
- Quick check-in/check-out
- View attendance history
- Submit attendance requests
- Request shift changes
- View shift assignments

### 6. Employee Profile
- View personal information
- Update contact details
- View employment details
- App settings and preferences

## Tech Stack

### Core
- **Flutter** - UI framework
- **Dart** - Programming language

### State Management
- **Provider** - State management solution

### Networking
- **Dio** - HTTP client for API calls
- **http** - Additional HTTP support

### Storage
- **shared_preferences** - Local data storage
- **flutter_secure_storage** - Secure credential storage

### Push Notifications
- **firebase_core** - Firebase SDK
- **firebase_messaging** - Cloud messaging
- **flutter_local_notifications** - Local notification display

### Navigation
- **go_router** - Declarative routing

### UI Components
- **cached_network_image** - Image caching
- **flutter_svg** - SVG support
- **shimmer** - Loading animations
- **pull_to_refresh** - Pull to refresh functionality

### Forms & Validation
- **flutter_form_builder** - Form building
- **form_builder_validators** - Form validation

### Date & Time
- **intl** - Internationalization
- **table_calendar** - Calendar widget

## Setup Instructions

### Prerequisites

1. **Flutter SDK** (version 3.0.0 or higher)
   ```bash
   flutter --version
   ```

2. **Android Studio** or **Xcode** (for iOS development)

3. **Firebase Project** with Cloud Messaging enabled

### Installation

1. **Clone the repository:**
   ```bash
   cd /path/to/hrms_frappe_original_code
   cd mobile_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   
   - Create a Firebase project at [https://console.firebase.google.com](https://console.firebase.google.com)
   - Add Android and/or iOS apps to your Firebase project
   - Download configuration files:
     - Android: `google-services.json` → `android/app/`
     - iOS: `GoogleService-Info.plist` → `ios/Runner/`
   - Update `lib/config/firebase_options.dart` with your Firebase credentials

4. **Configure Backend URL:**
   
   Update `lib/config/app_config.dart`:
   ```dart
   static const String baseUrl = 'https://your-hrms-site.com';
   ```

5. **Run the app:**
   ```bash
   # For Android
   flutter run

   # For iOS
   flutter run --device=<device-id>

   # For specific device
   flutter devices  # List available devices
   flutter run -d <device-id>
   ```

### Building for Production

#### Android

1. **Configure signing:**
   - Create `android/key.properties`:
     ```properties
     storePassword=<your-store-password>
     keyPassword=<your-key-password>
     keyAlias=<your-key-alias>
     storeFile=<path-to-keystore>
     ```

2. **Build APK:**
   ```bash
   flutter build apk --release
   ```

3. **Build App Bundle:**
   ```bash
   flutter build appbundle --release
   ```

#### iOS

1. **Configure signing in Xcode:**
   - Open `ios/Runner.xcworkspace` in Xcode
   - Configure signing & capabilities
   - Add push notification capability

2. **Build IPA:**
   ```bash
   flutter build ios --release
   ```

## Configuration

### Environment Variables

Set environment variables for different environments:

```bash
# Development
flutter run --dart-define=BASE_URL=https://dev.your-site.com

# Production
flutter build apk --dart-define=BASE_URL=https://your-site.com
```

### Firebase Configuration

Update `lib/config/firebase_options.dart` with your project credentials:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ANDROID_API_KEY',
  appId: 'YOUR_ANDROID_APP_ID',
  messagingSenderId: 'YOUR_SENDER_ID',
  projectId: 'YOUR_PROJECT_ID',
  storageBucket: 'YOUR_PROJECT_ID.appspot.com',
);

static const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'YOUR_IOS_API_KEY',
  appId: 'YOUR_IOS_APP_ID',
  messagingSenderId: 'YOUR_SENDER_ID',
  projectId: 'YOUR_PROJECT_ID',
  storageBucket: 'YOUR_PROJECT_ID.appspot.com',
  iosBundleId: 'com.yourcompany.hrmsmobile',
);
```

## API Integration

The app integrates with the Frappe HRMS backend using REST APIs:

### Authentication
- `POST /api/method/login` - User login
- `POST /api/method/frappe.sessions.clear` - User logout

### Leave Management
- `GET /api/resource/Leave Application` - List leave applications
- `POST /api/resource/Leave Application` - Create leave application
- `PUT /api/resource/Leave Application/{name}` - Update leave application

### Expense Claims
- `GET /api/resource/Expense Claim` - List expense claims
- `POST /api/resource/Expense Claim` - Create expense claim
- `PUT /api/resource/Expense Claim/{name}` - Update expense claim

### Attendance
- `POST /api/resource/Employee Checkin` - Create check-in
- `GET /api/resource/Attendance` - List attendance records

### Push Notifications
- `POST /api/method/frappe.push_notification.register_device` - Register FCM token
- `POST /api/method/frappe.push_notification.unregister_device` - Unregister token

## Testing

### Run Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Integration Tests

```bash
flutter test integration_test/app_test.dart
```

## Project Structure Details

### Config
- **app_config.dart** - API endpoints, storage keys, app constants
- **firebase_options.dart** - Firebase project configuration
- **router.dart** - Navigation routes and guards
- **theme.dart** - App theme, colors, and typography

### Services
- **api_client.dart** - HTTP client with interceptors, authentication, error handling
- **notification_service.dart** - FCM token management, notification display

### Providers
- **auth_provider.dart** - Authentication state, login/logout logic
- **notification_provider.dart** - Notification state, badge management

### Screens
Each feature has its own screen directory with list, form, and detail views.

## Troubleshooting

### Common Issues

1. **Firebase not initialized:**
   - Ensure `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) is in the correct location
   - Run `flutter clean` and `flutter pub get`

2. **API connection errors:**
   - Verify `baseUrl` in `app_config.dart`
   - Check network permissions in `AndroidManifest.xml` and `Info.plist`
   - Ensure backend is accessible from the device

3. **Push notifications not working:**
   - Verify Firebase configuration
   - Check notification permissions
   - Test with Firebase Console test message

4. **Build errors:**
   - Run `flutter clean`
   - Delete `build/` directory
   - Run `flutter pub get`
   - Ensure all dependencies are compatible

## Development Guidelines

### Code Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter analyze` to check for issues
- Format code with `flutter format lib/`

### State Management
- Use Provider for global state
- Use StatefulWidget for local state
- Keep business logic in services/providers

### Naming Conventions
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/Functions: `camelCase`
- Constants: `SCREAMING_SNAKE_CASE`

## Roadmap

### Planned Features
- [ ] Offline support with local database
- [ ] Biometric authentication
- [ ] Document viewer for attachments
- [ ] Calendar integration
- [ ] Multi-language support
- [ ] Dark mode toggle
- [ ] Custom notification sounds
- [ ] Geofencing for attendance
- [ ] Team directory
- [ ] Performance dashboard

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and linting
5. Submit a pull request

## License

This project is part of the HRMS application and follows the same license.

## Support

For issues and questions:
- GitHub Issues: [Create an issue](https://github.com/frappe/hrms/issues)
- Forum: [Frappe Forum](https://discuss.erpnext.com/)
- Telegram: [Frappe HR Group](https://t.me/frappehr)

## Related Documentation

- [PWA Implementation Guide](../PWA_IMPLEMENTATION.md)
- [PWA Files Reference](../PWA_FILES.md)
- [PWA File Tree](../PWA_FILE_TREE.md)
- [Main README](../README.md)

---

**Version:** 1.0.0  
**Last Updated:** 2026-03-02  
**Maintained By:** Development Team
