// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon_preview_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PokemonPreviewDto {
  int get id;
  int get typeId;
  String get name;
  String get imageUrl;

  /// Create a copy of PokemonPreviewDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PokemonPreviewDtoCopyWith<PokemonPreviewDto> get copyWith =>
      _$PokemonPreviewDtoCopyWithImpl<PokemonPreviewDto>(
          this as PokemonPreviewDto, _$identity);

  /// Serializes this PokemonPreviewDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PokemonPreviewDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.typeId, typeId) || other.typeId == typeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, typeId, name, imageUrl);

  @override
  String toString() {
    return 'PokemonPreviewDto(id: $id, typeId: $typeId, name: $name, imageUrl: $imageUrl)';
  }
}

/// @nodoc
abstract mixin class $PokemonPreviewDtoCopyWith<$Res> {
  factory $PokemonPreviewDtoCopyWith(
          PokemonPreviewDto value, $Res Function(PokemonPreviewDto) _then) =
      _$PokemonPreviewDtoCopyWithImpl;
  @useResult
  $Res call({int id, int typeId, String name, String imageUrl});
}

/// @nodoc
class _$PokemonPreviewDtoCopyWithImpl<$Res>
    implements $PokemonPreviewDtoCopyWith<$Res> {
  _$PokemonPreviewDtoCopyWithImpl(this._self, this._then);

  final PokemonPreviewDto _self;
  final $Res Function(PokemonPreviewDto) _then;

  /// Create a copy of PokemonPreviewDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? typeId = null,
    Object? name = null,
    Object? imageUrl = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      typeId: null == typeId
          ? _self.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PokemonPreviewDto implements PokemonPreviewDto {
  const _PokemonPreviewDto(
      {required this.id,
      required this.typeId,
      required this.name,
      required this.imageUrl});
  factory _PokemonPreviewDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonPreviewDtoFromJson(json);

  @override
  final int id;
  @override
  final int typeId;
  @override
  final String name;
  @override
  final String imageUrl;

  /// Create a copy of PokemonPreviewDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PokemonPreviewDtoCopyWith<_PokemonPreviewDto> get copyWith =>
      __$PokemonPreviewDtoCopyWithImpl<_PokemonPreviewDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PokemonPreviewDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PokemonPreviewDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.typeId, typeId) || other.typeId == typeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, typeId, name, imageUrl);

  @override
  String toString() {
    return 'PokemonPreviewDto(id: $id, typeId: $typeId, name: $name, imageUrl: $imageUrl)';
  }
}

/// @nodoc
abstract mixin class _$PokemonPreviewDtoCopyWith<$Res>
    implements $PokemonPreviewDtoCopyWith<$Res> {
  factory _$PokemonPreviewDtoCopyWith(
          _PokemonPreviewDto value, $Res Function(_PokemonPreviewDto) _then) =
      __$PokemonPreviewDtoCopyWithImpl;
  @override
  @useResult
  $Res call({int id, int typeId, String name, String imageUrl});
}

/// @nodoc
class __$PokemonPreviewDtoCopyWithImpl<$Res>
    implements _$PokemonPreviewDtoCopyWith<$Res> {
  __$PokemonPreviewDtoCopyWithImpl(this._self, this._then);

  final _PokemonPreviewDto _self;
  final $Res Function(_PokemonPreviewDto) _then;

  /// Create a copy of PokemonPreviewDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? typeId = null,
    Object? name = null,
    Object? imageUrl = null,
  }) {
    return _then(_PokemonPreviewDto(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      typeId: null == typeId
          ? _self.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
