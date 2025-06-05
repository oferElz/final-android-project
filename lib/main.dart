import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

enum FileType { pdf, word }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FileType _selectedType = FileType.pdf;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _OptionCard(
        title: 'Luna and the Cloud Balloon',
        icon: _selectedType == FileType.pdf ? Icons.picture_as_pdf : Icons.article,
        onTap: () {},
      ),
      _OptionCard(
        title: 'Niko and the Moon Ladder',
        icon: _selectedType == FileType.pdf ? Icons.picture_as_pdf : Icons.article,
        onTap: () {},
      ),
      _OptionCard(
        title: 'Leo and the Wishing Feather',
        icon: _selectedType == FileType.pdf ? Icons.picture_as_pdf : Icons.article,
        onTap: () {},
      ),
      _OptionCard(
        title: 'Ellie and the Rainy Day Parade',
        icon: _selectedType == FileType.pdf ? Icons.picture_as_pdf : Icons.article,
        onTap: () {},
      ),
      _OptionCard(
        title: "The Clockmaker's Apprentice",
        icon: _selectedType == FileType.pdf ? Icons.picture_as_pdf : Icons.article,
        onTap: () {},
      ),
      _OptionCard(
        title: 'The Forest Below the Floorboards',
        icon: _selectedType == FileType.pdf ? Icons.picture_as_pdf : Icons.article,
        onTap: () {},
      ),
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Choose your child’s age:'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: 204,
                height: 40,
                child: Stack(
                  children: [
                    AnimatedAlign(
                      alignment: _selectedType == FileType.pdf
                          ? Alignment(-1, 0)
                          : Alignment(1, 0),
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
                      onPressed: (index) {
                        setState(() {
                          _selectedType =
                              index == 0 ? FileType.pdf : FileType.word;
                        });
                      },
                      fillColor: Colors.transparent,
                      selectedColor: Colors.white,
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                      borderWidth: 0,
                      constraints: const BoxConstraints.tightFor(
                        width: 102,
                        height: 40,
                      ),
                      children: const [
                        Text('PDF'),
                        Text('Word'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(24),
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                children: cards,
              ),
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
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
