part of 'type_selection_bloc.dart';

enum TypeSelectionStatus {
  loadingTypes,
  typesLoaded,
  selectingType,
  typeSelected,

  proceedingToTypeDetailsScreen,
  readyToProceedToTypeDetailsScreen,

  failingproceedingToTypeDetailsScreen,
  errorToProceedToTypeDetailsScreenNoSelection,
  errorToNotifyForNoInternet,

  showInfoDialog,
  togglingDarkTheme,
  darkThemeToggled,
}

class TypeSelectionState extends Equatable {
  const TypeSelectionState({required this.typeSelectionStatus});

  final TypeSelectionStatus typeSelectionStatus;

  @override
  List<Object?> get props => <Object?>[typeSelectionStatus];
}
