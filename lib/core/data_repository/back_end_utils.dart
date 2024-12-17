import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../utilities/app_utils.dart' as app_utils;
import '../variables/app_constants.dart' as app_const;
import 'local_data_utils.dart';

class BackendUtils {
  BackendUtils();
  LocalDataUtils localDataUtils = const LocalDataUtils();

  /// Performs an http request to the back end.
  ///
  /// Returns the response in the form of a `Map<String,dynamic>`.
  Future<Map<String, dynamic>> httpRequestMap(String unEncodedPath) async {
    if (kDebugMode && !unEncodedPath.contains('SetLogEvent')) {
      app_utils.myLog(msg: 'unEncodedPath = $unEncodedPath');
    }

    final Uri finalUri = Uri.parse(app_const.POKE_API + unEncodedPath);

    if (kDebugMode && !unEncodedPath.contains('SetLogEvent')) {
      app_utils.myLog(msg: 'finalUri = $finalUri');
    }

    try {
      final http.Response response = await http.get(finalUri).timeout(const Duration(seconds: 15));

      if (response.statusCode == app_const.API_STATUS_OK) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch data.');
      }
    } catch (e) {
      throw Exception('Failed to fetch data.');
    }
  }

  ///End point to get the type details based on its name
  ///
  ///Ie: `https://pokeapi.co/api/v2/type/water`
  Future<Map<String, dynamic>> getTypeDetails({
    required String type,
  }) async {
    Map<String, dynamic> response = <String, dynamic>{};
    final String tmpType = type.toLowerCase();

    final String typeUrl = 'type/$tmpType/';

    response = await httpRequestMap(typeUrl);

    return Future<Map<String, dynamic>>.value(response);
  }

  ///End point to get the pokemon details based on its name
  ///
  ///Ie: `https://pokeapi.co/api/v2/pokemon/pikachu`
  Future<Map<String, dynamic>> getPokemonByName({
    required String name,
  }) async {
    Map<String, dynamic> response = <String, dynamic>{};
    final String tmpName = name.toLowerCase();

    final String pokemonUrl = 'pokemon/$tmpName/';

    response = await httpRequestMap(pokemonUrl);

    return Future<Map<String, dynamic>>.value(response);
  }
}
