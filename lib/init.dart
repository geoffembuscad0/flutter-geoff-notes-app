import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/services/service_locator.dart';

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator serviceLocator = ServiceLocator();
  await serviceLocator.initialize();
}
