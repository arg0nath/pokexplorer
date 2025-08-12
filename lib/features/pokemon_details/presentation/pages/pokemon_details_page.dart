import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/extensions/string_ext.dart';
import 'package:pokexplorer/core/common/widgets/appbar_background.dart';
import 'package:pokexplorer/core/common/widgets/favorite_button.dart';
import 'package:pokexplorer/core/common/widgets/message_toast.dart';
import 'package:pokexplorer/features/pokemon_details/domain/entities/pokemon_details.dart';
import 'package:pokexplorer/features/pokemon_details/presentation/bloc/pokemon_details_bloc.dart';
import 'package:pokexplorer/features/pokemon_details/presentation/widgets/horizontal_type_list.dart';
import 'package:pokexplorer/features/pokemon_details/presentation/widgets/images_carousel.dart';
import 'package:pokexplorer/features/pokemon_details/presentation/widgets/stat_container.dart';
//final String extraString = GoRouterState.of(context).extra! as String;

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage({super.key, required this.name});

  final String name;

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  @override
  void initState() {
    super.initState();

    context.read<PokemonDetailsBloc>().add(FetchPokemonDetailsEvent(widget.name));
  }

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      layoutBuilder: (List<Widget> entries) {
        return Stack(
          alignment: Alignment.topCenter,
          children: entries,
        );
      },
      transitionBuilder: (Widget child, Animation<double> animation, Animation<double> secondaryAnimation) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      duration: const Duration(milliseconds: 300),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(widget.name.toUpperFirst()),
            actions: <Widget>[
              BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
                builder: (BuildContext context, PokemonDetailsState state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox(),
                    loaded: (PokemonDetails pokemonDetails) => FavoriteButton(
                      name: pokemonDetails.name,
                      avatarUrl: pokemonDetails.imagesUrls[1],
                      id: pokemonDetails.id,
                    ),
                  );
                },
              )
            ],
          ),
        ),
        body: BlocConsumer<PokemonDetailsBloc, PokemonDetailsState>(
          listener: (BuildContext context, PokemonDetailsState state) {
            state.maybeWhen(
              error: (String message) {
                showPokeToast(context, message);
                context.pop();
              },
              orElse: () {},
            );
          },
          builder: (BuildContext context, PokemonDetailsState state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (String message) => Center(child: Text('Oops..! $message')),
              loaded: (PokemonDetails pokemonDetails) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Container(
                        height: context.height * 0.6, // Adjust based on your carousel size
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            AppbarGradientBackground(color: pokemonDetails.types.first.color),
                            Positioned(
                              top: context.height * 0.1,
                              child: ImagesCarousel(
                                pokemonImageList: pokemonDetails.imagesUrls,
                                pageIndicatorColor: pokemonDetails.types.first.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: Container(height: context.height * 0.09, child: HorizontalTypeList(pokemonTypes: pokemonDetails.types))),
                    SliverToBoxAdapter(child: Container(height: context.height * 0.31, child: StatContainer(pokemon: pokemonDetails))),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
