import 'package:toastification/toastification.dart';
import 'import_app.dart';

enum MessageType { none, success, error, notice }

enum StatusApp {
  none,
  success,
  error,

  connectError,
  disconnectError,

  incorrectAccount,
  blankAccount,

  contactAccount,

  newFeature,
  newFeaturePornhub
}

class ConfigApp {
  static String message(StatusApp e) {
    String msg = '';

    switch (e) {
      case StatusApp.connectError:
      case StatusApp.disconnectError:
        msg = 'Unable to connect to the server, please check your internet connection!';
        break;
      case StatusApp.incorrectAccount:
        msg = 'Username or password is incorrect.'
            'If you do not have an account, please contact the administrator for support.';
        break;
      case StatusApp.blankAccount:
        msg = 'Username or Password is empty!';
        break;
      case StatusApp.contactAccount:
        msg =
            'To reset your password or register an account, please contact the administrator.\n'
            'Email: chitung1999@gmail.com\nPhone: 0356.080.398';
        break;
      case StatusApp.newFeature:
        msg = 'This feature will be rolled out soon!';
        break;
      case StatusApp.newFeaturePornhub:
        msg = 'This feature will be rolled out soon!\n'
            'However, we detected that you have a PORNHUB account :>';
        break;
      default:
        break;
    }

    return msg;
  }

  static void showNotify(
      BuildContext context, MessageType msgType, StatusApp msg) {
    ToastificationType type;
    String title;

    switch (msgType) {
      case MessageType.success:
        type = ToastificationType.success;
        title = 'SUCCESS';
        break;
      case MessageType.error:
        type = ToastificationType.error;
        title = 'ERROR';
        break;
      default:
        type = ToastificationType.info;
        title = 'NOTICE';
        break;
    }

    toastification.show(
        context: context,
        type: type,
        style: ToastificationStyle.minimal,
        title: Text(title),
        description: Text(message(msg)),
        autoCloseDuration: const Duration(seconds: 5),
        showProgressBar: false);
  }
}
