// LAYER: Services (Layer 3)
// PURPOSE: Manages FCM token registration and local notification scheduling.
//          HabitController calls scheduleReminder(); budgetAlert arrives via FCM.
// TODO Week 8: implement with flutter_local_notifications + firebase_messaging

class NotificationService {
  // Register the device FCM token in Firestore under users/{uid}/fcmToken
  Future<void> registerToken(String uid) async {
    // TODO: FirebaseMessaging.instance.getToken() → save to Firestore
  }

  // Schedule a local notification for a habit reminder at HH:MM each day.
  // notificationId is derived from the habit Firestore doc ID.
  Future<void> scheduleHabitReminder({
    required int notificationId,
    required String habitTitle,
    required String time, // 'HH:MM'
  }) async {
    // TODO: flutter_local_notifications — daily repeat at given time
  }

  // Cancel a previously scheduled habit reminder (called on habit toggle-complete or delete).
  Future<void> cancelReminder(int notificationId) async {
    // TODO: flutterLocalNotificationsPlugin.cancel(notificationId)
  }
}
