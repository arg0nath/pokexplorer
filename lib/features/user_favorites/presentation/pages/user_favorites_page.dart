import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        appBar: AppBar(title: const Text('User Favorites')),
        body: BlocConsumer<UserFavoritesBloc, UserFavoritesState>(
          listener: (BuildContext context, UserFavoritesState state) {},
          builder: (BuildContext context, UserFavoritesState state) {
            if (state is LoadingUserFavorites) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserFavoritesLoaded) {
              if (state.favorites.isEmpty) {
                return const Center(child: Text('No favorites added yet.'));
              }
              return ListView.builder(
                itemExtent: 60,
                itemCount: state.favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  final favorite = state.favorites[index];
                  return ListTile(
                    title: Text(favorite.name),
                    onTap: () {
                      // Navigate to details page or perform any action
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
