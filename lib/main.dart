import 'package:bilimlar_bellashuvi/presentation/auth/confirm/ConfirmScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/auth/login/LoginScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/auth/login/LoginWithPhoneScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/auth/reset/ResetCodeScreeen.dart';
import 'package:bilimlar_bellashuvi/presentation/auth/reset/SetPasswodScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/auth/signup/SignUpScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/intro/IntroScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/language/LanguageScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/main/MainScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/settings/EditDataScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/splash/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'presentation/auth/reset/ConfirmCodeScreen.dart';
import 'presentation/auth/confirm/ConfirmStaticScreen.dart';

void main() {
  runApp(MaterialApp.router(
    routerConfig: router,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    })),
  ));
}

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/language',
      builder: (context, state) {
        return LanguageScreen();
      },
    ),
    GoRoute(
      path: '/intro',
      builder: (context, state) {
        return const IntroScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
        path: '/login_phone',
        builder: (context, state) {
          return const LoginWithPhoneScreen();
        }),
    GoRoute(
      path: '/reset',
      builder: (context, state) {
        return const ResetCodeScreen();
      },
    ),
    GoRoute(
      path: '/confirm_code',
      builder: (context, state) {
        Map<String, String> args = state.extra as Map<String, String>;
        return ConfirmCodeScreen(phone: args['phone'] ?? '');
      },
    ),
    GoRoute(
      path: '/setpasswordscreen',
      builder: (context, state) {
        return SetPasswordScreen(token: state.queryParameters['token'] ?? '');
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      path: '/confirm',
      builder: (context, state) {
        return ConfirmScreen(
            timer: int.parse(state.pathParameters['timer'] ?? '40'));
      },
    ),
    GoRoute(
      path: '/confirm_page',
      builder: (context, state) {
        return ConfirmVerificationScreen(
            token: state.queryParameters['token'] ?? '');
      },
    ),
    GoRoute(
      path: '/main_page',
      builder: (context, state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) {
        return const EditScreen();
      },
    ),
  ],
);
