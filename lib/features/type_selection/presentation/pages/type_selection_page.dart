import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/features/type_selection/domain/entities/pokemon_type.dart';
import 'package:pokexplorer/features/type_selection/presentation/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/features/type_selection/presentation/widgets/type_card.dart';

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
            final String selectedTypeName = state.selectedTypeName;

            return Container(
              constraints: const BoxConstraints.expand(),
              child: GridView.builder(
                  gridDelegate: _gridDelegate(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    // Placeholder for type items
                    return TypeCard(
                      type: types[index],
                      onTap: () => context.read<TypeSelectionBloc>().add(SelectTypeEvent(typeName: types[index].name)),
                      selectedTypeName: selectedTypeName,
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
