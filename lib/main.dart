import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/login.dart';
import 'pages/dashboard.dart';
import 'routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xrrpioappeetgnbsoaal.supabase.co',
    anonKey: 'sb_publishable_vIQ2dQmTQXezcFXHHCc61g_GNNtB7w2',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      // Check if user is logged in to decide initial route
      initialRoute: Supabase.instance.client.auth.currentSession == null
          ? AppRoutes.login
          : AppRoutes.dashboard,
      routes: {
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.dashboard: (context) => const DashboardPage(),
      },
    );
  }
}
