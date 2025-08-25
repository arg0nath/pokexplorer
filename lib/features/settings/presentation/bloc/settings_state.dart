part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  const SettingsLoaded({
    required this.termsAccepted,
    required this.showCopyrightedContent,
  });

  final bool termsAccepted;
  final bool showCopyrightedContent;

  @override
  List<Object> get props => [termsAccepted, showCopyrightedContent];

  SettingsLoaded copyWith({
    bool? termsAccepted,
    bool? showCopyrightedContent,
  }) {
    return SettingsLoaded(
      termsAccepted: termsAccepted ?? this.termsAccepted,
      showCopyrightedContent: showCopyrightedContent ?? this.showCopyrightedContent,
    );
  }
}
