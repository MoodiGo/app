import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodigo_app/core/router/route_paths.dart';
import 'package:moodigo_app/core/router/routes.dart';
import 'package:moodigo_app/providers/auth_state_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final isLoggedIn = ref.watch(authStateProvider).valueOrNull != null;
  
  return GoRouter(
  routes: appRoutes,

  debugLogDiagnostics: true,

  initialLocation: isLoggedIn ? RoutePaths.home : RoutePaths.signIn,

  redirect: (context, state) {
    final isGoingToSignInPage = state.matchedLocation == RoutePaths.signIn;

    final isGoingToSignUpPage = state.matchedLocation == RoutePaths.signUp;

    final isGoingToProtectedRoute = state.matchedLocation.startsWith('/protected/');

    if(!isLoggedIn && isGoingToProtectedRoute){
      return RoutePaths.signIn;
    }

    if(isLoggedIn && (isGoingToSignInPage || isGoingToSignUpPage)){
      return RoutePaths.home;
    }
  },
  errorBuilder: (context, state) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Text('Error 404 - Page not found'),
                SizedBox(height: 20),
                Text('The page you are looking for does not exist. ${state.error}'),
              ],
            ),
          ),
        ],
      ),
    );
  },
);
});