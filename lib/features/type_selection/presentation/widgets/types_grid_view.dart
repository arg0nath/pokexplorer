import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';
import 'package:pokexplorer/features/type_selection/presentation/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/features/type_selection/presentation/widgets/generic_type_card.dart';

class TypesGridView extends StatelessWidget {
  const TypesGridView({
    super.key,
    required this.types,
    required this.selectedTypeName,
  });
  final String selectedTypeName;
  final List<PokemonType> types;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: _gridDelegate(),
        itemBuilder: (BuildContext context, int index) {
          // Placeholder for type items
          return GenericTypeCard(
            pokemonType: types[index],
            onTap: () => context.read<TypeSelectionBloc>().add(SelectTypeEvent(typeName: types[index].name)),
            isSelected: types[index].name == selectedTypeName,
          );
        },
        itemCount: types.length);
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
