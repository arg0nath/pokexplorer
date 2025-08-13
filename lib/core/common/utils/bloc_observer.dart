import 'package:bloc/bloc.dart';
import 'package:pokexplorer/config/logger/my_log.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';

class AppBlocObserver extends BlocObserver {
  ///We can run something, when we create our Bloc
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    myLog("$bloc created", level: AppConst.logWarning);
  }

  ///We can react to events
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    myLog("an event Happened in $bloc the event is $event");
  }

  ///We can even react to transitions
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    /// With this we can specifically know, when and what changed in our Bloc
    // myLog("There was a transition from ${transition.currentState} to ${transition.nextState}");
  }

  ///We can react to errors, and we will know the error and the StackTrace
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    myLog("Error happened in $bloc with error $error and the stacktrace is $stackTrace", level: AppConst.logError);
  }

  ///We can even run something, when we close our Bloc
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    myLog("$bloc BLOC is closed", level: AppConst.logWarning);
  }
}
