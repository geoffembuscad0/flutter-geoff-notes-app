import 'package:flutter/material.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/feature_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _features = [
    {
      'title': 'Profile',
      'description': 'Manage your personal information',
      'icon': Icons.person,
    },
    {
      'title': 'Settings',
      'description': 'Configure app preferences',
      'icon': Icons.settings,
    },
    {
      'title': 'Analytics',
      'description': 'View your statistics',
      'icon': Icons.analytics,
    },
    {
      'title': 'Messages',
      'description': 'Check your inbox',
      'icon': Icons.message,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Welcome Back!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _features.length,
                itemBuilder: (context, index) {
                  return FeatureCard(
                    title: _features[index]['title'],
                    description: _features[index]['description'],
                    icon: _features[index]['icon'],
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
