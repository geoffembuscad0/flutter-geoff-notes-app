import 'package:go_router/go_router.dart';

import '../../presentation/screens/home_screen/home_screen.dart';
import '../../presentation/screens/login_screen/login_screen.dart';

final router = GoRouter(
  // Set the initial location
  initialLocation: AppRoutes.loginScreen,
  routes: [
    GoRoute(
      path: AppRoutes.loginScreen,
      // Uncomment the following line to use the LoginScreen widget
      builder: (context, state) => LoginScreen(),
    ),
    // GoRoute(
    //   path: AppRoutes.registerScreen,
    //   builder: (context, state) => RegisterScreen(),
    // ),
    GoRoute(
      path: AppRoutes.homeScreen,
      builder: (context, state) => HomeScreen(),
    ),
  ],
);

abstract class AppRoutes {
  static const loginScreen = '/login';
  static const registerScreen = '/register';
  static const homeScreen = '/home';
}
