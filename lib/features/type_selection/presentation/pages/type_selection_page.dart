import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/widgets/loading_dialog.dart';
import 'package:pokexplorer/features/type_selection/domain/entities/pokemon_type.dart';
import 'package:pokexplorer/features/type_selection/presentation/bloc/type_selection_bloc.dart';

class TypeSelectionPage extends StatefulWidget {
  const TypeSelectionPage({super.key});

  @override
  State<TypeSelectionPage> createState() => _TypeSelectionPageState();
}

class _TypeSelectionPageState extends State<TypeSelectionPage> {
  @override
  void initState() {
    super.initState();
    context.read<TypeSelectionBloc>().add(const LoadPokemonTypesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final TypeSelectionBloc typeSelectionBloc = BlocProvider.of<TypeSelectionBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Pokemon Type'),
        ),
        body: BlocConsumer<TypeSelectionBloc, TypeSelectionState>(
          listener: (BuildContext context, TypeSelectionState state) {
            if (state is LoadingPokemonTypes) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const DialogProgressPokeball(hardBackEnabled: false),
              );
            } else {
              // Close dialog when leaving loading state
              if (Navigator.canPop(context)) Navigator.pop(context);
            }
          },
          builder: (BuildContext context, TypeSelectionState state) {
            if (state is PokemonTypesLoaded) {
              final List<PokemonType> types = state.pokemonTypes;
              return SingleChildScrollView(
                child: GridView.builder(
                  gridDelegate: _gridDelegate(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        child: Text(types[index].name),
                      ),
                    );
                  },
                  itemCount: types.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}

SliverGridDelegateWithFixedCrossAxisCount _gridDelegate() {
  return const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 1.0,
    mainAxisSpacing: 8.0,
    crossAxisSpacing: 8.0,
  );
}
