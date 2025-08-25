part of 'di_imports.dart';

final GetIt sl = GetIt.instance;

//Feature
//bloc first!
//then usecases
//repo
//data source
//service

Future<void> injectionInit() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final Database favoritesDb = await initFavoritesDatabase();

  sl
    // * Theme
    ..registerFactory(() => ThemeBloc(getThemeUseCase: sl(), setThemeUseCase: sl()))
    ..registerLazySingleton(() => GetThemeUseCase(sl()))
    ..registerLazySingleton(() => SetThemeUseCase(sl()))
    ..registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(themeLocalDatasource: sl()))
    ..registerLazySingleton<ThemeLocalDataSource>(() => ThemeLocalDatasourceImpl(sl()))
    // * On boarding
    ..registerFactory(() => OnBoardingCubit(cacheFirstTimer: sl(), checkFirstTimer: sl()))
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckFirstTimer(sl()))
    ..registerLazySingleton<OnBoardingRepository>(() => OnBoardingRepoImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(() => OnBoardingLocalDataSourceImpl(sl()))
    // * Type selection
    ..registerFactory(() => TypeSelectionBloc(
          getPokemonTypes: sl(),
          selectPokemonType: sl(),
          getSelectedPokemonType: sl(),
        ))
    ..registerLazySingleton(() => GetPokemonTypes(sl()))
    ..registerLazySingleton(() => SelectPokemonType(sl()))
    ..registerLazySingleton(() => GetSelectedPokemonType(sl()))
    ..registerLazySingleton<TypeSelectionRepository>(() => TypeSelectionRepositoryImpl(sl()))
    ..registerLazySingleton<TypeSelectionLocalDataSource>(() => TypeSelectionLocalDataSourceImpl(sl()))

    // * Type Details
    ..registerFactory(() => TypeDetailsBloc(fetchTypeDetails: sl()))
    ..registerLazySingleton(() => FetchTypeDetails(sl()))
    ..registerLazySingleton<TypeDetailsRepository>(() => TypeDetailsRepoImpl(sl()))
    ..registerLazySingleton<TypeDetailsRemoteDataSource>(() => TypeDetailsRemoteDataSourceImpl(sl()))
    // * Pokemon Details
    ..registerFactory(() => PokemonDetailsBloc(
          fetchPokemonDetails: sl(),
        ))
    ..registerLazySingleton(() => FetchPokemonDetails(sl()))
    ..registerLazySingleton<PokemonDetailsRepository>(() => PokemonDetailsRepoImpl(sl()))
    ..registerLazySingleton<PokemonDetailsRemoteDataSource>(() => PokemonDetailsRemoteDataSourceImpl(sl()))

    // * Uzer Favorites
    ..registerFactory(() => UserFavoritesBloc(
          getUserFavorites: sl(),
          addToFavorites: sl(),
          removeFromFavorites: sl(),
        ))
    ..registerLazySingleton(() => GetUserFavorites(sl()))
    ..registerLazySingleton(() => AddToFavorites(sl()))
    ..registerLazySingleton(() => RemoveFromFavorites(sl()))
    ..registerLazySingleton<UserFavoritesRepo>(() => UserFavoritesRepoImpl(sl()))
    ..registerLazySingleton<UserFavoritesLocalDatasource>(() => UserFavoritesLocalDatasourceImpl(sl()))
    // * Settings
    ..registerFactory(() => SettingsBloc(getCopyrightOption: sl(), setCopyrightOption: sl(), getTermsOption: sl(), setTermsOption: sl()))
    ..registerLazySingleton(() => GetCopyrightOption(sl()))
    ..registerLazySingleton(() => SetCopyrightOption(sl()))
    ..registerLazySingleton(() => GetTermsOption(sl()))
    ..registerLazySingleton(() => SetTermsOption(sl()))
    ..registerLazySingleton<SettingsRepo>(() => SettingsRepoImpl(sl()))
    ..registerLazySingleton<SettingsLocalDatasource>(() => SettingsLocalDatasourceImpl(sl()))

    // * General Services
    ..registerLazySingleton<http.Client>(() => http.Client())
    ..registerLazySingleton(() => prefs)
    ..registerSingleton<Database>(favoritesDb);

  // ..registerLazySingleton(()=>SharedPreferences.getInstance()) // ! Cant do this becsue it ns not initialized so check the init
}
