class AppAssets {
  //pokeballs
  static const String pokeballPng = '$_pokeballsBasePath/pokeball.png';
  static const String buttonOpenPokeball = '$_pokeballsBasePath/button-open-pokeball.png';
  static const String buttonPokeball = '$_pokeballsBasePath/button-pokeball.png';
  static const String emptyOpenedPokeballPng = '$_pokeballsBasePath/emptyPokeball.png';
  static const String pokeballOutlined = '$_pokeballsBasePath/pokeball_outlined.png';
  //logos
  static const String pokexplorerLogo = '$_imagesBasePath/pokexplorer_logo.png';
  static const String pokemonCustomPhrase = '$_imagesBasePath/gonnasearch.png';
  static const String pokemonLogoSvg = '$_svgsBasePath/official_pokemon_logo.svg';
  static const String githubLogoSvg = '$_svgsBasePath/github.svg';
  //lottie
  static const String loadingPokeballLottie = '$_lottiesBasePath/pokeball.json';

  static const String fontFamily = 'Quicksand';
}

String getIconForType(String typeName) {
  return '${_pokeTypesBasePath}/${typeName}_icon.png';
}

const String _imagesBasePath = 'assets/images';
const String _pokeballsBasePath = '$_imagesBasePath/pokeballs';
const String _pokeTypesBasePath = '$_imagesBasePath/poke_types';
const String _lottiesBasePath = 'assets/lottieFiles';
const String _svgsBasePath = 'assets/svgs';
