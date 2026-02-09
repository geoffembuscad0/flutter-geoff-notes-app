import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/const/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/config/size_config.dart';
import 'app/enum/enum.dart';
import 'app/providers/app_providers.dart';
import 'app/routes/app_routes.dart';
import 'core/notifiers/theme/theme_notifiers.dart';
import 'init.dart';

void main() async {
  await init();
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xrrpioappeetgnbsoaal.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhycnBpb2FwcGVldGduYnNvYWFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgzNzE2NTcsImV4cCI6MjA4Mzk0NzY1N30.EZBvbw23HBizBp4mspxzDyeIalHT3yS2m74jRyv_4Go',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiProvider(
      providers: AppProvider.providers,
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppConstant.appName,
            routerConfig: router,
            theme: FlexThemeData.light(scheme: FlexScheme.brandBlue),
            darkTheme: FlexThemeData.dark(scheme: FlexScheme.brandBlue),
            themeMode: switch (themeNotifier.themeMode) {
              AppThemeMode.light => ThemeMode.light,
              AppThemeMode.dark => ThemeMode.dark,
              AppThemeMode.system => ThemeMode.system,
            },
          );
        },
      ),
    );
  }
}
