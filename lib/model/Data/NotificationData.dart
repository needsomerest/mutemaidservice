import 'package:firebase_auth/firebase_auth.dart';

class NotificationData {
  String NotificationID;
  String UserID;
  String ReservationID;
  String NotificationDetail;

  NotificationData(this.NotificationID, this.UserID, this.ReservationID,
      this.NotificationDetail);

  Map<String, dynamic> CreateNotificationtoJson() => {
        'NotificationID': NotificationID,
        'UserID': UserID,
        'ReservationID': ReservationID,
        'NotificationDetail': NotificationDetail,
      };
}
