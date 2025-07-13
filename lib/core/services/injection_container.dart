import 'package:get_it/get_it.dart';
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
import 'package:pokexplorer/features/type_selection/data/datasources/local/type_selection_local_datasource.dart';
import 'package:pokexplorer/features/type_selection/data/repo/type_selection_repo_impl.dart';
import 'package:pokexplorer/features/type_selection/domain/repos/type_selection_repo.dart';
import 'package:pokexplorer/features/type_selection/domain/usecases/get_pokemon_types.dart';
import 'package:pokexplorer/features/type_selection/domain/usecases/get_selected_pokemon_type.dart';
import 'package:pokexplorer/features/type_selection/domain/usecases/select_pokemon_types.dart';
import 'package:pokexplorer/features/type_selection/presentation/bloc/type_selection_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> injectionInit() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  //Feature - OnBoarding
  //bloc first!
  sl
    ..registerFactory(() => ThemeBloc(getThemeUseCase: sl(), setThemeUseCase: sl()))
    ..registerLazySingleton(() => GetThemeUseCase(sl()))
    ..registerLazySingleton(() => SetThemeUseCase(sl()))
    ..registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(themeLocalDatasource: sl()))
    ..registerLazySingleton<ThemeLocalDataSource>(() => ThemeLocalDatasourceImpl(sl()))
    ..registerFactory(() => OnBoardingCubit(cacheFirstTimer: sl(), checkFirstTimer: sl()))
    //then usecases
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckFirstTimer(sl()))
    //repo
    ..registerLazySingleton<OnBoardingRepository>(() => OnBoardingRepoImpl(sl()))
    //data source
    ..registerLazySingleton<OnBoardingLocalDataSource>(() => OnBoardingLocalDataSourceImpl(sl()))
    //service

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
    // ..registerLazySingleton(()=>SharedPreferences.getInstance()) // ! Cant do this becsue it ns not initialized so check the init
    ..registerLazySingleton(() => prefs);
}
