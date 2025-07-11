import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/src/features/type_selection/domain/entities/pokemon_type.dart';
import 'package:pokexplorer/src/features/type_selection/presentation/bloc/type_selection_bloc.dart';

class TypeSelectionPage extends StatefulWidget {
  const TypeSelectionPage({super.key});

  @override
  State<TypeSelectionPage> createState() => _TypeSelectionPageState();
}

class _TypeSelectionPageState extends State<TypeSelectionPage> {
  @override
  void initState() {
    context.read<TypeSelectionBloc>().add(const GetTypesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Pokemon Type'),
      ),
      body: BlocConsumer<TypeSelectionBloc, TypeSelectionState>(
        listener: (BuildContext context, TypeSelectionState state) {},
        builder: (BuildContext context, TypeSelectionState state) {
          if (state is LoadingTypes) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TypeSelectionError) {
            return Center(child: Text(state.message));
          } else if (state is TypesLoaded) {
            final List<PokemonType> types = state.types;
            return Container(
              constraints: BoxConstraints.expand(),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    // Placeholder for type items
                    return Container(
                      width: 30,
                      height: 30,
                      color: Colors.red,
                      child: Center(child: Text('Type ${types[index].name}')),
                    );
                  },
                  itemCount: types.length),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ), // Example item count
    );
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
