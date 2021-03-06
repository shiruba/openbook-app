import 'package:Openbook/models/notifications/notification.dart';

class PushNotification {
  static PushNotificationType parseType(String pushNotificationTypeStr) {
    if (pushNotificationTypeStr == null) return null;

    PushNotificationType pushNotificationType;
    if (pushNotificationTypeStr == OBNotification.postReaction) {
      pushNotificationType = PushNotificationType.postReaction;
    } else if (pushNotificationTypeStr == OBNotification.postComment) {
      pushNotificationType = PushNotificationType.postComment;
    } else if (pushNotificationTypeStr == OBNotification.connectionRequest) {
      pushNotificationType = PushNotificationType.connectionRequest;
    } else if (pushNotificationTypeStr == OBNotification.follow) {
      pushNotificationType = PushNotificationType.follow;
    } else if (pushNotificationTypeStr == OBNotification.communityInvite) {
      pushNotificationType = PushNotificationType.communityInvite;
    } else {
      throw 'Unsupported push notification type';
    }

    return pushNotificationType;
  }

  final PushNotificationType type;
  final int notificationId;

  const PushNotification({this.notificationId, this.type});

  factory PushNotification.fromJson(Map<String, dynamic> parsedJson) {
    PushNotificationType type = parseType(parsedJson['type']);

    return PushNotification(
        notificationId: parsedJson['notification_id'], type: type);
  }
}

enum PushNotificationType {
  postReaction,
  postComment,
  connectionRequest,
  follow,
  communityInvite
}
