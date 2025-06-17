//youtube shorts playing in flutter app it self

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class ViewMoreShortsScreen extends StatefulWidget {
//   @override
//   _ViewMoreShortsScreenState createState() => _ViewMoreShortsScreenState();
// }
//
// class _ViewMoreShortsScreenState extends State<ViewMoreShortsScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   YoutubePlayerController? _youtubeController;
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
//   void _playVideo(String videoUrl) {
//     final videoId = _getVideoId(videoUrl);
//     if (videoId.isNotEmpty) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => FullScreenVideoPlayer(videoId: videoId),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.pinkAccent,
//         title: Text(
//           'Trending Shorts',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 24,
//             letterSpacing: 1.2,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 4,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.pinkAccent, Colors.purple],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
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
//           return ListView.separated(
//             itemCount: shorts.length,
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             separatorBuilder: (context, index) => Container(
//               width: double.infinity,
//               height: 1.0,
//               color: Colors.pinkAccent.withOpacity(0.5),
//               margin: EdgeInsets.symmetric(vertical: 8),
//             ),
//             itemBuilder: (context, index) {
//               final short = shorts[index];
//               final videoUrl = short['url'];
//               final videoId = _getVideoId(videoUrl);
//               final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
//
//               return GestureDetector(
//                 onTap: () => _playVideo(videoUrl),
//                 child: AnimatedContainer(
//                   duration: Duration(milliseconds: 300),
//                   curve: Curves.easeInOut,
//                   margin: EdgeInsets.symmetric(vertical: 8.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 8,
//                         offset: Offset(4, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start, // Align title to the left
//                     children: [
//                       // Thumbnail
//                       ClipRRect(
//                         child: Container(
//                           width: double.infinity,
//                           height: 250, // Set thumbnail height to 250
//                           child: Image.network(
//                             thumbnailUrl,
//                             width: double.infinity,
//                             height: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       // Video Title below the thumbnail
//                       Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Text(
//                           short['title'] ?? '',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black87,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.start, // Align title to the left
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
//   @override
//   void dispose() {
//     _youtubeController?.dispose();
//     super.dispose();
//   }
// }
//
// class FullScreenVideoPlayer extends StatefulWidget {
//   final String videoId;
//
//   FullScreenVideoPlayer({required this.videoId});
//
//   @override
//   _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
// }
//
// class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
//   late YoutubePlayerController _youtubeController;
//
//   @override
//   void initState() {
//     super.initState();
//     _youtubeController = YoutubePlayerController(
//       initialVideoId: widget.videoId,
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//         loop: false, // Disable the loop flag here
//       ),
//     );
//
//     // Add a listener to handle the video end
//     _youtubeController.addListener(() {
//       if (_youtubeController.value.playerState == PlayerState.ended) {
//         // Seek to the beginning to restart the video
//         _youtubeController.seekTo(Duration.zero);
//         _youtubeController.play(); // Play again
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _youtubeController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black, // Set background color to black for better contrast
//       appBar: AppBar(
//         backgroundColor: Colors.pinkAccent,
//         title: Text('Video Player'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: YoutubePlayerBuilder(
//                 player: YoutubePlayer(
//                   controller: _youtubeController,
//                   showVideoProgressIndicator: true,
//                   progressIndicatorColor: Colors.deepPurpleAccent,
//                 ),
//                 builder: (context, player) {
//                   return Center(child: player);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// youtube short videos playing in youtube by navigating to youtube



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewMoreShortsScreen extends StatefulWidget {
  @override
  _ViewMoreShortsScreenState createState() => _ViewMoreShortsScreenState();
}

class _ViewMoreShortsScreenState extends State<ViewMoreShortsScreen> {
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
      appBar: AppBar(
        backgroundColor: Colors.redAccent.shade700,
        title: Text(
          'Trending Shorts',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.2,
          ),
        ),
        // centerTitle: true,
        // elevation: 4,
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [Colors.pinkAccent, Colors.purple],
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //     ),
        //   ),
        // ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('admin')
            .doc('youtube_short')
            .collection('shorts')
            .snapshots(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent.shade700),
              minHeight: 5.0,
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final shorts = snapshot.data!.docs;

          return ListView.separated(
            itemCount: shorts.length,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.pinkAccent.withOpacity(0.5),
              margin: EdgeInsets.symmetric(vertical: 8),
            ),
            itemBuilder: (context, index) {
              final short = shorts[index];
              final videoUrl = short['url'];
              final videoId = _getVideoId(videoUrl);
              final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';

              return GestureDetector(
                onTap: () => _playVideo(videoUrl),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnail
                      ClipRRect(
                        child: Container(
                          width: double.infinity,
                          height: 250,
                          child: Image.network(
                            thumbnailUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Video Title below the thumbnail
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          short['title'] ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
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




