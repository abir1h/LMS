import 'app_event_widget.dart';
import 'notification_client.dart';

class NotificationClickedNotifier  extends EventNotifier<NotificationEntity> {
  NotificationClickedNotifier._();
  static NotificationClickedNotifier get instance=> _instance;
  static final NotificationClickedNotifier _instance = NotificationClickedNotifier._();


  String get getKey=>"notification_received_on_landing_screen";
  void onNotificationClicked(NotificationEntity notification) {
    notifyListeners(getKey,notification);
  }
}