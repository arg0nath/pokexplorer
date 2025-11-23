import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';
import 'package:pokexplorer/features/type_selection/presentation/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/features/type_selection/presentation/widgets/generic_type_card.dart';

class TypesGridView extends StatelessWidget {
  const TypesGridView({
    required this.selectedTypeName,
    required this.types,
  });
  final String selectedTypeName;
  final List<PokemonType> types;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: _gridDelegate(),
          itemBuilder: (BuildContext context, int index) {
            // Placeholder for type items
            return GenericTypeCard(
              pokemonType: types[index],
              onTap: () => context.read<TypeSelectionBloc>().add(SelectTypeEvent(typeName: types[index].name)),
              isSelected: types[index].name == selectedTypeName,
            );
          },
          itemCount: types.length),
    );
  }
}

SliverGridDelegateWithFixedCrossAxisCount _gridDelegate() {
  return const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 1.0,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
  );
}
