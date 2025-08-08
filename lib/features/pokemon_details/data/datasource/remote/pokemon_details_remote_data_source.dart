import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pokexplorer/config/logger/my_log.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/errors/exceptions.dart';
import 'package:pokexplorer/features/pokemon_details/data/dtos/pokemon_details_dto.dart';
import 'package:retry/retry.dart';

abstract interface class PokemonDetailsRemoteDataSource {
  Future<PokemonDetailsDto> fetchPokemonDetails(String name);
}

class PokemonDetailsRemoteDataSourceImpl implements PokemonDetailsRemoteDataSource {
  const PokemonDetailsRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<PokemonDetailsDto> fetchPokemonDetails(String name) async {
    try {
      final Uri uri = Uri.https(
        AppConst.pokeApiUrl,
        AppConst.getPokemonDetailsUrl.replaceFirst(':pokemonName', name),
      );

      final http.Response response = await retry(
        () => _client.get(uri).timeout(const Duration(seconds: 8)),
        retryIf: (Exception e) => e is SocketException || e is TimeoutException,
        maxAttempts: 3,
      );

      if (response.statusCode != 200) {
        throw ApiException(
          message: 'Failed to fetch Pokemon details',
          statusCode: response.statusCode,
        );
      }

      final DataMap jsonMap = json.decode(response.body) as DataMap;
      return PokemonDetailsDto.fromJson(jsonMap);
    } on ApiException {
      rethrow;
    } catch (e) {
      myLog('Unexpected error: $e');
      throw ApiException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
