import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/toolTip_shape.dart';

class ToolTipPopUp extends StatelessWidget {
  const ToolTipPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 40),
      icon: Icon(
        CupertinoIcons.question_circle,
        color: AppColors.grey1Color,
      ),
      shape: const TooltipShape(),
      itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: Text(
            AppLocalization.of(context).getTransatedValues('surveyDesc') ?? '',
          ),
        ),
      ],
    );
  }
}
