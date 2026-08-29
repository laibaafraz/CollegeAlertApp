import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// This class handles showing a simple notification whenever a new
// alert is added. Everything here is wrapped in try/catch so that
// even if notifications fail (e.g. permission not granted), the rest
// of the app keeps working normally - saving an alert should never
// depend on notifications succeeding.
class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // Call this once when the app starts.
  static Future<void> init() async {
    try {
      const androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const settings = InitializationSettings(android: androidSettings);
      await _plugin.initialize(settings);

      // Android 13+ needs this runtime permission request.
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } catch (e) {
      // If anything goes wrong during setup, just print it.
      // The app should still work fine without notifications.
      debugPrintSafe('Notification init failed: $e');
    }
  }

  // Call this whenever a new alert is added.
  static Future<void> showNotification(String title, String body) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'alerts_channel', // channel id
        'College Alerts', // channel name
        channelDescription: 'Notifies you when a new alert is posted',
        importance: Importance.high,
        priority: Priority.high,
      );
      const details = NotificationDetails(android: androidDetails);

      await _plugin.show(
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title,
        body,
        details,
      );
    } catch (e) {
      debugPrintSafe('Showing notification failed: $e');
    }
  }

  static void debugPrintSafe(String message) {
    // ignore: avoid_print
    print(message);
  }
}
