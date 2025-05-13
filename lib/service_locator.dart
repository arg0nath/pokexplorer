import 'package:get_it/get_it.dart';
import 'package:pokexplorer/core/theme/data/repository/theme_repo_impl.dart';
import 'package:pokexplorer/core/theme/data/source/local/theme_local_datasource.dart';
import 'package:pokexplorer/core/theme/domain/repository/theme_repo.dart';
import 'package:pokexplorer/core/theme/domain/usecase/get_theme_usecase.dart';
import 'package:pokexplorer/core/theme/domain/usecase/set_theme_usecase.dart';
import 'package:pokexplorer/core/theme/presentation/bloc/theme_bloc.dart';
import 'package:pokexplorer/features/type_selection/data/repositories/type_selection_impl.dart';
import 'package:pokexplorer/features/type_selection/data/sources/local/implementation/type_selection_local_data_source_impl.dart';
import 'package:pokexplorer/features/type_selection/data/sources/local/interface/type_selection_local_data_source_interface.dart';
import 'package:pokexplorer/features/type_selection/domain/repositories/type_selection_repo.dart';
import 'package:pokexplorer/features/type_selection/domain/usecases/type_selection_usecase.dart';
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
  //theme
  sl.registerSingleton<ThemeLocalDatasource>(ThemeLocalDatasource(sharedPreferences: sl()));
  sl.registerSingleton<ThemeRepository>(ThemeRepositoryImpl(themeLocalDatasource: sl()));
  sl.registerSingleton<GetThemeUseCase>(GetThemeUseCase(sl()));
  sl.registerSingleton(SetThemeUseCase(sl()));
  sl.registerSingleton(ThemeBloc(getThemeUseCase: sl(), setThemeUseCase: sl()));

  //type selection
  sl.registerFactory<TypeSelectionLocalSourceInterface>(() => TypeSelectionLocalSourceImpl());
  sl.registerFactory<TypeSelectionRepository>(() => TypeSelectionImpl(typeSelectionSource: sl()));
  sl.registerFactory<GetPokemonTypesUsecase>(() => GetPokemonTypesUsecase(typeSelectionRepository: sl()));
  sl.registerFactory<TypeSelectionBloc>(() => TypeSelectionBloc(getPokemonTypesUsecase: sl()));
}
