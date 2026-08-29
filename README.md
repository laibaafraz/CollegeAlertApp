# 🎓 College Alert App

A clean, beginner-friendly Flutter app that keeps students in the loop about
campus events — exams, holidays, fests, and deadlines — all in one place.

## ✨ Features

- 📋 **Home Screen** — a live feed of every campus alert, newest at a glance
- ➕ **Add Alert** — a simple form to post a new event in seconds
- 🔍 **Alert Details** — tap any alert to see the full description
- 🗑️ **Delete Alerts** — remove outdated alerts with one tap, right from the
  list or the detail view
- 🔔 **Instant Notifications** — get notified the moment a new alert is posted
- 🎨 **Polished Theme** — a clean deep-purple Material 3 design out of the box

## 📱 Screens

| Screen | What it does |
|---|---|
| **Home** | Browse all alerts, delete old ones, jump into any alert |
| **Add Alert** | Fill in a title, description, and date to post a new alert |
| **Detail** | See the full alert and delete it if it's no longer needed |

## 🗂️ Project Structure

```
lib/
  main.dart                          # App entry point + theme
  models/alert.dart                  # Alert data model
  services/notification_service.dart # Notification logic
  screens/home_screen.dart           # Alert feed
  screens/add_alert_screen.dart      # New alert form
  screens/detail_screen.dart         # Alert details
```

## 🚀 Getting Started

```bash
flutter create .
flutter pub get
flutter run
```

That's it — the app will launch on your connected device or emulator.


It's small enough to read top to bottom in a few minutes, but touches all
the core building blocks of a real app: navigation between screens, forms,
state management, and notifications — a solid foundation to build on.
