# PWA Implementation Documentation

This document provides a comprehensive overview of the Progressive Web App (PWA) implementation in the HRMS application.

## Table of Contents

1. [Overview](#overview)
2. [PWA Architecture](#pwa-architecture)
3. [File Organization](#file-organization)
4. [Core Components](#core-components)
5. [Configuration](#configuration)
6. [Backend Integration](#backend-integration)
7. [Setup and Development](#setup-and-development)
8. [Testing](#testing)

---

## Overview

The HRMS application implements a complete PWA solution with the following features:

- ✅ **Service Worker** - Offline support and caching via Workbox
- ✅ **Push Notifications** - Firebase Cloud Messaging (FCM) integration
- ✅ **Installable** - Add to home screen capability on mobile devices
- ✅ **Offline Support** - Precaching and runtime caching strategies
- ✅ **App-like Experience** - Standalone mode with custom splash screens
- ✅ **Cross-platform** - Support for iOS, Android, and desktop browsers

---

## PWA Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        Frontend (Vue.js)                        │
├─────────────────────────────────────────────────────────────────┤
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────┐ │
│  │   main.js        │  │ index.html       │  │ vite.config  │ │
│  │ (SW Registration)│  │ (PWA Meta Tags)  │  │ (VitePWA)    │ │
│  └──────────────────┘  └──────────────────┘  └──────────────┘ │
├─────────────────────────────────────────────────────────────────┤
│                    Service Worker Layer                         │
├─────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  sw.js - Service Worker                                   │  │
│  │  • Workbox Precaching                                     │  │
│  │  • Firebase Cloud Messaging (FCM)                         │  │
│  │  • Background Notification Handling                       │  │
│  └──────────────────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  frappe-push-notification.js                              │  │
│  │  • FCM Token Management                                   │  │
│  │  • Notification Subscription                              │  │
│  └──────────────────────────────────────────────────────────┘  │
├─────────────────────────────────────────────────────────────────┤
│                      Backend (Frappe)                           │
├─────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  PWA Notification DocType                                 │  │
│  │  • Notification Storage                                   │  │
│  │  • Push Notification Sending                              │  │
│  └──────────────────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  PWA Notifications Mixin                                  │  │
│  │  • Approval Workflows                                     │  │
│  │  • Status Change Notifications                            │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

---

## File Organization

### Frontend PWA Files

#### Service Workers
| File | Location | Purpose |
|------|----------|---------|
| `sw.js` | `/frontend/public/sw.js` | Main service worker implementing Workbox precaching and FCM background message handling |
| `frappe-push-notification.js` | `/frontend/public/frappe-push-notification.js` | FrappePushNotification class for FCM token management and notification subscriptions |

#### Utilities
| File | Location | Purpose |
|------|----------|---------|
| `pushNotifications.js` | `/frontend/src/utils/pushNotifications.js` | Helper functions for displaying browser notifications |

#### Configuration
| File | Location | Purpose |
|------|----------|---------|
| `vite.config.js` | `/frontend/vite.config.js` | VitePWA plugin configuration with manifest and icon settings |
| `index.html` | `/frontend/index.html` | PWA meta tags, Apple touch icons, and splash screen links |
| `main.js` | `/frontend/src/main.js` | Service worker registration and initialization |

### Backend PWA Files

#### DocTypes
| File | Location | Purpose |
|------|----------|---------|
| `pwa_notification.py` | `/hrms/hr/doctype/pwa_notification/pwa_notification.py` | Python DocType for PWA notification handling |
| `pwa_notification.json` | `/hrms/hr/doctype/pwa_notification/pwa_notification.json` | DocType schema definition |
| `pwa_notification.js` | `/hrms/hr/doctype/pwa_notification/pwa_notification.js` | Client-side form handlers |
| `test_pwa_notification.py` | `/hrms/hr/doctype/pwa_notification/test_pwa_notification.py` | Unit tests |

#### Mixins
| File | Location | Purpose |
|------|----------|---------|
| `pwa_notifications.py` | `/hrms/mixins/pwa_notifications.py` | Mixin for workflow approval notifications (Leave, Expense Claims, Shift Requests) |

### PWA Assets

#### Icons and Splash Screens
| Location | Contents |
|----------|----------|
| `/hrms/public/manifest/` | PWA icons (192x192, 512x512 maskable) and Apple splash screens for various device sizes |

**Icon Files:**
- `favicon-196.png` - Favicon
- `manifest-icon-192.maskable.png` - Android icon (192x192)
- `manifest-icon-512.maskable.png` - Android icon (512x512)

**Splash Screens:** (Various sizes for iPhone, iPad, etc.)
- `apple-splash-640-1136.jpg` through `apple-splash-2048-2732.jpg`

---

## Core Components

### 1. Service Worker (`/frontend/public/sw.js`)

**Key Features:**
- **Workbox Integration**: Precaches assets using Workbox's precache manifest
- **Firebase Messaging**: Handles background push notifications via FCM
- **Notification Display**: Shows notifications when app is in background

**Key Code Sections:**
```javascript
// Precaching with Workbox
self.__WB_MANIFEST; // Populated by VitePWA plugin

// FCM Background Handler
messaging.onBackgroundMessage((payload) => {
  // Display notification logic
});
```

### 2. Push Notification Manager (`/frontend/public/frappe-push-notification.js`)

**Key Features:**
- FCM token generation and management
- Notification permission handling
- Token registration with Frappe backend
- Subscription management

**Main Class:**
```javascript
class FrappePushNotification {
  async initialize() { /* ... */ }
  async requestNotificationPermission() { /* ... */ }
  async registerFCMToken() { /* ... */ }
}
```

### 3. PWA Configuration (`/frontend/vite.config.js`)

**VitePWA Plugin Configuration:**
- **Display Mode**: `standalone` (app-like experience)
- **Start URL**: `/frontend/`
- **Theme Color**: `#0089FF`
- **Icons**: 192x192 and 512x512 maskable icons
- **Service Worker**: Injects manifest and handles registration

### 4. Backend Notification System

#### PWA Notification DocType (`/hrms/hr/doctype/pwa_notification/`)

**Fields:**
- User reference
- Notification message
- Title
- Click action URL
- Timestamp

**Methods:**
- `send_push_notification()` - Sends push notification via Frappe
- `get_notification_link()` - Generates notification click action URL

#### PWA Notifications Mixin (`/hrms/mixins/pwa_notifications.py`)

**Usage in DocTypes:**
- `Leave Application`
- `Expense Claim`
- `Shift Request`

**Notification Triggers:**
- When approver is assigned
- When status changes (Approved/Rejected/Cancelled)
- Notifies relevant employees and approvers

---

## Configuration

### Firebase Configuration

FCM configuration is set in `/frontend/src/main.js`:

```javascript
const firebaseConfig = {
  apiKey: "...",
  authDomain: "...",
  projectId: "...",
  storageBucket: "...",
  messagingSenderId: "...",
  appId: "...",
  measurementId: "..."
};
```

### PWA Manifest (Auto-generated by VitePWA)

The manifest is automatically generated with:
- App name
- Icons (192x192, 512x512)
- Theme colors
- Display mode
- Start URL

### Apple Mobile Web App Configuration

Configured in `/frontend/index.html`:
```html
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<link rel="apple-touch-icon" href="...">
<link rel="apple-touch-startup-image" href="...">
```

---

## Backend Integration

### Frappe Push Notification API

The PWA integrates with Frappe's push notification system:

**Endpoints:**
- `/api/method/frappe.push_notification.register_device` - Register FCM token
- `/api/method/frappe.push_notification.send_notification` - Send notification

### Notification Flow

1. **Frontend**: User grants notification permission
2. **FCM**: Generates unique token for device
3. **Registration**: Token sent to Frappe backend via API
4. **Storage**: Token stored in `Push Notification Subscription` DocType
5. **Trigger**: Backend event (approval, status change)
6. **Send**: Notification sent via FCM to registered devices
7. **Display**: Service worker displays notification

---

## Setup and Development

### Prerequisites

1. Firebase project with Cloud Messaging enabled
2. FCM configuration keys
3. Node.js and npm/yarn
4. Frappe framework

### Installation Steps

1. **Install Frontend Dependencies:**
   ```bash
   cd frontend
   yarn install
   ```

2. **Configure Firebase:**
   - Update FCM config in `/frontend/src/main.js`
   - Add Firebase credentials

3. **Build PWA:**
   ```bash
   yarn build
   ```

4. **Enable PWA in Frappe:**
   - Install `hrms` app
   - Enable push notifications in site config

### Development

**Run Frontend Dev Server:**
```bash
cd frontend
yarn dev
```

**Test Service Worker:**
- Use Chrome DevTools > Application > Service Workers
- Test offline functionality
- Verify cache strategies

**Test Push Notifications:**
- Grant notification permissions
- Trigger notification from backend
- Verify notification display

---

## Testing

### Frontend Testing

**Service Worker Tests:**
- Precaching functionality
- FCM message handling
- Notification display

**Manual Testing:**
1. Install PWA on mobile device
2. Test offline functionality
3. Test push notifications
4. Verify app installation

### Backend Testing

**Unit Tests:**
Located in `/hrms/hr/doctype/pwa_notification/test_pwa_notification.py`

**Run Tests:**
```bash
bench --site [site-name] run-tests hrms.hr.doctype.pwa_notification
```

### Integration Testing

1. **Create notification trigger** (e.g., submit leave application)
2. **Verify notification sent** via FCM
3. **Check notification display** on device
4. **Test click action** (opens correct URL)

---

## Troubleshooting

### Common Issues

**Service Worker Not Registering:**
- Check console for errors
- Verify HTTPS (required for service workers)
- Clear browser cache

**Push Notifications Not Working:**
- Verify FCM configuration
- Check notification permissions
- Verify token registration in backend
- Check FCM console for delivery status

**Offline Mode Not Working:**
- Verify Workbox precache manifest
- Check service worker cache storage
- Test network throttling in DevTools

**Icons Not Displaying:**
- Verify icon paths in manifest
- Check file permissions
- Clear app data and reinstall

---

## Resources

- [Web.dev PWA Guide](https://web.dev/progressive-web-apps/)
- [Workbox Documentation](https://developers.google.com/web/tools/workbox)
- [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging)
- [VitePWA Plugin](https://vite-pwa-org.netlify.app/)
- [Frappe Framework Documentation](https://frappeframework.com/)

---

## Maintenance

### Regular Tasks

1. **Update Dependencies:**
   - VitePWA plugin
   - Workbox libraries
   - Firebase SDK

2. **Monitor:**
   - FCM delivery rates
   - Service worker errors
   - Cache storage usage

3. **Update Assets:**
   - App icons when branding changes
   - Splash screens for new devices
   - Manifest configuration

---

## Future Enhancements

- [ ] Background sync for offline actions
- [ ] Periodic background sync
- [ ] Enhanced caching strategies
- [ ] Web Share API integration
- [ ] Badging API for notification counts
- [ ] Install prompt customization

---

**Last Updated:** 2026-03-02
**Version:** 1.0
