import 'package:flutter/material.dart';
import 'package:notes_app_supabase/app_drawer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: const AppDrawer(), // The Side Menu
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '“Waste no more time arguing what a good man should be. Be one.”',
            ),
            const SizedBox(height: 8),
            Text(
              '- Marcus Aurelius',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
