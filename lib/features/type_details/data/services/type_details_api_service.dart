import 'package:dio/dio.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/features/type_details/data/models/type_details_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'type_details_api_service.g.dart';

@RestApi(baseUrl: AppConst.pokeApiUrl)
abstract class TypeDetailsApiService {
  factory TypeDetailsApiService(Dio dio) = _TypeDetailsApiService;

  @GET('type/{typeName}')
  Future<HttpResponse<TypeDetailsDto>> getTypeDetails(@Path('typeName') String typeName);
}
