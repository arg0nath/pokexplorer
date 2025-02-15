import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:pokexplorer/core/variables/app_constants.dart';
import 'package:pokexplorer/core/variables/app_variables.dart';
import 'package:pokexplorer/core/widgets/custom_progress_indicator.dart';

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

  @override
  Widget build(BuildContext context) {
    if (imageURL.contains('.svg')) {
      return CachedNetworkSVGImage(
        imageURL,
        placeholder: _networkImageCustomPlaceHolder(),
        errorWidget: _networkImageErrorWidget(),
        width: width,
        height: height,
        fadeDuration: const Duration(milliseconds: 200),
      );
    } else {
      return Image.network(
        imageURL,
        scale: 0.3,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) => _networkImageErrorWidget(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _networkImageCustomPlaceHolder();
        },
      );
    }
  }

  Widget _networkImageErrorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(border: Border.all(color: Colors.transparent, width: 0)),
      child: Center(
        child: Image.asset(EMPTY_POKEBALL_PNG, width: logicalHeight * 0.05, height: logicalHeight * 0.05),
      ),
    );
  }

  Widget _networkImageCustomPlaceHolder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.transparent, width: NETWORK_IMAGE_PLACEHOLDER_WIDTH),
      ),
      child: const Center(child: CustomProgressIndicator()),
    );
  }
}
