# PWA File Tree Structure

This document provides a visual tree structure of all PWA-related files in the HRMS repository.

> **Note:** For detailed documentation, see [PWA_IMPLEMENTATION.md](./PWA_IMPLEMENTATION.md) | For quick file reference, see [PWA_FILES.md](./PWA_FILES.md)

---

## Complete PWA File Tree

```
hrms_frappe_original_code/
│
├── frontend/                                   # Frontend Application
│   ├── public/                                # Public Static Files
│   │   ├── sw.js                             # ⚡ Service Worker (Workbox + FCM)
│   │   └── frappe-push-notification.js       # ⚡ Push Notification Manager
│   │
│   ├── src/                                  # Source Code
│   │   ├── main.js                           # ⚡ App Entry + SW Registration
│   │   └── utils/
│   │       └── pushNotifications.js          # ⚡ Notification Display Utilities
│   │
│   ├── index.html                            # ⚡ PWA Meta Tags + Apple Config
│   └── vite.config.js                        # ⚡ VitePWA Plugin Configuration
│
├── hrms/                                       # HRMS Application
│   ├── hr/
│   │   └── doctype/
│   │       └── pwa_notification/             # PWA Notification DocType
│   │           ├── __init__.py
│   │           ├── pwa_notification.py       # ⚡ Notification Logic (Python)
│   │           ├── pwa_notification.json     # ⚡ DocType Schema
│   │           ├── pwa_notification.js       # ⚡ Client-side Handlers
│   │           └── test_pwa_notification.py  # ⚡ Unit Tests
│   │
│   ├── mixins/
│   │   └── pwa_notifications.py              # ⚡ Workflow Notification Mixin
│   │
│   └── public/
│       └── manifest/                         # PWA Assets
│           ├── favicon-196.png               # ⚡ Favicon
│           ├── manifest-icon-192.maskable.png # ⚡ Android Icon (192x192)
│           ├── manifest-icon-512.maskable.png # ⚡ Android Icon (512x512)
│           │
│           └── [Apple Splash Screens]        # ⚡ 30 splash screen variants
│               ├── apple-splash-640-1136.jpg     # iPhone 5/SE
│               ├── apple-splash-750-1334.jpg     # iPhone 8
│               ├── apple-splash-828-1792.jpg     # iPhone 11
│               ├── apple-splash-1125-2436.jpg    # iPhone X
│               ├── apple-splash-1170-2532.jpg    # iPhone 12 Pro
│               ├── apple-splash-1179-2556.jpg    # iPhone 14 Pro
│               ├── apple-splash-1242-2208.jpg    # iPhone 8 Plus
│               ├── apple-splash-1242-2688.jpg    # iPhone 11 Pro Max
│               ├── apple-splash-1284-2778.jpg    # iPhone 12 Pro Max
│               ├── apple-splash-1290-2796.jpg    # iPhone 14 Pro Max
│               ├── apple-splash-1536-2048.jpg    # iPad Mini (portrait)
│               ├── apple-splash-1620-2160.jpg    # iPad Pro 10.5"
│               ├── apple-splash-1668-2224.jpg    # iPad Pro 10.5" (portrait)
│               ├── apple-splash-1668-2388.jpg    # iPad Pro 11"
│               ├── apple-splash-2048-1536.jpg    # iPad Mini (landscape)
│               ├── apple-splash-2048-2732.jpg    # iPad Pro 12.9"
│               ├── apple-splash-2160-1620.jpg    # iPad Pro 10.5" (landscape)
│               ├── apple-splash-2208-1242.jpg    # iPhone 8 Plus (landscape)
│               ├── apple-splash-2224-1668.jpg    # iPad Pro 10.5" (landscape)
│               ├── apple-splash-2388-1668.jpg    # iPad Pro 11" (landscape)
│               ├── apple-splash-2532-1170.jpg    # iPhone 12 Pro (landscape)
│               ├── apple-splash-2556-1179.jpg    # iPhone 14 Pro (landscape)
│               ├── apple-splash-2688-1242.jpg    # iPhone 11 Pro Max (landscape)
│               ├── apple-splash-2732-2048.jpg    # iPad Pro 12.9" (landscape)
│               ├── apple-splash-2778-1284.jpg    # iPhone 12 Pro Max (landscape)
│               └── apple-splash-2796-1290.jpg    # iPhone 14 Pro Max (landscape)
│
└── [Documentation]
    ├── PWA_IMPLEMENTATION.md                 # 📚 Comprehensive PWA Guide
    ├── PWA_FILES.md                          # 📚 Quick File Reference
    └── PWA_FILE_TREE.md                      # 📚 This File (Visual Tree)

```

**Legend:**
- ⚡ = PWA-related file
- 📚 = Documentation file

---

## File Categories

### 1. Frontend Core (6 files)

```
frontend/
├── public/
│   ├── sw.js                                 # Service Worker
│   └── frappe-push-notification.js           # Push Manager
├── src/
│   ├── main.js                               # SW Registration
│   └── utils/
│       └── pushNotifications.js              # Utilities
├── index.html                                # PWA Meta Tags
└── vite.config.js                            # VitePWA Config
```

### 2. Backend Core (5 files)

```
hrms/
├── hr/doctype/pwa_notification/
│   ├── pwa_notification.py                   # DocType Logic
│   ├── pwa_notification.json                 # DocType Schema
│   ├── pwa_notification.js                   # Client Handlers
│   └── test_pwa_notification.py              # Tests
└── mixins/
    └── pwa_notifications.py                  # Workflow Mixin
```

### 3. PWA Assets (30 files)

```
hrms/public/manifest/
├── [Icons - 3 files]
│   ├── favicon-196.png
│   ├── manifest-icon-192.maskable.png
│   └── manifest-icon-512.maskable.png
│
└── [Splash Screens - 27 files]
    ├── [iPhone - 10 variants]
    ├── [iPad - 8 variants]
    └── [Landscape - 9 variants]
```

---

## Integration Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                         User Device                              │
├─────────────────────────────────────────────────────────────────┤
│  Browser                                                         │
│  ├── index.html (loads)                                         │
│  ├── main.js (registers SW)                                     │
│  │   └── sw.js (installed)                                      │
│  │       ├── Precaches assets (Workbox)                         │
│  │       └── Registers FCM handler                              │
│  │                                                               │
│  └── frappe-push-notification.js (initializes)                  │
│      ├── Requests notification permission                       │
│      ├── Gets FCM token                                         │
│      └── Registers token with backend                           │
│          │                                                       │
│          └──── API Call ────┐                                   │
└─────────────────────────────│───────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                     Frappe Backend                               │
├─────────────────────────────────────────────────────────────────┤
│  Push Notification Subscription (stores token)                  │
│                                                                  │
│  User performs action (e.g., submits Leave Application)         │
│  │                                                               │
│  ├── pwa_notifications.py (mixin)                               │
│  │   └── notify_approver() called                               │
│  │                                                               │
│  └── pwa_notification.py (DocType)                              │
│      └── send_push_notification()                               │
│          │                                                       │
│          └──── FCM API ─────┐                                   │
└─────────────────────────────│───────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                  Firebase Cloud Messaging                        │
├─────────────────────────────────────────────────────────────────┤
│  Delivers notification to registered device                     │
│          │                                                       │
│          └──── Push Message ────┐                               │
└─────────────────────────────────│───────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────┐
│                         User Device                              │
├─────────────────────────────────────────────────────────────────┤
│  sw.js (background)                                             │
│  ├── onBackgroundMessage() triggered                            │
│  ├── Uses pushNotifications.js utilities                        │
│  └── Displays notification to user                              │
│                                                                  │
│  User clicks notification                                        │
│  └── Opens app at specified URL                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Key Dependencies

### Frontend (package.json)
```json
{
  "devDependencies": {
    "vite-plugin-pwa": "^x.x.x"
  },
  "dependencies": {
    "workbox-precaching": "^x.x.x",
    "workbox-routing": "^x.x.x",
    "firebase": "^x.x.x"
  }
}
```

### Backend
- **Frappe Framework** - Built-in push notification system
- No additional Python packages required for PWA functionality

---

## Build Process

### VitePWA Plugin Actions

When building the frontend:

1. **Generates Web App Manifest** (`manifest.webmanifest`)
   - Uses configuration from `vite.config.js`
   - Includes app name, icons, theme colors

2. **Creates Workbox Precache Manifest**
   - Lists all assets to cache
   - Injects into `sw.js` at build time

3. **Optimizes Service Worker**
   - Bundles and minifies `sw.js`
   - Adds cache versioning

4. **Copies Static Assets**
   - Icons, splash screens, etc.
   - Ensures proper paths in manifest

### Build Output

```
frontend/dist/
├── manifest.webmanifest        # Generated manifest
├── sw.js                       # Optimized service worker
├── workbox-*.js               # Workbox runtime
└── assets/
    └── manifest/              # Copied PWA assets
```

---

## Development Workflow

### Local Development

1. **Start Frontend Dev Server:**
   ```bash
   cd frontend
   yarn dev
   ```

2. **Service Worker Note:**
   - Service workers don't update in dev mode by default
   - Use "Update on reload" in DevTools for testing
   - Or build and serve production build locally

3. **Test PWA Features:**
   ```bash
   cd frontend
   yarn build
   yarn preview  # Serves production build locally
   ```

### Testing Checklist

- [ ] Service worker registers successfully
- [ ] Assets are precached
- [ ] App works offline (after first load)
- [ ] Push notifications display
- [ ] App is installable (Add to Home Screen)
- [ ] Splash screens show on iOS devices
- [ ] Icons display correctly on all platforms

---

## File Statistics

| Category | File Count | Total Size (approx) |
|----------|-----------|---------------------|
| Frontend JS | 3 | ~10 KB |
| Frontend Config | 3 | ~5 KB |
| Backend Python | 3 | ~5 KB |
| Backend Config | 2 | ~3 KB |
| Icons | 3 | ~50 KB |
| Splash Screens | 27 | ~2 MB |
| **Total** | **41** | **~2.1 MB** |

---

## Quick Actions

### Find all PWA files:
```bash
# Frontend PWA files
find frontend -type f \( -name "sw.js" -o -name "*push*" -o -name "vite.config.js" \)

# Backend PWA files
find hrms -type f -path "*/pwa_notification/*"
find hrms -type f -name "pwa_notifications.py"

# PWA assets
find hrms/public/manifest -type f
```

### Search PWA-related code:
```bash
# Search for PWA-related terms
grep -r "service worker\|push notification\|PWA\|workbox" --include="*.js" --include="*.py" frontend/ hrms/

# Search for FCM/Firebase
grep -r "firebase\|FCM\|messaging" --include="*.js" frontend/
```

### Count PWA files:
```bash
# Total count
echo "Frontend: $(find frontend -name "sw.js" -o -name "*push*" | wc -l)"
echo "Backend: $(find hrms -path "*/pwa_notification/*" -o -name "pwa_notifications.py" | wc -l)"
echo "Assets: $(ls hrms/public/manifest/ | wc -l)"
```

---

## Related Documentation

- [PWA_IMPLEMENTATION.md](./PWA_IMPLEMENTATION.md) - Complete implementation guide
- [PWA_FILES.md](./PWA_FILES.md) - File reference with descriptions
- [README.md](./README.md) - Main project README with PWA section

---

**Last Updated:** 2026-03-02
**File Count:** 41 PWA-related files
**Maintained By:** Development Team
