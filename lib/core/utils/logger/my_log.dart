import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';

/// Prints log output to the console.
///
/// [level] is the type of message.
///
/// [msg] is the message to be printed in console.
///
/// Returns void. Debuging purposes only.
void myLog({int? level = LOG_INFO, required String msg}) {
  if (kDebugMode) {
    level ??= LOG_INFO;
    if (SHOW_LOG) {
      if (level == LOG_INFO) {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-$APP_PACKAGE: $msg');
      } else if (level == LOG_WARNING) {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-$LOG_WARNING_COLOR$APP_PACKAGE: $msg $LOG_RESET_COLOR');
      } else if (level == LOG_ERROR) {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-$LOG_ERROR_COLOR$APP_PACKAGE: 🚫 ERROR: $msg 🚫 $LOG_RESET_COLOR');
      } else {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-$LOG_WTF_COLOR$APP_PACKAGE : WTF:  $msg$LOG_RESET_COLOR');
      }
    }
  }
}
