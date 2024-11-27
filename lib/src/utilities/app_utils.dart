import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokexplorer/src/variables/app_variables.dart';
import 'package:pokexplorer/src/widgets/app_widgets.dart' as app_widgets;
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../variables/app_constants.dart' as app_const;
import 'front_end_utils.dart';

import 'package:flutter/foundation.dart';

import 'package:intl/intl.dart';

extension StringExtensions on String {
  /// Converts the very first character in this string to upper case.
  ///
  /// ```dart
  /// 'alphabet'.toUpperFirst(); // 'Alphabet'
  /// ```
  String toUpperFirst() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

String typeToAssetIcon(String type) {
  try {
    return 'assets/images/${type}_icon.png';
  } catch (e) {
    return 'assets/images/pokeball.png';
  }
}

/// Prints log output to the console.
///
/// [debugLevel] is the type of message.
///
/// [msg] is the message to be printed in console.
///
/// Returns void. Debuging purposes only.
void myLog(int debugLevel, String msg) {
  if (kDebugMode) {
    if (app_const.SHOW_LOG) {
      if (debugLevel == app_const.LOG_INFO) {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${app_const.APP_PACKAGE}: $msg');
      } else if (debugLevel == app_const.LOG_WARNING) {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${app_const.LOG_WARNING_COLOR}${app_const.APP_PACKAGE}: $msg ${app_const.LOG_RESET_COLOR}');
      } else if (debugLevel == app_const.LOG_ERROR) {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${app_const.LOG_ERROR_COLOR}${app_const.APP_PACKAGE}: 🚫 ERROR: $msg 🚫 ${app_const.LOG_RESET_COLOR}');
      } else {
        log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${app_const.LOG_WTF_COLOR}${app_const.APP_PACKAGE} : WTF:  $msg${app_const.LOG_RESET_COLOR}');
      }
    }
  }
}

Future<void> loadPrefs(FrontendUtils frontEndUtils) async {
  myLog(app_const.LOG_WARNING, 'loadPrefs..');

  return Future<void>.value();
}

String extractPokemonImageUrl(String url) {
  final id = url.split('/').where((segment) => segment.isNotEmpty).last; // the last parameter of the url is the id of the pokemon so

  return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png'; // this on takes only 70ms
}

List<Color> gradientFromType(String type) {
  List<Color> gradList = [app_const.GRADIENT_BASE];
  switch (type.toLowerCase()) {
    case app_const.FIRE_TYPE_NAME:
      gradList.insert(0, app_const.FIRE_COLOR);
      break;
    case app_const.WATER_TYPE_NAME:
      gradList.insert(0, app_const.WATER_COLOR);
      break;
    case app_const.GRASS_TYPE_NAME:
      gradList.insert(0, app_const.GRASS_COLOR);
      break;
    case app_const.ELECTRIC_TYPE_NAME:
      gradList.insert(0, app_const.ELECTRIC_COLOR);
      break;
    case app_const.DRAGON_TYPE_NAME:
      gradList.insert(0, app_const.DRAGON_COLOR);
      break;
    case app_const.PSYCHIC_TYPE_NAME:
      gradList.insert(0, app_const.PSYCHIC_COLOR);
      break;
    case app_const.GHOST_TYPE_NAME:
      gradList.insert(0, app_const.GHOST_COLOR);
      break;
    case app_const.DARK_TYPE_NAME:
      gradList.insert(0, app_const.DARK_COLOR);
      break;
    case app_const.STEEL_TYPE_NAME:
      gradList.insert(0, app_const.STEEL_COLOR);
      break;
    case app_const.FAIRY_TYPE_NAME:
      gradList.insert(0, app_const.FAIRY_COLOR);
      break;

    default:
      gradList.insert(0, app_const.GRADIENT_DEFAULT);
  }

  return gradList;
}

/* Color convertPercentToColor(double percent) {
  if (percent >= 0.4) {
    return app_const.PERCENT_HIGH_COLOR;
  } else if (percent >= 0.2) {
    return app_const.PERCENT_MEDIUM_COLOR;
  } else {
    return app_const.PERCENT_LOW_COLOR;
  }
} */

ToastificationItem myToast(BuildContext context, String msg) {
  toastification.dismissAll();
  return toastification.show(
    icon: Image.asset(app_const.POKEBALL_PNG, width: 20, height: 20),
    title: Container(
        width: logicalWidth * 0.9,
        child: app_widgets.MyText(
          msg,
          maxLines: 3,
        )),
    closeOnClick: false,
    context: context,
    pauseOnHover: false,
    showIcon: true,
    alignment: Alignment.bottomCenter,
    showProgressBar: false,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 2),
  );
}

void sendContactEmail() async {
  final Uri mail = Uri.parse('mailto:vamakris07@gmail.com?subject=About pokexplorer');
  if (await launchUrl(mail)) {
  } else {
    throw 'Could not launch';
  }
}

Future<Widget?> showLoadingDialog(BuildContext context) {
  return showDialog<Widget>(
    barrierDismissible: false,
    context: context,
    barrierColor: const Color(0x73A3A3A3),
    builder: (BuildContext context) => app_widgets.DialogProgressPokeball(hardBackEnabled: false).animate().fade(duration: 100.ms).scale(),
  );
}
