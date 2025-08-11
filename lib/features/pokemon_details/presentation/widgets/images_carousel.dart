import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/widgets/custom_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesCarousel extends StatelessWidget {
  ImagesCarousel({
    required this.pokemonImageList,
    required this.pageIndicatorColor,
    super.key,
  });

  final List<String> pokemonImageList;
  final Color pageIndicatorColor;

  final ValueNotifier<int> _visiblePageIdx = ValueNotifier<int>(0);
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CarouselSlider.builder(
            carouselController: _carouselController,
            options: CarouselOptions(
              viewportFraction: 0.6,
              enableInfiniteScroll: false,
              enlargeFactor: 0.8,
              pageSnapping: true,
              animateToClosest: true,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: false,
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                _visiblePageIdx.value = index;
              },
            ),
            itemCount: pokemonImageList.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              final String imageUrl = pokemonImageList[index];
              return CustomNetworkImage(imageURL: imageUrl);
            },
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<int>(
            valueListenable: _visiblePageIdx,
            builder: (BuildContext context, int index, _) {
              return AnimatedSmoothIndicator(
                activeIndex: index,
                count: pokemonImageList.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: pageIndicatorColor,
                  dotColor: context.theme.colorScheme.onSurface.withAlpha(40),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
