import 'package:flutter/material.dart';
import 'package:final_android_project/file_type.dart';
import 'book_details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FileType _selectedType = FileType.pdf;

  static const books = [
    'Luna and the Cloud Balloon',
    'Niko and the Moon Ladder',
    'Leo and the Wishing Feather',
    'Ellie and the Rainy Day Parade',
    "The Clockmaker's Apprentice",
    'The Forest Below the Floorboards',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose your child’s age:')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildToggle(),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(24),
              crossAxisCount: 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              children: books
                  .map((title) => _OptionCard(
                        title: title,
                        icon: _selectedType == FileType.pdf
                            ? Icons.picture_as_pdf
                            : Icons.article,
                        onTap: () => Navigator.push(
                          context,                              // <- now *inside* Navigator
                          MaterialPageRoute(
                            builder: (_) => BookDetailsScreen(
                                title: title, fileType: _selectedType),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return Center(
      child: SizedBox(
        width: 204,
        height: 40,
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: _selectedType == FileType.pdf
                  ? const Alignment(-1, 0)
                  : const Alignment(1, 0),
              duration: const Duration(milliseconds: 150),
              child: Container(
                width: 102,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            ToggleButtons(
              isSelected: [
                _selectedType == FileType.pdf,
                _selectedType == FileType.word,
              ],
              onPressed: (i) => setState(() =>
                  _selectedType = i == 0 ? FileType.pdf : FileType.word),
              fillColor: Colors.transparent,
              selectedColor: Colors.white,
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
              borderWidth: 0,
              constraints:
                  const BoxConstraints.tightFor(width: 102, height: 40),
              children: const [Text('PDF'), Text('Word')],
            ),
          ],
        ),
      ),
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
              Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
