import 'package:flutter/material.dart';

class TypeSelectionPage extends StatefulWidget {
  const TypeSelectionPage({super.key});

  @override
  State<TypeSelectionPage> createState() => _TypeSelectionPageState();
}

class _TypeSelectionPageState extends State<TypeSelectionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Pokemon Type'),
      ),
      body: const SizedBox.shrink(),
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
