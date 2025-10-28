import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:vagarin_app/core/router/app_routes.dart';
import 'package:vagarin_app/features/auth/pages/login_screen.dart';
import 'package:vagarin_app/features/onboarding/pages/onboarding_screen.dart';
import 'package:vagarin_app/features/register/pages/register_screen.dart';
import 'package:vagarin_app/features/auth/pages/signup_screen.dart';
import 'package:vagarin_app/features/auth/stores/auth_store.dart';
import 'package:vagarin_app/features/home/pages/home_screen.dart';
import 'package:vagarin_app/shared/injection_container.dart';

class AuthStateListenable extends ChangeNotifier {
  final AuthStore _authStore = getIt<AuthStore>();
  late final ReactionDisposer _disposer;

  AuthStateListenable() {
    _disposer = reaction((_) => _authStore.isAuthenticated, (bool isAuth) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }
}

GoRouter setupRouter() {
  final authStore = getIt<AuthStore>();
  final authStateListenable = getIt<AuthStateListenable>();

  return GoRouter(
    initialLocation: '/',
    refreshListenable: authStateListenable,
    redirect: (BuildContext context, GoRouterState state) {
      final bool isAuthenticated = authStore.isAuthenticated;
      final String currentLocation = state.matchedLocation;
      print(
        '>>> GoRouter Redirect Check (Web?): IsAuth=$isAuthenticated, Location=$currentLocation',
      );

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
        name: AppRoutes.onboarding,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: AppRoutes.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: AppRoutes.signup,
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        path: '/register',
        name: AppRoutes.register,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        name: AppRoutes.home,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
