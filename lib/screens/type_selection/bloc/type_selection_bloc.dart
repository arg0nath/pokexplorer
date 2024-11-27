import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokexplorer/src/variables/app_variables.dart' as app_vars;

import '../../../src/models/app_models.dart' as app_models;
import '../../../src/utilities/app_utils.dart' as app_utils;
import '../../../src/utilities/front_end_utils.dart';
import '../../../src/variables/app_constants.dart' as app_const;

part 'type_selection_event.dart';
part 'type_selection_state.dart';

class TypeSelectionBloc extends Bloc<TypeSelectionEvent, TypeSelectionState> {
  TypeSelectionBloc({required this.frontEndUtils})
      : super(const TypeSelectionState(
          typeSelectionStatus: TypeSelectionStatus.loadingTypes,
        )) {
    on<LoadTypesEvent>((LoadTypesEvent event, Emitter<TypeSelectionState> emit) async {
      await app_utils.loadPrefs(frontEndUtils);
      initializeVariables();
      app_utils.myLog(app_const.LOG_WARNING, 'LoadTypesEvent loadingTypes..');
      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.loadingTypes));

      availableTypes.addAll([
        app_models.PokemonType(name: 'Fire', icon: app_const.FIRE_ICON, isSelected: false),
        app_models.PokemonType(name: 'Water', icon: app_const.WATER_ICON, isSelected: false),
        app_models.PokemonType(name: 'Grass', icon: app_const.GRASS_ICON, isSelected: false),
        app_models.PokemonType(name: 'Electric', icon: app_const.ELECTRIC_ICON, isSelected: false),
        app_models.PokemonType(name: 'Dragon', icon: app_const.DRAGON_ICON, isSelected: false),
        app_models.PokemonType(name: 'Psychic', icon: app_const.PSYCHIC_ICON, isSelected: false),
        app_models.PokemonType(name: 'Ghost', icon: app_const.GHOST_ICON, isSelected: false),
        app_models.PokemonType(name: 'Dark', icon: app_const.DARK_ICON, isSelected: false),
        app_models.PokemonType(name: 'Steel', icon: app_const.STEEL_ICON, isSelected: false),
        app_models.PokemonType(name: 'Fairy', icon: app_const.FAIRY_ICON, isSelected: false),
      ]);

      if (frontEndUtils.loadSelectedTypeName().isNotEmpty) {
        selectedPokemonType = availableTypes.firstWhere((type) => type.name.toLowerCase() == frontEndUtils.loadSelectedTypeName());
        selectedPokemonType.setIsSelected(true);
      }

      app_utils.myLog(app_const.LOG_WARNING, 'LoadTypesEvent typesLoaded..');
      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.typesLoaded));
    });

    on<SelectTypeEvent>((SelectTypeEvent event, Emitter<TypeSelectionState> emit) async {
      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.selectingType));
      if (event.type.isSelected) {
        frontEndUtils.saveSelectedTypeName(app_const.EMPTY_STRING);
        selectedPokemonType.setIsSelected(false);
        selectedPokemonType = app_models.PokemonType.empty();
      } else {
        selectedPokemonType.setIsSelected(false);
        selectedPokemonType = app_models.PokemonType.empty();
        selectedPokemonType = event.type;
        selectedPokemonType.setIsSelected(true);
      }

      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.typeSelected));
    });

    on<ProceedToTypeDetailsScreenEvent>((ProceedToTypeDetailsScreenEvent event, Emitter<TypeSelectionState> emit) async {
      if (selectedPokemonType.name.isEmpty) {
        emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.failingproceedingToTypeDetailsScreen));
        emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.errorToProceedToTypeDetailsScreenNoSelection));
        return;
      }

      final bool hasInternetawait = await InternetConnection().hasInternetAccess;
      if (!hasInternetawait) {
        emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.failingproceedingToTypeDetailsScreen));
        emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.errorToNotifyForNoInternet));
        return;
      }

      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.proceedingToTypeDetailsScreen));
      frontEndUtils.saveSelectedTypeName(selectedPokemonType.name.toLowerCase());
      selectedPokemonTypeDetails = await frontEndUtils.loadTypeDetails(type: selectedPokemonType.name.toLowerCase());

      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.readyToProceedToTypeDetailsScreen));
    });

    on<ShowInfoDialogEvent>((ShowInfoDialogEvent event, Emitter<TypeSelectionState> emit) async {
      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.showInfoDialog));

      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.typesLoaded));
    });

    on<ToggleDarkThemeEvent>((ToggleDarkThemeEvent event, Emitter<TypeSelectionState> emit) async {
      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.togglingDarkTheme));
      //  app_vars.isDarkMode = !app_vars.isDarkMode;
      //  print('bloc isDarkMode: ${app_vars.isDarkMode}');
      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.darkThemeToggled));
    });
  }

  late final FrontendUtils frontEndUtils;

  List<app_models.PokemonType> availableTypes = [];
  app_models.PokemonType selectedPokemonType = app_models.PokemonType.empty();
  app_models.PokemonTypeDetails selectedPokemonTypeDetails = app_models.PokemonTypeDetails.empty();

  void initializeVariables() {
    availableTypes.clear();
    selectedPokemonType = app_models.PokemonType.empty();
    selectedPokemonTypeDetails = app_models.PokemonTypeDetails.empty();
  }
}
