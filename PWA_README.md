# Progressive Web App (PWA) Documentation

Welcome to the PWA documentation for the HRMS application. This README provides an overview of the PWA implementation and guides you to the appropriate documentation.

## 📚 Documentation Overview

We have created three comprehensive documents to help you understand and work with the PWA code:

### 1. [PWA Implementation Guide](PWA_IMPLEMENTATION.md) 📖
**Best for:** Understanding how PWA works, setting up, and developing

**Contents:**
- Complete PWA architecture with diagrams
- Detailed explanation of all components
- Firebase configuration guide
- Development and testing instructions
- Troubleshooting common issues
- Maintenance guidelines

**When to use:** When you need to understand the implementation details, set up the PWA from scratch, or troubleshoot issues.

### 2. [PWA Files Reference](PWA_FILES.md) 📋
**Best for:** Quick lookup of PWA files and their locations

**Contents:**
- Complete list of all 41 PWA files with paths
- Files organized by technology (Frontend/Backend)
- Files organized by function (Service Worker/Push/Install)
- Integration points and API documentation
- Dependencies and environment variables

**When to use:** When you need to quickly find a specific PWA file or understand what each file does.

### 3. [PWA File Tree](PWA_FILE_TREE.md) 🌲
**Best for:** Visual understanding of file organization

**Contents:**
- Visual tree structure of all PWA files
- Directory hierarchy
- Integration flow diagrams
- Build process documentation
- Quick action commands
- File statistics

**When to use:** When you want to see the big picture of how PWA files are organized or need a visual reference.

---

## 🚀 Quick Start

### For New Developers

1. Start with [PWA Implementation Guide](PWA_IMPLEMENTATION.md) - Read the "Overview" and "PWA Architecture" sections
2. Check [PWA File Tree](PWA_FILE_TREE.md) - Get familiar with the file structure
3. Reference [PWA Files Reference](PWA_FILES.md) - As you work on specific files

### For Existing Developers

- Need to find a file? → [PWA Files Reference](PWA_FILES.md)
- Need to understand a feature? → [PWA Implementation Guide](PWA_IMPLEMENTATION.md)
- Need to see file organization? → [PWA File Tree](PWA_FILE_TREE.md)

### For System Administrators

- Setup and configuration → [PWA Implementation Guide](PWA_IMPLEMENTATION.md) - "Setup and Development" section
- Troubleshooting → [PWA Implementation Guide](PWA_IMPLEMENTATION.md) - "Troubleshooting" section

---

## 📊 PWA Implementation Summary

The HRMS application includes a complete PWA implementation with:

| Feature | Status | Description |
|---------|--------|-------------|
| **Service Worker** | ✅ Implemented | Offline support with Workbox precaching |
| **Push Notifications** | ✅ Implemented | Firebase Cloud Messaging integration |
| **Installable** | ✅ Implemented | Add to home screen on mobile devices |
| **Offline Support** | ✅ Implemented | Assets cached for offline access |
| **App-like Experience** | ✅ Implemented | Standalone mode with custom UI |
| **Cross-platform** | ✅ Implemented | iOS, Android, and desktop support |

### File Statistics

- **Frontend Files:** 6 files (Service Worker, Push Manager, Configuration)
- **Backend Files:** 5 files (DocType, Mixin, Tests)
- **Assets:** 30 files (Icons and Splash Screens)
- **Total:** 41 PWA-related files
- **Documentation:** 1,031 lines across 3 documents

---

## 🎯 PWA Features

### 1. Offline Functionality
The app works offline after the first load, with assets precached using Workbox.

**Files involved:**
- `/frontend/public/sw.js` - Service Worker
- `/frontend/vite.config.js` - VitePWA configuration

### 2. Push Notifications
Users receive real-time notifications for Leave Applications, Expense Claims, and Shift Requests.

**Files involved:**
- `/frontend/public/frappe-push-notification.js` - Push manager
- `/hrms/hr/doctype/pwa_notification/` - Backend notification system
- `/hrms/mixins/pwa_notifications.py` - Workflow integration

### 3. Installable App
Users can install the app on their device's home screen for a native-like experience.

**Files involved:**
- `/frontend/vite.config.js` - Manifest configuration
- `/frontend/index.html` - PWA meta tags
- `/hrms/public/manifest/` - Icons and splash screens

---

## 🔧 Common Tasks

### View All PWA Files
```bash
# Quick command to list all PWA files
find . -name "sw.js" -o -name "*push*notification*" -o -path "*/pwa_notification/*" -o -path "*/manifest/*"
```

### Search PWA Code
```bash
# Search for PWA-related code
grep -r "service worker\|push notification\|PWA" --include="*.js" --include="*.py"
```

### Test PWA Locally
```bash
cd frontend
yarn build
yarn preview  # Serves production build for PWA testing
```

---

## 📖 Documentation Structure

```
Documentation/
├── PWA_README.md              # This file - Overview and navigation
├── PWA_IMPLEMENTATION.md      # Complete implementation guide (417 lines)
├── PWA_FILES.md              # File reference and quick lookup (268 lines)
└── PWA_FILE_TREE.md          # Visual structure and diagrams (346 lines)
```

---

## 🛠️ Technology Stack

### Frontend
- **Vite** + **VitePWA Plugin** - Build tooling and PWA generation
- **Workbox** - Service Worker and caching strategies
- **Firebase** - Cloud messaging for push notifications
- **Vue.js** - Frontend framework

### Backend
- **Frappe Framework** - Backend framework with built-in push notification support
- **Python** - Backend language

---

## 📞 Support & Resources

### Documentation
- [PWA Implementation Guide](PWA_IMPLEMENTATION.md)
- [PWA Files Reference](PWA_FILES.md)
- [PWA File Tree](PWA_FILE_TREE.md)

### External Resources
- [Web.dev PWA Guide](https://web.dev/progressive-web-apps/)
- [Workbox Documentation](https://developers.google.com/web/tools/workbox)
- [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging)
- [VitePWA Plugin](https://vite-pwa-org.netlify.app/)

### Community
- [Frappe Forum](https://discuss.erpnext.com/)
- [GitHub Issues](https://github.com/frappe/hrms/issues)
- [Telegram Group](https://t.me/frappehr)

---

## 🔄 Maintenance

### Regular Updates
- Update Firebase SDK and Workbox libraries
- Test on new iOS/Android versions
- Add splash screens for new devices
- Monitor PWA performance metrics

### Monitoring
- Check service worker registration rates
- Monitor push notification delivery
- Track app installation numbers
- Review cache storage usage

---

**Last Updated:** 2026-03-02  
**Version:** 1.0  
**Maintained By:** Development Team

---

## Quick Navigation

| Document | Purpose | Size |
|----------|---------|------|
| [PWA_IMPLEMENTATION.md](PWA_IMPLEMENTATION.md) | Complete guide | 15KB, 417 lines |
| [PWA_FILES.md](PWA_FILES.md) | File reference | 8.6KB, 268 lines |
| [PWA_FILE_TREE.md](PWA_FILE_TREE.md) | Visual structure | 15KB, 346 lines |

Choose the document that best fits your needs and happy coding! 🚀
