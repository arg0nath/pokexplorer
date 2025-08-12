import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';
import 'package:pokexplorer/core/common/widgets/appbar_background.dart';
import 'package:pokexplorer/features/type_details/presentation/bloc/type_details_bloc.dart';
import 'package:pokexplorer/features/type_details/presentation/widgets/poke_search_bar.dart';

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  SliverSearchAppBar({
    required this.selectedType,
  });

  final PokemonType selectedType;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double adjustedShrinkOffset = shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.3;
    double topPadding = MediaQuery.paddingOf(context).top + 10;
    return BlocBuilder<TypeDetailsBloc, TypeDetailsState>(
      builder: (BuildContext context, TypeDetailsState state) {
        return SizedBox(
          height: AppConst.typeDetailsAppBarDelegateMaxExtend,
          child: Stack(
            children: <Widget>[
              //cool gradient background
              AppbarGradientBackground(color: selectedType.color),

              //search bar
              Positioned(
                  top: topPadding + offset * 0.2,
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
                      child: PokeSearchBar(
                        onSearch: (String? value) => context.read<TypeDetailsBloc>().add(SearchPokemonsEvent(query: value ?? AppConst.emptyString)),
                      ),
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
