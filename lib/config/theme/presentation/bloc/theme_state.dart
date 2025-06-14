part of 'theme_bloc.dart';

//use single state, not a sealed class

enum ThemeStatus { initial, loading, success, failure }

class ThemeState {
  final ThemeStatus status;
  final Failure? failure;
  final ThemeEntity? themeEntity;

  const ThemeState._({
    required this.status,
    this.failure,
    this.themeEntity,
  });

  factory ThemeState.initial() => const ThemeState._(status: ThemeStatus.initial);

  ThemeState copyWith({
    ThemeStatus? status,
    Failure? failure,
    ThemeEntity? themeEntity,
  }) {
    return ThemeState._(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      themeEntity: themeEntity ?? this.themeEntity,
    );
  }
}
