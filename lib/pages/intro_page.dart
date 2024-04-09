import 'package:flutter/material.dart';
import 'package:flutter_geoff_notes_app/pages/notes_page.dart';
import 'package:lottie/lottie.dart';


class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NotesPage()),
      );
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Lottie.asset('assets/notes.json'),
      ),
    );
  }
}
