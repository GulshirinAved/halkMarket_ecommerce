import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/blocs/favButton/fav_button_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/models/fav_model.dart';

class FavButton extends StatelessWidget {
  final double containerSize;
  final double padding;
  final FavItem favItem;
  final BorderRadius borderRadius;
  const FavButton({
    required this.containerSize,
    required this.padding,
    required this.favItem,
    required this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.read<FavButtonBloc>().add(ToggleFavEvent(item: favItem)),
      child: BlocBuilder<FavButtonBloc, FavButtonState>(
        builder: (context, state) {
          return Container(
            height: containerSize,
            width: containerSize,
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: AppColors.lightPurpleColor,
              borderRadius: borderRadius,
            ),
            child: SvgPicture.asset(
              state.favList.any((item) => item.id == favItem.id)
                  ? cuteBoldHeartIcon
                  : cuteHeartIcon,
              colorFilter: ColorFilter.mode(
                state.favList.any((item) => item.id == favItem.id)
                    ? AppColors.redColor
                    : AppColors.purpleColor,
                BlendMode.srcIn,
              ),
            ),
          );
        },
      ),
    );
  }
}
