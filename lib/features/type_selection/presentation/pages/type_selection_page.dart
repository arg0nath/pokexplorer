import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';
import 'package:pokexplorer/core/common/widgets/message_toast.dart';
import 'package:pokexplorer/core/common/widgets/misc_dialog.dart';
import 'package:pokexplorer/core/routes/route_names.dart';
import 'package:pokexplorer/features/type_selection/presentation/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/features/type_selection/presentation/widgets/types_grid_view.dart';

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
      backgroundColor: context.theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Pokemon Type'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.setting_5_copy),
            onPressed: () => showDialog(context: context, builder: (_) => MiscDialog()),
          ),
        ],
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
          if (state is ReadyToProceedTypeDetails && state.proceedingStatus == ProceedingStatus.completed) {
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
            return TypesGridView(types: types, selectedTypeName: _selectedTypeName);
          } else {
            return const SizedBox.shrink();
          }
        },
      ), // Example item count
    );
  }
}
