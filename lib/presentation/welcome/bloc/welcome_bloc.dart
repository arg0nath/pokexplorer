import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/utilities/front_end_utils.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc({required this.frontEndUtils}) : super(const WelcomeState(welcomeStatus: WelcomeStatus.pagesNotLoaded)) {
    on<LoadWelcomePageEvent>((LoadWelcomePageEvent event, Emitter<WelcomeState> emit) async {
      emit(const WelcomeState(welcomeStatus: WelcomeStatus.loadingPages));

      // app_utils.loadPrefs(frontEndUtils);

      emit(const WelcomeState(welcomeStatus: WelcomeStatus.pagesLoaded));
    });
  }

  final FrontendUtils frontEndUtils;
}
