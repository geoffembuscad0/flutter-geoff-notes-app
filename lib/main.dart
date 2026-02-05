import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/const/app_constant.dart';
import 'package:provider/provider.dart';

import 'app/config/size_config.dart';
import 'app/enum/enum.dart';
import 'app/providers/app_providers.dart';
import 'app/routes/app_routes.dart';
import 'core/notifiers/theme/theme_notifiers.dart';
import 'init.dart';

void main() async {
  await init();
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
