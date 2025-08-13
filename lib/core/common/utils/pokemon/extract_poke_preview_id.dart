import 'package:pokexplorer/core/common/constants/app_const.dart';

int extractPokemonPreviewId(String url) {
  final String id = url.split('/').where((String segment) => segment.isNotEmpty).last; // the last parameter of the url is the id
  final int resultId = int.tryParse(id) ?? AppConst.emptyInt;
  return resultId;
}
