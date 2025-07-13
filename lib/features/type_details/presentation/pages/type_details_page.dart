import 'package:flutter/material.dart';
//final String extraString = GoRouterState.of(context).extra! as String;

class TypeDetailsPage extends StatefulWidget {
  const TypeDetailsPage({super.key, required this.typeName});

  final String typeName;

  @override
  State<TypeDetailsPage> createState() => _TypeDetailsPageState();
}

class _TypeDetailsPageState extends State<TypeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results for ${widget.typeName}'),
      ),
      body: Center(
        child: Text(
          'Displaying results for type: ${widget.typeName}',
        ),
      ),
    );
  }
}
