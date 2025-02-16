///int due to sqflite requirements
enum RelationValue {
  notFavorite(0),
  favorite(1);

  final int value;
  const RelationValue(this.value);
}
