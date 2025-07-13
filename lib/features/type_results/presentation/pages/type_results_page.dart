import 'package:flutter/material.dart';
//final String extraString = GoRouterState.of(context).extra! as String;

class TypeResultsPage extends StatefulWidget {
  const TypeResultsPage({super.key, required this.typeName});

  final String typeName;

  @override
  State<TypeResultsPage> createState() => _TypeResultsPageState();
}

class _TypeResultsPageState extends State<TypeResultsPage> {
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
