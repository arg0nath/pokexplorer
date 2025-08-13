extension StringExtensions on String {
  /// Converts the very first character in this string to upper case.
  ///
  /// ```dart
  /// 'alphabet'.toUpperFirst(); // 'Alphabet'
  /// ```
  String toUpperFirst() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
