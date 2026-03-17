import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';

class ThemeCubit extends HydratedCubit<String> {
  ThemeCubit() : super(AppConst.darkThemeKey); // Default theme is dark

  void getTheme() => emit(state);
  void setTheme(String theme) => emit(theme);

  @override
  String fromJson(DataMap json) => json['value'] as String;

  @override
  Map<String, String> toJson(String state) => {'value': state};
}
