import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/widgets/appbar_background.dart';
import 'package:pokexplorer/features/type_details/presentation/bloc/type_details_bloc.dart';

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  SliverSearchAppBar({
    required this.typeName,
    required this.typeColorNum,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;
  final String typeName;
  final int typeColorNum;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double adjustedShrinkOffset = shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.3; //was 0.4
    double topPadding = MediaQuery.paddingOf(context).top + 10;
    return BlocBuilder<TypeDetailsBloc, TypeDetailsState>(
      builder: (BuildContext context, TypeDetailsState state) {
        return SizedBox(
          height: AppConst.typeDetailsAppBarDelegateMaxExtend,
          child: Stack(
            children: <Widget>[
              //cool gradient background
              AppbarGradientBackground(
                color: Color(typeColorNum),
              ),

              //type icon + name
              Positioned(
                top: topPadding,
                child: SizedBox(
                  width: context.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //TODO
                      // CustomAppbarBackButton(onPressed: () => typeDetailsBloc.add(const ExitTypeDetailsEvent())),
                      // SelectedTypeContainer(typeName: typeName),
                    ],
                  ),
                ),
              ),
              //search bar
              Positioned(
                  top: (topPadding + context.height * 0.055) + offset * 0.3,
                  left: 16,
                  right: 16,
                  child: SizedBox(
                    height: 50,
                    width: context.width - 32,
                    child: InkWell(
                      splashColor: AppPalette.transparent,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      //TODO
                      // child: _customTextFormField(typeDetailsBloc, context),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => AppConst.typeDetailsAppBarDelegateMaxExtend;

  @override
  double get minExtent => AppConst.typeDetailsAppBarDelegateMinExtend;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
