import 'package:go_router/go_router.dart';
import 'package:moodigo_app/core/router/route_paths.dart';
import 'package:moodigo_app/main.dart';

final List<GoRoute> appRoutes = [
  GoRoute(
    path: RoutePaths.home,
    builder: (context, state) => const TestHomePage(), // só exemplo
  ),

  GoRoute(
    path: RoutePaths.signIn,
    builder: (context, state) => const TestSigninPage(), // só exemplo
  ),
];