import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:pokexplorer/features/settings/presentation/bloc/settings_bloc.dart';

void showLegalBottomSheet(
  BuildContext context, {
  bool isFirstTime = false,
  OnBoardingCubit? onBoardingCubit,
}) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    backgroundColor: context.colorScheme.surface,
    isScrollControlled: true,
    useSafeArea: true,
    isDismissible: !isFirstTime,
    enableDrag: !isFirstTime,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (_) => LegalBottomSheet(
      isFirstTime: isFirstTime,
      onBoardingCubit: onBoardingCubit,
    ),
  );
}

class LegalBottomSheet extends StatefulWidget {
  const LegalBottomSheet({
    super.key,
    this.isFirstTime = false,
    this.onBoardingCubit,
  });

  final bool isFirstTime;
  final OnBoardingCubit? onBoardingCubit;

  @override
  State<LegalBottomSheet> createState() => _LegalBottomSheetState();
}

class _LegalBottomSheetState extends State<LegalBottomSheet> {
  bool _accepted = false;
  bool _showCopyrightContent = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isFirstTime) {
      final SettingsState state = context.read<SettingsBloc>().state;
      if (state is SettingsLoaded) {
        _accepted = state.termsAccepted;
        _showCopyrightContent = state.showCopyrightedContent;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = context.textTheme;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Content & Copyright Notice',
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(_legalNotice, style: textTheme.bodyMedium),
            ),
          ),
          CheckboxListTile(
            title: Text(
              'I have read and agree to the above terms.',
              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            value: _accepted,
            onChanged: _getAcceptanceHandler(),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: Text(
              'I want to see copyrighted content (Pokémon images, sprites, etc.)',
              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            value: _showCopyrightContent,
            onChanged: (bool? value) {
              setState(() {
                _showCopyrightContent = value ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_accepted || !widget.isFirstTime) ? _handleAcceptance : null,
                child: Text(widget.isFirstTime ? 'I Understand' : 'Save Settings'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ValueChanged<bool?>? _getAcceptanceHandler() {
    if (widget.isFirstTime) {
      return (bool? value) {
        setState(() {
          _accepted = value ?? false;
        });
      };
    }

    if (_accepted) return null;

    return (bool? value) {
      if (value == true) {
        setState(() {
          _accepted = true;
        });
        context.read<SettingsBloc>().add(AcceptTermsEvent(true));
      }
    };
  }

  void _handleAcceptance() {
    final SettingsBloc bloc = context.read<SettingsBloc>();
    bloc.add(AcceptTermsEvent(_accepted));
    bloc.add(ToggleCopyrightedContentEvent(_showCopyrightContent));

    if (widget.isFirstTime) {
      widget.onBoardingCubit?.cacheFirstTimer();
    }

    Navigator.of(context).pop();
  }
}

const String _legalNotice = '''
This is an unofficial, fan-made, and open-source application developed for educational and non-commercial purposes only. The developer does not receive any financial gain from this application. It is distributed freely, without ads, purchases, or monetization of any kind.

The app uses publicly available data from PokéAPI and includes Pokémon names, game data, and sprites/images that are the intellectual property of Nintendo, Game Freak, Creatures Inc., and The Pokémon Company.

All referenced content (including names, visuals, sprites, and other assets) remains the property of their respective copyright holders.

Some images and materials are used under the principles of fair use (for commentary, research, and educational purposes). No copyright infringement is intended.

This project is not affiliated with or endorsed by Nintendo, Game Freak, Creatures Inc., or The Pokémon Company.

Pokémon © 1995–2025 Nintendo / Creatures Inc. / GAME FREAK Inc.
''';
