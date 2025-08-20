import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pokexplorer/config/theme/theme.dart';
import 'package:pokexplorer/core/common/utils/general/init_db.dart';
import 'package:pokexplorer/features/on_boarding/on_boarding.dart';
import 'package:pokexplorer/features/pokemon_details/pokemon_details.dart';
import 'package:pokexplorer/features/type_details/type_details.dart';
import 'package:pokexplorer/features/type_selection/type_selection.dart';
import 'package:pokexplorer/features/user_favorites/user_favorites.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

part 'injection_container.dart';
