// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon_type_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PokemonTypeDto implements DiagnosticableTreeMixin {
  String get name;
  String get icon;

  /// Create a copy of PokemonTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PokemonTypeDtoCopyWith<PokemonTypeDto> get copyWith =>
      _$PokemonTypeDtoCopyWithImpl<PokemonTypeDto>(
          this as PokemonTypeDto, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'PokemonTypeDto'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('icon', icon));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PokemonTypeDto &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, icon);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PokemonTypeDto(name: $name, icon: $icon)';
  }
}

/// @nodoc
abstract mixin class $PokemonTypeDtoCopyWith<$Res> {
  factory $PokemonTypeDtoCopyWith(
          PokemonTypeDto value, $Res Function(PokemonTypeDto) _then) =
      _$PokemonTypeDtoCopyWithImpl;
  @useResult
  $Res call({String name, String icon});
}

/// @nodoc
class _$PokemonTypeDtoCopyWithImpl<$Res>
    implements $PokemonTypeDtoCopyWith<$Res> {
  _$PokemonTypeDtoCopyWithImpl(this._self, this._then);

  final PokemonTypeDto _self;
  final $Res Function(PokemonTypeDto) _then;

  /// Create a copy of PokemonTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? icon = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _PokemonTypeDto with DiagnosticableTreeMixin implements PokemonTypeDto {
  const _PokemonTypeDto({required this.name, required this.icon});

  @override
  final String name;
  @override
  final String icon;

  /// Create a copy of PokemonTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PokemonTypeDtoCopyWith<_PokemonTypeDto> get copyWith =>
      __$PokemonTypeDtoCopyWithImpl<_PokemonTypeDto>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'PokemonTypeDto'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('icon', icon));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PokemonTypeDto &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, icon);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PokemonTypeDto(name: $name, icon: $icon)';
  }
}

/// @nodoc
abstract mixin class _$PokemonTypeDtoCopyWith<$Res>
    implements $PokemonTypeDtoCopyWith<$Res> {
  factory _$PokemonTypeDtoCopyWith(
          _PokemonTypeDto value, $Res Function(_PokemonTypeDto) _then) =
      __$PokemonTypeDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String icon});
}

/// @nodoc
class __$PokemonTypeDtoCopyWithImpl<$Res>
    implements _$PokemonTypeDtoCopyWith<$Res> {
  __$PokemonTypeDtoCopyWithImpl(this._self, this._then);

  final _PokemonTypeDto _self;
  final $Res Function(_PokemonTypeDto) _then;

  /// Create a copy of PokemonTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? icon = null,
  }) {
    return _then(_PokemonTypeDto(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
