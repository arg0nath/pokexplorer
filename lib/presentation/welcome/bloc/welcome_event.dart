part of 'welcome_bloc.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();
}

class LoadWelcomePageEvent extends WelcomeEvent {
  const LoadWelcomePageEvent();

  @override
  List<Object?> get props => <Object>[];
}
