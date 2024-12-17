import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../core/models/app_models.dart' as app_models;
import '../../../core/utilities/app_utils.dart' as app_utils;
import '../../../core/utilities/front_end_utils.dart';
import '../../../core/variables/app_constants.dart' as app_const;

part 'type_selection_event.dart';
part 'type_selection_state.dart';

class TypeSelectionBloc extends Bloc<TypeSelectionEvent, TypeSelectionState> {
  TypeSelectionBloc({required this.frontEndUtils})
      : super(const TypeSelectionState(
          typeSelectionStatus: TypeSelectionStatus.loadingTypes,
        )) {
    on<LoadTypesEvent>((LoadTypesEvent event, Emitter<TypeSelectionState> emit) async {
      await app_utils.loadPrefs(frontEndUtils);
      initializeTypeSelectionVariables();

      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.loadingTypes));

      availableTypes.addAll([
        app_models.PokemonType(name: 'fire', icon: app_const.FIRE_ICON, isSelected: false),
        app_models.PokemonType(name: 'water', icon: app_const.WATER_ICON, isSelected: false),
        app_models.PokemonType(name: 'grass', icon: app_const.GRASS_ICON, isSelected: false),
        app_models.PokemonType(name: 'electric', icon: app_const.ELECTRIC_ICON, isSelected: false),
        app_models.PokemonType(name: 'dragon', icon: app_const.DRAGON_ICON, isSelected: false),
        app_models.PokemonType(name: 'psychic', icon: app_const.PSYCHIC_ICON, isSelected: false),
        app_models.PokemonType(name: 'ghost', icon: app_const.GHOST_ICON, isSelected: false),
        app_models.PokemonType(name: 'dark', icon: app_const.DARK_ICON, isSelected: false),
        app_models.PokemonType(name: 'steel', icon: app_const.STEEL_ICON, isSelected: false),
        app_models.PokemonType(name: 'fairy', icon: app_const.FAIRY_ICON, isSelected: false),
      ]);

      if (frontEndUtils.loadSelectedTypeName().isNotEmpty) {
        selectedPokemonType = availableTypes.firstWhere((type) => type.name == frontEndUtils.loadSelectedTypeName());
        selectedPokemonType.setIsSelected(true);
      }

      app_utils.myLog(level: app_const.LOG_WARNING, msg: 'LoadTypesEvent typesLoaded..');
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
      final tmpSelectedPokemonTypeName = selectedPokemonType.name;
      frontEndUtils.saveSelectedTypeName(tmpSelectedPokemonTypeName);
      selectedPokemonTypeDetails = await frontEndUtils.loadTypeDetails(type: tmpSelectedPokemonTypeName);

      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.readyToProceedToTypeDetailsScreen));
    });

    on<ShowInfoDialogEvent>((ShowInfoDialogEvent event, Emitter<TypeSelectionState> emit) async {
      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.showInfoDialog));

      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.typesLoaded));
    });
  }

  late final FrontendUtils frontEndUtils;

  List<app_models.PokemonType> availableTypes = [];
  app_models.PokemonType selectedPokemonType = app_models.PokemonType.empty();
  app_models.PokemonTypeDetails selectedPokemonTypeDetails = app_models.PokemonTypeDetails.empty();

  void initializeTypeSelectionVariables() {
    availableTypes.clear();
    selectedPokemonType = app_models.PokemonType.empty();
    selectedPokemonTypeDetails = app_models.PokemonTypeDetails.empty();
  }
}
