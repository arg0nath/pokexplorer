part of 'welcome_bloc.dart';

enum WelcomeStatus {
  pagesNotLoaded,
  loadingPages,
  pagesLoaded,
}

class WelcomeState extends Equatable {
  const WelcomeState({required this.welcomeStatus});

  final WelcomeStatus welcomeStatus;

  @override
  List<Object> get props => <Object>[welcomeStatus];
}
