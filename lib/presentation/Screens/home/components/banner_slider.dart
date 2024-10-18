import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/bannerSlider/banner_slider_cubit.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';

class BannerSlider extends StatelessWidget {
  final List imageList;

  const BannerSlider({
    required this.imageList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imageList.length,
      itemBuilder: (context, index, realIndex) {
        final imageUrl =
            imageList[index].image != null ? imageList[index].image.url : '';

        return Container(
          padding: const EdgeInsets.only(right: 10, top: 20, bottom: 20),
          child: ClipRRect(
            borderRadius: AppBorders.borderRadius12,
            child: ExtendedImage.network(
              '${Endpoints().url}/$imageUrl',
              height: 160,
              width: 390,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      options: CarouselOptions(
        onPageChanged: (index, reason) =>
            context.read<BannerSliderCubit>().changeImage(index),
        height: 160,
        viewportFraction: 0.8,
        autoPlay: true,
        scrollPhysics: const BouncingScrollPhysics(),
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        autoPlayAnimationDuration: const Duration(milliseconds: 2000),
      ),
    );
  }
}
