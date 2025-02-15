import 'package:flutter/material.dart';
import 'package:pokexplorer/core/enums/app_enums.dart';

import '../utilities/app_utils.dart';
import '../variables/app_constants.dart';

///Return of  https://pokeapi.co/api/v2/type/
class PokemonType {
  PokemonType({
    required this.name,
    required this.icon,
    required this.isSelected,
  });

  PokemonType.empty() {
    name = EMPTY_STRING;
    isSelected = false;
    icon = EMPTY_STRING;
  }

  String name = EMPTY_STRING;
  bool isSelected = false;
  String icon = EMPTY_STRING;

  void setName(String name) => this.name = name;
  void setIcon(String icon) => this.icon = icon;
  void setIsSelected(bool isSelected) => this.isSelected = isSelected;

  // Method to get color based on Pokemon type
  Color getTypeColor() {
    switch (name.toLowerCase()) {
      case 'fire':
        return FIRE_COLOR;
      case 'water':
        return WATER_COLOR;
      case 'grass':
        return GRASS_COLOR;
      case 'electric':
        return ELECTRIC_COLOR;
      case 'dragon':
        return DRAGON_COLOR;
      case 'psychic':
        return PSYCHIC_COLOR;
      case 'ghost':
        return GHOST_COLOR;
      case 'dark':
        return DARK_COLOR;
      case 'steel':
        return STEEL_COLOR;
      case 'fairy':
        return FAIRY_COLOR;
      case 'normal':
        return NORMAL_COLOR;
      case 'fighting':
        return FIGHTING_COLOR;
      case 'flying':
        return FLYING_COLOR;
      case 'poison':
        return POISON_COLOR;
      case 'ground':
        return GROUND_COLOR;
      case 'rock':
        return ROCK_COLOR;
      case 'bug':
        return BUG_COLOR;
      case 'ice':
        return ICE_COLOR;
      default:
        return GRADIENT_BASE; // Default color if no match
    }
  }

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
    name = EMPTY_STRING;
    icon = EMPTY_STRING;
    pokemon = [];
    id = EMPTY_INT;
  }
  int id = EMPTY_INT;
  String name = EMPTY_STRING;
  String icon = EMPTY_STRING;
  List<PokemonPreview> pokemon = []; // thats not the basic pokemon object,

// json converters
  factory PokemonTypeDetails.fromJson(Map<String, dynamic> json) {
    var pokemonList = json['pokemon'] as List;
    List<PokemonPreview> pokemonPreviews = pokemonList.map((poke) => PokemonPreview.fromJson(poke['pokemon'])).toList();

    return PokemonTypeDetails(
      id: json['id'],
      icon: AppUtils.typeToAssetIcon(json['name']),
      name: json['name'] ?? EMPTY_STRING,
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

  int id = EMPTY_INT;
  String name = EMPTY_STRING;
  String imageUrl = EMPTY_STRING;
  int isFavorite = EMPTY_INT_ZERO;

  PokemonPreview.empty() {
    id = EMPTY_INT;
    name = EMPTY_STRING;
    imageUrl = EMPTY_STRING;
    isFavorite = EMPTY_INT_ZERO;
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
    int id = AppUtils.extractPokemonPreviewId(json['url']);
    return PokemonPreview(
      id: id,
      name: json['name'] ?? EMPTY_STRING,
      imageUrl: AppUtils.getPokemonBaseImageById(id),
      isFavorite: EMPTY_INT_ZERO, //false
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
    id = EMPTY_INT;
    name = EMPTY_STRING;
    gifUrl = EMPTY_STRING;
    hdImageUrl = EMPTY_STRING;
    baseImageUrl = EMPTY_STRING;
    height = EMPTY_INT;
    weight = EMPTY_INT;
    hp = EMPTY_INT;
    attack = EMPTY_INT;
    defense = EMPTY_INT;
    isFavorite = EMPTY_INT_ZERO;
    types = [];
  }

  int id = EMPTY_INT;
  String name = EMPTY_STRING;
  String? gifUrl = EMPTY_STRING;

  /// `Low Quality` image
  String baseImageUrl = EMPTY_STRING;

  ///`High Quality` image. Bigger file size
  String hdImageUrl = EMPTY_STRING;
  int height = EMPTY_INT;
  int weight = EMPTY_INT;
  int hp = EMPTY_INT;
  int attack = EMPTY_INT;
  int defense = EMPTY_INT;
  List<PokemonType> types = [];
  int isFavorite = EMPTY_INT_ZERO;

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
      return PokemonType(name: type['type']['name'] as String, icon: EMPTY_STRING, isSelected: false);
    }).toList();

    return Pokemon(
      id: tmpId,
      name: json['name'] as String,
      hdImageUrl: json['sprites']['other']['official-artwork']['front_default'] as String? ?? EMPTY_STRING,
      baseImageUrl: AppUtils.getPokemonBaseImageById(tmpId),
      gifUrl: json['sprites']['other']['showdown']['front_default'] as String? ?? EMPTY_STRING,
      height: (json['height'] as int).toInt(),
      weight: (json['weight'] as int).toInt(),
      hp: statsMap['hp'] ?? EMPTY_INT,
      attack: statsMap['attack'] ?? EMPTY_INT,
      defense: statsMap['defense'] ?? EMPTY_INT,
      types: typesList,
      isFavorite: EMPTY_INT_ZERO,
    );
  }

  @override
  String toString() {
    return 'Pokemon name:$name, isFavorite: ${isFavorite == RelationValue.favorite.value} ';
  }
}
