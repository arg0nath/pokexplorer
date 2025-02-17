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
import '../constants/app_constants.dart';

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
  static void myLog({int? level = LOG_INFO, required String msg}) {
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

  static Future<void> loadPrefs(FrontendUtils frontEndUtils) async {
    myLog(level: LOG_WARNING, msg: 'loadPrefs..');
    return Future<void>.value();
  }

  static int extractPokemonPreviewId(String url) {
    final id = url.split('/').where((segment) => segment.isNotEmpty).last; // the last parameter of the url is the id
    final resultId = int.tryParse(id) ?? EMPTY_INT;
    return resultId;
  }

  static String getPokemonBaseImageById(int id) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }

  static ToastificationItem myToast(BuildContext context, String msg) {
    toastification.dismissAll();
    return toastification.show(
      icon: Image.asset(POKEBALL_PNG, width: 20, height: 20),
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
      case FIRE_TYPE_NAME:
        return AppPalette.fire;
      case WATER_TYPE_NAME:
        return AppPalette.water;
      case GRASS_TYPE_NAME:
        return AppPalette.grass;
      case ELECTRIC_TYPE_NAME:
        return AppPalette.electric;
      case DRAGON_TYPE_NAME:
        return AppPalette.dragon;
      case PSYCHIC_TYPE_NAME:
        return AppPalette.psychic;
      case GHOST_TYPE_NAME:
        return AppPalette.ghost;
      case DARK_TYPE_NAME:
        return AppPalette.dark;
      case STEEL_TYPE_NAME:
        return AppPalette.steel;
      case FAIRY_TYPE_NAME:
        return AppPalette.fairy;
      case NORMAL_TYPE_NAME:
        return AppPalette.normal;
      case FIGHTING_TYPE_NAME:
        return AppPalette.fighting;
      case FLYING_TYPE_NAME:
        return AppPalette.flying;
      case POISON_TYPE_NAME:
        return AppPalette.poison;
      case GROUND_TYPE_NAME:
        return AppPalette.ground;
      case ROCK_TYPE_NAME:
        return AppPalette.rock;
      case BUG_TYPE_NAME:
        return AppPalette.bug;
      case ICE_TYPE_NAME:
        return AppPalette.ice;
      default:
        return AppPalette.gradientBaseLight; // Default color if no match
    }
  }
}
