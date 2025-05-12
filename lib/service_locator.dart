import 'package:get_it/get_it.dart';
import 'package:pokexplorer/core/theme/data/repository/theme_repo_impl.dart';
import 'package:pokexplorer/core/theme/data/source/local/theme_local_datasource.dart';
import 'package:pokexplorer/core/theme/domain/repository/theme_repo.dart';
import 'package:pokexplorer/core/theme/domain/usecase/get_theme_usecase.dart';
import 'package:pokexplorer/core/theme/domain/usecase/set_theme_usecase.dart';
import 'package:pokexplorer/core/theme/presentation/bloc/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Service locator
final GetIt sl = GetIt.instance;

//init dependencies

//02:14:56
Future<void> setupServiceLocator() async {
  //sharedPrefs
  sl.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  //theme
  sl.registerSingleton<ThemeLocalDatasource>(ThemeLocalDatasource(sharedPreferences: sl()));
  sl.registerSingleton<ThemeRepository>(ThemeRepositoryImpl(themeLocalDatasource: sl()));
  sl.registerSingleton<GetThemeUseCase>(GetThemeUseCase(sl()));
  sl.registerSingleton(SetThemeUseCase(sl()));
  sl.registerSingleton(ThemeBloc(getThemeUseCase: sl(), setThemeUseCase: sl()));
}
