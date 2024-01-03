import 'package:doal/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_10y.dart' as tz;

class MyNotification {
  int getNotificationId(String taskId) {
    // Use hash function to convert the string taskId into an integer value
    return taskId.hashCode;
  }

  void showNotification(
      int notificationId, String title, String time, String date) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel id',
      'channel name',
      importance: Importance.max,
      priority: Priority.max,
    );

    NotificationDetails notiDetails =
        NotificationDetails(android: androidDetails);

    int year = int.parse(date.substring(0, 4));
    int month = int.parse(date.substring(5, 7));
    int day = int.parse(date.substring(8));
    int hour = int.parse(time.substring(0, 2));
    int minute = int.parse(time.substring(3));
    final location = tz.local;

    tz.TZDateTime scheduledDateTime =
        tz.TZDateTime.from(DateTime(year, month, day, hour, minute), location);

    // Convert the scheduledDateTime to the appropriate time zone

    try {
      await notificationsPlugin.zonedSchedule(
        notificationId,
        title,
        'Scheduled task at $time', // Modify notification body if needed
        scheduledDateTime,
        notiDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        // Allow notification to be shown while idle
      );
    } catch (e) {
      print('Error scheduling notification: $e');
      // Handle the error or perform additional actions if needed
    }
  }
}


//   static Future showNotification({
//     int id = 0;
//     String? title,
//     String? body,
//     String? payload,
//   }) async => _notifications.show(id, title, body, _notificationDetails(),payload: payload,);