part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => <Object>[];
}

final class LoadSettingsEvent extends SettingsEvent {}

final class AcceptTermsEvent extends SettingsEvent {
  const AcceptTermsEvent(this.accepted);

  final bool accepted;

  @override
  List<Object> get props => <Object>[accepted];
}

final class ToggleCopyrightedContentEvent extends SettingsEvent {
  const ToggleCopyrightedContentEvent(this.show);

  final bool show;

  @override
  List<Object> get props => <Object>[show];
}
