import 'package:flutter/material.dart';
import 'package:learning_english_web/constants/status_app.dart';

abstract class ToastMessage {
  static OverlayEntry? _currentOverlayEntry;

  static Icon getIcon(int status) {
    switch(status) {
      case StatusApp.success:
      case StatusApp.loginSuccess:
        return Icon(Icons.check, color: Colors.green);
      case StatusApp.error:
      case StatusApp.loginBlank:
      case StatusApp.loginWrongPassword:
      case StatusApp.loginError:
      case StatusApp.newWordBlank:
      case StatusApp.newWordInvalid:
      case StatusApp.updateFail:
        return Icon(Icons.clear, color: Colors.red);
      default:
        return Icon(Icons.priority_high, color: Colors.yellow);
    }
  }

  static String getMessage(int status) {
    switch(status) {
      case StatusApp.success:
        return '';
      case StatusApp.error:
        return 'Something is wrong!';
      case StatusApp.loginBlank:
        return 'Username or password cannot be blank!';
      case StatusApp.loginWrongPassword:
        return 'Incorrect password!';
      case StatusApp.loginError:
        return 'An error occurred!';
      case StatusApp.loginSuccess:
        return 'Login successful!';
      case StatusApp.newWordBlank:
        return 'New word blank!';
      case StatusApp.newWordExist:
        return 'New word already exist!';
      case StatusApp.newWordInvalid:
        return 'New word contains invalid character!';
      case StatusApp.updateFail:
        return 'Data update failed!';
      default:
        return '';
    }
  }

  static show(BuildContext context, int status, {int delay = 5000}) {
    _currentOverlayEntry?.remove();
    _currentOverlayEntry = null;

    Icon icon = getIcon(status);
    String msg = getMessage(status);

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              _currentOverlayEntry?.remove();
              _currentOverlayEntry = null;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  icon,
                  Text(
                    msg,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    _currentOverlayEntry = overlayEntry;
    overlay.insert(overlayEntry);

    Future.delayed(Duration(milliseconds: delay), () {
      if (_currentOverlayEntry == overlayEntry) {
        _currentOverlayEntry?.remove();
        _currentOverlayEntry = null;
      }
    });
  }
}