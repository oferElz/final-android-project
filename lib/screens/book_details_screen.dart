import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_android_project/file_type.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

// ─────────────────────────── download helper ───────────────────────────
enum DownloadStatus { notDownloaded, downloading, downloaded }

class DownloadButton extends StatefulWidget {
  const DownloadButton({super.key, required this.url});
  final String url;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  DownloadStatus _status = DownloadStatus.notDownloaded;
  double _progress = 0;               // 0.0 – 1.0
  String? _localPath;                 // where we saved it

  Future<void> _startDownload() async {
    setState(() {
      _status = DownloadStatus.downloading;
      _progress = 0;
    });

    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = widget.url.split('/').last.split('?').first;
      final savePath = '${dir.path}/$fileName';

      await Dio().download(
        widget.url,
        savePath,
        onReceiveProgress: (r, t) {
          if (t != -1) {
            setState(() => _progress = r / t);
          }
        },
      );

      if (!mounted) return;
      setState(() {
        _status = DownloadStatus.downloaded;
        _localPath = savePath;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Download failed: $e')));
      setState(() => _status = DownloadStatus.notDownloaded);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_status) {
      case DownloadStatus.notDownloaded:
        return ElevatedButton(
          onPressed: _startDownload,
          child: const Text('DOWNLOAD'),
        );

      case DownloadStatus.downloading:
        return SizedBox(
          width: 48,
          child: LinearProgressIndicator(value: _progress),
        );

      case DownloadStatus.downloaded:
        return ElevatedButton(
          onPressed: () {
            if (_localPath != null) OpenFile.open(_localPath!);
          },
          child: const Text('OPEN'),
        );
    }
  }
}
// ───────────────────────── Book details screen ─────────────────────────
class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({
    super.key,
    required this.title,
    required this.fileType,
  });

  final String title;
  final FileType fileType;

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchDoc() {
    return FirebaseFirestore.instance
        .collection('books')
        .where('title', isEqualTo: title)
        .limit(1)
        .get()
        .then((snap) => snap.docs.first);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _fetchDoc(),
      builder: (context, snap) {
        if (snap.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: Center(child: Text('Error: ${snap.error}')),
          );
        }
        if (!snap.hasData) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        final data = snap.data!.data()!;
        final coverUrl = data['cover_url'] as String? ?? '';
        final description = data['description'] as String? ?? '';
        final chosenUrl = fileType == FileType.pdf
            ? data['pdf_url'] as String? ?? ''
            : data['word_url'] as String? ?? '';

        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                  child:
                      Container(color: const Color.fromARGB(188, 77, 46, 11))),
              if (coverUrl.isNotEmpty)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 400,
                    child: Image.network(
                      coverUrl,
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    24,
                    MediaQuery.of(context).padding.top + 56,
                    24,
                    24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 370),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          children: [
                            const TextSpan(
                              text: 'Title: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: title),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          children: [
                            const TextSpan(
                              text: 'Description: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: description),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      DownloadButton(url: chosenUrl),
                      const SizedBox(height: 8),
                      Text(
                        'Chosen format: ${fileType.name.toUpperCase()}',
                        style: const TextStyle(
                            fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                left: 8,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
