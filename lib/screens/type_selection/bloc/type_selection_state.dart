part of 'type_selection_bloc.dart';

enum TypeSelectionStatus {
  loadingTypes,
  typesLoaded,
  selectingType,
  typeSelected,

  proceedingToTypeDetailsScreen,
  readyToProceedToTypeDetailsScreen,
  proceedingToTypeDetailsScreeFailure,

  readyToProceedToTypeDetailsScreenNoSelection,
  readyToProceedToTypeDetailsScreenGenericFail,

  showInfoDialog,
}

class TypeSelectionState extends Equatable {
  const TypeSelectionState({required this.typeSelectionStatus});

  final TypeSelectionStatus typeSelectionStatus;

  @override
  List<Object> get props => <Object>[typeSelectionStatus];
}
