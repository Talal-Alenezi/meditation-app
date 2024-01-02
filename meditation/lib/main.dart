import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation/pages/exercises.dart';
import 'package:meditation/pages/home_page.dart';
import 'package:meditation/pages/profile_page.dart';
import 'package:meditation/pages/sessions.dart';
import 'package:meditation/pages/signin_page.dart';
import 'package:meditation/pages/signup_page.dart';
import 'package:meditation/pages/tips_page.dart';
import 'package:meditation/providers/auth_povider.dart';
import 'package:meditation/providers/exercises_provider.dart';
import 'package:meditation/providers/sessions_provider.dart';
import 'package:meditation/providers/tips_provider.dart';
import 'package:meditation/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => TipsProvider()),
    ChangeNotifierProvider(create: (context) => ExercisesProvider()),
    ChangeNotifierProvider(create: (context) => SessionProvider())
  ], child: MyApp()));
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/homepage',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: '/yogaVideos',
      name: "yogaVideos",
      builder: (BuildContext context, GoRouterState state) {
        return Exercises();
      },
    ),
    GoRoute(
      name: "signup",
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return SignUpPage();
      },
    ),
    GoRoute(
      path: '/signin',
      builder: (BuildContext context, GoRouterState state) {
        return SignInPage();
      },
    ),
    GoRoute(
      name: "profile",
      path: '/profile',
      builder: (BuildContext context, GoRouterState state) {
        return ProfilePage();
      },
    ),
    GoRoute(
      name: "tips",
      path: '/tips',
      builder: (BuildContext context, GoRouterState state) {
        return TipsPage();
      },
    ),
    GoRoute(
      name: "meditation",
      path: '/meditation',
      builder: (BuildContext context, GoRouterState state) {
        return Sessions();
      },
    ),
    // GoRoute(
    //   path: '/',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return SplashScreen();
    //   },
    // ),
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: iconbool ? lightTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
