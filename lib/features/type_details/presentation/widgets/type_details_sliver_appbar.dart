import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';
import 'package:pokexplorer/core/common/widgets/appbar_background.dart';
import 'package:pokexplorer/core/common/widgets/custom_appbar_back_button.dart';
import 'package:pokexplorer/core/common/widgets/type_short_card.dart';
import 'package:pokexplorer/features/type_details/presentation/bloc/type_details_bloc.dart';

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  SliverSearchAppBar({
    required this.selectedType,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;
  final PokemonType selectedType;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double adjustedShrinkOffset = shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.3; //was 0.4
    double topPadding = MediaQuery.paddingOf(context).top + 10;
    return BlocBuilder<TypeDetailsBloc, TypeDetailsState>(
      builder: (BuildContext context, TypeDetailsState state) {
        final typeDetailsBloc = context.read<TypeDetailsBloc>();
        return SizedBox(
          height: AppConst.typeDetailsAppBarDelegateMaxExtend,
          child: Stack(
            children: <Widget>[
              //cool gradient background
              AppbarGradientBackground(
                color: selectedType.color,
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
                      CustomAppbarBackButton(onPressed: () => Navigator.pop(context)),
                      // typeDetailsBloc.add(const ExitTypeDetailsEvent())),
                      SelectedTypeContainer(type: selectedType),
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
                      child: _customTextFormField(typeDetailsBloc, context),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  TextFormField _customTextFormField(TypeDetailsBloc typeDetailsBloc, BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      style: Theme.of(context).inputDecorationTheme.labelStyle,
      decoration:
          const InputDecoration().copyWith(suffixIcon: _customSuffixIcon(typeDetailsBloc, context), prefixIcon: textEditingController.value.text.isEmpty ? null : _customPrefixButton(typeDetailsBloc)),
      onChanged: (value) {
        if (value.isEmpty) {
          // typeDetailsBloc.add(const ReturnFromSearchEvent());
        }
      },
      onTapOutside: (val) => FocusScope.of(context).unfocus(),
      // onFieldSubmitted: (String val) => val.isNotEmpty ? typeDetailsBloc.add(SearchPokemonEvent(value: val)) : null,
    );
  }

  IconButton _customSuffixIcon(TypeDetailsBloc typeDetailsBloc, BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          if (textEditingController.value.text.isNotEmpty) {
            // typeDetailsBloc.add(SearchPokemonEvent(value: textEditingController.value.text));
            FocusScope.of(context).unfocus();
          }
        });
  }

  GestureDetector _customPrefixButton(TypeDetailsBloc typeDetailsBloc) {
    return GestureDetector(
        onTap: () {
          // typeDetailsBloc.add(const ReturnFromSearchEvent());
          textEditingController.clear();
        },
        child: const Icon(
          Icons.clear_rounded,
        ));
  }

  @override
  double get maxExtent => AppConst.typeDetailsAppBarDelegateMaxExtend;

  @override
  double get minExtent => AppConst.typeDetailsAppBarDelegateMinExtend;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
