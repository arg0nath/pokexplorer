import 'package:pokexplorer/config/logger/my_log.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/errors/exceptions.dart';
import 'package:pokexplorer/shared/dtos/pokemon_type_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kSelectedPokemonType = 'selected_pokemon_type';

abstract class TypeSelectionLocalDataSource {
  const TypeSelectionLocalDataSource();

  Future<List<PokemonTypeDto>> getPokemonTypes();
  Future<String> getSelectedType();
  Future<void> selectPokemonType(String typeName);
}

class TypeSelectionLocalDataSourceImpl implements TypeSelectionLocalDataSource {
  const TypeSelectionLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<List<PokemonTypeDto>> getPokemonTypes() async {
    // Simulate fetching data from local storage
    final types = [
      PokemonTypeDto.fromTypeName('fire'),
      PokemonTypeDto.fromTypeName('water'),
      PokemonTypeDto.fromTypeName('grass'),
      PokemonTypeDto.fromTypeName('electric'),
      PokemonTypeDto.fromTypeName('dragon'),
      PokemonTypeDto.fromTypeName('psychic'),
      PokemonTypeDto.fromTypeName('ghost'),
      PokemonTypeDto.fromTypeName('dark'),
      PokemonTypeDto.fromTypeName('steel'),
      PokemonTypeDto.fromTypeName('fairy'),
      PokemonTypeDto.fromTypeName('normal'),
      PokemonTypeDto.fromTypeName('fighting'),
      PokemonTypeDto.fromTypeName('flying'),
      PokemonTypeDto.fromTypeName('poison'),
      PokemonTypeDto.fromTypeName('ground'),
      PokemonTypeDto.fromTypeName('rock'),
      PokemonTypeDto.fromTypeName('bug'),
      PokemonTypeDto.fromTypeName('ice'),
    ];
    final List<PokemonTypeDto> result = types.map((type) => PokemonTypeDto.fromJson(type.toJson())).toList();
    return Future<List<PokemonTypeDto>>.value(result);
  }

  @override
  Future<void> selectPokemonType(String typeName) async {
    try {
      await _prefs.setString(kSelectedPokemonType, typeName);
      myLog(msg: '$typeName saved to prefs');
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<String> getSelectedType() async {
    try {
      final String name = _prefs.getString(kSelectedPokemonType) ?? AppConst.emptyString;
      return Future<String>.value(name);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
