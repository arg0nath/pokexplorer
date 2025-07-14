import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pokexplorer/config/theme/data/repository/theme_repo_impl.dart';
import 'package:pokexplorer/config/theme/data/source/local/theme_local_datasource.dart';
import 'package:pokexplorer/config/theme/domain/repository/theme_repo.dart';
import 'package:pokexplorer/config/theme/domain/usecase/get_theme_usecase.dart';
import 'package:pokexplorer/config/theme/domain/usecase/set_theme_usecase.dart';
import 'package:pokexplorer/config/theme/presentation/bloc/theme_bloc.dart';
import 'package:pokexplorer/features/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:pokexplorer/features/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:pokexplorer/features/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:pokexplorer/features/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:pokexplorer/features/on_boarding/domain/usecases/check_first_timer.dart';
import 'package:pokexplorer/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:pokexplorer/features/pokemon_details/data/datasource/remote/pokemon_details_remote_data_source.dart';
import 'package:pokexplorer/features/pokemon_details/data/repos/pokemon_details_repo_impl.dart';
import 'package:pokexplorer/features/pokemon_details/domain/repos/pokemon_details_repo.dart';
import 'package:pokexplorer/features/pokemon_details/domain/usecases/fetch_pokemon_details.dart';
import 'package:pokexplorer/features/pokemon_details/presentation/bloc/pokemon_details_bloc.dart';
import 'package:pokexplorer/features/type_details/data/datasource/remote/type_details_remote_data_source.dart';
import 'package:pokexplorer/features/type_details/data/repos/type_details_repo_impl.dart';
import 'package:pokexplorer/features/type_details/domain/repos/type_details_repo.dart';
import 'package:pokexplorer/features/type_details/domain/usecases/fetch_type_details.dart';
import 'package:pokexplorer/features/type_details/presentation/bloc/type_details_bloc.dart';
import 'package:pokexplorer/features/type_selection/data/datasources/local/type_selection_local_datasource.dart';
import 'package:pokexplorer/features/type_selection/data/repo/type_selection_repo_impl.dart';
import 'package:pokexplorer/features/type_selection/domain/repos/type_selection_repo.dart';
import 'package:pokexplorer/features/type_selection/domain/usecases/get_pokemon_types.dart';
import 'package:pokexplorer/features/type_selection/domain/usecases/get_selected_pokemon_type.dart';
import 'package:pokexplorer/features/type_selection/domain/usecases/select_pokemon_types.dart';
import 'package:pokexplorer/features/type_selection/presentation/bloc/type_selection_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

//Feature
//bloc first!
//then usecases
//repo
//data source
//service

Future<void> injectionInit() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

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
    ..registerFactory(() => TypeDetailsBloc(
          fetchTypeDetails: sl(),
        ))
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

    // * General Services
    ..registerLazySingleton<http.Client>(() => http.Client())
    ..registerLazySingleton(() => prefs);
  // ..registerLazySingleton(()=>SharedPreferences.getInstance()) // ! Cant do this becsue it ns not initialized so check the init
}
