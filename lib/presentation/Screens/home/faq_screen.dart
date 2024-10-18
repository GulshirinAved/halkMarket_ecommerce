import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/home/expansionPanelExpand/expansion_panel_expand_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/profile/faq/get_faq_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExpansionPanelExpandBloc(),
        ),
        BlocProvider(
          create: (context) => GetFaqBloc()..add(GetFaqList()),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar.leadingTitle(
          title: AppLocalization.of(context).getTransatedValues('faq') ?? '',
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) {
            return Container(
              color: AppColors.grey2Color,
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<GetFaqBloc, GetFaqState>(
                    builder: (context, state) {
                      if (state is GetFaqLoaded) {
                        return ExpansionPanelList.radio(
                          elevation: 0,
                          materialGapSize: 5,
                          expandedHeaderPadding: EdgeInsets.zero,
                          dividerColor: AppColors.grey2Color,
                          expansionCallback: (panelIndex, isExpanded) => context
                              .read<ExpansionPanelExpandBloc>()
                              .add(PressEvent(panelIndex: panelIndex)),
                          children: state.faqList.map(
                            (entry) {
                              return ExpansionPanelRadio(
                                backgroundColor: AppColors.whiteColor,
                                value: entry.question!,
                                headerBuilder: (context, isExpanded) =>
                                    ListTile(
                                  trailing: Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: AppColors.purpleColor,
                                  ),
                                  title: Text(
                                    entry.question!,
                                    style: TextStyle(
                                      color: AppColors.darkPurpleColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: AppFonts.fontSize16,
                                    ),
                                  ),
                                ),
                                body: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 13),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: ClickableText(
                                    fullText: entry.answer!,
                                    clickableText: 'halkmarket.com.tm',
                                    onTap: () {},
                                  ),
                                ),
                                canTapOnHeader: true,
                              );
                            },
                          ).toList(),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ClickableText extends StatelessWidget {
  final String fullText;
  final String clickableText;
  final VoidCallback onTap;

  const ClickableText({
    required this.fullText,
    required this.clickableText,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> spans = [];
    String remainingText = fullText;
    while (remainingText.contains(clickableText)) {
      final index = remainingText.indexOf(clickableText);
      if (index > 0) {
        spans.add(TextSpan(text: remainingText.substring(0, index)));
      }
      spans.add(
        TextSpan(
          text: clickableText,
          style: TextStyle(color: AppColors.blueColor),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      );
      remainingText = remainingText.substring(index + clickableText.length);
    }
    spans.add(TextSpan(text: remainingText));

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: spans,
      ),
    );
  }
}
