// youtube long videos with youtube

// bus_booking_application

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class AdminUploadingYoutubeVideosScreen extends StatefulWidget {
//   @override
//   _AdminUploadingYoutubeVideosScreenState createState() => _AdminUploadingYoutubeVideosScreenState();
// }
//
// class _AdminUploadingYoutubeVideosScreenState extends State<AdminUploadingYoutubeVideosScreen> {
//   final TextEditingController _urlController = TextEditingController();
//   final TextEditingController _titleController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   void _uploadVideo() async {
//     String videoUrl = _urlController.text.trim();
//     String videoTitle = _titleController.text.trim();
//
//     if (videoUrl.isNotEmpty && videoTitle.isNotEmpty) {
//       // Add video details to the specified Firestore location
//       await _firestore
//           .collection('admin')
//           .doc('youtube_video')
//           .collection('videos')
//           .add({
//         'url': videoUrl,
//         'title': videoTitle,
//       });
//
//       _urlController.clear();
//       _titleController.clear();
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Video uploaded successfully!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter a video URL and title.')),
//       );
//     }
//   }
//
//   void _navigateToViewVideos() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => VideoViewPage()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _urlController,
//               decoration: InputDecoration(labelText: 'YouTube Video URL'),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(labelText: 'Video Title'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _uploadVideo,
//               child: Text('Upload Video'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _navigateToViewVideos,
//               child: Text('View Uploaded Videos'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class VideoViewPage extends StatefulWidget {
//   @override
//   _VideoViewPageState createState() => _VideoViewPageState();
// }
//
// class _VideoViewPageState extends State<VideoViewPage> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   void _playVideo(String videoUrl) async {
//     // Open the YouTube video URL in the device's default browser
//     if (await canLaunch(videoUrl)) {
//       await launch(videoUrl);
//     } else {
//       throw 'Could not launch $videoUrl';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Trending Videos'),
//       backgroundColor: Colors.pinkAccent,),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore
//             .collection('admin')
//             .doc('youtube_video')
//             .collection('videos')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           final videos = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: videos.length,
//             itemBuilder: (context, index) {
//               final video = videos[index];
//               final videoUrl = video['url'];
//               final videoId = _getVideoId(videoUrl);
//               final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
//
//               return GestureDetector(
//                 onTap: () => _playVideo(videoUrl),
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 8.0),
//                   child: Column(
//                     children: [
//                       // Display video title if available
//                       if (video['title'] != null)
//                       // Stack for thumbnail
//                       Stack(
//                         children: [
//                           // Display video thumbnail
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
//                             video['title'],
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
//
//   String _getVideoId(String url) {
//     // Extract the video ID from the YouTube URL
//     final RegExp regExp = RegExp(
//       r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?|watch|.+\?v)=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
//       caseSensitive: false,
//     );
//     final match = regExp.firstMatch(url);
//     if (match != null) {
//       return match.group(1) ?? '';
//     }
//     return '';
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }

// hurry

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class AdminUploadingYoutubeVideosScreen extends StatefulWidget {
  const AdminUploadingYoutubeVideosScreen({super.key});

  @override
  _AdminUploadingYoutubeVideosScreenState createState() =>
      _AdminUploadingYoutubeVideosScreenState();
}

class _AdminUploadingYoutubeVideosScreenState
    extends State<AdminUploadingYoutubeVideosScreen> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isUploading = false;

  Future<void> _uploadVideo() async {
    String videoUrl = _urlController.text.trim();
    String videoTitle = _titleController.text.trim();

    if (videoUrl.isEmpty || videoTitle.isEmpty) {
      _showSnackbar('Please enter both URL and title', Colors.red);
      return;
    }

    if (!_isValidYoutubeUrl(videoUrl)) {
      _showSnackbar('Please enter a valid YouTube URL', Colors.red);
      return;
    }

    setState(() => _isUploading = true);
    try {
      await _firestore
          .collection('admin')
          .doc('youtube_video')
          .collection('videos')
          .add({
        'url': videoUrl,
        'title': videoTitle,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _urlController.clear();
      _titleController.clear();
      _showSnackbar('Video uploaded successfully!', Colors.green);
    } catch (e) {
      _showSnackbar('Error uploading video: ${e.toString()}', Colors.red);
    } finally {
      setState(() => _isUploading = false);
    }
  }

  bool _isValidYoutubeUrl(String url) {
    final RegExp regExp = RegExp(
      r'^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?$',
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

  void _navigateToViewVideos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  VideoViewPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('YouTube Video Manager'),
      //   centerTitle: true,
      //   backgroundColor: Colors.red[700],
      //   elevation: 0,
      //   systemOverlayStyle: SystemUiOverlayStyle.light,
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Upload Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload New Video',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _urlController,
                      decoration: InputDecoration(
                        labelText: 'YouTube Video URL',
                        prefixIcon: Icon(Icons.link, color: Colors.red[700]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Video Title',
                        prefixIcon: Icon(Icons.title, color: Colors.red[700]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isUploading ? null : _uploadVideo,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                        ),
                        child: _isUploading
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              )
                            : const Text(
                                'UPLOAD VIDEO',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // View Videos Section
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: _navigateToViewVideos,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red[700]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_circle_fill, color: Colors.red[700]),
                    const SizedBox(width: 8),
                    Text(
                      'VIEW UPLOADED VIDEOS',
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

class VideoViewPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  VideoViewPage({super.key});

  Future<void> _playVideo(String videoUrl) async {
    if (await canLaunch(videoUrl)) {
      await launch(videoUrl);
    } else {
      throw 'Could not launch $videoUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Videos'),
        centerTitle: true,
        backgroundColor: Colors.red[700],
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('admin')
            .doc('youtube_video')
            .collection('videos')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading videos'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.video_library, size: 60, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No videos uploaded yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          final videos = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              final videoUrl = video['url'];
              final videoId = _getVideoId(videoUrl);
              final thumbnailUrl =
                  'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _playVideo(videoUrl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Thumbnail with play button overlay
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: Image.network(
                              thumbnailUrl,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  height: 200,
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 200,
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child:
                                        Icon(Icons.error, color: Colors.grey),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(16),
                            child: const Icon(
                              Icons.play_arrow,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      // Video info
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video['title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.link,
                                    size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    videoUrl,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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

  String _getVideoId(String url) {
    final RegExp regExp = RegExp(
      r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?|watch|.+\?v)=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }
}
