// youtube short videos

// bus_booking_application

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ShortVideoUploadPage extends StatefulWidget {
  @override
  _ShortVideoUploadPageState createState() => _ShortVideoUploadPageState();
}

class _ShortVideoUploadPageState extends State<ShortVideoUploadPage> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _uploadShortVideo() async {
    String videoUrl = _urlController.text.trim();
    String videoTitle = _titleController.text.trim();

    if (videoUrl.isNotEmpty && videoTitle.isNotEmpty) {
      // Add short video details to the specified Firestore location
      await _firestore
          .collection('admin')
          .doc('youtube_short')
          .collection('shorts')
          .add({
        'url': videoUrl,
        'title': videoTitle,
      });

      _urlController.clear();
      _titleController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Short video uploaded successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a short video URL and title.')),
      );
    }
  }

  void _navigateToViewShortVideos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShortVideoViewPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload YouTube Short Video')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(labelText: 'YouTube Short Video URL'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Short Video Title'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadShortVideo,
              child: Text('Upload Short Video'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToViewShortVideos,
              child: Text('View Uploaded Shorts'),
            ),
          ],
        ),
      ),
    );
  }
}



class ShortVideoViewPage extends StatefulWidget {
  @override
  _ShortVideoViewPageState createState() => _ShortVideoViewPageState();
}

class _ShortVideoViewPageState extends State<ShortVideoViewPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _getVideoId(String url) {
    // Extract the video ID from the YouTube Shorts URL
    final RegExp regExp = RegExp(
      r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:shorts\/|(?:v|e(?:mbed)?|watch|.+\?v)=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(url);
    if (match != null) {
      return match.group(1) ?? '';
    }
    return '';
  }

  void _playVideo(String videoUrl) async {
    final videoId = _getVideoId(videoUrl);
    if (videoId.isNotEmpty) {
      final youtubeUrl = 'https://www.youtube.com/watch?v=$videoId';
      if (await canLaunch(youtubeUrl)) {
        await launch(youtubeUrl);
      } else {
        throw 'Could not launch $youtubeUrl';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trending Shorts')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('admin')
            .doc('youtube_short')
            .collection('shorts')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final shorts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: shorts.length,
            itemBuilder: (context, index) {
              final short = shorts[index];
              final videoUrl = short['url'];
              final videoId = _getVideoId(videoUrl);
              final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';

              return GestureDetector(
                onTap: () => _playVideo(videoUrl),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
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
                            short['title'] ?? 'No Title',
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
}

















