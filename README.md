# College Alert App (Flutter) — Beginner Project

A simple 3-screen Flutter app that lets students see, add, and delete college
alerts (exams, holidays, fests, etc.), with a notification shown whenever a
new alert is added.

## Screens
1. **Home Screen** — lists all alerts. Tap the trash icon to delete one, tap
   the card to view full details, tap the **+** button to add a new one.
2. **Add Alert Screen** — a simple form (title, description, date) to create
   a new alert.
3. **Detail Screen** — shows the full alert and lets you delete it from here too.

## Project structure
```
lib/
  main.dart                          # App entry point + theme
  models/alert.dart                  # Simple Alert data class
  services/notification_service.dart # Shows a notification safely
  screens/home_screen.dart           # List + delete
  screens/add_alert_screen.dart      # Add form
  screens/detail_screen.dart         # Full details + delete
```

Data is kept in memory (a simple `List<Alert>` inside `HomeScreen`) — no
database needed. This keeps the project easy to read and understand, which
fits a beginner-level assignment. (Note: alerts will reset if you fully close
the app — that's expected and fine for this project.)

## How to run this

1. **Install Flutter** if you haven't already:
   https://docs.flutter.dev/get-started/install
2. **Create a fresh Flutter project** (this generates the `android/`, `ios/`
   folders you need, which aren't included here):
   ```bash
   flutter create college_alert_app
   cd college_alert_app
   ```
3. **Copy files in**: copy `pubspec.yaml` over the generated one, and copy
   everything inside this zip's `lib/` folder into your project's `lib/`
   folder (replacing the generated `main.dart`).
4. **Install dependencies:**
   ```bash
   flutter pub get
   ```
5. **Enable notification permission on Android 13+**: open
   `android/app/src/main/AndroidManifest.xml` and add this line inside the
   `<manifest>` tag, above `<application>`:
   ```xml
   <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
   ```
6. **Run it:**
   ```bash
   flutter run
   ```

### Windows users
If you see **"Building with plugins requires symlink support"**, enable
Developer Mode once: run `start ms-settings:developers`, turn on Developer
Mode, then restart your terminal and try again.

## How notifications work here
When you tap "Save Alert", the app:
1. Builds the new `Alert` from what you typed.
2. Tries to show a notification ("New Alert: <title>").
3. Sends the alert back to the Home screen and adds it to the list.

Step 2 is wrapped in a safety net (`try/catch` inside
`NotificationService`) — so even if the notification fails for any reason
(permission not granted, emulator quirks, etc.), your alert still saves
normally. You'll just quietly miss the notification pop-up in that case,
nothing breaks.

## Things you could add later (not required for a beginner project)
- Save alerts permanently using `sqflite` or `shared_preferences`, so they
  don't reset when the app closes.
- Add categories (Exam/Fest/Holiday) with colored tags.
- Add a date picker instead of typing the date manually.
