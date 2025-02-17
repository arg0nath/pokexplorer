import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:pokexplorer/core/common/variables/app_variables.dart';
import 'package:pokexplorer/core/common/widgets/pokeball_loading_dialog.dart';
import 'package:pokexplorer/core/theme/colors/app_palette.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/front_end_utils.dart';
import '../constants/app_constants.dart' as app_const;

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

extension ContextExtension on BuildContext {
  /* void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(message),backgroundColor: isError ? Theme.of(this).colorScheme.error : Theme.of(this).snackBarTheme.backgroundColor,),);
  } */

  Future<Widget?> showLoadingDialog() {
    return showDialog<Widget>(
      barrierDismissible: false,
      context: this,
      builder: (_) => const DialogProgressPokeball(hardBackEnabled: false).animate().fade(duration: 100.ms).scale(),
    );
  }
}

abstract class AppUtils {
  static String typeToAssetIcon(String type) {
    try {
      return 'assets/images/${type}_icon.png';
    } catch (e) {
      return 'assets/images/pokeball.png';
    }
  }

  /// Prints log output to the console.
  ///
  /// [level] is the type of message.
  ///
  /// [msg] is the message to be printed in console.
  ///
  /// Returns void. Debuging purposes only.
  static void myLog({int? level = app_const.LOG_INFO, required String msg}) {
    if (kDebugMode) {
      level ??= app_const.LOG_INFO;
      if (app_const.SHOW_LOG) {
        if (level == app_const.LOG_INFO) {
          log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${app_const.APP_PACKAGE}: $msg');
        } else if (level == app_const.LOG_WARNING) {
          log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${app_const.LOG_WARNING_COLOR}${app_const.APP_PACKAGE}: $msg ${app_const.LOG_RESET_COLOR}');
        } else if (level == app_const.LOG_ERROR) {
          log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${app_const.LOG_ERROR_COLOR}${app_const.APP_PACKAGE}: 🚫 ERROR: $msg 🚫 ${app_const.LOG_RESET_COLOR}');
        } else {
          log('${DateFormat('HH:mm:ss').format(DateTime.now())}-${app_const.LOG_WTF_COLOR}${app_const.APP_PACKAGE} : WTF:  $msg${app_const.LOG_RESET_COLOR}');
        }
      }
    }
  }

  static Future<void> loadPrefs(FrontendUtils frontEndUtils) async {
    myLog(level: app_const.LOG_WARNING, msg: 'loadPrefs..');
    return Future<void>.value();
  }

  static int extractPokemonPreviewId(String url) {
    final id = url.split('/').where((segment) => segment.isNotEmpty).last; // the last parameter of the url is the id
    final resultId = int.tryParse(id) ?? app_const.EMPTY_INT;
    return resultId;
  }

  static String getPokemonBaseImageById(int id) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }

  static ToastificationItem myToast(BuildContext context, String msg) {
    toastification.dismissAll();
    return toastification.show(
      icon: Image.asset(app_const.POKEBALL_PNG, width: 20, height: 20),
      title: SizedBox(
          width: logicalWidth * 0.9,
          child: Text(
            msg,
            maxLines: 3,
            style: Theme.of(context).textTheme.labelSmall,
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

  static void sendContactEmail() async {
    final Uri mail = Uri.parse('mailto:vamakris07@gmail.com?subject=About pokexplorer');
    if (await launchUrl(mail)) {
    } else {
      throw 'Could not launch';
    }
  }

  // Method to get color based on Pokemon type
  static Color getTypeColor(String name) {
    switch (name.toLowerCase()) {
      case 'fire':
        return AppPalette.fire;
      case 'water':
        return AppPalette.water;
      case 'grass':
        return AppPalette.grass;
      case 'electric':
        return AppPalette.electric;
      case 'dragon':
        return AppPalette.dragon;
      case 'psychic':
        return AppPalette.psychic;
      case 'ghost':
        return AppPalette.ghost;
      case 'dark':
        return AppPalette.dark;
      case 'steel':
        return AppPalette.steel;
      case 'fairy':
        return AppPalette.fairy;
      case 'normal':
        return AppPalette.normal;
      case 'fighting':
        return AppPalette.fighting;
      case 'flying':
        return AppPalette.flying;
      case 'poison':
        return AppPalette.poison;
      case 'ground':
        return AppPalette.ground;
      case 'rock':
        return AppPalette.rock;
      case 'bug':
        return AppPalette.bug;
      case 'ice':
        return AppPalette.ice;
      default:
        return AppPalette.gradientBaseLight; // Default color if no match
    }
  }
}
