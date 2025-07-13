import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/widgets/message_toast.dart';
import 'package:pokexplorer/core/routes/route_names.dart';
import 'package:pokexplorer/features/type_selection/domain/entities/pokemon_type.dart';
import 'package:pokexplorer/features/type_selection/presentation/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/features/type_selection/presentation/widgets/type_card.dart';

class TypeSelectionPage extends StatefulWidget {
  const TypeSelectionPage({super.key});

  @override
  State<TypeSelectionPage> createState() => _TypeSelectionPageState();
}

class _TypeSelectionPageState extends State<TypeSelectionPage> {
  late String _selectedTypeName;

  @override
  Widget build(BuildContext context) {
    final TypeSelectionBloc typeSelectionBloc = context.read<TypeSelectionBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Pokemon Type'),
      ),
      floatingActionButton: BlocBuilder<TypeSelectionBloc, TypeSelectionState>(
        buildWhen: (TypeSelectionState previous, TypeSelectionState current) => current is! ReadyToProceedTypeDetails,
        builder: (BuildContext context, TypeSelectionState state) {
          if (state is TypesLoaded) {
            _selectedTypeName = state.selectedTypeName;
            if (_selectedTypeName.isNotEmpty) {
              return FloatingActionButton.extended(
                onPressed: () => typeSelectionBloc.add(ProceedToTypeDetails()),
                label: Icon(Icons.catching_pokemon_rounded),
                icon: Text('Explore'),
              );
            } else {
              return SizedBox.shrink();
            }
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      body: BlocConsumer<TypeSelectionBloc, TypeSelectionState>(
        listener: (BuildContext context, TypeSelectionState state) {
          if (state is ReadyToProceedTypeDetails) {
            context.pushNamed(RouteName.typeDetailsPageName, pathParameters: <String, String>{'typeName': _selectedTypeName});
          } else if (state is TypeSelectionError) {
            showPokeToast(context, state.message);
          }
        },
        buildWhen: (TypeSelectionState previous, TypeSelectionState current) => current is! ReadyToProceedTypeDetails,
        builder: (BuildContext context, TypeSelectionState state) {
          if (state is LoadingTypes) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TypeSelectionError) {
            return Center(child: Text(state.message));
          } else if (state is TypesLoaded) {
            final List<PokemonType> types = state.types;
            _selectedTypeName = state.selectedTypeName;

            return Container(
              constraints: const BoxConstraints.expand(),
              child: GridView.builder(
                  gridDelegate: _gridDelegate(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    // Placeholder for type items
                    return TypeCard(
                      type: types[index],
                      onTap: () => typeSelectionBloc.add(SelectTypeEvent(typeName: types[index].name)),
                      selectedTypeName: _selectedTypeName,
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
