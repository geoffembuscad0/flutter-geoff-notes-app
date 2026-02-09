import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Dashboard'),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
        IconButton(
          icon: const CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
