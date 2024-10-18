// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/passwordVisibility/password_obscure_cubit.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/forgetPass_content.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/login_content.dart';

class LoginTab extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController passController;
  const LoginTab({
    required this.phoneController,
    required this.passController,
    super.key,
  });

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ObscureCubit(),
        ),
        BlocProvider(
          create: (context) => ValidateTextFieldBloc(),
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) => index == 0
                  ? LoginContent(
                      phoneController: widget.phoneController,
                      passController: widget.passController,
                      pageController: pageController,
                    )
                  : const ForgetPassContent(),
            ),
          ),
        ),
      ),
    );
  }
}
