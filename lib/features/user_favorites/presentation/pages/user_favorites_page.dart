import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/widgets/debug_button.dart';
import 'package:pokexplorer/core/common/widgets/preview_list_tile.dart';
import 'package:pokexplorer/core/routes/route_names.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/user_favorites/presentation/bloc/user_favorites_bloc.dart';

class UserFavoritesPage extends StatefulWidget {
  const UserFavoritesPage({super.key});

  @override
  State<UserFavoritesPage> createState() => _UserFavoritesPageState();
}

class _UserFavoritesPageState extends State<UserFavoritesPage> {
  @override
  void initState() {
    context.read<UserFavoritesBloc>().add(LoadUserFavoritesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: const Text('User Favorites'),
          actions: [DebugButton()],
        ),
        body: BlocConsumer<UserFavoritesBloc, UserFavoritesState>(
          listener: (BuildContext context, UserFavoritesState state) {},
          builder: (BuildContext context, UserFavoritesState state) {
            if (state is LoadingUserFavorites) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserFavoritesLoaded || state is UpdatingFavoriteStatus) {
              final List<PokemonPreview> favorites = (state is UserFavoritesLoaded) ? state.favorites : (state as UpdatingFavoriteStatus).favorites;
              if (favorites.isEmpty) {
                return const Center(child: Text('No favorites added yet.'));
              }
              return ListView.builder(
                itemExtent: 60,
                itemCount: favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  final PokemonPreview favorite = favorites[index];

                  return PreviewListTile(
                    preview: favorite,
                    key: ValueKey<String>(favorite.name),
                    onCardTap: () {
                      context.pushNamed(RouteName.pokemonDetailsPageName, pathParameters: {'pokemonName': favorite.name});
                    },
                  );
                },
              );
            } else if (state is UserFavoritesError) {
              return Center(child: Text(state.errorMessage));
            }
            return SizedBox.shrink();
          },
        ));
  }
}
