import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/login_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.leadingTitle(
        title: AppLocalization.of(context).getTransatedValues('profile') ?? '',
        centerTitle: true,
      ),
      body: ListView(
        children: [
          //card for login
          const LoginCard(),
          //feature card
          ProfileCard(
            cardList: profileCard,
          ),
          //feature card

          ProfileCard(
            cardList: profile2Card,
            isArrow: false,
          ),
        ],
      ),
    );
  }
}
