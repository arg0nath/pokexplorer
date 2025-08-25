import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';
import 'package:pokexplorer/core/services/di_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageURL,
    this.width,
    this.height,
  });

  final String imageURL;
  final double? width;
  final double? height;

  // Cached value to avoid SharedPreferences calls on every build
  static bool? _cachedCopyrightVisible;

  // Get copyright visibility, cache it on first access
  static bool get _isCopyrightedVisible {
    if (_cachedCopyrightVisible == null) {
      final SharedPreferences prefs = sl<SharedPreferences>();
      _cachedCopyrightVisible = prefs.getBool(AppConst.kShowCopyrighted) ?? false;
    }
    return _cachedCopyrightVisible!;
  }

  // Method to update the cache when settings change
  static void updateCopyrightVisibility(bool value) {
    _cachedCopyrightVisible = value;
  }

  @override
  Widget build(BuildContext context) {
    final bool isCopyrightedVisible = _isCopyrightedVisible;

    if (imageURL.contains('.svg')) {
      return CachedNetworkSVGImage(
        imageURL,
        placeholder: _PlaceHolderWidget(),
        errorWidget: _ErrorWidget(),
        width: width,
        height: height,
        colorFilter: isCopyrightedVisible ? null : ColorFilter.mode(AppPalette.grey, BlendMode.srcATop),
        fadeDuration: const Duration(milliseconds: 200),
      );
    } else {
      return Image.network(
        imageURL,
        scale: 0.3,
        width: width,
        color: isCopyrightedVisible ? null : AppPalette.grey,
        height: height,
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => _ErrorWidget(),
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return _PlaceHolderWidget();
        },
      );
    }
  }
}

class _PlaceHolderWidget extends StatelessWidget {
  const _PlaceHolderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: AppConst.mainRadius,
        border: Border.all(color: AppPalette.transparent, width: AppConst.networkImagePlaceholderWidth),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(border: Border.all(color: AppPalette.transparent, width: 0)),
      child: Center(
        child: Image.asset(AppAssets.emptyOpenedPokeballPng, width: context.height * 0.05, height: context.height * 0.05),
      ),
    );
  }
}
