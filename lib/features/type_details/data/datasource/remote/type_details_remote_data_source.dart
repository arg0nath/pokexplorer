import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pokexplorer/config/logger/my_log.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/errors/exceptions.dart';
import 'package:pokexplorer/features/type_details/data/dtos/type_details_dto.dart';
import 'package:retry/retry.dart';

abstract interface class TypeDetailsRemoteDataSource {
  Future<TypeDetailsDto> fetchTypeDetails(String typeName);
}

class TypeDetailsRemoteDataSourceImpl implements TypeDetailsRemoteDataSource {
  const TypeDetailsRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<TypeDetailsDto> fetchTypeDetails(String typeName) async {
    try {
      final Uri uri = Uri.https(
        AppConst.pokeApiUrl,
        AppConst.getTypeDetailsUrl.replaceFirst(':typeName', typeName),
      );

      final http.Response response = await retry(
        () => _client.get(uri).timeout(const Duration(seconds: 8)),
        retryIf: (Exception e) => e is SocketException || e is TimeoutException,
        maxAttempts: 3,
      );

      if (response.statusCode != 200) {
        throw ApiException(
          message: 'Failed to fetch type details',
          statusCode: response.statusCode,
        );
      }

      final DataMap jsonMap = json.decode(response.body) as DataMap;
      return TypeDetailsDto.fromJson(jsonMap);
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
