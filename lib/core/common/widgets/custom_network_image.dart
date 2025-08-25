import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageURL,
    required this.isCopyrightedVisible,
    this.width,
    this.height,
  });

  final String imageURL;
  final bool isCopyrightedVisible;
  final double? width;
  final double? height;

  bool get isSvg => imageURL.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return CachedNetworkSVGImage(
        imageURL,
        placeholder: const _PlaceHolderWidget(),
        errorWidget: const _ErrorWidget(),
        width: width,
        height: height,
        colorFilter: isCopyrightedVisible ? null : const ColorFilter.mode(AppPalette.grey, BlendMode.srcATop),
        fadeDuration: const Duration(milliseconds: 200),
      );
    } else {
      return Image.network(
        imageURL,
        scale: 0.3,
        width: width,
        height: height,
        color: isCopyrightedVisible ? null : AppPalette.grey,
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => const _ErrorWidget(),
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return const _PlaceHolderWidget();
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
