import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/widgets/custom_network_image.dart';
import 'package:pokexplorer/features/settings/presentation/bloc/settings_bloc.dart';

class CustomNetworkImageWrapper extends StatelessWidget {
  const CustomNetworkImageWrapper({
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
    return BlocSelector<SettingsBloc, SettingsState, bool>(
      selector: (SettingsState state) => state is SettingsLoaded ? state.showCopyrightedContent : false,
      builder: (BuildContext context, bool isCopyrightedVisible) {
        return CustomNetworkImage(
          imageURL: imageURL,
          width: width,
          height: height,
          isCopyrightedVisible: isCopyrightedVisible,
        );
      },
    );
  }
}
