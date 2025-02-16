import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../core/common/models/app_models.dart';
import '../../../core/common/utilities/app_utils.dart';
import '../../../core/common/constants/app_constants.dart';
import '../../../domain/front_end_utils.dart';

part 'type_selection_event.dart';
part 'type_selection_state.dart';

class TypeSelectionBloc extends Bloc<TypeSelectionEvent, TypeSelectionState> {
  TypeSelectionBloc({required this.frontEndUtils})
      : super(const TypeSelectionState(
          typeSelectionStatus: TypeSelectionStatus.loadingTypes,
        )) {
    on<LoadTypesEvent>((LoadTypesEvent event, Emitter<TypeSelectionState> emit) async {
      await AppUtils.loadPrefs(frontEndUtils);
      initializeTypeSelectionVariables();

      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.loadingTypes));

      availableTypes.addAll([
        PokemonType(name: 'fire', icon: FIRE_ICON, isSelected: false),
        PokemonType(name: 'water', icon: WATER_ICON, isSelected: false),
        PokemonType(name: 'grass', icon: GRASS_ICON, isSelected: false),
        PokemonType(name: 'electric', icon: ELECTRIC_ICON, isSelected: false),
        PokemonType(name: 'dragon', icon: DRAGON_ICON, isSelected: false),
        PokemonType(name: 'psychic', icon: PSYCHIC_ICON, isSelected: false),
        PokemonType(name: 'ghost', icon: GHOST_ICON, isSelected: false),
        PokemonType(name: 'dark', icon: DARK_ICON, isSelected: false),
        PokemonType(name: 'steel', icon: STEEL_ICON, isSelected: false),
        PokemonType(name: 'fairy', icon: FAIRY_ICON, isSelected: false),
      ]);

      if (frontEndUtils.loadSelectedTypeName().isNotEmpty) {
        selectedPokemonType = availableTypes.firstWhere((type) => type.name == frontEndUtils.loadSelectedTypeName());
        selectedPokemonType.setIsSelected(true);
      }

      AppUtils.myLog(level: LOG_WARNING, msg: 'LoadTypesEvent typesLoaded..');
      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.typesLoaded));
    });

    on<SelectTypeEvent>((SelectTypeEvent event, Emitter<TypeSelectionState> emit) async {
      emit(const TypeSelectionState(typeSelectionStatus: TypeSelectionStatus.selectingType));
      if (event.type.isSelected) {
        frontEndUtils.saveSelectedTypeName(EMPTY_STRING);
        selectedPokemonType.setIsSelected(false);
        selectedPokemonType = PokemonType.empty();
      } else {
        selectedPokemonType.setIsSelected(false);
        selectedPokemonType = PokemonType.empty();
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

  List<PokemonType> availableTypes = [];
  PokemonType selectedPokemonType = PokemonType.empty();
  PokemonTypeDetails selectedPokemonTypeDetails = PokemonTypeDetails.empty();

  void initializeTypeSelectionVariables() {
    availableTypes.clear();
    selectedPokemonType = PokemonType.empty();
    selectedPokemonTypeDetails = PokemonTypeDetails.empty();
  }
}
