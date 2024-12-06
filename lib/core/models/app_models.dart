import 'package:pokexplorer/core/enums/app_enums.dart';

import '../utilities/app_utils.dart' as app_utils;
import '../variables/app_constants.dart' as app_const;

///Return of  https://pokeapi.co/api/v2/type/
class PokemonType {
  PokemonType({
    required this.name,
    required this.icon,
    required this.isSelected,
  });

  PokemonType.empty() {
    name = app_const.EMPTY_STRING;
    isSelected = false;
    icon = app_const.EMPTY_STRING;
  }

  String name = app_const.EMPTY_STRING;
  bool isSelected = false;
  String icon = app_const.EMPTY_STRING;

  void setName(String name) => this.name = name;
  void setIcon(String icon) => this.icon = icon;
  void setIsSelected(bool isSelected) => this.isSelected = isSelected;

  @override
  String toString() {
    return 'Type name:$name';
  }
}

class PokemonTypeDetails {
  PokemonTypeDetails({
    required this.id,
    required this.name,
    required this.pokemon,
    required this.icon,
  });
  PokemonTypeDetails.empty() {
    name = app_const.EMPTY_STRING;
    icon = app_const.EMPTY_STRING;
    pokemon = [];
    id = app_const.EMPTY_INT;
  }
  int id = app_const.EMPTY_INT;
  String name = app_const.EMPTY_STRING;
  String icon = app_const.EMPTY_STRING;
  List<PokemonPreview> pokemon = []; // thats not the basic pokemon object,

// json converters
  factory PokemonTypeDetails.fromJson(Map<String, dynamic> json) {
    var pokemonList = json['pokemon'] as List;
    List<PokemonPreview> pokemonPreviews = pokemonList.map((poke) => PokemonPreview.fromJson(poke['pokemon'])).toList();

    return PokemonTypeDetails(
      id: json['id'],
      icon: app_utils.typeToAssetIcon(json['name']),
      name: json['name'] ?? app_const.EMPTY_STRING,
      pokemon: pokemonPreviews,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'pokemon': pokemon.map((poke) => poke.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Type id:$id, name $name, pokemon.length: ${pokemon.length}';
  }
}

///A preview of the pokemon that only contains `name` and `url`
class PokemonPreview {
  PokemonPreview({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isFavorite,
  });

  int id = app_const.EMPTY_INT;
  String name = app_const.EMPTY_STRING;
  String imageUrl = app_const.EMPTY_STRING;
  int isFavorite = app_const.EMPTY_INT_ZERO;

  PokemonPreview.empty() {
    id = app_const.EMPTY_INT;
    name = app_const.EMPTY_STRING;
    imageUrl = app_const.EMPTY_STRING;
    isFavorite = app_const.EMPTY_INT_ZERO;
  }

  /// [int] setter, instead of [bool] for database purposes
  ///
  /// `0 is false`
  ///
  /// `1 is true`
  void setIsFavorite(RelationValue relationValue) => isFavorite = relationValue.value;

  String setImageUrl(String imageUrl) => this.imageUrl = imageUrl;

// json converters
  factory PokemonPreview.fromJson(Map<String, dynamic> json) {
    int id = app_utils.extractPokemonPreviewId(json['url']);
    return PokemonPreview(
      id: id,
      name: json['name'] ?? app_const.EMPTY_STRING,
      imageUrl: app_utils.getPokemonBaseImageById(id),
      isFavorite: app_const.EMPTY_INT_ZERO, //false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return 'PokemonPreview name: $name, isFavorite:$isFavorite';
  }
}

//this for details moving https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/4.gif
class Pokemon {
  Pokemon({
    required this.id,
    required this.name,
    required this.gifUrl,
    required this.hdImageUrl,
    required this.baseImageUrl,
    required this.height,
    required this.weight,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.types,
    required this.isFavorite,
  });

  Pokemon.empty() {
    id = app_const.EMPTY_INT;
    name = app_const.EMPTY_STRING;
    gifUrl = app_const.EMPTY_STRING;
    hdImageUrl = app_const.EMPTY_STRING;
    baseImageUrl = app_const.EMPTY_STRING;
    height = app_const.EMPTY_INT;
    weight = app_const.EMPTY_INT;
    types = [];
    hp = app_const.EMPTY_INT;
    attack = app_const.EMPTY_INT;
    defense = app_const.EMPTY_INT;
    isFavorite = app_const.EMPTY_INT_ZERO;
  }

  int id = app_const.EMPTY_INT;
  String name = app_const.EMPTY_STRING;

  String? gifUrl = app_const.EMPTY_STRING;

  /// `Low Quality` image
  String baseImageUrl = app_const.EMPTY_STRING;

  ///`High Quality` image. Bigger file size
  String hdImageUrl = app_const.EMPTY_STRING;
  int height = app_const.EMPTY_INT;
  int weight = app_const.EMPTY_INT;
  int hp = app_const.EMPTY_INT;
  int attack = app_const.EMPTY_INT;
  int defense = app_const.EMPTY_INT;
  List<PokemonType> types = [];
  int isFavorite = app_const.EMPTY_INT_ZERO;

  /// [int] setter, instead of [bool] for database purposes
  ///
  /// `0 is false`
  ///
  /// `1 is true`
  void setIsFavorite(RelationValue relationValue) => isFavorite = relationValue.value;

  // json converters
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final statsMap = <String, int>{};
    for (final stat in json['stats'] as List) {
      statsMap[stat['stat']['name'] as String] = stat['base_stat'] as int;
    }

    final tmpId = (json['id'] as int).toInt();

    var typesList = (json['types'] as List).map((type) {
      return PokemonType(name: type['type']['name'] as String, icon: app_const.EMPTY_STRING, isSelected: false);
    }).toList();

    return Pokemon(
      id: tmpId,
      name: json['name'] as String,
      hdImageUrl: json['sprites']['other']['official-artwork']['front_default'] as String? ?? app_const.EMPTY_STRING,
      baseImageUrl: app_utils.getPokemonBaseImageById(tmpId),
      gifUrl: json['sprites']['other']['showdown']['front_default'] as String? ?? app_const.EMPTY_STRING,
      height: (json['height'] as int).toInt(),
      weight: (json['weight'] as int).toInt(),
      hp: statsMap['hp'] ?? app_const.EMPTY_INT,
      attack: statsMap['attack'] ?? app_const.EMPTY_INT,
      defense: statsMap['defense'] ?? app_const.EMPTY_INT,
      types: typesList,
      isFavorite: app_const.EMPTY_INT_ZERO,
    );
  }

  @override
  String toString() {
    return 'Pokemon name:$name, isFavorite: ${isFavorite == RelationValue.favorite.value} ';
  }
}
