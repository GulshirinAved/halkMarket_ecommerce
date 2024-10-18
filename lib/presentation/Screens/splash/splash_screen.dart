import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/internetConnection/internet_connection_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/network_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  Timer? _animationTimer;
  double _containerOpacity = 0.0;
  int _containerSize = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller.forward();
    _showAnimation();
  }

//animation
  void _showAnimation() {
    _animationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _containerSize = 2;
          _containerOpacity = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InternetConnectionBloc()..add(const InternetListenEvent()),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: BlocListener<InternetConnectionBloc, InternetConnectionState>(
          listener: (context, state) {
            if (state is InternetConnectedState) {
              Future.delayed(const Duration(seconds: 4), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBar(),
                  ),
                );
              });
            } else if (state is InternetNotConnectedState) {
              showingDialog(context);
            }
          },
          child: Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastOutSlowIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastOutSlowIn,
                height: MediaQuery.of(context).size.height / _containerSize,
                width: MediaQuery.of(context).size.width / _containerSize,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                child: Image.asset(
                  halkMarketImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationTimer?.cancel();
    super.dispose();
  }
}
