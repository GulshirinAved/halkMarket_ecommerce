import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/language/language_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/data/api_providers/customHttp_provider.dart';
import 'package:halkmarket_ecommerce/data/api_providers/notification_provider.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/splash/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> backgroundNotificationHandler(RemoteMessage message) async {
  if (message.notification != null) {
    await FCMConfig().sendNotification(
      body: message.notification?.body ?? 'No body',
      title: message.notification?.title ?? 'No title',
    );
  } else {
    debugPrint('Received data-only message: ${message.data}');
  }
}

void main() async {
  HttpOverrides.global = CustomHttpOverrides();
  final dio = Dio();
  dio.httpClientAdapter = IOHttpClientAdapter()
    ..onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarColor: AppColors.whiteColor,
      statusBarColor: AppColors.whiteColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBi5Mp3cDOF3ee_G00YIAi7u8c_3QFqWuI',
      appId: '1:432591314406:android:27bf4a2ecdc8b3007e0a27',
      messagingSenderId: '432591314406',
      projectId: 'halk-market-352cb',
    ),
  );
  await Hive.initFlutter();
  await Hive.openBox('favBox');
  await Hive.openBox('cartBox');
  await Hive.openBox('lang');
  await Hive.openBox('popularCategory');
  await Hive.openBox('homeProducts');
  await Hive.openBox('homeData');
  await Hive.openBox('auth');
  await Hive.openBox('addressBox');
  await Hive.openBox('cardBox');

  final Box homeBox = Hive.box('homeProducts');
  final Box homeDataBox = Hive.box('homeData');
  final Box popularCategoryBox = Hive.box('popularCategory');

  await homeBox.clear();
  await homeDataBox.clear();
  await popularCategoryBox.clear();
  await FCMConfig().requestPermission();
  await FCMConfig().initAwesomeNotification();
  FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);

  log(AuthProvider().getAccessToken().toString());
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    String? token;
    FirebaseMessaging.instance.getToken().then((value) {
      token = value;
      log('it is fcmtoken $token');
    });
    print(AuthProvider().getAccessToken());
    FCMConfig().requestPermission();
    FCMConfig().subscribeToTopic('halk_market');

    // Listen for foreground messages and handle notifications safely
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        FCMConfig().sendNotification(
          body: message.notification?.body ?? 'No body',
          title: message.notification?.title ?? 'No title',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: BlocProvider(
        create: (context) => LanguageBloc()..add(InitialLanguageEvent()),
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            String? locale;
            if (state is ChangeLanguageState) {
              locale = state.languageCode;
            }

            return MaterialApp(
              title: 'Halk Market',
              home: const SplashScreen(),
              debugShowCheckedModeBanner: false,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.noScaling),
                child: child!,
              ),
              locale: Locale(locale ?? 'tr'),
              supportedLocales: const [
                Locale('ru'),
                Locale('tr'),
              ],
              localizationsDelegates: const [
                AppLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (deviceLocale != null) {
                    if (deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }
                }
                return supportedLocales.first;
              },
              theme: lightTheme(),
            );
          },
        ),
      ),
    );
  }
}
