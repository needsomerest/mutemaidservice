import 'package:firebase_auth/firebase_auth.dart';

class NotificationData {
  String UserID;
  String ReservationID;
  String NotificationDetail;
  String Header;
  NotificationData(
      this.UserID, this.ReservationID, this.NotificationDetail, this.Header);

  Map<String, dynamic> CreateNotificationtoJson() => {
        'UserID': UserID,
        'Header': Header,
        'ReservationID': ReservationID,
        'NotificationDetail': NotificationDetail,
        'Seen': false,
        'Datetime': DateTime.now()
      };
}
