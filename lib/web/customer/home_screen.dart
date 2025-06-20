// // bus_booking_application
//
// import 'dart:convert';
//
// import 'package:bus_booking_app/customer/search_places_screen.dart';
// import 'package:bus_booking_app/customer/seat_layout_screen.dart';
// import 'package:bus_booking_app/customer/theme_provider.dart';
// import 'package:bus_booking_app/customer/view_more_shorts_screen.dart';
// import 'package:bus_booking_app/customer/view_more_youtube_videos_screen.dart';
// import 'package:intl/intl.dart'; // Add this for date formatting
// import 'package:animate_do/animate_do.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'bus_search_screen.dart';
// import 'bus_search_service.dart';
// import 'busses_list_screen.dart';
// import 'customer_account_screen.dart';
// import 'customer_offers_details_screen.dart';
// import 'help_screen.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// // class _HomePageState extends State<HomePage> {
// //   int _currentIndex = 0;
// //
// //   // bool _isNotificationHovered = false;
// //   // bool _isMenuHovered = false;
// //
// //   final List<Widget> _pages = [
// //     HomeScreen(),
// //     // SearchPlacesPage(apiKey: 'AIzaSyDJX-wndZeS6fQ3nxV60w7ANTAP2BCYLw4',),
// //     BookingsScreen(),
// //     // HelpScreen(),
// //     HelpScreen(),
// //     // MyAccountScreen(),
// //     MyAccountScreen(),
// //   ];
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           "Namma Savaari",
// //           style: TextStyle(
// //             color: Colors.white,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 22,
// //           ),
// //         ),
// //         backgroundColor: Colors.pink[300],
// //       ),
// //       body: AnimatedSwitcher(
// //         duration: Duration(milliseconds: 300),
// //         child: _pages[_currentIndex],
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _currentIndex,
// //         onTap: (index) {
// //           setState(() {
// //             _currentIndex = index;
// //           });
// //         },
// //         items: [
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.home),
// //             label: 'Home',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.book),
// //             label: 'Bookings',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.help),
// //             label: 'Help',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.account_circle),
// //             label: 'My Account',
// //           ),
// //         ],
// //         selectedItemColor: Colors.pink[300],
// //         unselectedItemColor: Colors.grey,
// //         showUnselectedLabels: true,
// //       ),
// //     );
// //   }
// // }
//
//
// //main
//
//
// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//
//   late final List<Widget> _pages;
//
//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       HomeScreen(),
//       BookingsScreen(),
//       HelpScreen(),
//       MyAccountScreen(
//         onNavigateToHelp: () => _onItemTapped(2),
//         onNavigateToBookings: () => _onItemTapped(1),
//       ),
//     ];
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Namma Savaari",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         backgroundColor: Colors.pink[300],
//       ),
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
//           BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
//           BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'My Account'),
//         ],
//         selectedItemColor: Colors.pink[300],
//         unselectedItemColor: Colors.grey,
//         showUnselectedLabels: true,
//       ),
//     );
//   }
// }
//
//
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
//   DateTime _selectedDate = DateTime.now(); // Default to today's date
//   String _fromPlace = "Bengaluru"; // Default From place
//   String _toPlace = "Destination"; // Default To place
//
//
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   YoutubePlayerController? _youtubeController;
//
//   // Method to fetch bus data from the API
//
//
//
//
//   @override
//   void dispose() {
//     _youtubeController?.dispose(); // Dispose of the YouTube player controller
//     super.dispose();
//   }
//
//   // Function to handle bus search
//
//
//   // Function to fetch and display videos in a carousel slider
//   Widget buildVideoCarousel() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore
//           .collection('admin')
//           .doc('youtube_video')
//           .collection('videos')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//         final videos = snapshot.data!.docs;
//
//         if (videos.isEmpty) {
//           return Center(child: Text('No videos available'));
//         }
//
//         return CarouselSlider(
//           options: CarouselOptions(
//             height: 200,
//             autoPlay: false,
//             enlargeCenterPage: true,
//             viewportFraction: 0.8, // Set the fraction for center visibility
//             aspectRatio: 16 / 9,
//             enableInfiniteScroll: true, // Allows continuous scrolling
//             initialPage: 1, // Start with the first video
//           ),
//           items: videos.map((video) {
//             final videoUrl = video['url'];
//             final videoId = _getVideoId(videoUrl);
//             final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
//             final videoTitle = video['title'] ?? '';
//
//             return GestureDetector(
//               onTap: () => _playVideo(videoUrl),
//               child: Container(
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 4,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Stack(
//                   children: [
//                     ClipRRect(
//                       child: Image.network(
//                         thumbnailUrl,
//                         width: double.infinity,
//                         height: 200,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       left: 0,
//                       right: 0,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
//                         color: Colors.black54,
//                         child: Text(
//                           videoTitle,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
//
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
//
//   // Function to fetch and display short videos in a carousel slider by navigating to youtube
//
//
//   Widget buildShortVideoCarousel() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore
//           .collection('admin')
//           .doc('youtube_short')
//           .collection('shorts')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//         final videos = snapshot.data!.docs;
//
//         if (videos.isEmpty) {
//           return Center(child: Text('No videos available'));
//         }
//
//         return CarouselSlider.builder(
//           options: CarouselOptions(
//             height: 250,
//             autoPlay: true,
//             enlargeCenterPage: true,
//             viewportFraction: 0.7,
//             enableInfiniteScroll: true,
//             autoPlayInterval: Duration(seconds: 3),
//           ),
//           itemCount: videos.length,
//           itemBuilder: (context, index, _) {
//             final video = videos[index];
//             final videoUrl = video['url'];
//             final videoId = _getShortVideoId(videoUrl);
//             final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
//             final videoTitle = video['title'] ?? '';
//
//             return GestureDetector(
//               onTap: () => _openVideoInYouTube(videoId),
//               child: AnimatedContainer(
//                 duration: Duration(milliseconds: 300),
//                 margin: EdgeInsets.symmetric(vertical: 8.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 8,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(15.0),
//                       child: Image.network(
//                         thumbnailUrl,
//                         width: double.infinity,
//                         height: 250,
//                         fit: BoxFit.cover,
//                         color: Colors.black.withOpacity(0.3),
//                         colorBlendMode: BlendMode.darken,
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       left: 0,
//                       right: 0,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//                         decoration: BoxDecoration(
//                           color: Colors.black54,
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               videoTitle,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             SizedBox(height: 4),
//                             Row(
//                               children: [
//                                 Icon(Icons.play_circle_filled, color: Colors.white, size: 20),
//                                 SizedBox(width: 5),
//                                 Text(
//                                   "Watch Short video",
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//
//   String _getShortVideoId(String url) {
//     final RegExp regExp = RegExp(
//       r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:shorts\/|(?:v|e(?:mbed)?|watch|.+\?v)=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
//       caseSensitive: false,
//     );
//     final match = regExp.firstMatch(url);
//     return match != null ? match.group(1) ?? '' : '';
//   }
//
//   void _openVideoInYouTube(String videoId) async {
//     final url = 'https://youtube.com/watch?v=$videoId'; // Standard video format URL
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   // Function to fetch and display short videos in a carousel slider there only inside flutter app it self
//   // Widget buildShortVideoCarousel() {
//   //   return StreamBuilder<QuerySnapshot>(
//   //     stream: _firestore
//   //         .collection('admin')
//   //         .doc('youtube_short')
//   //         .collection('shorts')
//   //         .snapshots(),
//   //     builder: (context, snapshot) {
//   //       if (snapshot.connectionState == ConnectionState.waiting) {
//   //         return Center(child: CircularProgressIndicator());
//   //       }
//   //       if (snapshot.hasError) {
//   //         return Center(child: Text('Error: ${snapshot.error}'));
//   //       }
//   //       final videos = snapshot.data!.docs;
//   //
//   //       if (videos.isEmpty) {
//   //         return Center(child: Text('No videos available'));
//   //       }
//   //
//   //       return CarouselSlider(
//   //         options: CarouselOptions(
//   //           height: 220, // Adjust the height as needed
//   //           autoPlay: false,
//   //           enlargeCenterPage: true,
//   //           viewportFraction: 0.5, // Shows two items at a time
//   //           enableInfiniteScroll: true,
//   //         ),
//   //         items: videos.map((video) {
//   //           final videoUrl = video['url'];
//   //           final videoId = _getShortVideoId(videoUrl);
//   //           final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
//   //           final videoTitle = video['title'] ?? '';
//   //
//   //           return GestureDetector(
//   //             onTap: () => _playShortVideo(videoId),
//   //             child: Container(
//   //               margin: EdgeInsets.symmetric(horizontal: 5.0), // Space between videos
//   //               decoration: BoxDecoration(
//   //                 boxShadow: [
//   //                   BoxShadow(
//   //                     color: Colors.black26,
//   //                     blurRadius: 4,
//   //                     offset: Offset(0, 2),
//   //                   ),
//   //                 ],
//   //               ),
//   //               child: Stack(
//   //                 children: [
//   //                   ClipRRect(
//   //                     borderRadius: BorderRadius.circular(15.0), // Round all corners
//   //                     child: Image.network(
//   //                       thumbnailUrl,
//   //                       width: double.infinity,
//   //                       height: 200,
//   //                       fit: BoxFit.cover,
//   //                     ),
//   //                   ),
//   //                   // Positioned(
//   //                   //   bottom: 0,
//   //                   //   left: 0,
//   //                   //   right: 0,
//   //                   //   child: Container(
//   //                   //     padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
//   //                   //     color: Colors.black54,
//   //                   //     child: Text(
//   //                   //       videoTitle,
//   //                   //       style: TextStyle(
//   //                   //         color: Colors.white,
//   //                   //         fontSize: 16,
//   //                   //         fontWeight: FontWeight.bold,
//   //                   //       ),
//   //                   //       maxLines: 1,
//   //                   //       overflow: TextOverflow.ellipsis,
//   //                   //       textAlign: TextAlign.center,
//   //                   //     ),
//   //                   //   ),
//   //                   // ),
//   //                   Positioned(
//   //                     bottom: 0,
//   //                     left: 0,
//   //                     right: 0,
//   //                     child: Container(
//   //                       padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
//   //                       decoration: BoxDecoration(
//   //                         color: Colors.black54, // Set color here within BoxDecoration
//   //                         borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)), // Add border radius
//   //                       ),
//   //                       child: Text(
//   //                         videoTitle,
//   //                         style: TextStyle(
//   //                           color: Colors.white,
//   //                           fontSize: 16,
//   //                           fontWeight: FontWeight.bold,
//   //                         ),
//   //                         maxLines: 1,
//   //                         overflow: TextOverflow.ellipsis,
//   //                         textAlign: TextAlign.center,
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           );
//   //         }).toList(),
//   //       );
//   //     },
//   //   );
//   // }
//   //
//   // void _playShortVideo(String videoId) {
//   //   // Dispose of any previous controller
//   //   _youtubeController?.dispose();
//   //
//   //   // Create a new YoutubePlayerController
//   //   _youtubeController = YoutubePlayerController(
//   //     initialVideoId: videoId,
//   //     flags: YoutubePlayerFlags(
//   //       autoPlay: true,
//   //       mute: false,
//   //     ),
//   //   );
//   //
//   //   // Show the video player in a dialog
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       return Dialog(
//   //         backgroundColor: Colors.black,
//   //         child: ClipRRect(
//   //           borderRadius: BorderRadius.circular(15),
//   //           child: Stack(
//   //             children: [
//   //               SizedBox(
//   //                 width: double.infinity,
//   //                 height: 400, // Height of the dialog
//   //                 child: YoutubePlayer(
//   //                   controller: _youtubeController!,
//   //                   showVideoProgressIndicator: true,
//   //                   progressIndicatorColor: Colors.deepPurpleAccent,
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   //
//   //   // Add a listener to the controller to close the dialog when the video ends
//   //   _youtubeController?.addListener(() {
//   //     if (_youtubeController?.value.playerState == PlayerState.ended) {
//   //       Navigator.of(context).pop(); // Close the dialog
//   //     }
//   //   });
//   // }
//   //
//   // String _getShortVideoId(String url) {
//   //   // Extract the video ID from the YouTube URL
//   //   final RegExp regExp = RegExp(
//   //     r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:shorts\/|(?:v|e(?:mbed)?|watch|.+\?v)=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
//   //     caseSensitive: false,
//   //   );
//   //   final match = regExp.firstMatch(url);
//   //   if (match != null) {
//   //     return match.group(1) ?? '';
//   //   }
//   //   return '';
//   // }
//
//
//   // final TextEditingController _controller = TextEditingController();
//   // bool _isSearching = false;
//
//   // void _toggleSearch() {
//   //   setState(() {
//   //     _isSearching = !_isSearching;
//   //     if (!_isSearching) {
//   //       _controller.clear();
//   //     }
//   //   });
//   // }
//
//
//
//   // final List<String> imagePaths = [
//   //   'assets/red_bus_caro_1.jpeg',
//   //   'assets/Namma Savaari_caro_2.jpeg',
//   //   'assets/Namma Savaari_caro_3.jpeg',
//   //   'assets/red_bus_caro_4.jpeg',
//   // ];
//   // int _current = 0;
//
//
//   Future<void> _showRateDialog(BuildContext context) async {
//     final TextEditingController _reviewController = TextEditingController();
//     double _rating = 0.0; // Variable to store the user's rating
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return SingleChildScrollView(
//           child: AlertDialog(
//             backgroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             contentPadding: EdgeInsets.all(16.0),
//             content: Container(
//               height: MediaQuery.of(context).size.height * 0.45, // Adjusted height
//               width: MediaQuery.of(context).size.width * 0.9, // Adjusted width
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Image on top
//                     FadeInDown(
//                       duration: Duration(milliseconds: 500),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(15.0),
//                         child: Image.asset(
//                           'assets/rate_rev.JPG', // Replace with your asset image
//                           height: 180, // Updated image height
//                           width: double.infinity, // Updated image width
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     // "Rate Your Experience" Text
//                     FadeIn(
//                       duration: Duration(milliseconds: 500),
//                       child: Text(
//                         "Rate Your Experience",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//
//                     // Mandatory Rating input (stars)
//                     FadeIn(
//                       duration: Duration(milliseconds: 500),
//                       child: RatingBar.builder(
//                         initialRating: _rating,
//                         minRating: 1,
//                         direction: Axis.horizontal,
//                         allowHalfRating: true,
//                         itemCount: 5,
//                         itemBuilder: (context, _) => Icon(
//                           Icons.star,
//                           color: Colors.amber,
//                         ),
//                         unratedColor: Colors.grey, // Color for unselected stars
//                         onRatingUpdate: (rating) {
//                           _rating = rating;
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 10),
//
//                     // Optional Review input
//                     FadeInUp(
//                       duration: Duration(milliseconds: 500),
//                       child: TextField(
//                         controller: _reviewController,
//                         maxLines: 3,
//                         decoration: InputDecoration(
//                           hintText: 'Write a review (Optional)...',
//                           border: OutlineInputBorder(),
//                           contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             actionsPadding: EdgeInsets.symmetric(horizontal: 16), // Adjust padding for buttons
//             actionsAlignment: MainAxisAlignment.spaceBetween, // Arrange buttons properly
//             actions: [
//               TextButton(
//                 child: Text('Cancel'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ElevatedButton(
//                 child: Text('Submit'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.pink[400],
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
//                 ),
//                 onPressed: () async {
//                   if (_rating == 0.0) {
//                     // Show a message if rating is not provided
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Please provide a rating!')),
//                     );
//                     return;
//                   }
//
//                   // Get the logged-in user's ID
//                   final User? user = FirebaseAuth.instance.currentUser;
//                   if (user != null) {
//                     String uid = user.uid; // Customer UID
//                     String review = _reviewController.text;
//
//                     try {
//                       // Check if the user has already submitted a rating
//                       var reviewSnapshot = await FirebaseFirestore.instance
//                           .collection('customers')
//                           .doc(uid)
//                           .collection('reviews')
//                           .limit(1) // Limit to one review per customer
//                           .get();
//
//                       if (reviewSnapshot.docs.isNotEmpty) {
//                         // Update the existing review
//                         await FirebaseFirestore.instance
//                             .collection('customers')
//                             .doc(uid)
//                             .collection('reviews')
//                             .doc(reviewSnapshot.docs[0].id)
//                             .update({
//                           'rating': _rating,
//                           'review': review.isNotEmpty ? review : null,
//                           'timestamp': FieldValue.serverTimestamp(),
//                         });
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Rating updated successfully!')),
//                         );
//                       } else {
//                         // Add a new review
//                         await FirebaseFirestore.instance
//                             .collection('customers')
//                             .doc(uid)
//                             .collection('reviews')
//                             .add({
//                           'rating': _rating,
//                           'review': review.isNotEmpty ? review : null,
//                           'timestamp': FieldValue.serverTimestamp(),
//                         });
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Rating submitted successfully!')),
//                         );
//                       }
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Failed to submit rating: $e')),
//                       );
//                     }
//                   }
//
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Color _getBackgroundColor(String couponCode) {
//     int length = couponCode.length;
//     if (length <= 5) {
//       return Colors.amber.shade900; // Shorter codes have a green background
//     } else if (length <= 10) {
//       return Colors.pink; // Medium-length codes have a blue background
//     } else {
//       return Colors.cyanAccent; // Longer codes have a red background
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor:Colors.pink[50],
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Book a Bus',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             // Padding(
//             //   padding: const EdgeInsets.only(left: 10.0,right: 10.0),
//             //   child: Container(
//             //     height: 210,
//             //     decoration: BoxDecoration(
//             //       color: Colors.white,
//             //       border: Border.all(color: Colors.black, width: 1),
//             //     ),
//             //     child: Column(
//             //       children: [
//             //         Expanded(
//             //           child: Padding(
//             //             padding: const EdgeInsets.all(8.0),
//             //             child: Row(
//             //               children: [
//             //                 Icon(
//             //                   Icons.directions_bus, // Bus icon
//             //                   size: 40,
//             //                   color: Colors.black,
//             //                 ),
//             //                 SizedBox(width: 10), // Space between the icon and text
//             //                 Column(
//             //                   crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
//             //                   mainAxisAlignment: MainAxisAlignment.center, // Center vertically
//             //                   children: [
//             //                     Text(
//             //                       "From",
//             //                       style: TextStyle(fontSize: 10),
//             //                     ),
//             //                     SizedBox(height: 5), // Space between the two texts
//             //                     // Text(
//             //                     //   "Bengaluru",
//             //                     //   style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//             //                     // ),
//             //                   ],
//             //                 ),
//             //               ],
//             //             ),
//             //           ),
//             //         ),
//             //         Divider(
//             //           color: Colors.black, // Black divider line
//             //           thickness: 1, // Thickness of the divider
//             //         ),
//             //         Expanded(
//             //           child: Padding(
//             //             padding: const EdgeInsets.all(8.0),
//             //             child: Row(
//             //               children: [
//             //                 Icon(
//             //                   Icons.directions_bus, // Bus icon
//             //                   size: 40,
//             //                   color: Colors.black,
//             //                 ),
//             //                 SizedBox(width: 10), // Space between the icon and text
//             //                 Column(
//             //                   crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
//             //                   mainAxisAlignment: MainAxisAlignment.center, // Center vertically
//             //                   children: [
//             //                     Text(
//             //                       "To",
//             //                       style: TextStyle(fontSize: 10),
//             //                     ),
//             //                     SizedBox(height: 5), // Space between the two texts
//             //
//             //                   ],
//             //                 ),
//             //               ],
//             //             ),
//             //           ),
//             //         ),
//             //         Divider(
//             //           color: Colors.black, // Black divider line
//             //           thickness: 1, // Thickness of the divider
//             //         ),
//             //         Expanded(
//             //           child: Padding(
//             //             padding: const EdgeInsets.all(8.0),
//             //             child: Row(
//             //               children: [
//             //                 Icon(
//             //                   Icons.calendar_today, // Calendar icon
//             //                   size: 40,
//             //                   color: Colors.black,
//             //                 ),
//             //                 SizedBox(width: 10), // Space between the icon and text
//             //                 Column(
//             //                   crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
//             //                   mainAxisAlignment: MainAxisAlignment.center, // Center vertically
//             //                   children: [
//             //                     GestureDetector(
//             //                       onTap: () => _selectDate(context),
//             //                       child: Text(
//             //                         "Date of Journey",
//             //                         style: TextStyle(fontSize: 10,),
//             //                       ),
//             //                     ),
//             //                     SizedBox(height: 5), // Space between the text and the date
//             //                     Text(
//             //                       "${_selectedDate.toLocal()}".split(' ')[0], // Display the selected date
//             //                       style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//             //                     ),
//             //                   ],
//             //                 ),
//             //               ],
//             //             ),
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//
//             SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                 child: Container(
//                   height: 210,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.black, width: 1),
//                   ),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () async {
//                             final selectedCity = await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CitySelectionPage(),
//                               ),
//                             );
//
//                             if (selectedCity != null) {
//                               setState(() {
//                                 _fromPlace = selectedCity; // or _toPlace, based on your implementation
//                               });
//                             }
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.directions_bus, // Bus icon
//                                   size: 40,
//                                   color: Colors.black,
//                                 ),
//                                 SizedBox(width: 10), // Space between the icon and text
//
//     // before api
//     //                             Expanded(
//     //                               child: SingleChildScrollView(
//     //                                 scrollDirection: Axis.horizontal,
//     //                                 child: Column(
//     //                                   crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
//     //                                   mainAxisAlignment: MainAxisAlignment.center, // Center vertically
//     //                                   children: [
//     //                                     Text(
//     //                                       "Source City",
//     //                                       style: TextStyle(fontSize: 10),
//     //                                       overflow: TextOverflow.ellipsis, // This will truncate text with ellipsis
//     //                                       maxLines: 1, // Limit the number of lines
//     //                                     ),
//     //                                     SizedBox(height: 5), // Space between the two texts
//     //                                     Text(
//     //                                       _fromPlace, // Display selected From place
//     //                                       style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//     //                                     ),
//     //                                   ],
//     //                                 ),
//     //                               ),
//     //                             ),
//     //                           ],
//     //                         ),
//     //                       ),
//     //                     ),
//     //                   ),
//     //                   Divider(color: Colors.black, thickness: 1), // Divider line
//     //                   Expanded(
//     //                     child: GestureDetector(
//     //                       onTap: () => _navigateToSearchPage(false), // Navigate to search page for "To"
//     //                       child: Padding(
//     //                         padding: const EdgeInsets.all(8.0),
//     //                         child: Row(
//     //                           children: [
//     //                             Icon(
//     //                               Icons.directions_bus, // Bus icon
//     //                               size: 40,
//     //                               color: Colors.black,
//     //                             ),
//     //                             SizedBox(width: 10), // Space between the icon and text
//     //                             Expanded(
//     //                               child: SingleChildScrollView(
//     //                                 scrollDirection: Axis.horizontal,
//     //                                 child: Column(
//     //                                   crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
//     //                                   mainAxisAlignment: MainAxisAlignment.center, // Center vertically
//     //                                   children: [
//     //                                     Text(
//     //                                       "Destination City",
//     //                                       style: TextStyle(fontSize: 10),
//     //                                     ),
//     //                                     SizedBox(height: 5), // Space between the two texts
//     //                                     Text(
//     //                                       _toPlace, // Display selected To place
//     //                                       style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//     //                                     ),
//     //                                   ],
//     //                                 ),
//     //                               ),
//     //                             ),
//     //                           ],
//     //                         ),
//     //                       ),
//     //                     ),
//     //                   ),
//     //                   Divider(color: Colors.black, thickness: 1), // Divider line
//     //                   Expanded(
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.all(8.0),
//     //                       child: Row(
//     //                         children: [
//     //                           Icon(
//     //                             Icons.calendar_today, // Calendar icon
//     //                             size: 40,
//     //                             color: Colors.black,
//     //                           ),
//     //                           SizedBox(width: 10), // Space between the icon and text
//     //                           Column(
//     //                             crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
//     //                             mainAxisAlignment: MainAxisAlignment.center, // Center vertically
//     //                             children: [
//     //                               GestureDetector(
//     //                                 onTap: () => _selectDate(context), // Your existing date selection function
//     //                                 child: Text(
//     //                                   "Date of Journey",
//     //                                   style: TextStyle(fontSize: 10),
//     //                                 ),
//     //                               ),
//     //                               SizedBox(height: 5), // Space between the text and the date
//     //                               Text(
//     //                                 "${_selectedDate.toLocal()}".split(' ')[0], // Display the selected date
//     //                                 style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//     //                               ),
//     //                             ],
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   ),
//     //                 ],
//     //               ),
//     //             ),
//     //           ),
//     //         ),
//     //
//     //         Padding(
//     //           padding: const EdgeInsets.all(8.0),
//     //           child: Container(
//     //             height: 50,
//     //             width: double.infinity,
//     //             child: ElevatedButton(
//     //               onPressed: () {
//     //                 // Add your search functionality here
//     //                 print("Search button pressed");
//     //               },
//     //               style: ElevatedButton.styleFrom(
//     //                 foregroundColor: Colors.white, backgroundColor: Colors.pink[400], // Text color
//     //                 elevation: 5,
//     //                 shape: RoundedRectangleBorder(
//     //                   borderRadius: BorderRadius.circular(12), // Rounded corners
//     //                 ),
//     //               ),
//     //               child: Text(
//     //                 "Search",
//     //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//     //               ),
//     //             ),
//     //           ),
//     //         ),
//
//     // after api
//
//
//
//                                 Expanded(
//                                   child: SingleChildScrollView(
//                                     scrollDirection: Axis.horizontal,
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
//                                       mainAxisAlignment: MainAxisAlignment.center, // Center vertically
//                                       children: [
//                                         Text(
//                                           "Source City",
//                                           style: TextStyle(fontSize: 10),
//                                           overflow: TextOverflow.ellipsis, // This will truncate text with ellipsis
//                                           maxLines: 1, // Limit the number of lines
//                                         ),
//                                         SizedBox(height: 5), // Space between the two texts
//                                         Text(
//                                           _fromPlace, // Display selected From place
//                                           style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Divider(color: Colors.black, thickness: 1), // Divider line
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () async {
//                             final selectedCity = await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CitySelectionPage(),
//                               ),
//                             );
//
//                             if (selectedCity != null) {
//                               setState(() {
//                                 _toPlace = selectedCity; // or _toPlace, based on your implementation
//                               });
//                             }
//                           },
//
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.directions_bus, // Bus icon
//                                   size: 40,
//                                   color: Colors.black,
//                                 ),
//                                 SizedBox(width: 10), // Space between the icon and text
//                                 Expanded(
//                                   child: SingleChildScrollView(
//                                     scrollDirection: Axis.horizontal,
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
//                                       mainAxisAlignment: MainAxisAlignment.center, // Center vertically
//                                       children: [
//                                         Text(
//                                           "Destination City",
//                                           style: TextStyle(fontSize: 10),
//                                         ),
//                                         SizedBox(height: 5), // Space between the two texts
//                                         Text(
//                                           _toPlace, // Display selected To place
//                                           style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Divider(color: Colors.black, thickness: 1), // Divider line
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.calendar_today, // Calendar icon
//                                 size: 40,
//                                 color: Colors.black,
//                               ),
//                               SizedBox(width: 10), // Space between the icon and text
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
//                                 mainAxisAlignment: MainAxisAlignment.center, // Center vertically
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () => _selectDate(context), // Your existing date selection function
//                                     child: Text(
//                                       "Date of Journey",
//                                       style: TextStyle(fontSize: 10),
//                                     ),
//                                   ),
//                                   SizedBox(height: 5), // Space between the text and the date
//                                   Text(
//                                     "${_selectedDate.toLocal()}".split(' ')[0], // Display the selected date
//                                     style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
// // Inside your widget where the Search button is placed
//             // Inside the widget with the "Search" button
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 height: 50,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (_fromPlace == "Enter Source City" ||
//                         _toPlace == "Enter Destination City" ||
//                         _selectedDate == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("Please fill all fields!")),
//                       );
//                       return;
//                     }
//
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => BusListPage(
//                           sourceCity: _fromPlace,
//                           destinationCity: _toPlace,
//                           journeyDate: "${_selectedDate.toLocal()}".split(' ')[0],
//                         ),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white, backgroundColor: Colors.pink[400], // Text color
//                     elevation: 5,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12), // Rounded corners
//                     ),
//                   ),
//                   child: Text(
//                     "Search",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10,),
//             Padding(
//               padding: const EdgeInsets.only(left: 5.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Offers",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 2), // Space between the two texts
//             // "Get best deals with great offers" text
//             Padding(
//               padding: const EdgeInsets.only(left: 5.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Get best deals with great offers",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//               ),
//             ),
//             // The carousel slider
//             // CarouselSlider.builder(
//             //   itemCount: imagePaths.length,
//             //   itemBuilder: (context, index, realIndex) {
//             //     return AnimatedContainer(
//             //       duration: Duration(milliseconds: 500),
//             //       curve: Curves.easeInOut,
//             //       margin: EdgeInsets.symmetric(horizontal: 10.0),
//             //       decoration: BoxDecoration(
//             //         boxShadow: [
//             //           BoxShadow(
//             //             color: Colors.grey.withOpacity(0.5),
//             //             spreadRadius: 5,
//             //             blurRadius: 10,
//             //             offset: Offset(0, 3),
//             //           ),
//             //         ],
//             //         borderRadius: BorderRadius.circular(20), // Rounded corners
//             //       ),
//             //       child: ClipRRect(
//             //         borderRadius: BorderRadius.circular(20), // Clip images to rounded corners
//             //         child: Stack(
//             //           children: [
//             //             Positioned.fill(
//             //               child: Image.asset(
//             //                 imagePaths[index],
//             //                 fit: BoxFit.cover,
//             //                 alignment: Alignment.topCenter,
//             //                 // Fade transition for smooth image change
//             //               ),
//             //             ),
//             //             Container(
//             //               decoration: BoxDecoration(
//             //                 gradient: LinearGradient(
//             //                   begin: Alignment.bottomCenter,
//             //                   end: Alignment.topCenter,
//             //                   colors: [
//             //                     Colors.black.withOpacity(0.7),
//             //                     Colors.transparent,
//             //                   ],
//             //                 ),
//             //               ),
//             //             ),
//             //             Positioned(
//             //               bottom: 10,
//             //               left: 20,
//             //               child: Text(
//             //                 "Image ${index + 1}",
//             //                 style: TextStyle(
//             //                   fontSize: 20,
//             //                   fontWeight: FontWeight.bold,
//             //                   color: Colors.white,
//             //                 ),
//             //               ),
//             //             ),
//             //           ],
//             //         ),
//             //       ),
//             //     );
//             //   },
//             //   options: CarouselOptions(
//             //     height: 200,
//             //
//             //     autoPlay: true,
//             //     enlargeCenterPage: true,
//             //     autoPlayInterval: Duration(seconds: 3),
//             //     aspectRatio: 16 / 9,
//             //     viewportFraction: 0.8,
//             //     onPageChanged: (index, reason) {
//             //       setState(() {
//             //         _current = index;
//             //       });
//             //     },
//             //   ),
//             // ),
//
//             // SizedBox(height: 10),
//             //
//             // // Indicators below the carousel
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: imagePaths.asMap().entries.map((entry) {
//             //     return GestureDetector(
//             //       onTap: () => setState(() => _current = entry.key),
//             //       child: AnimatedContainer(
//             //         duration: Duration(milliseconds: 300),
//             //         width: _current == entry.key ? 12.0 : 8.0,
//             //         height: 8.0,
//             //         margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//             //         decoration: BoxDecoration(
//             //           shape: BoxShape.circle,
//             //           color: _current == entry.key
//             //               ? Colors.pink[300]
//             //               : Colors.grey.withOpacity(0.5),
//             //         ),
//             //       ),
//             //     );
//             //   }).toList(),
//             // ),
//             StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('admin')
//                   .doc('admin_offers')
//                   .collection('offers')
//                   .orderBy('createdAt', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 // if (snapshot.connectionState == ConnectionState.waiting) {
//                 //   return Center(child: CircularProgressIndicator());
//                 // }
//
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return LinearProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
//                     minHeight: 5.0,
//                   );
//                 }
//
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Something went wrong'));
//                 }
//
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(child: Text('No offers available'));
//                 }
//
//                 final offers = snapshot.data!.docs;
//
//                 return CarouselSlider.builder(
//                   itemCount: offers.length,
//                   options: CarouselOptions(
//                     height: 200, // Adjust the height as needed
//                     autoPlay: true,
//                     autoPlayInterval: Duration(seconds: 3),
//                     enlargeCenterPage: true,
//                     aspectRatio: 16 / 9,
//                     viewportFraction: 0.8,
//                     enableInfiniteScroll: true,
//                   ),
//                   itemBuilder: (context, index, realIndex) {
//                     final offer = offers[index];
//                     final imageUrl = offer['imageUrl'];
//                     final offerLine = offer['offerLine'];
//                     final couponCode = offer['couponCode'];
//                     final validTill = offer['validTill'];
//
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => OfferDetailsPage(
//                               imageUrl: imageUrl,
//                               offerLine: offerLine,
//                               couponCode: couponCode,
//                               validTill: validTill,
//                               terms: offer['terms'],
//                             ),
//                           ),
//                         );
//                       },
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             Image.network(
//                               imageUrl,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Center(child: Text('Error loading image'));
//                               },
//                             ),
//                             Positioned(
//                               top: 20,
//                               left: 10,
//                               right: 10,
//                               child: Text(
//                                 offerLine,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   shadows: [
//                                     Shadow(
//                                       offset: Offset(1, 1),
//                                       blurRadius: 3,
//                                       color: Colors.black,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 50,
//                               left: 10,
//                               right: 10,
//                               child: Text(
//                                 'Valid Till: $validTill',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                   shadows: [
//                                     Shadow(
//                                       offset: Offset(1, 1),
//                                       blurRadius: 3,
//                                       color: Colors.black,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 15,
//                               left: 10,
//                               child: Container(
//                                 constraints: BoxConstraints(
//                                   maxWidth: MediaQuery.of(context).size.width - 40, // Adjust based on padding
//                                 ),
//                                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                 decoration: BoxDecoration(
//                                   color: _getBackgroundColor(couponCode),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(
//                                       Icons.local_offer,
//                                       color: Colors.white,
//                                       size: 18,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       '$couponCode',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                         shadows: [
//                                           Shadow(
//                                             offset: Offset(1, 1),
//                                             blurRadius: 3,
//                                             color: Colors.black,
//                                           ),
//                                         ],
//                                       ),
//                                       overflow: TextOverflow.ellipsis, // Prevents overflow by truncating
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//
//
//
//
//
//
//             // Ratings Functionality
//
//             Stack(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start, // Align "Rate Us" to left
//                     children: [
//                       // "Rate Us" Text at the center-left
//                       FadeInDown(
//                         child: Align(
//                           alignment: Alignment.centerLeft, // Align to left
//                           child: Text(
//                             "Rate Us",
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//
//                       // Container with image and text
//                       FadeInLeft(
//                         child: Container(
//                           width: double.infinity,
//                           height: 180, // Increased height of the blue container by 20
//                           decoration: BoxDecoration(
//                             color: Colors.blue[50],
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.blue.withOpacity(0.2),
//                                 blurRadius: 10,
//                                 spreadRadius: 3,
//                                 offset: Offset(0, 5),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min, // Makes the column take only the needed space
//                             children: [
//                               Row(
//                                 children: [
//                                   // Image container
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 10.0,left: 10.0),
//                                     child: Container(
//                                       height: 100, // Adjusted height for more space
//                                       width: 100, // Adjusted width for more space
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(5), // Added border radius for the image
//                                         child: Image.asset(
//                                           'assets/reate_review_pic.jpg', // Replace with your image asset
//                                           fit: BoxFit.fill, // Fill the entire space without maintaining aspect ratio
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: 5), // Increased spacing between image and text
//
//                                   // Texts inside the Container
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.center, // Center text vertically
//                                       children: [
//                                         Text(
//                                           "Enjoying bus booking app?",
//                                           style: TextStyle(
//                                             fontSize: 15, // Increased font size for visibility
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         SizedBox(height: 10), // Increased spacing between texts
//                                         Text(
//                                           "Share your thoughts with us and help spread the word to others!",
//                                           style: TextStyle(
//                                             fontSize: 11, // Increased font size for readability
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 10),
//                               // "Rate Now" button at the bottom
//                               Container(
//                                 height: 50,
//                                 width: 400,
//                                 child: ElasticIn(
//                                   child: ElevatedButton(
//                                     onPressed: () => _showRateDialog(context),
//                                     style: ElevatedButton.styleFrom(
//                                       foregroundColor: Colors.white,
//                                       backgroundColor: Colors.pink[400],
//                                       padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                       ),
//                                       elevation: 10,
//                                       shadowColor: Colors.pink[400]?.withOpacity(0.5),
//                                     ),
//                                     child: Text(
//                                       'Rate Now',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 18,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items to opposite ends
//                         children: [
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Trending Videos",
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               // Navigate to the "View More" page
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => ViewMorePage()),
//                               );
//                             },
//                             child: Column(
//                               children: [
//                                 Text(
//                                   "View More",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     color: Colors.indigo,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 3, // Height of the underline
//                                   width: 90, // Width of the underline
//                                   color: Colors.indigo, // Color of the underline
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       buildVideoCarousel(),
//                       SizedBox(height: 18,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items to opposite ends
//                         children: [
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Trending Shorts",
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               // Navigate to the "View More" page
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => ViewMoreShortsScreen()),
//                               );
//                             },
//                             child: Column(
//                               children: [
//                                 Text(
//                                   "View More",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     color: Colors.indigo,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 3, // Height of the underline
//                                   width: 90, // Width of the underline
//                                   color: Colors.indigo, // Color of the underline
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       buildShortVideoCarousel(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//
//     if (pickedDate != null && pickedDate != _selectedDate) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }
// }
//
// class BookingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Bookings Screen',
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
//
//

// Testing

// Testing

import 'package:bus_booking_app/customer/welcome_screen.dart';
import 'package:bus_booking_app/web/customer/ticket_details_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bus_booking_app/customer/search_places_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../customer/customer_offers_details_screen.dart';
import 'busses_list_screen.dart';
import 'customer_account_screen.dart';
import 'help_screen.dart';

class HomePage_Web extends StatefulWidget {
  @override
  _HomePage_WebState createState() => _HomePage_WebState();
}

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//
//   // bool _isNotificationHovered = false;
//   // bool _isMenuHovered = false;
//
//   final List<Widget> _pages = [
//     HomeScreen(),
//     // SearchPlacesPage(apiKey: 'AIzaSyDJX-wndZeS6fQ3nxV60w7ANTAP2BCYLw4',),
//     BookingsScreen(),
//     // HelpScreen(),
//     HelpScreen(),
//     // MyAccountScreen(),
//     MyAccountScreen(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Namma Savaari",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         backgroundColor: Colors.pink[300],
//       ),
//       body: AnimatedSwitcher(
//         duration: Duration(milliseconds: 300),
//         child: _pages[_currentIndex],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book),
//             label: 'Bookings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.help),
//             label: 'Help',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: 'My Account',
//           ),
//         ],
//         selectedItemColor: Colors.pink[300],
//         unselectedItemColor: Colors.grey,
//         showUnselectedLabels: true,
//       ),
//     );
//   }
// }

//main

class _HomePage_WebState extends State<HomePage_Web> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(),
      BookingScreen(),
      HelpScreen(),
      MyAccountScreen(
        onNavigateToHelp: () => _onItemTapped(2),
        onNavigateToBookings: () => _onItemTapped(1),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.5),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child: InkWell(
                onTap: () {
                  context.go('/home'); // Navigate to Home
                },
                child: Image.asset(
                  'assets/Namma_Savaari.png',
                  height: 250,
                  width: 250,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 180),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    context.go('/helptopics'); // Navigate using go_router
                  },
                  icon: const Icon(Icons.help_outline, color: Colors.black),
                  label: const Text(
                    'Help',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 16),
                PopupMenuButton<String>(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.account_circle_outlined,
                        color: Colors.black),
                    label: const Text(
                      'Account',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(
                      value: 'Cancel Ticket',
                      child: const ListTile(
                        leading:
                            Icon(Icons.cancel_outlined, color: Colors.black),
                        title: Text('Cancel Ticket',
                            style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/home'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Change Travel Date',
                      child: const ListTile(
                        leading: Icon(Icons.calendar_month_outlined,
                            color: Colors.black),
                        title: Text('Change Travel Date',
                            style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/home'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Show My Ticket',
                      child: const ListTile(
                        leading: Icon(Icons.confirmation_number_outlined,
                            color: Colors.black),
                        title: Text('Show My Ticket',
                            style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/myBookings'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Email/SMS',
                      child: const ListTile(
                        leading:
                            Icon(Icons.email_outlined, color: Colors.black),
                        title:
                            Text('Email/SMS', style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/home'),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'Login/Sign Up',
                      child: const ListTile(
                        leading: Icon(Icons.login, color: Colors.black),
                        title: Text('Login/Sign Up',
                            style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomePage())),
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white,
                  elevation: 4,
                ),
              ],
            ),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined), label: 'Bookings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.help_outline), label: 'Help'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'My Account'),
        ],
        selectedItemColor: Colors.redAccent.shade700,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class BusBookingContent extends StatefulWidget {
  @override
  _BusBookingContentState createState() => _BusBookingContentState();
}

class _BusBookingContentState extends State<BusBookingContent> {
  bool _isExpanded = false;

  // Define the initial content and full content
  final String _shortContent =
      "Namma Savaari is India's largest brand for online bus ticket booking and offers an easy-to-use platform for booking both bus and train tickets. With over 36 million satisfied customers, 3500+ bus operators to choose from, and numerous offers, Namma Savaari makes road journeys highly convenient for travellers. Over the past 17 years, it has led the market in online bus bookings across thousands of cities and lakhs of routes in India.\n\nBooking a bus ticket online on the Namma Savaari app or website is very simple. You can download the app or visit nammasavaari.in and enter your source, destination, and travel date to check the top-rated bus services available. You can compare the cheapest ticket price, user ratings, and amenities, select your preferred seat, boarding and dropping points, and pay using multiple payment options like UPI, debit or credit cards, net banking, and more. With Namma Savaari, enjoy assured safe & secure payment methods, and guaranteed travel with the best seat and bus operator of your choice at an affordable ticket price. Once your payment is confirmed, all you need is your mobile m-ticket to show to the bus operator before boarding.";

  final String _fullContent =
      "Namma Savaari is India's largest brand for online bus ticket booking and offers an easy-to-use platform for booking both bus and train tickets. With over 36 million satisfied customers, 3500+ bus operators to choose from, and numerous offers, Namma Savaari makes road journeys highly convenient for travellers. Over the past 17 years, it has led the market in online bus bookings across thousands of cities and lakhs of routes in India.\n\nBooking a bus ticket online on the Namma Savaari app or website is very simple. You can download the app or visit nammasavaari.in and enter your source, destination, and travel date to check the top-rated bus services available. You can compare the cheapest ticket price, user ratings, and amenities, select your preferred seat, boarding and dropping points, and pay using multiple payment options like UPI, debit or credit cards, net banking, and more. With Namma Savaari, enjoy assured safe & secure payment methods, and guaranteed travel with the best seat and bus operator of your choice at an affordable ticket price. Once your payment is confirmed, all you need is your mobile m-ticket to show to the bus operator before boarding.\n\nNamma Savaari also offers other exclusive benefits, such as flexible ticket rescheduling options, easy cancellation policies, and instant payment refunds. The live bus tracking feature ensures you can plan your travel and never miss the bus. With redDeals, you can avail of additional discounts on your booking. Namma Savaari provides 24/7 customer support to resolve any queries.\n\nThe platform also offers Primo bus services, which have highly-rated buses at the lowest prices and provide best-in-class service. With Primo, enjoy a safe, comfortable, and on-time travel experience. You can also select multiple boarding and dropping points for your convenience.\n\nWith renowned private bus operators like Orange Travels, VRL Travels, SRS Travels, A1 Travels, and state government bus operators such as APSRTC, TSRTC, GSRTC, and Kerala RTC, Namma Savaari is a reliable platform for booking your bus tickets.";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Text
        const Text(
          'BOOK BUS TICKETS ONLINE',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
            height: 20), // Add some spacing between title and content

        // The expandable content text
        Text(
          _isExpanded ? _fullContent : _shortContent,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),

        // Read More / Read Less button
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'Read Less' : 'Read More',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now(); // Default to today's date
  String _fromPlace = "From City - 0"; // Default From place with ID
  String _toPlace = "To City - 0"; // Default To place with ID

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // YoutubePlayerController? _youtubeController;
  //
  // // Method to fetch bus data from the API
  // @override
  // void dispose() {
  //   _youtubeController?.dispose(); // Dispose of the YouTube player controller
  //   super.dispose();
  // }
  //
  // // Function to fetch and display videos in a carousel slider
  // Widget buildVideoCarousel() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: _firestore
  //         .collection('admin')
  //         .doc('youtube_video')
  //         .collection('videos')
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //       if (snapshot.hasError) {
  //         return Center(child: Text('Error: ${snapshot.error}'));
  //       }
  //       final videos = snapshot.data!.docs;
  //
  //       if (videos.isEmpty) {
  //         return Center(child: Text('No videos available'));
  //       }
  //
  //       return CarouselSlider(
  //         options: CarouselOptions(
  //           height: 200,
  //           autoPlay: false,
  //           enlargeCenterPage: true,
  //           viewportFraction: 0.8, // Set the fraction for center visibility
  //           aspectRatio: 16 / 9,
  //           enableInfiniteScroll: true, // Allows continuous scrolling
  //           initialPage: 1, // Start with the first video
  //         ),
  //         items: videos.map((video) {
  //           final videoUrl = video['url'];
  //           final videoId = _getVideoId(videoUrl);
  //           final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
  //           final videoTitle = video['title'] ?? '';
  //
  //           return GestureDetector(
  //             onTap: () => _playVideo(videoUrl),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.black26,
  //                     blurRadius: 4,
  //                     offset: Offset(0, 2),
  //                   ),
  //                 ],
  //               ),
  //               child: Stack(
  //                 children: [
  //                   ClipRRect(
  //                     child: Image.network(
  //                       thumbnailUrl,
  //                       width: double.infinity,
  //                       height: 200,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                   Positioned(
  //                     bottom: 0,
  //                     left: 0,
  //                     right: 0,
  //                     child: Container(
  //                       padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
  //                       color: Colors.black54,
  //                       child: Text(
  //                         videoTitle,
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                         maxLines: 1,
  //                         overflow: TextOverflow.ellipsis,
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       );
  //     },
  //   );
  // }
  //
  // void _playVideo(String videoUrl) async {
  //   // Open the YouTube video URL in the device's default browser
  //   if (await canLaunch(videoUrl)) {
  //     await launch(videoUrl);
  //   } else {
  //     throw 'Could not launch $videoUrl';
  //   }
  // }
  //
  // String _getVideoId(String url) {
  //   // Extract the video ID from the YouTube URL
  //   final RegExp regExp = RegExp(
  //     r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?|watch|.+\?v)=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
  //     caseSensitive: false,
  //   );
  //   final match = regExp.firstMatch(url);
  //   if (match != null) {
  //     return match.group(1) ?? '';
  //   }
  //   return '';
  // }
  //
  // // Function to fetch and display short videos in a carousel slider by navigating to youtube
  //
  // Widget buildShortVideoCarousel() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: _firestore
  //         .collection('admin')
  //         .doc('youtube_short')
  //         .collection('shorts')
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //       if (snapshot.hasError) {
  //         return Center(child: Text('Error: ${snapshot.error}'));
  //       }
  //       final videos = snapshot.data!.docs;
  //
  //       if (videos.isEmpty) {
  //         return Center(child: Text('No videos available'));
  //       }
  //
  //       return CarouselSlider.builder(
  //         options: CarouselOptions(
  //           height: 250,
  //           autoPlay: true,
  //           enlargeCenterPage: true,
  //           viewportFraction: 0.7,
  //           enableInfiniteScroll: true,
  //           autoPlayInterval: Duration(seconds: 3),
  //         ),
  //         itemCount: videos.length,
  //         itemBuilder: (context, index, _) {
  //           final video = videos[index];
  //           final videoUrl = video['url'];
  //           final videoId = _getShortVideoId(videoUrl);
  //           final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
  //           final videoTitle = video['title'] ?? '';
  //
  //           return GestureDetector(
  //             onTap: () => _openVideoInYouTube(videoId),
  //             child: AnimatedContainer(
  //               duration: Duration(milliseconds: 300),
  //               margin: EdgeInsets.symmetric(vertical: 8.0),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(15.0),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.black26,
  //                     blurRadius: 8,
  //                     offset: Offset(0, 4),
  //                   ),
  //                 ],
  //               ),
  //               child: Stack(
  //                 children: [
  //                   ClipRRect(
  //                     borderRadius: BorderRadius.circular(15.0),
  //                     child: Image.network(
  //                       thumbnailUrl,
  //                       width: double.infinity,
  //                       height: 250,
  //                       fit: BoxFit.cover,
  //                       color: Colors.black.withOpacity(0.3),
  //                       colorBlendMode: BlendMode.darken,
  //                     ),
  //                   ),
  //                   Positioned(
  //                     bottom: 0,
  //                     left: 0,
  //                     right: 0,
  //                     child: Container(
  //                       padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
  //                       decoration: BoxDecoration(
  //                         color: Colors.black54,
  //                         borderRadius: BorderRadius.circular(10.0),
  //                       ),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             videoTitle,
  //                             style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                             maxLines: 1,
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                           SizedBox(height: 4),
  //                           Row(
  //                             children: [
  //                               Icon(Icons.play_circle_filled, color: Colors.white, size: 20),
  //                               SizedBox(width: 5),
  //                               Text(
  //                                 "Watch Short video",
  //                                 style: TextStyle(
  //                                   color: Colors.white70,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  //
  // String _getShortVideoId(String url) {
  //   final RegExp regExp = RegExp(
  //     r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:shorts\/|(?:v|e(?:mbed)?|watch|.+\?v)=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
  //     caseSensitive: false,
  //   );
  //   final match = regExp.firstMatch(url);
  //   return match != null ? match.group(1) ?? '' : '';
  // }
  //
  // void _openVideoInYouTube(String videoId) async {
  //   final url = 'https://youtube.com/watch?v=$videoId'; // Standard video format URL
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // Function to fetch and display short videos in a carousel slider there only inside flutter app it self
  // Widget buildShortVideoCarousel() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: _firestore
  //         .collection('admin')
  //         .doc('youtube_short')
  //         .collection('shorts')
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //       if (snapshot.hasError) {
  //         return Center(child: Text('Error: ${snapshot.error}'));
  //       }
  //       final videos = snapshot.data!.docs;
  //
  //       if (videos.isEmpty) {
  //         return Center(child: Text('No videos available'));
  //       }
  //
  //       return CarouselSlider(
  //         options: CarouselOptions(
  //           height: 220, // Adjust the height as needed
  //           autoPlay: false,
  //           enlargeCenterPage: true,
  //           viewportFraction: 0.5, // Shows two items at a time
  //           enableInfiniteScroll: true,
  //         ),
  //         items: videos.map((video) {
  //           final videoUrl = video['url'];
  //           final videoId = _getShortVideoId(videoUrl);
  //           final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
  //           final videoTitle = video['title'] ?? '';
  //
  //           return GestureDetector(
  //             onTap: () => _playShortVideo(videoId),
  //             child: Container(
  //               margin: EdgeInsets.symmetric(horizontal: 5.0), // Space between videos
  //               decoration: BoxDecoration(
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.black26,
  //                     blurRadius: 4,
  //                     offset: Offset(0, 2),
  //                   ),
  //                 ],
  //               ),
  //               child: Stack(
  //                 children: [
  //                   ClipRRect(
  //                     borderRadius: BorderRadius.circular(15.0), // Round all corners
  //                     child: Image.network(
  //                       thumbnailUrl,
  //                       width: double.infinity,
  //                       height: 200,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                   // Positioned(
  //                   //   bottom: 0,
  //                   //   left: 0,
  //                   //   right: 0,
  //                   //   child: Container(
  //                   //     padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
  //                   //     color: Colors.black54,
  //                   //     child: Text(
  //                   //       videoTitle,
  //                   //       style: TextStyle(
  //                   //         color: Colors.white,
  //                   //         fontSize: 16,
  //                   //         fontWeight: FontWeight.bold,
  //                   //       ),
  //                   //       maxLines: 1,
  //                   //       overflow: TextOverflow.ellipsis,
  //                   //       textAlign: TextAlign.center,
  //                   //     ),
  //                   //   ),
  //                   // ),
  //                   Positioned(
  //                     bottom: 0,
  //                     left: 0,
  //                     right: 0,
  //                     child: Container(
  //                       padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
  //                       decoration: BoxDecoration(
  //                         color: Colors.black54, // Set color here within BoxDecoration
  //                         borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)), // Add border radius
  //                       ),
  //                       child: Text(
  //                         videoTitle,
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                         maxLines: 1,
  //                         overflow: TextOverflow.ellipsis,
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       );
  //     },
  //   );
  // }
  //
  // void _playShortVideo(String videoId) {
  //   // Dispose of any previous controller
  //   _youtubeController?.dispose();
  //
  //   // Create a new YoutubePlayerController
  //   _youtubeController = YoutubePlayerController(
  //     initialVideoId: videoId,
  //     flags: YoutubePlayerFlags(
  //       autoPlay: true,
  //       mute: false,
  //     ),
  //   );
  //
  //   // Show the video player in a dialog
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         backgroundColor: Colors.black,
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(15),
  //           child: Stack(
  //             children: [
  //               SizedBox(
  //                 width: double.infinity,
  //                 height: 400, // Height of the dialog
  //                 child: YoutubePlayer(
  //                   controller: _youtubeController!,
  //                   showVideoProgressIndicator: true,
  //                   progressIndicatorColor: Colors.deepPurpleAccent,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //
  //   // Add a listener to the controller to close the dialog when the video ends
  //   _youtubeController?.addListener(() {
  //     if (_youtubeController?.value.playerState == PlayerState.ended) {
  //       Navigator.of(context).pop(); // Close the dialog
  //     }
  //   });
  // }
  //
  // String _getShortVideoId(String url) {
  //   // Extract the video ID from the YouTube URL
  //   final RegExp regExp = RegExp(
  //     r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:shorts\/|(?:v|e(?:mbed)?|watch|.+\?v)=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
  //     caseSensitive: false,
  //   );
  //   final match = regExp.firstMatch(url);
  //   if (match != null) {
  //     return match.group(1) ?? '';
  //   }
  //   return '';
  // }

  // final TextEditingController _controller = TextEditingController();
  // bool _isSearching = false;

  // void _toggleSearch() {
  //   setState(() {
  //     _isSearching = !_isSearching;
  //     if (!_isSearching) {
  //       _controller.clear();
  //     }
  //   });
  // }

  // final List<String> imagePaths = [
  //   'assets/red_bus_caro_1.jpeg',
  //   'assets/Namma Savaari_caro_2.jpeg',
  //   'assets/Namma Savaari_caro_3.jpeg',
  //   'assets/red_bus_caro_4.jpeg',
  // ];
  // int _current = 0;

  Future<void> _showRateDialog(BuildContext context) async {
    final TextEditingController _reviewController = TextEditingController();
    double _rating = 0.0; // Variable to store the user's rating

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.only(bottom: 15),
          content: Container(
            height:
                MediaQuery.of(context).size.height * 0.75, // Increased height
            width: MediaQuery.of(context).size.width * 0.9, // Adjusted width
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image on top (without padding)
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/rate_rev.JPG', // Replace with your asset image
                      height: 250, // Updated image height
                      width: double.infinity, // Updated image width
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // "Rate Your Experience" Text
                FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    "Rate Your Experience",
                    style: TextStyle(
                      fontSize: 24, // Increased font size
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.blue.shade900, // Dark blue for better contrast
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Mandatory Rating input (stars)
                FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    unratedColor: Colors.grey.shade300,
                    // Light grey for unselected stars
                    glowColor: Colors.amber.withOpacity(0.3),
                    // Glow effect on hover
                    onRatingUpdate: (rating) {
                      _rating = rating;
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Optional Review input
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _reviewController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Write a review (Optional)...',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue.shade700),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Centered Buttons (Cancel and Submit)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Center buttons horizontally
                  children: [
                    // Cancel Button
                    TextButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors
                              .grey.shade700, // Grey color for cancel button
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 20), // Spacing between buttons
                    // Submit Button
                    ElevatedButton(
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        elevation: 5, // Add shadow
                      ),
                      onPressed: () async {
                        if (_rating == 0.0) {
                          // Show a message if rating is not provided
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please provide a rating!')),
                          );
                          return;
                        }

                        // Get the logged-in user's ID
                        final User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          String uid = user.uid; // Customer UID
                          String review = _reviewController.text;

                          try {
                            // Check if the user has already submitted a rating
                            var reviewSnapshot = await FirebaseFirestore
                                .instance
                                .collection('customers')
                                .doc(uid)
                                .collection('reviews')
                                .limit(1) // Limit to one review per customer
                                .get();

                            if (reviewSnapshot.docs.isNotEmpty) {
                              // Update the existing review
                              await FirebaseFirestore.instance
                                  .collection('customers')
                                  .doc(uid)
                                  .collection('reviews')
                                  .doc(reviewSnapshot.docs[0].id)
                                  .update({
                                'rating': _rating,
                                'review': review.isNotEmpty ? review : null,
                                'timestamp': FieldValue.serverTimestamp(),
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Rating updated successfully!')),
                              );
                            } else {
                              // Add a new review
                              await FirebaseFirestore.instance
                                  .collection('customers')
                                  .doc(uid)
                                  .collection('reviews')
                                  .add({
                                'rating': _rating,
                                'review': review.isNotEmpty ? review : null,
                                'timestamp': FieldValue.serverTimestamp(),
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Rating submitted successfully!')),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Failed to submit rating: $e')),
                            );
                          }
                        }

                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String selectedCategory = 'General';
  final Map<String, List<Map<String, String>>> faqData = {
    'General': [
      {
        'Can I track the location of my booked bus online?':
            'Yes, you can track your bus online by using our bus tracking app feature called “Track My Bus”. This feature allows passengers and their families to track the live bus location. You may follow your bus on a map and use the information to plan your trip to the boarding point and to get off at the correct stop. Family and friends may also check the bus position to schedule pick-ups and ensure safety.'
      },
      {
        'What are the advantages of purchasing a bus ticket with Namma Savaari?':
            'There are many advantages to purchasing online bus tickets with Namma Savaari. Namma Savaari is India’s most trusted bus ticket company, where you can book any type of private or government-owned bus. Namma Savaari allows you to find the different types of buses, choose the preferred bus seats, and find your nearest boarding and dropping points. You can also filter the buses based on timings, like morning, evening, etc. '
      },
      {
        'Why book bus tickets online on Namma Savaari?':
            'Booking bus tickets online on Namma Savaari is increasingly becoming the preferred choice for travellers due to its numerous advantages over traditional methods. With Namma Savaari, customers can book their bus tickets effortlessly from the comfort of their homes, avoiding the inconvenience of standing in long lines at bus stations or travel agencies. Online bus booking offers the luxury of comparing different bus schedules and operators and presents various discount offers and exclusive deals, resulting in significant savings. Payment security is another notable feature of online booking, which ensures that your financial information is well-protected against fraud. Additionally, customers can pick their seats, providing a customized travel experience. Online bus booking platforms give real-time updates about any changes in the bus timetable, including delays or cancellations, enabling better planning. The convenience doesn\'t stop here; travellers can even compare onboard amenities like charging points or snacks, further enhancing the travel experience.'
      },
      {
        'Do I need to create an account on the Namma Savaari site to book my bus ticket?':
            'No, you don’t have to create an account on the Namma Savaari site to book your bus ticket. But it is advisable to make one to accelerate the process next time you want to book bus tickets. Also, Namma Savaari has many discounts and offers that you can easily access if you have an account with us.'
      },
      {
        'Does bus booking online cost me more?':
            'Not at all! The bus ticket price is the same as you would get from the bus operator/ counter of any bus ticket agency. Namma Savaari reduces the travel budget by comparing the bus ticket prices among various operators, making it a more cost-effective choice. Therefore, online bus booking is increasingly recognized as a more convenient, efficient, and economical mode of securing travel arrangements.'
      },
      {
        'How can I get the discounts on the bus booking?':
            'To get a discount on bus booking, please visit https://www.nammasavaari.com and check the available offers. Copy the coupon code and paste it during checkout to avail of the discount.'
      },
      {
        'What\'s New in Bus Booking on Namma Savaari?':
            'Primo Bus Ticket: Namma Savaari has launched Primo bus services, where passengers can enjoy travelling in high-rated buses with best-in-class services. While looking for bus tickets on the desired route, customers can check the Primo tag to choose this excellent service. From hygiene standards to on-time service and comfort, passengers can benefit from the online bus booking experience from Primo buses.'
      },
    ],
    'Ticket Related': [
      {
        'How can I book bus tickets on Namma Savaari?':
            'Bus ticket Booking is effortless on Namma Savaari. To book the bus tickets, go to the main page and enter your source city and destination city in the “From” and “To” fields, respectively. Enter the travel date and hit the search button. Now, you will see the bus list available on the given bus route. You can use the filter option, such as duration, fare, bus type, etc., to rearrange the list accordingly. This makes it easier for customers to book their bus tickets online with Namma Savaari.'
      },
      {
        'Can I change the date of my journey after I have booked my bus ticket?':
            'Yes. You can change the journey date after booking a bus ticket on Namma Savaari by clicking the “Reschedule” icon if your travel plan might get interrupted while booking. Bus operators with the “Reschedule icon” next to it offer rescheduling of the bus ticket in case your initially selected date is not viable to travel on.'
      },
      {
        'Is it mandatory to take a printout of the ticket?':
            'It depends on the bus operator you have booked your online bus tickets with. Even mTickets are available on Namma Savaari. For operators that support mTickets, the SMS that is sent to your mobile can be produced at the time of boarding and you will be allowed to travel.For operators that do not support mTickets it is a must to take a printout of the e-ticket and produce it at the time of boarding. The e-ticket is sent to the e-mail ID provided at the time of boarding.To know which operators are mTicket enabled, look for the mTicket icon under the mTicket column while searching for buses.'
      },
      {
        'I\'ve lost my ticket. What should I do now?':
            'A copy of the bus ticket would have been sent to you by email when you booked bus ticket online. Please take a printout of that mail and produce it at the time of boarding. If you have not received the ticket e-mail, please call any of our call centers and our executive will resend you a copy by mail.'
      },
      {
        'What is an mTicket?':
            'An mTicket is an SMS that is sent to your mobile on booking bus tickets with select private bus operators. This SMS has the TIN number and the PNR number along with other ticket related information. It can be used to board the bus. Please note that not all operators accept mTickets. To know which operators are mTicket enabled, look for the mTicket icon under the mTicket column while searching for buses.'
      },
      {
        'I didn’t receive my mTicket. Can you resend it?':
            'You can generate your mTicket online. To generate m-Ticket online click on the Print/SMS ticket link on the Namma Savaari home page on www.Namma Savaari.in. Enter your TIN number mentioned on the e-ticket we emailed you. Choose the SMS option and click on Submit. In case you don’t have a copy of the e-ticket either, contact our call center and our executive will assist you.'
      },
      {
        'I entered the wrong mobile number while booking. Can I get my mTicket on a different number?':
            'Yes, you can get the m-Ticket on the different numbers.To get the M-Ticket on the different number please contact Namma Savaari call center and our customer executive will send you the mTicket on your desired number.'
      },
    ],
    'Payment': [
      {
        'Is it safe to use my credit or debit card to buy bus tickets on Namma Savaari?':
            'Transactions on Namma Savaari are very safe. We employ the best-in-class security and the transactions done are secure. Apart from being certified by Verisign, Namma Savaari uses Secure Socket Layers (SSL) data encryption. Using SSL ensures that the information exchanged with us is never transmitted unencrypted, thus protecting the information from being viewed by unauthorized individuals.'
      },
      {
        'Does the owner of the credit card/debit card with which the bus ticket is purchased need to be one of the passengers?':
            'Not at all! A passenger can use any debit or credit card to pay for the bus ticket, not necessarily their own. However, please note that the passenger in whose name the ticket is booked should carry a proof of his identity (along with the ticket) at the time of boarding the bus.'
      },
      {
        'What are the different payment options available on Bus Ticket booking?':
            'There are many payment modes available to book buses on the Namma Savaari website and app. Some of these payment modes are:\n'
                '• Debit Card/Credit Card/ATM Cards (Visa, MasterCard, Maestro & Rupay)\n'
                '• Net Banking (HDFC Bank, ICICI Bank, Indian Bank, Axis Bank, SBI, and all major banks)\n'
                '• UPI (Google Pay, Amazon Pay, PhonePe)\n'
                '• Book Now, Pay Later (Simpl)\n'
                '• Wallets (Paytm)\n\n'
                'Make sure to check the coupon code to get discounts on bus booking online. Namma Savaari offers a lot of redDeals to book bus tickets on a budget.'
      },
      {
        'How does the transaction appear on my card / account statement?':
            'Transactions on Namma Savaari will appear as Namma Savaari.IN, www.nammasavaari.com in your bank statement.'
      },
    ],
    'Cancellation & Refund': [
      {
        'Can I cancel my bus ticket online?':
            'Yes you can cancel bus tickets online, Most of the tickets can be canceled online. However, there are some bus tickets that can only be canceled through our call center.However please note that the cancellation fee and cancellation period may differ for specific bus services. Please contact any of our executives for cancellation details on any specific service.'
      },
      {
        'How can I cancel my bus ticket online?':
            'To cancel the bus ticket online, you need to click on the cancellation link provided on our home page. Enter your ticket number and the e-mail ID that was provided at the time of bus booking and click on cancel ticket.'
      },
      {
        'I missed the bus. Do I get a refund?':
            'Namma Savaari provides a 100% refund if the bus is missed due to either Namma Savaari or its partner company\'s fault. However, if the bus is missed due to any other reason not directly related to Namma Savaari no refund is provided.'
      },
      {
        'How can I get a refund in case I cancel my ticket?':
            'The refund is provided as per cancellation policy of the operator. The refund can be credited to the source of payment (Example: debit card, credit card, net banking) or credited to Namma Savaari wallet. Wallet credit can be used for bus booking in future (within 6 months of cancellation).'
      },
      {
        'What happens if the bus does not leave on time or is canceled?':
            'If your bus does not leave on time or is canceled, in such situations, you will need to consult the counter of the respective bus operators. You can also call the Namma Savaari customer care to discuss the appropriate actions.'
      },
    ],
  };

  // final List<String> popularBusRoutes =
  //     ["Delhi To Manali Bus|Delhi To Rishikesh Bus|Delhi To Shimla Bus|Delhi To Nainital Bus|Delhi To Katra Bus|Bangalore To Goa Bus|Bangalore To Hyderabad Bus|Bangalore To Tirupathi Bus|Bangalore To Chennai Bus|Bangalore To Pondicherry Bus|Hyderabad To Bangalore Bus|Hyderabad To Goa Bus|Hyderabad To Srisailam Bus|Hyderabad To Vijayawada Bus|Hyderabad To Tirupathi Bus|Pune To Goa Bus|Pune To Mumbai Bus|Pune To Nagpur Bus|Pune To Kolhapur Bus|Pune To Nashik Bus|Mumbai To Goa Bus|Mumbai To Pune Bus|Mumbai To Shirdi Bus|Mumbai To Mahabaleshwar Bus|Mumbai To Kolhapur Bus|Kolkata To Digha Bus|Kolkata To Siliguri Bus|Kolkata To Puri Bus|Kolkata To Bakkhali Bus|Kolkata To Mandarmani Bus|Chennai To Bangalore Bus|Chennai To Pondicherry Bus|Chennai To Coimbatore Bus|Chennai To Madurai Bus|Chennai To Tirupathi Bus|Chandigarh To Manali Bus|Chandigarh To Shimla Bus|Chandigarh To Delhi Bus|Chandigarh To Dehradun Bus|Chandigarh To Amritsar Bus|Coimbatore To Chennai Bus|Coimbatore To Bangalore Bus|Coimbatore To Ooty Bus|Coimbatore To Tiruchendur Bus|Coimbatore To Madurai Bus|Agra to Bareilly Bus|Hisar to Chandigarh Bus|Hisar to Delhi Bus|Lucknow to Ballia Bus|Lucknow to Moradabad Bus|Rajkot to Dwarka Bus|Siliguri to Gangtok Bus|Ahmedabad to Goa Bus|Ahmedabad to Kanpur Bus|Akola to Pune Bus|Delhi to Dehradun Bus|Delhi to Haridwar Bus|Dehradun to Delhi Bus|Delhi to Agra Bus|Delhi to Varanasi Bus"];
  //
  // final List<String> popularCities =
  //     ["Hyderabad Bus Booking|Bangalore Bus Booking|Chennai Bus Booking|Pune Bus Booking|Delhi Bus Booking|Mumbai Bus Booking|Kolkata Bus Booking|Ernakulam Bus Booking|Ahmedabad Bus Booking|Vijayawada Bus Booking|Jaipur Bus Booking|Indore Bus Booking|Lucknow Bus Booking|Bhopal Bus Booking|Goa Bus Booking|Ayodhya Bus Booking|Prayagraj Bus Booking|Varanasi Bus Booking"];
  //
  // final List<String> popularOperators =
  //     ["No 1 Air Travels|YBM Travels|Sri SMS Travels|Svkdt Travels|RKT Tours and Travels|Royal Cars|Rahul Travels|JBT Travels|Raj Express|Vaishali Express|Delhi Tours And Travels|Ashok Travels|Greenline Travels|Pawan Travels|Ravi Travels|VRL Travels|Dolphin Travels|Ganesh Travels|Kaveri Travels|National Travels|Bharathi Travels|City Land Travels|KKaveri Travels|KK Travels|Mahadev Travels|Maharaja Travels|M R Travels|New Payal Travels|Paras Travels|Shree Mahaveer Travels|SRS Travels|Tulsi Travels|Vaibhav Travels|Vikas Travels|Amarnath Travels|HRTC Bus|SBSTC|NBSTC|AI Travels"];
  //

  final List<String> popularBusRoutes = [
    "Delhi To Manali Bus",
    "Delhi To Rishikesh Bus",
    "Delhi To Shimla Bus",
    "Delhi To Nainital Bus",
    "Delhi To Katra Bus",
    "Bangalore To Goa Bus",
    "Bangalore To Hyderabad Bus",
    "Bangalore To Tirupathi Bus",
    "Bangalore To Chennai Bus",
    "Bangalore To Pondicherry Bus",
    "Hyderabad To Bangalore Bus",
    "Hyderabad To Goa Bus",
    "Hyderabad To Srisailam Bus",
    "Hyderabad To Vijayawada Bus",
    "Hyderabad To Tirupathi Bus",
    "Pune To Goa Bus",
    "Pune To Mumbai Bus",
    "Pune To Nagpur Bus",
    "Pune To Kolhapur Bus",
    "Pune To Nashik Bus",
    "Mumbai To Goa Bus",
    "Mumbai To Pune Bus",
    "Mumbai To Shirdi Bus",
    "Mumbai To Mahabaleshwar Bus",
    "Mumbai To Kolhapur Bus",
    "Kolkata To Digha Bus",
    "Kolkata To Siliguri Bus",
    "Kolkata To Puri Bus",
    "Kolkata To Bakkhali Bus",
    "Kolkata To Mandarmani Bus",
    "Chennai To Bangalore Bus",
    "Chennai To Pondicherry Bus",
    "Chennai To Coimbatore Bus",
    "Chennai To Madurai Bus",
    "Chennai To Tirupathi Bus",
    "Chandigarh To Manali Bus",
    "Chandigarh To Shimla Bus",
    "Chandigarh To Delhi Bus",
    "Chandigarh To Dehradun Bus",
    "Chandigarh To Amritsar Bus",
    "Coimbatore To Chennai Bus",
    "Coimbatore To Bangalore Bus",
    "Coimbatore To Ooty Bus",
    "Coimbatore To Tiruchendur Bus",
    "Coimbatore To Madurai Bus",
    "Agra to Bareilly Bus",
    "Hisar to Chandigarh Bus",
    "Hisar to Delhi Bus",
    "Lucknow to Ballia Bus",
    "Lucknow to Moradabad Bus",
    "Rajkot to Dwarka Bus",
    "Siliguri to Gangtok Bus",
    "Ahmedabad to Goa Bus",
    "Ahmedabad to Kanpur Bus",
    "Akola to Pune Bus",
    "Delhi to Dehradun Bus",
    "Delhi to Haridwar Bus",
    "Dehradun to Delhi Bus",
    "Delhi to Agra Bus",
    "Delhi to Varanasi Bus"
  ];

  final List<String> popularCities = [
    "Hyderabad Bus Booking",
    "Bangalore Bus Booking",
    "Chennai Bus Booking",
    "Pune Bus Booking",
    "Delhi Bus Booking",
    "Mumbai Bus Booking",
    "Kolkata Bus Booking",
    "Ernakulam Bus Booking",
    "Ahmedabad Bus Booking",
    "Vijayawada Bus Booking",
    "Jaipur Bus Booking",
    "Indore Bus Booking",
    "Lucknow Bus Booking",
    "Bhopal Bus Booking",
    "Goa Bus Booking",
    "Ayodhya Bus Booking",
    "Prayagraj Bus Booking",
    "Varanasi Bus Booking"
  ];

  final List<String> popularOperators = [
    "No 1 Air Travels",
    "YBM Travels",
    "Sri SMS Travels",
    "Svkdt Travels",
    "RKT Tours and Travels",
    "Royal Cars",
    "Rahul Travels",
    "JBT Travels",
    "Raj Express",
    "Vaishali Express",
    "Delhi Tours And Travels",
    "Ashok Travels",
    "Greenline Travels",
    "Pawan Travels",
    "Ravi Travels",
    "VRL Travels",
    "Dolphin Travels",
    "Ganesh Travels",
    "Kaveri Travels",
    "National Travels",
    "Bharathi Travels",
    "City Land Travels",
    "KKaveri Travels",
    "KK Travels",
    "Mahadev Travels",
    "Maharaja Travels",
    "M R Travels",
    "New Payal Travels",
    "Paras Travels",
    "Shree Mahaveer Travels",
    "SRS Travels",
    "Tulsi Travels",
    "Vaibhav Travels",
    "Vikas Travels",
    "Amarnath Travels",
    "HRTC Bus",
    "SBSTC",
    "NBSTC",
    "AI Travels"
  ];

  Color _getBackgroundColor(String couponCode) {
    int length = couponCode.length;
    if (length <= 5) {
      return Colors.amber.shade900; // Shorter codes have a green background
    } else if (length <= 10) {
      return Colors
          .redAccent.shade700; // Medium-length codes have a blue background
    } else {
      return Colors.cyanAccent; // Longer codes have a red background
    }
  }

  // Method to save city pairs to Firestore without duplicate check

  // Future<void> _saveCityPairToFirestore(String fromPlace, String toPlace) async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return; // Ensure the user is logged in
  //
  //   try {
  //     final userDocRef = FirebaseFirestore.instance
  //         .collection('customers')
  //         .doc(user.uid)
  //         .collection('recentCityPairs'); // Subcollection for recent city pairs
  //
  //     // Create a new document with the city pair
  //     await userDocRef.add({
  //       'fromPlace': fromPlace,
  //       'toPlace': toPlace,
  //       'timestamp': FieldValue.serverTimestamp(), // Add a timestamp for sorting
  //     });
  //
  //     print("City pair saved to Firestore: $fromPlace -> $toPlace");
  //   } catch (e) {
  //     print("Error saving city pair to Firestore: $e");
  //   }
  // }

  Future<void> _saveCityPairToFirestore(
      String fromPlace, String toPlace) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return; // Ensure the user is logged in

    try {
      final userDocRef = FirebaseFirestore.instance
          .collection('customers')
          .doc(user.uid)
          .collection('recentCityPairs'); // Subcollection for recent city pairs

      // Check if the same city pair already exists
      final querySnapshot = await userDocRef
          .where('fromPlace', isEqualTo: fromPlace)
          .where('toPlace', isEqualTo: toPlace)
          .get();

      // If the city pair does not exist, store it
      if (querySnapshot.docs.isEmpty) {
        // Add the new city pair
        await userDocRef.add({
          'fromPlace': fromPlace,
          'toPlace': toPlace,
          'timestamp': FieldValue.serverTimestamp(),
          // Add a timestamp for sorting
        });

        print("City pair saved to Firestore: $fromPlace -> $toPlace");

        // Fetch all city pairs to check the count
        final allPairsSnapshot = await userDocRef.orderBy('timestamp').get();

        // If there are more than 5 city pairs, delete the oldest ones
        if (allPairsSnapshot.docs.length > 5) {
          final pairsToDelete =
              allPairsSnapshot.docs.length - 5; // Number of pairs to delete
          for (int i = 0; i < pairsToDelete; i++) {
            await userDocRef
                .doc(allPairsSnapshot.docs[i].id)
                .delete(); // Delete the oldest pairs
            print(
                "Deleted old city pair: ${allPairsSnapshot.docs[i].data()['fromPlace']} -> ${allPairsSnapshot.docs[i].data()['toPlace']}");
          }
        }
      } else {
        print("City pair already exists in Firestore: $fromPlace -> $toPlace");
      }
    } catch (e) {
      print("Error saving city pair to Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:Colors.pink[50],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       'Book a Bus',
            //       style: TextStyle(
            //         fontSize: 22,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10.0,right: 10.0),
            //   child: Container(
            //     height: 210,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       border: Border.all(color: Colors.black, width: 1),
            //     ),
            //     child: Column(
            //       children: [
            //         Expanded(
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.directions_bus, // Bus icon
            //                   size: 40,
            //                   color: Colors.black,
            //                 ),
            //                 SizedBox(width: 10), // Space between the icon and text
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
            //                   mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            //                   children: [
            //                     Text(
            //                       "From",
            //                       style: TextStyle(fontSize: 10),
            //                     ),
            //                     SizedBox(height: 5), // Space between the two texts
            //                     // Text(
            //                     //   "Bengaluru",
            //                     //   style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            //                     // ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         Divider(
            //           color: Colors.black, // Black divider line
            //           thickness: 1, // Thickness of the divider
            //         ),
            //         Expanded(
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.directions_bus, // Bus icon
            //                   size: 40,
            //                   color: Colors.black,
            //                 ),
            //                 SizedBox(width: 10), // Space between the icon and text
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
            //                   mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            //                   children: [
            //                     Text(
            //                       "To",
            //                       style: TextStyle(fontSize: 10),
            //                     ),
            //                     SizedBox(height: 5), // Space between the two texts
            //
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         Divider(
            //           color: Colors.black, // Black divider line
            //           thickness: 1, // Thickness of the divider
            //         ),
            //         Expanded(
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.calendar_today, // Calendar icon
            //                   size: 40,
            //                   color: Colors.black,
            //                 ),
            //                 SizedBox(width: 10), // Space between the icon and text
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
            //                   mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            //                   children: [
            //                     GestureDetector(
            //                       onTap: () => _selectDate(context),
            //                       child: Text(
            //                         "Date of Journey",
            //                         style: TextStyle(fontSize: 10,),
            //                       ),
            //                     ),
            //                     SizedBox(height: 5), // Space between the text and the date
            //                     Text(
            //                       "${_selectedDate.toLocal()}".split(' ')[0], // Display the selected date
            //                       style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            Stack(
              children: [
                // Background Image
                Image.asset(
                  'assets/cover_picture1.jpg',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                // Search UI Container
                Positioned(
                  top: 110,
                  left: 210,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 3,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // From Selection
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("From",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54)),
                                GestureDetector(
                                  onTap: () async {
                                    final selected = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CitySelectionPage()),
                                    );
                                    if (selected != null) {
                                      setState(() {
                                        _fromPlace =
                                            "${selected['CityName']} - ${selected['CityId']}";
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.directions_bus_filled_outlined,
                                          color: Colors.grey[700]),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          _fromPlace.split(' - ')[0],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Swap Button and Divider
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 80,
                                child: const VerticalDivider(
                                    color: Colors.black54, thickness: 0.5),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    final temp = _fromPlace;
                                    _fromPlace = _toPlace;
                                    _toPlace = temp;
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.redAccent.shade700,
                                  radius: 14,
                                  child: const Icon(Icons.swap_horiz,
                                      color: Colors.white, size: 18),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 15),

                          // To Selection
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("To",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54)),
                                GestureDetector(
                                  onTap: () async {
                                    final selected = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CitySelectionPage()),
                                    );
                                    if (selected != null) {
                                      setState(() {
                                        _toPlace =
                                            "${selected['CityName']} - ${selected['CityId']}";
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.directions_bus_filled_outlined,
                                          color: Colors.grey[700]),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          _toPlace.split(' - ')[0],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const VerticalDivider(
                              color: Colors.black54, thickness: 0.5, width: 20),

                          // Date Selection
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _selectDate(context),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month_outlined,
                                      color: Colors.grey[700]),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "${_selectedDate.toLocal()}"
                                          .split(' ')[0],
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const VerticalDivider(
                              color: Colors.black54, thickness: 0.5, width: 20),

                          // Search Buses Button
                          ElevatedButton(
                            onPressed: () {
                              if (_fromPlace == "From City - 0" ||
                                  _toPlace == "To City - 0") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Please select source and destination cities!")),
                                );
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BusListPage(
                                    sourceCity: _fromPlace.split(' - ')[0],
                                    SourceCityId: _fromPlace.split(' - ')[1],
                                    destinationCity: _toPlace.split(' - ')[0],
                                    destinationCityId: _toPlace.split(' - ')[1],
                                    journeyDate: "${_selectedDate.toLocal()}"
                                        .split(' ')[0],
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            child: const Text("Search Buses",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Positioned(
                    left: 350,
                    top: 40,
                    child: Text('India\'s No. 1 Online Bus Ticket Booking Site',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Colors.red))),
              ],
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(top: 100, left: 100, right: 100),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Offers",
                        style: TextStyle(
                          fontSize: 28,
                          // Increased font size for prominence
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .blue.shade900, // Dark blue for better contrast
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Space between the two texts
                  // "Get best deals with great offers" text
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Get best deals with great offers",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),

                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('admin')
                        .doc('admin_offers')
                        .collection('offers')
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   return Center(child: CircularProgressIndicator());
                      // }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.redAccent.shade700),
                          minHeight: 5.0,
                        );
                      }

                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong'));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No offers available'));
                      }

                      final offers = snapshot.data!.docs;

                      return CarouselSlider.builder(
                        itemCount: offers.length,
                        options: CarouselOptions(
                          height: 200,
                          // Adjust the height as needed
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          enableInfiniteScroll: true,
                        ),
                        itemBuilder: (context, index, realIndex) {
                          final offer = offers[index];
                          final imageUrl = offer['imageUrl'];
                          final offerLine = offer['offerLine'];
                          final couponCode = offer['couponCode'];
                          final validTill = offer['validTill'];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OfferDetailsPage(
                                    imageUrl: imageUrl,
                                    offerLine: offerLine,
                                    couponCode: couponCode,
                                    validTill: validTill,
                                    terms: offer['terms'],
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                          child: Text('Error loading image'));
                                    },
                                  ),
                                  Positioned(
                                    top: 20,
                                    left: 10,
                                    right: 10,
                                    child: Text(
                                      offerLine,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(1, 1),
                                            blurRadius: 3,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 50,
                                    left: 10,
                                    right: 10,
                                    child: Text(
                                      'Valid Till: $validTill',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(1, 1),
                                            blurRadius: 3,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    left: 10,
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width -
                                                40, // Adjust based on padding
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: _getBackgroundColor(couponCode),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.local_offer,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            '$couponCode',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(1, 1),
                                                  blurRadius: 3,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                            overflow: TextOverflow
                                                .ellipsis, // Prevents overflow by truncating
                                          ),
                                        ],
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
                  //Ratings Functionality

                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align "Rate Us" to left
                          children: [
                            // "Rate Us" Text at the center-left
                            FadeInDown(
                              child: const Align(
                                alignment:
                                    Alignment.centerLeft, // Align to left
                                child: Text(
                                  "Rate Us",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),

                            // Container with image and text
                            FadeInLeft(
                              child: Container(
                                width: double.infinity,
                                height:
                                    180, // Increased height of the blue container by 20
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 3,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize
                                      .min, // Makes the column take only the needed space
                                  children: [
                                    Row(
                                      children: [
                                        // Image container
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, left: 10.0),
                                          child: Container(
                                            height:
                                                100, // Adjusted height for more space
                                            width:
                                                100, // Adjusted width for more space
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  5), // Added border radius for the image
                                              child: Image.asset(
                                                'assets/reate_review_pic.jpg', // Replace with your image asset
                                                fit: BoxFit
                                                    .fill, // Fill the entire space without maintaining aspect ratio
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                5), // Increased spacing between image and text

                                        // Texts inside the Container
                                        const Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment
                                                .center, // Center text vertically
                                            children: [
                                              Text(
                                                "Enjoying bus booking app?",
                                                style: TextStyle(
                                                  fontSize:
                                                      15, // Increased font size for visibility
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                      10), // Increased spacing between texts
                                              Text(
                                                "Share your thoughts with us and help spread the word to others!",
                                                style: TextStyle(
                                                  fontSize:
                                                      11, // Increased font size for readability
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    // "Rate Now" button at the bottom
                                    Container(
                                      height: 50,
                                      width: 400,
                                      child: ElasticIn(
                                        child: ElevatedButton(
                                          onPressed: () =>
                                              _showRateDialog(context),
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                Colors.redAccent.shade700,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 60, vertical: 15),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            elevation: 10,
                                            shadowColor: Colors
                                                .redAccent.shade700
                                                ?.withOpacity(0.5),
                                          ),
                                          child: const Text(
                                            'Rate Now',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items to opposite ends
                            //   children: [
                            //     Align(
                            //       alignment: Alignment.centerLeft,
                            //       child: Text(
                            //         "Trending Videos",
                            //         style: TextStyle(
                            //           fontSize: 22,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ),
                            //     ),
                            //     GestureDetector(
                            //       onTap: () {
                            //         // Navigate to the "View More" page
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(builder: (context) => ViewMorePage()),
                            //         );
                            //       },
                            //       child: Column(
                            //         children: [
                            //           Text(
                            //             "View More",
                            //             style: TextStyle(
                            //               fontSize: 18,
                            //               color: Colors.indigo,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //           Container(
                            //             height: 3, // Height of the underline
                            //             width: 90, // Width of the underline
                            //             color: Colors.indigo, // Color of the underline
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 10),
                            // //buildVideoCarousel(),
                            // SizedBox(height: 18,),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items to opposite ends
                            //   children: [
                            //     Align(
                            //       alignment: Alignment.centerLeft,
                            //       child: Text(
                            //         "Trending Shorts",
                            //         style: TextStyle(
                            //           fontSize: 22,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ),
                            //     ),
                            //     GestureDetector(
                            //       onTap: () {
                            //         // Navigate to the "View More" page
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(builder: (context) => ViewMoreShortsScreen()),
                            //         );
                            //       },
                            //       child: Column(
                            //         children: [
                            //           Text(
                            //             "View More",
                            //             style: TextStyle(
                            //               fontSize: 18,
                            //               color: Colors.indigo,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //           Container(
                            //             height: 3, // Height of the underline
                            //             width: 90, // Width of the underline
                            //             color: Colors.indigo, // Color of the underline
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 10),
                            //buildShortVideoCarousel(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(16),
                  //   // Add padding around the container
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     // Background color
                  //     borderRadius: BorderRadius.circular(20),
                  //     // Rounded corners
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.3), // Shadow color
                  //         blurRadius: 10,
                  //         spreadRadius: 3,
                  //         offset: Offset(0, 5), // Shadow position
                  //       ),
                  //     ],
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     // Align content to the start
                  //     children: [
                  //       // "Offers" Text
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 5.0),
                  //         child: Align(
                  //           alignment: Alignment.centerLeft,
                  //           child: Text(
                  //             "Offers",
                  //             style: TextStyle(
                  //               fontSize: 28,
                  //               // Increased font size for prominence
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.blue
                  //                   .shade900, // Dark blue for better contrast
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(height: 2), // Space between the two texts
                  //
                  //       // "Get best deals with great offers" Text
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 5.0),
                  //         child: Align(
                  //           alignment: Alignment.centerLeft,
                  //           child: Text(
                  //             "Get best deals with great offers",
                  //             style: TextStyle(
                  //               fontSize: 16,
                  //               color: Colors.grey[700],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(height: 20), // Space between text and carousel
                  //
                  //       // Carousel Slider for Offers
                  //       StreamBuilder<QuerySnapshot>(
                  //         stream: FirebaseFirestore.instance
                  //             .collection('admin')
                  //             .doc('admin_offers')
                  //             .collection('offers')
                  //             .orderBy('createdAt', descending: true)
                  //             .snapshots(),
                  //         builder: (context, snapshot) {
                  //           if (snapshot.connectionState ==
                  //               ConnectionState.waiting) {
                  //             return LinearProgressIndicator(
                  //               valueColor: AlwaysStoppedAnimation<Color>(
                  //                   Colors.redAccent.shade700),
                  //               minHeight: 5.0,
                  //             );
                  //           }
                  //
                  //           if (snapshot.hasError) {
                  //             return Center(
                  //                 child: Text('Something went wrong'));
                  //           }
                  //
                  //           if (!snapshot.hasData ||
                  //               snapshot.data!.docs.isEmpty) {
                  //             return Center(child: Text('No offers available'));
                  //           }
                  //
                  //           final offers = snapshot.data!.docs;
                  //
                  //           return CarouselSlider.builder(
                  //             itemCount: offers.length,
                  //             options: CarouselOptions(
                  //               height: 200,
                  //               // Adjust the height as needed
                  //               autoPlay: true,
                  //               autoPlayInterval: Duration(seconds: 3),
                  //               enlargeCenterPage: true,
                  //               aspectRatio: 16 / 9,
                  //               viewportFraction: 0.8,
                  //               enableInfiniteScroll: true,
                  //             ),
                  //             itemBuilder: (context, index, realIndex) {
                  //               final offer = offers[index];
                  //               final imageUrl = offer['imageUrl'];
                  //               final offerLine = offer['offerLine'];
                  //               final couponCode = offer['couponCode'];
                  //               final validTill = offer['validTill'];
                  //
                  //               return GestureDetector(
                  //                 onTap: () {
                  //                   Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                       builder: (context) => OfferDetailsPage(
                  //                         imageUrl: imageUrl,
                  //                         offerLine: offerLine,
                  //                         couponCode: couponCode,
                  //                         validTill: validTill,
                  //                         terms: offer['terms'],
                  //                       ),
                  //                     ),
                  //                   );
                  //                 },
                  //                 child: ClipRRect(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   child: Stack(
                  //                     fit: StackFit.expand,
                  //                     children: [
                  //                       Image.network(
                  //                         imageUrl,
                  //                         fit: BoxFit.cover,
                  //                         errorBuilder:
                  //                             (context, error, stackTrace) {
                  //                           return Center(
                  //                               child: Text(
                  //                                   'Error loading image'));
                  //                         },
                  //                       ),
                  //                       Positioned(
                  //                         top: 20,
                  //                         left: 10,
                  //                         right: 10,
                  //                         child: Text(
                  //                           offerLine,
                  //                           style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 18,
                  //                             fontWeight: FontWeight.bold,
                  //                             shadows: [
                  //                               Shadow(
                  //                                 offset: Offset(1, 1),
                  //                                 blurRadius: 3,
                  //                                 color: Colors.black,
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       Positioned(
                  //                         bottom: 50,
                  //                         left: 10,
                  //                         right: 10,
                  //                         child: Text(
                  //                           'Valid Till: $validTill',
                  //                           style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 14,
                  //                             shadows: [
                  //                               Shadow(
                  //                                 offset: Offset(1, 1),
                  //                                 blurRadius: 3,
                  //                                 color: Colors.black,
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       Positioned(
                  //                         bottom: 15,
                  //                         left: 10,
                  //                         child: Container(
                  //                           constraints: BoxConstraints(
                  //                             maxWidth: MediaQuery.of(context)
                  //                                     .size
                  //                                     .width -
                  //                                 40, // Adjust based on padding
                  //                           ),
                  //                           padding: EdgeInsets.symmetric(
                  //                               horizontal: 8, vertical: 4),
                  //                           decoration: BoxDecoration(
                  //                             color: _getBackgroundColor(
                  //                                 couponCode),
                  //                             borderRadius:
                  //                                 BorderRadius.circular(8),
                  //                           ),
                  //                           child: Row(
                  //                             mainAxisSize: MainAxisSize.min,
                  //                             children: [
                  //                               Icon(
                  //                                 Icons.local_offer,
                  //                                 color: Colors.white,
                  //                                 size: 18,
                  //                               ),
                  //                               SizedBox(width: 8),
                  //                               Text(
                  //                                 '$couponCode',
                  //                                 style: TextStyle(
                  //                                   color: Colors.white,
                  //                                   fontSize: 16,
                  //                                   shadows: [
                  //                                     Shadow(
                  //                                       offset: Offset(1, 1),
                  //                                       blurRadius: 3,
                  //                                       color: Colors.black,
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                                 overflow: TextOverflow
                  //                                     .ellipsis, // Prevents overflow by truncating
                  //                               ),
                  //                             ],
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
                  //     ],
                  //   ),
                  // ),

                  // SizedBox(height: 50),
                  // Stack(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(16.0),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         // Align content to the left
                  //         children: [
                  //           // "Rate Us" Text
                  //           FadeInDown(
                  //             child: Align(
                  //               alignment: Alignment.centerLeft,
                  //               // Align to left
                  //               child: Text(
                  //                 "Rate Us",
                  //                 style: TextStyle(
                  //                   fontSize: 28,
                  //                   // Larger font size for prominence
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.blue.shade900, // Dark blue for better contrast
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(height: 10),
                  //           // Spacing between text and container
                  //
                  //           // Container with image and text
                  //           FadeInLeft(
                  //             child: Container(
                  //               width: double.infinity,
                  //               height: 220,
                  //               // Increased height for better spacing
                  //               decoration: BoxDecoration(
                  //                 gradient: LinearGradient(
                  //                   colors: [
                  //                     Colors.blue.shade50,
                  //                     Colors.blue.shade100,
                  //                   ], // Gradient background
                  //                   begin: Alignment.topLeft,
                  //                   end: Alignment.bottomRight,
                  //                 ),
                  //                 borderRadius: BorderRadius.circular(20),
                  //                 // Rounded corners
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                     color: Colors.blue.withOpacity(0.3),
                  //                     // Shadow color
                  //                     blurRadius: 15,
                  //                     spreadRadius: 5,
                  //                     offset: Offset(0, 5), // Shadow position
                  //                   ),
                  //                 ],
                  //               ),
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(16.0),
                  //                 // Add padding inside the container
                  //                 child: Row(
                  //                   children: [
                  //                     // Image container
                  //                     Container(
                  //                       height: 140,
                  //                       // Adjusted height for more space
                  //                       width: 140,
                  //                       // Adjusted width for more space
                  //                       decoration: BoxDecoration(
                  //                         borderRadius:
                  //                             BorderRadius.circular(10),
                  //                         // Rounded corners for the image
                  //                         boxShadow: [
                  //                           BoxShadow(
                  //                             color: Colors.blue.withOpacity(
                  //                                 0.3), // Shadow for the image
                  //                             blurRadius: 10,
                  //                             spreadRadius: 3,
                  //                             offset: Offset(0, 5),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       child: ClipRRect(
                  //                         borderRadius:
                  //                             BorderRadius.circular(10),
                  //                         // Match container border radius
                  //                         child: Image.asset(
                  //                           'assets/reate_review_pic.jpg',
                  //                           // Replace with your image asset
                  //                           fit: BoxFit
                  //                               .cover, // Cover the entire space
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     SizedBox(width: 20),
                  //                     // Increased spacing between image and text
                  //
                  //                     // Texts inside the Container
                  //                     Expanded(
                  //                       child: Column(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         mainAxisAlignment: MainAxisAlignment
                  //                             .center, // Center text vertically
                  //                         children: [
                  //                           Text(
                  //                             "Enjoying our bus booking app?",
                  //                             style: TextStyle(
                  //                               fontSize: 20,
                  //                               // Increased font size for visibility
                  //                               fontWeight: FontWeight.bold,
                  //                               color: Colors.blue
                  //                                   .shade900, // Dark blue for better contrast
                  //                             ),
                  //                           ),
                  //                           SizedBox(height: 10),
                  //                           // Increased spacing between texts
                  //                           Text(
                  //                             "Share your thoughts with us and help spread the word to others!",
                  //                             style: TextStyle(
                  //                               fontSize: 14,
                  //                               // Increased font size for readability
                  //                               color: Colors.blue
                  //                                   .shade800, // Darker blue for better contrast
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(height: 20),
                  //           // Spacing between container and button
                  //
                  //           // "Rate Now" button at the bottom
                  //           Center(
                  //             child: ElasticIn(
                  //               child: ElevatedButton(
                  //                 onPressed: () => _showRateDialog(context),
                  //                 style: ElevatedButton.styleFrom(
                  //                   foregroundColor: Colors.white,
                  //                   backgroundColor: Colors.redAccent.shade700,
                  //                   padding: EdgeInsets.symmetric(
                  //                       horizontal: 60, vertical: 20),
                  //                   shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(30),
                  //                   ),
                  //                   elevation: 10,
                  //                   shadowColor: Colors.redAccent.shade700
                  //                       .withOpacity(0.5),
                  //                 ),
                  //                 child: Text(
                  //                   'Rate Now',
                  //                   style: TextStyle(
                  //                     fontSize: 18,
                  //                     // Increased font size for prominence
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  // SizedBox(height: 100),

                  Container(
                    height: 400, // Increased height for better web design
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD2635A), // Background color
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Align text to the left
                      children: [
                        // Text: "Enjoy the app"
                        const Text(
                          "Enjoy the app",
                          style: TextStyle(
                            fontSize: 28, // Larger font size
                            fontWeight: FontWeight.bold, // Bold text
                            color: Colors.white, // White color for contrast
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Spacing between text and content

                        // Main Content (Row with Features, QR Code, and Download Buttons)
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Left Section - Features & Ratings
                              Container(
                                padding: const EdgeInsets.all(20),
                                width: 350,
                                // Increased width
                                height: 250,
                                // Increased height
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    const Row(
                                      children: [
                                        Icon(Icons.check_circle,
                                            color: Colors.green),
                                        SizedBox(width: 8),
                                        Text(
                                          'Quick access',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    const Row(
                                      children: [
                                        Icon(Icons.check_circle,
                                            color: Colors.green),
                                        SizedBox(width: 8),
                                        Text(
                                          'Superior live tracking',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            const Text(
                                              '4.5 ★',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '50M+ downloads',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600]),
                                            ),
                                            const Text(
                                              'Play Store',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            height: 40,
                                            width: 1,
                                            color: Colors.grey[400]),
                                        Column(
                                          children: [
                                            const Text(
                                              '4.6 ★',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '50M+ downloads',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600]),
                                            ),
                                            const Text(
                                              'App Store',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Middle Section - QR Code
                              Column(
                                children: [
                                  const Text(
                                    'Scan to download',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 12),
                                  Image.asset(
                                    'assets/NammaSavaariQR.png',
                                    height: 200,
                                    width: 200,
                                  ),
                                ],
                              ),

                              // Right Section - Download Buttons
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Download the App on',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 12),
                                  Image.asset(
                                    'assets/playstore.png',
                                    width:
                                        170, // Increased size for better visibility
                                  ),
                                  const SizedBox(height: 12),
                                  Image.asset(
                                    'assets/appstore.png',
                                    width:
                                        170, // Increased size for better visibility
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: BusBookingContent(),
                  ),

                  const SizedBox(height: 100),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Main Heading
                          const Text(
                            'Bus Booking redDeals on Namma Savaari',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),

                          // Subtext
                          const Text(
                            'Don\'t miss out on these incredible offers, book your bus tickets now and travel with convenience and affordability. Hurry, grab the best bus booking deals before they\'re gone!',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 30),

                          // Offer Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left Section - Logo & Text
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/Namma_Savaari_LOGO1.png',
                                      // Replace with actual asset
                                      width: 100,
                                      height: 100,
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Unlock Unbeatable Exclusive redDeals! ',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        RichText(
                                          text: const TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '20% OFF',
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        const Row(
                                          children: [
                                            Text(' 3659 Deals  ',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(' | ',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(' 1758 Bus Operators ',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(' | ',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(' 216058 Routes ',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Right Section - Button
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Book now',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),

                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'FAQs related to Bus Tickets Booking',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: faqData.keys.map((category) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedCategory = category;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: selectedCategory == category
                                            ? Colors.red
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        category,
                                        style: TextStyle(
                                          color: selectedCategory == category
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Added to prevent overlapping
                            SizedBox(
                              height: 600,
                              // Fixed height to prevent infinite space issue
                              child: ListView(
                                children: faqData[selectedCategory]!.map((faq) {
                                  String question = faq.keys.first;
                                  String answer = faq[question]!;
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 20.0),
                                    child: ExpansionTile(
                                      title: Text(question,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(answer),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
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

            Container(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 100, right: 100),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildExpandableSection(
                              "Popular Bus Routes", popularBusRoutes),
                          const SizedBox(height: 20),
                          buildExpandableSection(
                              "Popular Cities", popularCities),
                          const SizedBox(height: 20),
                          buildExpandableSection(
                              "Popular Bus Operators", popularOperators),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align items to the top
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween, // Even spacing
                          children: [
                            // Logo & Description
                            Flexible(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/Namma_Savaari_LOGO1.png",
                                    width: 200,
                                  ),
                                  const SizedBox(height: 10),
                                  const SizedBox(
                                    width:
                                        300, // Set a fixed width for text to avoid overflow
                                    child: Text(
                                      "Namma Savaari is India's largest online bus ticket booking service trusted by over 25 million happy customers globally. We offer bookings through our website and mobile apps.",
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // About Namma Savaari
                            Flexible(
                              child: buildColumn_footer(
                                "About Namma Savaari",
                                [
                                  {
                                    "title": "About us",
                                    "destination": "/aboutus"
                                  },
                                  {
                                    "title": "Contact us",
                                    "destination": "/contactus"
                                  },
                                  {
                                    "title": "Namma Savaari on mobile",
                                    "destination":
                                        "https://play.google.com/store/apps/details?id=com.app.nammasavari.android"
                                  },
                                ],
                              ),
                            ),

                            // Info
                            Flexible(
                              child: buildColumn_footer(
                                "Info",
                                [
                                  {
                                    "title": "T&C",
                                    "destination": "/termsandcondition"
                                  },
                                  {
                                    "title": "Privacy policy",
                                    "destination": "/privacypolicy"
                                  },
                                  {"title": "FAQ", "destination": "/faq"},
                                ],
                              ),
                            ),

                            // Social Media
                            Flexible(
                              child: buildColumn_footer(
                                "Social Media",
                                [
                                  {
                                    "title": "Facebook",
                                    "destination":
                                        "https://www.facebook.com/people/Namma-Savaari/61573070618808/#"
                                  },
                                  {
                                    "title": "Instagram",
                                    "destination":
                                        "https://www.instagram.com/namma.savaari/?igsh=ODUxbm04ZmRucm13#"
                                  },
                                  {
                                    "title": "Twitter",
                                    "destination": "https://twitter.com"
                                  }, // Provide valid links
                                  {
                                    "title": "LinkedIn",
                                    "destination": "https://linkedin.com"
                                  },
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Copyright & Social Media
                        Column(
                          children: [
                            Divider(color: Colors.grey.shade300),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "© 2025 Namma Savaari India Pvt Ltd. All rights reserved",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _launchURL(
                                          "https://www.facebook.com/people/Namma-Savaari/61573070618808/#"),
                                      child: Image.asset(
                                        "assets/facebook.png",
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () => _launchURL(
                                          "https://www.instagram.com/namma.savaari/?igsh=ODUxbm04ZmRucm13#"),
                                      child: Image.asset(
                                        "assets/instagram.png",
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () => _launchURL(
                                          "https://www.linkedin.com"),
                                      child: Image.asset(
                                        "assets/linkedin.png",
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () =>
                                          _launchURL("https://www.twitter.com"),
                                      child: Image.asset(
                                        "assets/twitter.png",
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //
  //   if (pickedDate != null && pickedDate != _selectedDate) {
  //     setState(() {
  //       _selectedDate = pickedDate;
  //     });
  //   }
  // }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }

  Widget buildColumn_footer(
      String heading, List<Map<String, dynamic>> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        const SizedBox(height: 10),
        ...options.map((option) {
          return GestureDetector(
            onTap: () async {
              final destination = option['destination'];

              if (destination is String &&
                  Uri.tryParse(destination)?.hasScheme == true) {
                // Launch external URLs (Facebook, Instagram)
                if (await canLaunchUrl(Uri.parse(destination))) {
                  await launchUrl(Uri.parse(destination),
                      mode: LaunchMode.externalApplication);
                } else {
                  print('Could not launch $destination');
                }
              } else if (destination is String) {
                // Navigate to internal routes (GoRouter)
                print("Navigating to $destination"); // Debugging Log
                GoRouter.of(context).go(destination);
              } else {
                print("Invalid destination: $destination");
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                option['title'],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget buildExpandableSection(String title, List<String> items) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: items.map((item) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                  const Text("  |  ", style: TextStyle(color: Colors.grey)),
                  // Separator
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.redAccent.shade700, // Header background color
              onPrimary: Colors.pink.shade50, // Header text color
              onSurface: Colors.indigo, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent.shade700, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
}

// class BookingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Bookings Screen',
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
