import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:vagarin_app/features/auth/pages/login_screen.dart';
import 'package:vagarin_app/features/onboarding/pages/onboarding_screen.dart';
import 'package:vagarin_app/features/register/pages/register_screen.dart';
import 'package:vagarin_app/features/auth/pages/signup_screen.dart';
import 'package:vagarin_app/features/auth/stores/auth_store.dart';
import 'package:vagarin_app/features/home/pages/home_screen.dart';
import 'package:vagarin_app/shared/injection_container.dart';

final _authListenable = ValueNotifier<bool>(false);

GoRouter setupRouter() {
  final authStore = getIt<AuthStore>();

  reaction(
    (_) => authStore.isAuthenticated,
    (bool isAuth) => _authListenable.value = isAuth,
  );

  return GoRouter(
    initialLocation: '/',
    refreshListenable: _authListenable,
    redirect: (BuildContext context, GoRouterState state) {
      final bool isAuthenticated = authStore.isAuthenticated;
      final String currentLocation = state.matchedLocation;

      final authRelatedRoutes = [
        '/',
        '/login',
        '/signup',
        '/register',
        '/onboarding',
      ];
      final bool isGoingToAuthRelatedRoute = authRelatedRoutes.contains(
        currentLocation,
      );

      if (!isAuthenticated) {
        return isGoingToAuthRelatedRoute ? null : '/';
      }

      if (isGoingToAuthRelatedRoute) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => OnboardingScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(path: '/signup', builder: (context, state) => SignupScreen()),
      GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    ],
  );
}
