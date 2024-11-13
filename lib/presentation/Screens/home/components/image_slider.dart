import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/productProfile/dotIndicator/dot_indicator_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/productProfile/imageScrolling/image_scrolling_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';

class ImageSlider extends StatelessWidget {
  final List imageList;
  const ImageSlider({
    required PageController pageController,
    required this.imageList,
    super.key,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 390,
          width: 390,
          margin: const EdgeInsets.only(bottom: 5),
          child: PageView.builder(
            controller: _pageController,
            itemCount: imageList.length,
            scrollDirection: Axis.horizontal,
            allowImplicitScrolling: true,
            onPageChanged: (value) {
              context
                  .read<ImageScrollingBloc>()
                  .add(ImageScrollingEvent(value));
              context.read<DotIndicatorBloc>().add(DotIndicatorEvent(value));
            },
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: AppBorders.borderRadius12,
              child: imageList[index] is Map<String, dynamic>
                  ? ExtendedImage.network(
                      '${Endpoints().url}/${imageList[index]['url']!}',
                      height: 390,
                      width: 390,
                      fit: BoxFit.cover,
                    )
                  : ExtendedImage.network(
                      '${Endpoints().url}/${imageList[index].url}',
                      height: 390,
                      width: 390,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        imageList.length == 1
            ? const SizedBox.shrink()
            : Positioned(
                bottom: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    imageList.length,
                    (index) => BlocBuilder<DotIndicatorBloc, DotIndicatorState>(
                      builder: (context, stateIndicator) {
                        return GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                            context
                                .read<DotIndicatorBloc>()
                                .add(DotIndicatorEvent(index));
                          },
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: stateIndicator.selectedIndex == index
                                  ? AppColors.purpleColor
                                  : AppColors.grey5Color,
                              borderRadius: AppBorders.borderRadius12,
                              border: Border.all(
                                color: stateIndicator.selectedIndex == index
                                    ? AppColors.purpleColor
                                    : AppColors.grey5Color,
                                width: 1.5,
                                style: BorderStyle.solid,
                              ),
                            ),
                            margin: const EdgeInsets.only(right: 5),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
