import 'package:animations/animations.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/extensions/string_ext.dart';
import 'package:pokexplorer/core/common/widgets/appbar_background.dart';
import 'package:pokexplorer/core/common/widgets/favorite_button.dart';
import 'package:pokexplorer/core/common/widgets/message_toast.dart';
import 'package:pokexplorer/features/pokemon_details/domain/entities/pokemon_details.dart';
import 'package:pokexplorer/features/pokemon_details/presentation/bloc/pokemon_details_bloc.dart';
import 'package:pokexplorer/features/pokemon_details/presentation/widgets/horizontal_type_list.dart';
import 'package:pokexplorer/features/pokemon_details/presentation/widgets/images_carousel.dart';
import 'package:pokexplorer/features/pokemon_details/presentation/widgets/stat_container.dart';

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage({super.key, required this.name});

  final String name;

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  @override
  void initState() {
    super.initState();

    context.read<PokemonDetailsBloc>().add(FetchPokemonDetailsEvent(widget.name));
  }

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      layoutBuilder: (List<Widget> entries) {
        return Stack(
          alignment: Alignment.topCenter,
          children: entries,
        );
      },
      transitionBuilder: (Widget child, Animation<double> animation, Animation<double> secondaryAnimation) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      duration: const Duration(milliseconds: 300),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(widget.name.toUpperFirst()),
            actions: <Widget>[
              BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
                builder: (BuildContext context, PokemonDetailsState state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox(),
                    loaded: (PokemonDetails pokemonDetails) => FavoriteButton(
                      name: pokemonDetails.name,
                      avatarUrl: pokemonDetails.imagesUrls[1],
                      id: pokemonDetails.id,
                    ),
                  );
                },
              )
            ],
          ),
        ),
        body: BlocConsumer<PokemonDetailsBloc, PokemonDetailsState>(
          listener: (BuildContext context, PokemonDetailsState state) {
            state.maybeWhen(
              error: (String message) {
                showPokeToast(context, message);
                context.pop();
              },
              orElse: () {},
            );
          },
          builder: (BuildContext context, PokemonDetailsState state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (String message) => Center(child: Text('Oops..! $message')),
              loaded: (PokemonDetails pokemonDetails) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Container(
                        height: context.height * 0.6, // Adjust based on your carousel size
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            AppbarGradientBackground(color: pokemonDetails.types.first.color),
                            Positioned(
                              top: context.height * 0.1,
                              child: ImagesCarousel(
                                pokemonImageList: pokemonDetails.imagesUrls,
                                pageIndicatorColor: pokemonDetails.types.first.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (pokemonDetails.cryUrl != null && pokemonDetails.cryUrl!.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 200, maxWidth: context.width * 0.5),
                            child: CryPlaybackButton(url: pokemonDetails.cryUrl!, backgroudColor: pokemonDetails.types.first.color),
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(child: Container(height: context.height * 0.09, child: HorizontalTypeList(pokemonTypes: pokemonDetails.types))),
                    SliverToBoxAdapter(child: Container(height: context.height * 0.31, child: StatContainer(pokemon: pokemonDetails))),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

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
