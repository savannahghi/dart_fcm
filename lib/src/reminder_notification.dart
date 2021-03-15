/// [ReminderNotification] a model object for local notifications
class ReminderNotification {
  ReminderNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
