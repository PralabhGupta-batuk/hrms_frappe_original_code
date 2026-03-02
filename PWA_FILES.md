# PWA Files Reference

This document provides a quick reference to all Progressive Web App (PWA) related files in the HRMS repository.

> **Quick Navigation:** For detailed PWA implementation documentation, see [PWA_IMPLEMENTATION.md](./PWA_IMPLEMENTATION.md)

---

## Frontend Files

### Service Workers & Core PWA Logic

```
frontend/public/
├── sw.js                              # Main service worker (Workbox + FCM)
└── frappe-push-notification.js        # FCM token management & subscription
```

**Details:**
- **`sw.js`**: Implements service worker with Workbox precaching and Firebase Cloud Messaging background handler
- **`frappe-push-notification.js`**: FrappePushNotification class for managing push notification subscriptions

### Utilities

```
frontend/src/utils/
└── pushNotifications.js               # Helper functions for displaying notifications
```

**Details:**
- Browser-agnostic notification display functions
- Handles notification creation and display logic

### Configuration & Entry Points

```
frontend/
├── vite.config.js                     # VitePWA plugin configuration
├── index.html                         # PWA meta tags & Apple splash screens
└── src/
    └── main.js                        # Service worker registration & initialization
```

**Details:**
- **`vite.config.js`**: Configures VitePWA plugin with manifest, icons, and service worker settings
- **`index.html`**: Contains PWA meta tags, Apple touch icons, and splash screen links
- **`main.js`**: Registers service worker and initializes push notifications

---

## Backend Files

### DocTypes

```
hrms/hr/doctype/pwa_notification/
├── pwa_notification.py                # PWA Notification DocType (Python)
├── pwa_notification.json              # DocType schema definition
├── pwa_notification.js                # Client-side form handlers
└── test_pwa_notification.py           # Unit tests
```

**Details:**
- **`pwa_notification.py`**: Handles notification creation and sending via Frappe push notification system
- **`pwa_notification.json`**: Defines DocType fields (user, message, title, click_action, etc.)
- **`test_pwa_notification.py`**: Contains unit tests for PWA notification functionality

### Mixins

```
hrms/mixins/
└── pwa_notifications.py               # PWA Notifications Mixin
```

**Details:**
- Mixin used by Leave Application, Expense Claim, and Shift Request DocTypes
- Sends notifications on status changes and approver assignments
- Methods: `notify_approver()`, `notify_employee()`

---

## Assets

### Icons & Splash Screens

```
hrms/public/manifest/
├── favicon-196.png                    # Favicon (196x196)
├── manifest-icon-192.maskable.png     # Android icon (192x192, maskable)
├── manifest-icon-512.maskable.png     # Android icon (512x512, maskable)
├── apple-splash-640-1136.jpg          # iPhone 5/SE splash screen
├── apple-splash-750-1334.jpg          # iPhone 8 splash screen
├── apple-splash-828-1792.jpg          # iPhone 11 splash screen
├── apple-splash-1125-2436.jpg         # iPhone X splash screen
├── apple-splash-1170-2532.jpg         # iPhone 12 Pro splash screen
├── apple-splash-1179-2556.jpg         # iPhone 14 Pro splash screen
├── apple-splash-1242-2208.jpg         # iPhone 8 Plus splash screen
├── apple-splash-1242-2688.jpg         # iPhone 11 Pro Max splash screen
├── apple-splash-1284-2778.jpg         # iPhone 12 Pro Max splash screen
├── apple-splash-1290-2796.jpg         # iPhone 14 Pro Max splash screen
├── apple-splash-1536-2048.jpg         # iPad Mini splash screen
├── apple-splash-1620-2160.jpg         # iPad Pro 10.5" splash screen
├── apple-splash-1668-2224.jpg         # iPad Pro 10.5" splash screen (portrait)
├── apple-splash-1668-2388.jpg         # iPad Pro 11" splash screen
├── apple-splash-2048-1536.jpg         # iPad Mini splash screen (landscape)
├── apple-splash-2048-2732.jpg         # iPad Pro 12.9" splash screen
├── apple-splash-2160-1620.jpg         # iPad Pro 10.5" splash screen (landscape)
├── apple-splash-2208-1242.jpg         # iPhone 8 Plus splash screen (landscape)
├── apple-splash-2224-1668.jpg         # iPad Pro 10.5" splash screen (landscape)
├── apple-splash-2388-1668.jpg         # iPad Pro 11" splash screen (landscape)
├── apple-splash-2532-1170.jpg         # iPhone 12 Pro splash screen (landscape)
├── apple-splash-2556-1179.jpg         # iPhone 14 Pro splash screen (landscape)
├── apple-splash-2688-1242.jpg         # iPhone 11 Pro Max splash screen (landscape)
├── apple-splash-2732-2048.jpg         # iPad Pro 12.9" splash screen (landscape)
├── apple-splash-2778-1284.jpg         # iPhone 12 Pro Max splash screen (landscape)
└── apple-splash-2796-1290.jpg         # iPhone 14 Pro Max splash screen (landscape)
```

**Details:**
- Icons are in maskable format for Android adaptive icons
- Splash screens cover all major iOS device sizes and orientations

---

## File Count Summary

| Category | Count | Description |
|----------|-------|-------------|
| **Frontend Core** | 3 | Service worker, push notification manager, utilities |
| **Frontend Config** | 3 | Vite config, HTML entry, main.js registration |
| **Backend DocTypes** | 4 | PWA Notification DocType files (py, json, js, test) |
| **Backend Mixins** | 1 | PWA Notifications Mixin |
| **Assets (Icons)** | 3 | Favicon + 2 manifest icons |
| **Assets (Splash)** | 27 | Apple splash screens for various devices |
| **TOTAL** | **41** | Total PWA-related files |

---

## Quick File Access

### By Technology

**JavaScript/Frontend:**
- `/frontend/public/sw.js`
- `/frontend/public/frappe-push-notification.js`
- `/frontend/src/utils/pushNotifications.js`
- `/frontend/src/main.js`
- `/frontend/vite.config.js`
- `/frontend/index.html`

**Python/Backend:**
- `/hrms/hr/doctype/pwa_notification/pwa_notification.py`
- `/hrms/hr/doctype/pwa_notification/test_pwa_notification.py`
- `/hrms/mixins/pwa_notifications.py`

**Configuration:**
- `/hrms/hr/doctype/pwa_notification/pwa_notification.json`
- `/hrms/hr/doctype/pwa_notification/pwa_notification.js`

**Assets:**
- `/hrms/public/manifest/*.png` (icons)
- `/hrms/public/manifest/*.jpg` (splash screens)

### By Function

**Service Worker & Caching:**
- `/frontend/public/sw.js`
- `/frontend/vite.config.js` (VitePWA plugin)

**Push Notifications:**
- `/frontend/public/frappe-push-notification.js`
- `/frontend/src/utils/pushNotifications.js`
- `/hrms/hr/doctype/pwa_notification/` (all files)
- `/hrms/mixins/pwa_notifications.py`

**PWA Installation & Manifest:**
- `/frontend/vite.config.js`
- `/frontend/index.html`
- `/hrms/public/manifest/` (all assets)

**Initialization:**
- `/frontend/src/main.js`

---

## Integration Points

### Frontend → Backend API Calls

The PWA frontend interacts with Frappe backend via these API endpoints:

```javascript
// Token registration
frappe.call({
  method: "frappe.push_notification.register_device",
  args: { token: fcmToken }
});

// Send notification (backend-side)
frappe.push_notification.send_notification({
  user: user_id,
  message: message,
  title: title,
  click_action: url
});
```

### Backend → Frontend Notification Flow

1. **Trigger**: Status change in Leave/Expense/Shift DocType
2. **Mixin**: `pwa_notifications.py` calls `notify_approver()` or `notify_employee()`
3. **DocType**: `PWA Notification` created in database
4. **API**: Frappe sends notification via FCM to registered devices
5. **Service Worker**: `sw.js` receives background message
6. **Display**: Notification shown to user

---

## Dependencies

### NPM Packages (PWA-related)

```json
{
  "vite-plugin-pwa": "^x.x.x",
  "workbox-precaching": "^x.x.x",
  "workbox-routing": "^x.x.x",
  "firebase": "^x.x.x"
}
```

### Python Packages (PWA-related)

No specific Python packages required - uses Frappe's built-in push notification system.

---

## Environment Variables

### Firebase Configuration (in `/frontend/src/main.js`)

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

**Security Note:** These credentials should ideally be loaded from environment variables in production.

---

## Related Documentation

- [PWA_IMPLEMENTATION.md](./PWA_IMPLEMENTATION.md) - Comprehensive PWA implementation guide
- [README.md](./README.md) - Main project README
- Frontend Build: `frontend/package.json`
- Backend Setup: Frappe bench commands

---

**Last Updated:** 2026-03-02
**Maintained By:** Development Team
