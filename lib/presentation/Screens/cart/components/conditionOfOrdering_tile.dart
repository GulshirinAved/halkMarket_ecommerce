import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/cart/expandIcon/expand_icon_cubit.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class ConditionsOfOrdering extends StatelessWidget {
  final state;

  const ConditionsOfOrdering({
    super.key,
    this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalization.of(context)
                      .getTransatedValues('conditionsOrders') ??
                  '',
              style: TextStyle(
                fontFamily: fontExo2,
                fontWeight: FontWeight.w700,
                fontSize: AppFonts.fontSize16,
                color: AppColors.purpleColor,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<ExpandIconCubit>().tapDropDown();
              },
              icon: SvgPicture.asset(
                state == false ? arrowUpIcon : arrowDownIcon,
              ),
            ),
          ],
        ),
        state == true
            ? AnimatedSize(
                alignment: Alignment.topLeft,
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    conditionsForOrdering.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 12, top: 6),
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.purpleColor,
                            ),
                          ),
                          HighlightText(
                            AppLocalization.of(context).getTransatedValues(
                                  conditionsForOrdering[index],
                                ) ??
                                '',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class HighlightText extends StatelessWidget {
  final String text;

  const HighlightText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 60,
      child: RichText(
        text: TextSpan(
          children: _getSpans(text),
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        maxLines: 5,
      ),
    );
  }

  List<TextSpan> _getSpans(String text) {
    final pattern = RegExp(
      r'\b(50 манат|50 manat|150 манат|150 manatdan|бесплатно|mugt)\b',
    );
    final matches = pattern.allMatches(text);

    int lastMatchEnd = 0;
    final List<TextSpan> spans = [];

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }
      spans.add(
        TextSpan(
          text: match.group(0),
          style: TextStyle(
            color: match.group(0) == 'бесплатно' || match.group(0) == 'mugt'
                ? Colors.black
                : Colors.green,
            fontWeight:
                match.group(0) == 'бесплатно' || match.group(0) == 'mugt'
                    ? FontWeight.w700
                    : FontWeight.w400,
          ),
        ),
      );
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return spans;
  }
}
