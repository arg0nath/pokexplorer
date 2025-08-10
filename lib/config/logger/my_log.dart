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
void myLog(String msg, {int? level = AppConst.logInfo}) {
  if (kDebugMode) {
    level ??= AppConst.logInfo;
    if (AppConst.showLog) {
      if (level == AppConst.logInfo) {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}: $msg');
      } else if (level == AppConst.logWarning) {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${AppConst.logWarningColor}: $msg ${AppConst.logResetColor}');
      } else if (level == AppConst.logError) {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${AppConst.logErrorColor}: 🚫 ERROR: $msg 🚫 ${AppConst.logResetColor}');
      } else {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${AppConst.logWtfColor}: WTF:  $msg${AppConst.logResetColor}');
      }
    }
  }
}
