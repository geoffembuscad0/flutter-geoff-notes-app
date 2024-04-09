import 'package:flutter/material.dart';
import 'package:flutter_geoff_notes_app/models/note_database.dart';
import 'package:flutter_geoff_notes_app/pages/intro_page.dart';
import 'package:flutter_geoff_notes_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NoteDatabase(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Isar Notes App',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const IntroPage(),
      
    );
  }
}
