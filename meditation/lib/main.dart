import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation/pages/home_page.dart';
import 'package:meditation/pages/signin_page.dart';
import 'package:meditation/pages/signup_page.dart';
import 'package:meditation/providers/auth_povider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
      child: MyApp()));
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/homepage',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),
    // GoRoute(
    //   path: '/add',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return AddTodoPage();
    //   },
    // ),
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
    // GoRoute(
    //   path: '/',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return SplashScreen();
    //   },
    // ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
