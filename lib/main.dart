import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      _OptionCard(
        title: 'Ages 0-4\n  Book 1',
        icon: Icons.menu_book_outlined,
        onTap: () {},
      ),
      _OptionCard(
        title: 'Ages 0-4\n  Book 2',
        icon: Icons.menu_book_outlined,
        onTap: () {},
      ),
      _OptionCard(
        title: 'Ages 4-8\n  Book 1',
        icon: Icons.menu_book_outlined,
        onTap: () {},
      ),
      _OptionCard(
        title: 'Ages 4-8\n  Book 2',
        icon: Icons.menu_book_outlined,
        onTap: () {},
      ),
      _OptionCard(
        title: 'Ages 8-12\n    Book 1',
        icon: Icons.menu_book_outlined,
        onTap: () {},
      ),
      _OptionCard(
        title: 'Ages 8-12\n    Book 2',
        icon: Icons.menu_book_outlined,
        onTap: () {},
      ),
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Choose your child’s age:'),
        ),
        body: GridView.count(
          padding: const EdgeInsets.all(24),
          crossAxisCount: 2,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          children: cards,
        ),
      )
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.blue),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}