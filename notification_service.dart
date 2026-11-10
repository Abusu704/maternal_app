// lib/services/notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Timezone DB must be initialized before any zonedSchedule call
    tz.initializeTimeZones();

    // Android Configuration
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS Configuration
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
    );

    // Request Android 13+ runtime permissions explicitly
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // Android 12+ requires this for exact alarms, otherwise scheduled
    // reminders can fire late/inexactly
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
  }

  // Trigger immediate reminder notification
  static Future<void> showAppointmentAlert({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'antecare_appointments',
      'Clinical Appointments',
      channelDescription: 'Alerts for scheduled doctor appointments and prenatal checkups',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  // ---------------------------------------------------------------------
  // Toggle state (persisted so the Switch reflects the saved preference
  // on app restart)
  // ---------------------------------------------------------------------

  static const String _prefsKey = 'reminders_enabled';

  static Future<bool> remindersEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefsKey) ?? false;
  }

  /// Call this from the Notifications Switch's onChanged.
  static Future<void> setRemindersEnabled(
    bool enabled, {
    List<AppointmentReminder> appointments = const [],
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, enabled);

    if (enabled) {
      await scheduleAllReminders(appointments);
    } else {
      await _notificationsPlugin.cancelAll();
    }
  }

  // ---------------------------------------------------------------------
  // Scheduled reminder: fires 24 hours before the appointment
  // ---------------------------------------------------------------------

  static Future<void> scheduleAppointmentReminder({
    required int id,
    required String title,
    required String body,
    required DateTime appointmentDateTime,
  }) async {
    final reminderTime = appointmentDateTime.subtract(const Duration(hours: 24));

    // Don't schedule reminders that would fire in the past
    if (reminderTime.isBefore(DateTime.now())) return;

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'antecare_appointments',
      'Clinical Appointments',
      channelDescription: 'Alerts for scheduled doctor appointments and prenatal checkups',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(reminderTime, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Cancels any existing reminders and re-schedules one 24h-before
  /// reminder per appointment. Call this whenever the toggle turns ON,
  /// or whenever the appointment list changes while it's already on.
  static Future<void> scheduleAllReminders(
    List<AppointmentReminder> appointments,
  ) async {
    await _notificationsPlugin.cancelAll();

    for (final appt in appointments) {
      await scheduleAppointmentReminder(
        id: appt.id,
        title: appt.title,
        body: appt.body,
        appointmentDateTime: appt.dateTime,
      );
    }
  }

  static Future<void> cancelReminder(int id) async {
    await _notificationsPlugin.cancel(id);
  }
}

/// Minimal shape NotificationService needs — maps from your Hive
/// [Appointment] model (see profile_screen.dart for the mapping).
class AppointmentReminder {
  final int id;
  final String title;
  final String body;
  final DateTime dateTime;

  AppointmentReminder({
    required this.id,
    required this.title,
    required this.body,
    required this.dateTime,
  });
}

