import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/productProfile/expanableText/expandable_text_cubit.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class ExpandableText extends StatelessWidget {
  final String text;
  final int maxLines;

  const ExpandableText({
    required this.text,
    this.maxLines = 6,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpandableTextCubit, bool>(
      builder: (context, isExpanded) {
        final maxLines = isExpanded ? null : this.maxLines;

        return LayoutBuilder(
          builder: (context, constraints) {
            final textPainter = TextPainter(
              text: TextSpan(
                  text: text, style: DefaultTextStyle.of(context).style),
              maxLines: this.maxLines,
              textDirection: TextDirection.ltr,
            )..layout(maxWidth: constraints.maxWidth);

            final isOverflowing = textPainter.didExceedMaxLines;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  maxLines: maxLines,
                  overflow: TextOverflow.fade,
                ),
                if (isOverflowing)
                  GestureDetector(
                    onTap: () =>
                        context.read<ExpandableTextCubit>().toggleExpanded(),
                    child: Row(
                      children: [
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppColors.purpleColor,
                        ),
                        Text(
                          isExpanded
                              ? AppLocalization.of(context)
                                      .getTransatedValues('showLess') ??
                                  ''
                              : AppLocalization.of(context)
                                      .getTransatedValues('showMore') ??
                                  '',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppFonts.fontSize14,
                            color: AppColors.purpleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
