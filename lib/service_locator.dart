import 'package:get_it/get_it.dart';
import 'package:pokexplorer/core/theme/data/repository/theme_repo_impl.dart';
import 'package:pokexplorer/core/theme/data/source/local/theme_local_datasource.dart';
import 'package:pokexplorer/core/theme/domain/repository/theme_repo.dart';
import 'package:pokexplorer/core/theme/domain/usecase/get_theme_usecase.dart';
import 'package:pokexplorer/core/theme/domain/usecase/set_theme_usecase.dart';
import 'package:pokexplorer/core/theme/presentation/bloc/theme_bloc.dart';
import 'package:pokexplorer/features/type_selection/data/sources/type_selection_local_source.dart';
import 'package:pokexplorer/features/type_selection/domain/usecases/get_local_pokemon_types_usecase.dart';
import 'package:pokexplorer/features/type_selection/presentation/bloc/type_selection_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Service locator
final GetIt sl = GetIt.instance;

//init dependencies
//? use registerFactory for instances that we want to create every time
//? use registerLazySingleton for instances that we want to create only once
Future<void> setupServiceLocator() async {
  //sharedPrefs
  sl.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  //network is registerFactory because we want to create a new instance every time
  //theme
  _initTheme();
  //type selection
  _initTypeSelection();
}

void _initTheme() {
  sl
    ..registerSingleton<ThemeLocalDatasource>(ThemeLocalDatasource(sharedPreferences: sl()))
    ..registerSingleton<ThemeRepository>(ThemeRepositoryImpl(themeLocalDatasource: sl()))
    ..registerSingleton<GetThemeUseCase>(GetThemeUseCase(sl()))
    ..registerSingleton(SetThemeUseCase(sl()))
    ..registerSingleton(ThemeBloc(getThemeUseCase: sl(), setThemeUseCase: sl()));
}

void _initTypeSelection() {
  sl
    ..registerFactory<TypeSelectionLocalSourceInterface>(() => TypeSelectionLocalSourceImpl())
    ..registerFactory<GetLocalPokemonTypesUseCase>(() => GetLocalPokemonTypesUseCase(sl<TypeSelectionLocalSourceInterface>()))
    ..registerFactory<TypeSelectionBloc>(() => TypeSelectionBloc(getPokemonTypesUsecase: sl()));
}
