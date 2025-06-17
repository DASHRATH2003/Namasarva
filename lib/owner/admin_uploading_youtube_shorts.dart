// youtube short videos

// bus_booking_application

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class ShortVideoUploadPage extends StatefulWidget {
//   @override
//   _ShortVideoUploadPageState createState() => _ShortVideoUploadPageState();
// }
//
// class _ShortVideoUploadPageState extends State<ShortVideoUploadPage> {
//   final TextEditingController _urlController = TextEditingController();
//   final TextEditingController _titleController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   void _uploadShortVideo() async {
//     String videoUrl = _urlController.text.trim();
//     String videoTitle = _titleController.text.trim();
//
//     if (videoUrl.isNotEmpty && videoTitle.isNotEmpty) {
//       // Add short video details to the specified Firestore location
//       await _firestore
//           .collection('admin')
//           .doc('youtube_short')
//           .collection('shorts')
//           .add({
//         'url': videoUrl,
//         'title': videoTitle,
//       });
//
//       _urlController.clear();
//       _titleController.clear();
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Short video uploaded successfully!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter a short video URL and title.')),
//       );
//     }
//   }
//
//   void _navigateToViewShortVideos() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ShortVideoViewPage()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Upload YouTube Short Video')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _urlController,
//               decoration: InputDecoration(labelText: 'YouTube Short Video URL'),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(labelText: 'Short Video Title'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _uploadShortVideo,
//               child: Text('Upload Short Video'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _navigateToViewShortVideos,
//               child: Text('View Uploaded Shorts'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class ShortVideoViewPage extends StatefulWidget {
//   @override
//   _ShortVideoViewPageState createState() => _ShortVideoViewPageState();
// }
//
// class _ShortVideoViewPageState extends State<ShortVideoViewPage> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   String _getVideoId(String url) {
//     // Extract the video ID from the YouTube Shorts URL
//     final RegExp regExp = RegExp(
//       r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:shorts\/|(?:v|e(?:mbed)?|watch|.+\?v)=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
//       caseSensitive: false,
//     );
//     final match = regExp.firstMatch(url);
//     if (match != null) {
//       return match.group(1) ?? '';
//     }
//     return '';
//   }
//
//   void _playVideo(String videoUrl) async {
//     final videoId = _getVideoId(videoUrl);
//     if (videoId.isNotEmpty) {
//       final youtubeUrl = 'https://www.youtube.com/watch?v=$videoId';
//       if (await canLaunch(youtubeUrl)) {
//         await launch(youtubeUrl);
//       } else {
//         throw 'Could not launch $youtubeUrl';
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Trending Shorts')),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore
//             .collection('admin')
//             .doc('youtube_short')
//             .collection('shorts')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           final shorts = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: shorts.length,
//             itemBuilder: (context, index) {
//               final short = shorts[index];
//               final videoUrl = short['url'];
//               final videoId = _getVideoId(videoUrl);
//               final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
//
//               return GestureDetector(
//                 onTap: () => _playVideo(videoUrl),
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 8.0),
//                   child: Column(
//                     children: [
//                       Stack(
//                         children: [
//                           Image.network(
//                             thumbnailUrl,
//                             width: double.infinity,
//                             height: 200,
//                             fit: BoxFit.cover,
//                           ),
//                         ],
//                       ),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             short['title'] ?? 'No Title',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }




// hurry


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class ShortVideoUploadPage extends StatefulWidget {
  const ShortVideoUploadPage({super.key});

  @override
  _ShortVideoUploadPageState createState() => _ShortVideoUploadPageState();
}

class _ShortVideoUploadPageState extends State<ShortVideoUploadPage> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isUploading = false;

  Future<void> _uploadShortVideo() async {
    String videoUrl = _urlController.text.trim();
    String videoTitle = _titleController.text.trim();

    if (videoUrl.isEmpty || videoTitle.isEmpty) {
      _showSnackbar('Please enter both URL and title', Colors.red);
      return;
    }

    if (!_isValidYoutubeShortsUrl(videoUrl)) {
      _showSnackbar('Please enter a valid YouTube Shorts URL', Colors.red);
      return;
    }

    setState(() => _isUploading = true);
    try {
      await _firestore
          .collection('admin')
          .doc('youtube_short')
          .collection('shorts')
          .add({
        'url': videoUrl,
        'title': videoTitle,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _urlController.clear();
      _titleController.clear();
      _showSnackbar('Short video uploaded successfully!', Colors.green);
    } catch (e) {
      _showSnackbar('Error uploading short: ${e.toString()}', Colors.red);
    } finally {
      setState(() => _isUploading = false);
    }
  }

  bool _isValidYoutubeShortsUrl(String url) {
    final RegExp regExp = RegExp(
      r'^(https?:\/\/)?(www\.)?(youtube\.com|youtu\.be)\/(shorts\/)?([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );
    return regExp.hasMatch(url);
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _navigateToViewShortVideos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  ShortVideoViewPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Upload Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.short_text, color: Colors.red[700], size: 28),
                        const SizedBox(width: 8),
                        Text(
                          'Upload New Short',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _urlController,
                      decoration: InputDecoration(
                        labelText: 'YouTube Shorts URL',
                        hintText: 'https://youtube.com/shorts/...',
                        prefixIcon: Icon(Icons.link, color: Colors.red[700]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Short Video Title',
                        prefixIcon: Icon(Icons.title, color: Colors.red[700]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isUploading ? null : _uploadShortVideo,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                        ),
                        child: _isUploading
                            ? const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        )
                            : const Text(
                          'UPLOAD SHORT',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // View Shorts Section
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: _navigateToViewShortVideos,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red[700]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_circle_fill, color: Colors.red[700]),
                    const SizedBox(width: 8),
                    Text(
                      'VIEW UPLOADED SHORTS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShortVideoViewPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   ShortVideoViewPage({super.key});

  Future<void> _playVideo(String videoUrl) async {
    if (await canLaunch(videoUrl)) {
      await launch(videoUrl);
    } else {
      throw 'Could not launch $videoUrl';
    }
  }

  String _getVideoId(String url) {
    final RegExp regExp = RegExp(
      r'^(https?:\/\/)?(www\.)?(youtube\.com|youtu\.be)\/(shorts\/)?([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(url);
    return match?.group(5) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Shorts'),
        centerTitle: true,
        backgroundColor: Colors.red[700],
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('admin')
            .doc('youtube_short')
            .collection('shorts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading shorts'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.short_text, size: 60, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No shorts uploaded yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          final shorts = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: shorts.length,
            itemBuilder: (context, index) {
              final short = shorts[index];
              final videoUrl = short['url'];
              final videoId = _getVideoId(videoUrl);
              final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _playVideo(videoUrl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Thumbnail with play button overlay
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(
                              thumbnailUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Icon(Icons.error, color: Colors.grey),
                                  ),
                                );
                              },
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(12),
                              child: const Icon(
                                Icons.play_arrow,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Video info
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              short['title'] ?? 'No Title',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.short_text, size: 16, color: Colors.red),
                                const SizedBox(width: 4),
                                Text(
                                  'YouTube Short',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
















