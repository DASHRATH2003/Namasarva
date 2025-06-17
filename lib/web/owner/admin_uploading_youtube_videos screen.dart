// youtube long videos with youtube

// bus_booking_application

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminUploadingYoutubeVideosScreen extends StatefulWidget {
  @override
  _AdminUploadingYoutubeVideosScreenState createState() => _AdminUploadingYoutubeVideosScreenState();
}

class _AdminUploadingYoutubeVideosScreenState extends State<AdminUploadingYoutubeVideosScreen> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _uploadVideo() async {
    String videoUrl = _urlController.text.trim();
    String videoTitle = _titleController.text.trim();

    if (videoUrl.isNotEmpty && videoTitle.isNotEmpty) {
      // Add video details to the specified Firestore location
      await _firestore
          .collection('admin')
          .doc('youtube_video')
          .collection('videos')
          .add({
        'url': videoUrl,
        'title': videoTitle,
      });

      _urlController.clear();
      _titleController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video uploaded successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a video URL and title.')),
      );
    }
  }

  void _navigateToViewVideos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoViewPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(labelText: 'YouTube Video URL'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Video Title'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadVideo,
              child: Text('Upload Video'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToViewVideos,
              child: Text('View Uploaded Videos'),
            ),
          ],
        ),
      ),
    );
  }
}


class VideoViewPage extends StatefulWidget {
  @override
  _VideoViewPageState createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _playVideo(String videoUrl) async {
    // Open the YouTube video URL in the device's default browser
    if (await canLaunch(videoUrl)) {
      await launch(videoUrl);
    } else {
      throw 'Could not launch $videoUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trending Videos'),
      backgroundColor: Colors.pinkAccent,),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('admin')
            .doc('youtube_video')
            .collection('videos')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final videos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              final videoUrl = video['url'];
              final videoId = _getVideoId(videoUrl);
              final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';

              return GestureDetector(
                onTap: () => _playVideo(videoUrl),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      // Display video title if available
                      if (video['title'] != null)
                      // Stack for thumbnail
                      Stack(
                        children: [
                          // Display video thumbnail
                          Image.network(
                            thumbnailUrl,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            video['title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    // Extract the video ID from the YouTube URL
    final RegExp regExp = RegExp(
      r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?|watch|.+\?v)=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(url);
    if (match != null) {
      return match.group(1) ?? '';
    }
    return '';
  }

  @override
  void dispose() {
    super.dispose();
  }
}










