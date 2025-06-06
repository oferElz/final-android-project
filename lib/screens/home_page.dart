import 'package:flutter/material.dart';
import 'package:final_android_project/file_type.dart';
import 'book_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FileType _selectedType = FileType.pdf;

  static const _books = [
    'Luna and the Cloud Balloon',
    'Niko and the Moon Ladder',
    'Leo and the Wishing Feather',
    'Ellie and the Rainy Day Parade',
    "The Clockmaker's Apprentice",
    'The Forest Below the Floorboards',
  ];

  static const _images = [
    'assets/zeroToFour.png',
    'assets/zeroToFour.png',
    'assets/fourToEight.png',
    'assets/fourToEight.png',
    'assets/eightToTwelve.png',
    'assets/eightToTwelve.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:const Color.fromARGB(122, 172, 118, 57),
        child: Column(
          children: [
            const SizedBox(height: 45),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                    fontSize: 20, color: Colors.white),
                children: [
                  const TextSpan(
                    text: 'Welcome to our \nKids book download platform\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    
                  ),
                  const TextSpan(
                    text: 'Select a format, then click a book\nto see its description and download it.\nTo go back to the homepage, just tap the back arrow.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 5),
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                children: _books.asMap().entries.map((entry) {
                  final i = entry.key;
                  final title = entry.value;
                  return _OptionCard(
                    title: title,
                    imagePath: _images[i],
                    icon: _selectedType == FileType.pdf
                        ? Image.asset(
                          'assets/pdf_logo.png',
                          width: 20,
                          height: 20,
                        )
                      : Image.asset(
                          'assets/word_logo.png',
                          width: 20,
                          height: 20,
                        ),
                    onTap: () => _openBook(context, title),
                  );
                }).toList(),
              ),
            ),
            _buildToggle(),
            const SizedBox(height: 20),
          ],
        ),
      )
    );
  }
  
Future<void> _openBook(BuildContext context, String title) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  try {
    // 1️⃣  Fetch the Firestore doc here
    final snap = await FirebaseFirestore.instance
        .collection('books')
        .where('title', isEqualTo: title)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) throw 'Book not found';

    final data       = snap.docs.first.data();
    final coverUrl   = data['cover_url']   as String? ?? '';
    final description= data['description'] as String? ?? '';
    final pdfUrl     = data['pdf_url']     as String? ?? '';
    final wordUrl    = data['word_url']    as String? ?? '';
    final chosenUrl  = _selectedType == FileType.pdf ? pdfUrl : wordUrl;

    // 2️⃣  Pre-cache the cover image
    if (coverUrl.isNotEmpty && mounted) {
      await precacheImage(NetworkImage(coverUrl), context);
    }

    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop(); // close loader

    // 3️⃣  Push details screen with all ready-made data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookDetailsScreen(
          title:       title,
          description: description,
          coverUrl:    coverUrl,
          chosenUrl:   chosenUrl,
          fileType:    _selectedType,
        ),
      ),
    );
  } catch (e) {
    if (mounted) Navigator.of(context, rootNavigator: true).pop();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Failed: $e')));
  }
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
                  color: const Color.fromARGB(121, 104, 71, 34),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            ToggleButtons(
              isSelected: [
                _selectedType == FileType.pdf,
                _selectedType == FileType.word,
              ],
              onPressed: (i) => setState(
                  () => _selectedType = i == 0 ? FileType.pdf : FileType.word),
              fillColor: Colors.transparent,
              selectedColor: const Color.fromARGB(255, 88, 80, 80),
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
    required this.imagePath,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String imagePath;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, right: 10, left: 10),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 0, 0, 0),
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black54,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 3,
                bottom: 3,
                child: icon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
