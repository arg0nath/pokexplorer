import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/widgets/pokemon_list_card.dart';

class CustomFavoriteButton extends StatelessWidget {
  const CustomFavoriteButton({super.key, required this.isFavorite, required this.onPressed});

  final VoidCallback onPressed;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedHeart(isActive: isFavorite),
    );
  }
}
