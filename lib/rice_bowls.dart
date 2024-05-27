import 'package:flutter/material.dart';

class RiceBowls extends StatelessWidget {
  const RiceBowls({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          title: const Text('Beef Rice Bowl'),
          subtitle: const Text('Beef, rice, and vegetables'),
          leading: const Icon(Icons.fastfood),
        ),
        ListTile(
          title: const Text('Chicken Rice Bowl'),
          subtitle: const Text('Chicken, rice, and vegetables'),
          leading: const Icon(Icons.fastfood),
        ),
        ListTile(
          title: const Text('Pork Rice Bowl'),
          subtitle: const Text('Pork, rice, and vegetables'),
          leading: const Icon(Icons.fastfood),
        ),
      ],
    );
  }
}
