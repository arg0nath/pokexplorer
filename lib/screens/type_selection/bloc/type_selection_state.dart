part of 'type_selection_bloc.dart';

enum TypeSelectionStatus {
  loadingTypes,
  typesLoaded,
  selectingType,
  typeSelected,

  proceedingToTypeDetailsScreen,
  readyToProceedToTypeDetailsScreen,

  failingproceedingToTypeDetailsScreen,
  proceedingToTypeDetailsScreeFailed,

  readyToProceedToTypeDetailsScreenNoSelection,

  showInfoDialog,
}

class TypeSelectionState extends Equatable {
  const TypeSelectionState({required this.typeSelectionStatus, this.errorMessage});

  final TypeSelectionStatus typeSelectionStatus;
  final String? errorMessage;

  @override
  List<Object?> get props => <Object?>[typeSelectionStatus, errorMessage];
}
