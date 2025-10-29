import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:vagarin_app/core/router/app_routes.dart';
import 'package:vagarin_app/features/auth/pages/login_screen.dart';
import 'package:vagarin_app/features/onboarding/pages/onboarding_screen.dart';
import 'package:vagarin_app/features/register/presentation/pages/register_screen.dart';
import 'package:vagarin_app/features/auth/pages/signup_screen.dart';
import 'package:vagarin_app/features/auth/stores/auth_store.dart';
import 'package:vagarin_app/features/home/pages/home_screen.dart';
import 'package:vagarin_app/shared/injection_container.dart';

class AuthStateListenable extends ChangeNotifier {
  final AuthStore _authStore = getIt<AuthStore>();
  late final List<ReactionDisposer> _disposers;

  AuthStateListenable() {
    _disposers = [
      reaction((_) => _authStore.isAuthenticated, (_) => notifyListeners()),
      reaction((_) => _authStore.registrationStatus, (_) => notifyListeners()),
      reaction((_) => _authStore.isLoading, (_) => notifyListeners()),
    ];
  }

  @override
  void dispose() {
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter setupRouter() {
  final authStore = getIt<AuthStore>();
  final authStateListenable = getIt<AuthStateListenable>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: authStateListenable,
    redirect: (context, state) {
      final isAuthenticated = authStore.isAuthenticated;
      final status = authStore.registrationStatus;
      final isLoading = authStore.isLoading;

      final loc = state.matchedLocation;
      const authRoutes = ['/', '/login', '/signup', '/register', '/onboarding'];

      // enquanto carrega OU não sabe se precisa registrar, não decide
      if (isLoading || status == RegistrationStatus.unknown) return null;

      if (!isAuthenticated) {
        return authRoutes.contains(loc) ? null : '/';
      }

      if (status == RegistrationStatus.required) {
        return loc == '/register' ? null : '/register';
      }

      // autenticado + registrado
      return authRoutes.contains(loc) ? '/home' : null;
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
