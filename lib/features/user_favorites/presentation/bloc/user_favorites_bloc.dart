import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_favorites_event.dart';
part 'user_favorites_state.dart';

class UserFavoritesBloc extends Bloc<UserFavoritesEvent, UserFavoritesState> {
  UserFavoritesBloc() : super(UserFavoritesInitial()) {
    on<UserFavoritesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
