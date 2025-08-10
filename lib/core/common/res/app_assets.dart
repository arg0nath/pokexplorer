class AppAssets {
  static const String _imagesBasePath = 'assets/images';
  static const String _lottiesBasePath = 'assets/lottieFiles';
  static const String _svgsBasePath = 'assets/svgs';

  static const String pokedexPng = '$_imagesBasePath/pokedex.png';
  static const String pokeballPng = '$_imagesBasePath/pokeball.png';
  static const String emptyPokeballPng = '$_imagesBasePath/emptyPokeball.png';
  static const String pokeballOutlinedPng = '$_imagesBasePath/pokeball_outlined.png';
  static const String pokexplorerLogoPng = '$_imagesBasePath/pokexplorer_logo.png';
  static const String pokemonCustomPhrase = '$_imagesBasePath/gonnasearch.png';
  static const String pokemonLogoSvg = '$_svgsBasePath/official_pokemon_logo.svg';
  static const String loadingPokeballLottie = '$_lottiesBasePath/pokeball.json';
}

String getIconForType(String typeName) {
  return '${AppAssets._imagesBasePath}/${typeName}_icon.png';
}
