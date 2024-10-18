import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/userProfile/user_profile_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';

import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/login_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/privateRoom_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfileBloc _userProfileBloc;
  @override
  void initState() {
    super.initState();
    _userProfileBloc = UserProfileBloc()..add(GetUserData());
  }

  @override
  void dispose() {
    _userProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _userProfileBloc,
      child: Scaffold(
        appBar: CustomAppBar.leadingTitle(
          title:
              AppLocalization.of(context).getTransatedValues('profile') ?? '',
          centerTitle: true,
          needBoxshadow: false,
        ),
        body: Column(
          children: [
            //card for login
            AuthProvider().getAccessToken() == null
                ? const LoginCard()
                : const PrivateCard(),

            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  //feature card not authenticated
                  ProfileCard(
                    cardList: AuthProvider().getAccessToken() == null
                        ? profileCard
                        : longProfileCard,
                  ),
                  //feature card authenticated

                  ProfileCard(
                    cardList: profile2Card,
                    isArrow: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
