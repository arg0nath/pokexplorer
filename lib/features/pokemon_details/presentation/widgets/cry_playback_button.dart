import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/widgets/message_toast.dart';

class CryPlaybackButton extends StatefulWidget {
  const CryPlaybackButton({required this.url, required this.backgroudColor});
  final String url;
  final Color backgroudColor;

  @override
  State<CryPlaybackButton> createState() => _CryPlaybackButtonState();
}

class _CryPlaybackButtonState extends State<CryPlaybackButton> {
  AudioPlayer? _player;
  bool _isPlaying = false;
  bool _pluginAvailable = true;

  @override
  void initState() {
    super.initState();
    // Create AudioPlayer lazily on first play to avoid plugin-init before
    // Flutter has registered platform plugins. This avoids MissingPluginException
    // during page initialization.
  }

  @override
  void dispose() {
    // _player may be null if plugin wasn't available or user never played audio.
    _player?.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    try {
      if (!_pluginAvailable) {
        if (mounted) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Audio not available')));
        }
        return;
      }

      // Lazy-create the player to ensure plugin registration has happened.
      if (_player == null) {
        try {
          _player = AudioPlayer();
          _player!.onPlayerComplete.listen((_) {
            if (mounted) setState(() => _isPlaying = false);
          }, onError: (_) {
            // ignore stream errors here; they'll be handled by play/pause catches
          });
        } on MissingPluginException catch (_) {
          _pluginAvailable = false;
          if (mounted) {
            showPokeToast(context, 'Audio plugin not registered. Please fully restart the app.');
          }
          return;
        } catch (_) {
          _pluginAvailable = false;
          if (mounted) {
            showPokeToast(context, 'Audio not available');
          }
          return;
        }
      }

      if (_isPlaying) {
        await _player!.pause();
        setState(() => _isPlaying = false);
        return;
      }

      await _player!.play(UrlSource(widget.url));
      setState(() => _isPlaying = true);
    } catch (e) {
      if (e is MissingPluginException) {
        _pluginAvailable = false;
        if (mounted) {
          showPokeToast(context, 'Audio plugin not registered. Please fully restart the app.');
        }
        return;
      }

      if (mounted) {
        showPokeToast(context, 'Failed to play sound');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(context.textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold)),
        foregroundColor: WidgetStateProperty.all<Color>(widget.backgroudColor.computeLuminance() > 0.4 ? AppPalette.black : AppPalette.white),
        backgroundColor: WidgetStateProperty.all<Color>(widget.backgroudColor),
      ),
      onPressed: _toggle,
      icon: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
      label: Text(_isPlaying ? 'Pause' : 'Listen'),
    );
  }
}
