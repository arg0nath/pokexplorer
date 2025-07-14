import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/features/type_details/domain/entities/type_details.dart';
import 'package:pokexplorer/features/type_details/presentation/bloc/type_details_bloc.dart';
//final String extraString = GoRouterState.of(context).extra! as String;

class TypeDetailsPage extends StatefulWidget {
  const TypeDetailsPage({super.key, required this.typeName});

  final String typeName;

  @override
  State<TypeDetailsPage> createState() => _TypeDetailsPageState();
}

class _TypeDetailsPageState extends State<TypeDetailsPage> {
  late TypeDetailsBloc typeDetailsBloc;
  @override
  void initState() {
    super.initState();

    context.read<TypeDetailsBloc>().add(TypeDetailsEvent.fetchTypeDetails(widget.typeName));
  }

  @override
  Widget build(BuildContext context) {
    typeDetailsBloc = context.read<TypeDetailsBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Results for ${widget.typeName}'),
      ),
      body: BlocConsumer<TypeDetailsBloc, TypeDetailsState>(
        listener: (BuildContext context, TypeDetailsState state) {},
        builder: (BuildContext context, TypeDetailsState state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (String message) => Center(child: Text('Error: $message')),
            loaded: (TypeDetails typeDetails) {
              return Container(
                constraints: BoxConstraints.expand(),
                child: ListView.builder(
                  itemCount: typeDetails.pokemons.length,
                  itemBuilder: (BuildContext context, int index) {
                    final pokemon = typeDetails.pokemons[index];
                    return ListTile(
                      leading: Image.network(pokemon.thumbnail),
                      title: Text(pokemon.name),
                      onTap: () {
                        // Handle tap on Pokemon preview
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
