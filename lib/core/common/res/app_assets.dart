class AppAssets {
  static const String pokedexPng = '$_imagesBasePath/pokedex.png';
  static const String pokeballPng = '$_imagesBasePath/pokeball.png';
  static const String buttonOpenPokeball = '$_imagesBasePath/button-open-pokeball.png';
  static const String buttonPokeball = '$_imagesBasePath/button-pokeball.png';
  static const String emptyOpenedPokeballPng = '$_imagesBasePath/emptyPokeball.png';
  static const String pokeballOutlined = '$_imagesBasePath/pokeball_outlined.png';
  static const String pokexplorerLogo = '$_imagesBasePath/pokexplorer_logo.png';
  static const String pokemonCustomPhrase = '$_imagesBasePath/gonnasearch.png';
  static const String pokemonLogoSvg = '$_svgsBasePath/official_pokemon_logo.svg';
  static const String loadingPokeballLottie = '$_lottiesBasePath/pokeball.json';

  static const String fontFamily = 'Quicksand';
}

String getIconForType(String typeName) {
  return '${_imagesBasePath}/${typeName}_icon.png';
}

const String _imagesBasePath = 'assets/images';
const String _lottiesBasePath = 'assets/lottieFiles';
const String _svgsBasePath = 'assets/svgs';
