import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';

class LegalBottomSheet extends StatefulWidget {
  const LegalBottomSheet({Key? key}) : super(key: key);

  @override
  State<LegalBottomSheet> createState() => _LegalBottomSheetState();
}

class _LegalBottomSheetState extends State<LegalBottomSheet> {
  bool _accepted = false;
  bool _showCopyrighetContent = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(12),
      child: Column(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Content & Copyright Notice',
              style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                '''
This is an unofficial, fan-made, and open-source application developed for educational and non-commercial purposes only.

The app uses publicly available data from PokéAPI and includes Pokémon names, game data, and sprites/images that are the intellectual property of Nintendo, Game Freak, Creatures Inc., and The Pokémon Company.

All referenced content (including names, visuals, sprites, and other assets) remains the property of their respective copyright holders.

Some images and materials are used under the principles of fair use (for commentary, research, and educational purposes). No copyright infringement is intended.

This project is not affiliated with or endorsed by Nintendo, Game Freak, Creatures Inc., or The Pokémon Company.

Pokémon © 1995–2025 Nintendo / Creatures Inc. / GAME FREAK Inc.
                ''',
                style: context.textTheme.bodyMedium,
              ),
            ),
          ),
          CheckboxListTile(
            title: const Text('I have read and agree to the above terms.'),
            value: _accepted,
            onChanged: (bool? value) {
              setState(() {
                _accepted = value ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('I want to see copyrighted content.(Pokémon images, sprites, etc.)'),
            value: _showCopyrighetContent,
            onChanged: (bool? value) {
              setState(() {
                _showCopyrighetContent = value ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          ElevatedButton(
            onPressed: _accepted ? () => Navigator.of(context).pop() : null, // Disabled if not accepted
            child: const Text('I Understand'),
          ),
        ],
      ),
    );
  }
}
