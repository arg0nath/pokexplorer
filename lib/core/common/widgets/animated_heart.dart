import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';
import 'package:pokexplorer/core/common/widgets/custom_network_image.dart';

/// A highly animated Pokeball button that simulates capturing an item.
///
/// When `isActive` changes from `false` to `true`, a complex animation
/// sequence is triggered:
/// 1. The Pokeball icon transforms into an opening Pokeball image.
/// 2. The `pokemonAvatar` appears slightly above and to the left of the Pokeball.
/// 3. Then it "falls" into the center of the Pokeball while fading out.
/// 4. The opening Pokeball image transforms back into the closed Pokeball image.
///
/// If `isActive` is `false`, the button displays a standard Pokeball icon.
class AnimatedPokeballCapture extends StatefulWidget {
  /// Controls the active state of the Pokeball.
  /// Set to `true` to trigger the capture animation.
  final bool isActive;
  final String pokemonAvatar;

  const AnimatedPokeballCapture({super.key, required this.isActive, required this.pokemonAvatar});

  @override
  State<AnimatedPokeballCapture> createState() => _AnimatedPokeballCaptureState();
}

class _AnimatedPokeballCaptureState extends State<AnimatedPokeballCapture> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Animation for the falling item's position (X and Y offset)
  late Animation<Offset> _itemFallAnimation;
  // Animation for the falling item's opacity (fades out as it falls)
  late Animation<double> _itemFadeAnimation;

  // Animation for a slight scaling effect when the Pokeball opens
  late Animation<double> _pokeballOpenScaleAnimation;
  // Animation for a slight scaling effect when the Pokeball closes
  late Animation<double> _pokeballCloseScaleAnimation;

  // State flags to control the visibility of the open Pokeball image and the falling item.
  // These are updated in the listener of the AnimationController.
  bool _isPokeballOpen = false;
  bool _isItemVisible = false;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller with a total duration for the entire sequence.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Total animation time (1.5 seconds)
    );

    // Define the animation for the Pokeball opening scale.
    // It briefly scales up (1.0 to 1.1) during the first 20% of the total animation.
    _pokeballOpenScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeInOutBack), // First 20% for opening
      ),
    );

    // Define the animation for the falling item's offset.
    // Starts slightly left and top relative to the center of the Pokeball,
    // and ends at the center (Offset.zero).
    // This animation runs from 20% to 70% of the total duration.
    _itemFallAnimation = Tween<Offset>(
      begin: const Offset(-0.25, -0.6), // Start 25% left and 60% top of parent
      end: Offset.zero, // End at the center
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeInCirc), // From 20% to 70% for falling
      ),
    );

    // Define the animation for the falling item's opacity.
    // It fades from fully visible (1.0) to fully transparent (0.0).
    // This animation runs from 50% to 70% of the total duration, causing it to
    // disappear as it reaches the center of the Pokeball.
    _itemFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.7, curve: Curves.easeInOut), // Fades out during the last half of falling
      ),
    );

    // Define the animation for the Pokeball closing scale.
    // It briefly scales up (1.0 to 1.1) again during the last 20% of the total animation.
    _pokeballCloseScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0, curve: Curves.easeInOutBack), // Last 20% for closing
      ),
    );

    // Add a listener to the animation controller to update UI states based on animation progress.
    _controller.addListener(() {
      setState(() {
        // Show the open Pokeball image when the animation is between 0% and 75%.
        _isPokeballOpen = _controller.value > 0.0 && _controller.value <= 0.75;

        // Show the falling item when the animation is between 20% and 70%.
        _isItemVisible = _controller.value >= 0.2 && _controller.value <= 0.7;
      });
    });
  }

  @override
  void didUpdateWidget(covariant AnimatedPokeballCapture oldWidget) {
    super.didUpdateWidget(oldWidget);
    // When the `isActive` property changes, trigger the animation.
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        // If becoming active, start the animation from the beginning.
        _controller.forward(from: 0.0);
      } else {
        // If becoming inactive, reset the state immediately to the closed Pokeball.
        // No reverse animation for 'de-capturing' in this example.
        _isPokeballOpen = false;
        _isItemVisible = false;
        _controller.value = 0.0; // Reset controller to initial state
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine which Pokeball visual to display (icon or asset image).
    Widget currentPokeballVisual;
    if (_isPokeballOpen) {
      // If `_isPokeballOpen` is true, show the opening Pokeball image.
      currentPokeballVisual = Image.asset(AppAssets.buttonOpenPokeball, width: 25, height: 25, fit: BoxFit.contain);
    } else if (widget.isActive) {
      // If `isActive` is true but `_isPokeballOpen` is false (meaning the animation finished closing),
      // show the closed Pokeball image to signify it's "captured".
      currentPokeballVisual = Image.asset(AppAssets.buttonPokeball, width: 25, height: 25, fit: BoxFit.contain);
    } else {
      // If `isActive` is false, show the default Pokeball icon (not captured).
      currentPokeballVisual = Image.asset(AppAssets.pokeballOutlined, color: context.colorScheme.onSurface.withAlpha(100), width: 25, height: 25, fit: BoxFit.contain);
    }

    return SizedBox(
      width: 70, // Fixed size for the entire button area
      height: 70,
      child: Stack(
        alignment: Alignment.center, // Centers children within the Stack
        children: <Widget>[
          // The Pokeball visual (icon or image) with scaling animation
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              double scale = 1.0;
              // Apply appropriate scale animation based on the controller's value
              if (_controller.value <= 0.2) {
                // Opening phase
                scale = _pokeballOpenScaleAnimation.value;
              } else if (_controller.value >= 0.8) {
                // Closing phase
                scale = _pokeballCloseScaleAnimation.value;
              }
              return Transform.scale(
                scale: scale,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200), // Quick cross-fade for image change
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: currentPokeballVisual, // The dynamically chosen Pokeball visual
                ),
              );
            },
          ),

          // The falling item (20x20 container with a star icon)
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              if (!_isItemVisible) {
                return const SizedBox.shrink(); // Hide the item when it's not needed
              }
              // Use FractionalTranslation to position the item relative to the Stack's size.
              // Offset.zero would be the center.
              return FractionalTranslation(
                translation: _itemFallAnimation.value,
                child: Opacity(
                  opacity: _itemFadeAnimation.value, // Apply fading effect
                  child: Container(
                    // Key helps AnimatedSwitcher efficiently update the widget tree if needed,
                    // though not strictly necessary here since it's just a Container.
                    key: const ValueKey('falling_item'),
                    width: 40,
                    height: 40,
                    child: Center(
                        child: CustomNetworkImage(
                      imageURL: widget.pokemonAvatar,
                    )),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
