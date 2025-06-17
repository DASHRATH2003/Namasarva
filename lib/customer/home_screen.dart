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
//   //   'assets/redbus_caro_2.jpeg',
//   //   'assets/redbus_caro_3.jpeg',
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bus_booking_app/customer/search_places_screen.dart';
import 'package:bus_booking_app/customer/view_more_shorts_screen.dart';
import 'package:bus_booking_app/customer/view_more_youtube_videos_screen.dart';
// Add this for date formatting
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'Bookings_screen.dart';
import 'busses_list_screen.dart';
import 'customer_account_screen.dart';
import 'customer_offers_details_screen.dart';
import 'help_screen.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;
  const HomePage({super.key, this.initialIndex = 0});

  @override
  _HomePageState createState() => _HomePageState();
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

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      BookingsScreen(),
      const HelpScreen(),
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
        title: const Text(
          "Namma Savaari",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'My Account'),
        ],
        selectedItemColor: Colors.redAccent.shade700,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now(); // Default to today's date
  String _fromPlace = "From City - 0"; // Default From place with ID
  String _toPlace = "To City - 0"; // Default To place with ID

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  YoutubePlayerController? _youtubeController;

  // Method to fetch bus data from the API
  @override
  void dispose() {
    _youtubeController?.dispose(); // Dispose of the YouTube player controller
    super.dispose();
  }

  // Function to fetch and display videos in a carousel slider
  Widget buildVideoCarousel() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('admin')
          .doc('youtube_video')
          .collection('videos')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final videos = snapshot.data!.docs;

        if (videos.isEmpty) {
          return const Center(child: Text('No videos available'));
        }

        return CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 0.8, // Set the fraction for center visibility
            aspectRatio: 16 / 9,
            enableInfiniteScroll: true, // Allows continuous scrolling
            initialPage: 1, // Start with the first video
          ),
          items: videos.map((video) {
            final videoUrl = video['url'];
            final videoId = _getVideoId(videoUrl);
            final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
            final videoTitle = video['title'] ?? '';

            return GestureDetector(
              onTap: () => _playVideo(videoUrl),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      child: Image.network(
                        thumbnailUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        color: Colors.black54,
                        child: Text(
                          videoTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _playVideo(String videoUrl) async {
    // Open the YouTube video URL in the device's default browser
    if (await canLaunch(videoUrl)) {
      await launch(videoUrl);
    } else {
      throw 'Could not launch $videoUrl';
    }
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

  // Function to fetch and display short videos in a carousel slider by navigating to youtube

  Widget buildShortVideoCarousel() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('admin')
          .doc('youtube_short')
          .collection('shorts')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final videos = snapshot.data!.docs;

        if (videos.isEmpty) {
          return const Center(child: Text('No videos available'));
        }

        return CarouselSlider.builder(
          options: CarouselOptions(
            height: 250,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.7,
            enableInfiniteScroll: true,
            autoPlayInterval: const Duration(seconds: 3),
          ),
          itemCount: videos.length,
          itemBuilder: (context, index, _) {
            final video = videos[index];
            final videoUrl = video['url'];
            final videoId = _getShortVideoId(videoUrl);
            final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
            final videoTitle = video['title'] ?? '';

            return GestureDetector(
              onTap: () => _openVideoInYouTube(videoId),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        thumbnailUrl,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.3),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              videoTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            const Row(
                              children: [
                                Icon(Icons.play_circle_filled,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 5),
                                Text(
                                  "Watch Short video",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
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
    );
  }

  String _getShortVideoId(String url) {
    final RegExp regExp = RegExp(
      r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:shorts\/|(?:v|e(?:mbed)?|watch|.+\?v)=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(url);
    return match != null ? match.group(1) ?? '' : '';
  }

  void _openVideoInYouTube(String videoId) async {
    final url =
        'https://youtube.com/watch?v=$videoId'; // Standard video format URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
  //   'assets/redbus_caro_2.jpeg',
  //   'assets/redbus_caro_3.jpeg',
  //   'assets/red_bus_caro_4.jpeg',
  // ];
  // int _current = 0;

  Future<void> _showRateDialog(BuildContext context) async {
    final TextEditingController reviewController = TextEditingController();
    double rating = 0.0; // Variable to store the user's rating

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.all(16.0),
            content: SizedBox(
              height:
                  MediaQuery.of(context).size.height * 0.45, // Adjusted height
              width: MediaQuery.of(context).size.width * 0.9, // Adjusted width
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image on top
                    FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          'assets/rate_rev.JPG', // Replace with your asset image
                          height: 180, // Updated image height
                          width: double.infinity, // Updated image width
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // "Rate Your Experience" Text
                    FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        "Rate Your Experience",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Mandatory Rating input (stars)
                    FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: RatingBar.builder(
                        initialRating: rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        unratedColor: Colors.grey, // Color for unselected stars
                        onRatingUpdate: (rating) {
                          rating = rating;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Optional Review input
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: TextField(
                        controller: reviewController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Write a review (Optional)...',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actionsPadding: const EdgeInsets.symmetric(
                horizontal: 16), // Adjust padding for buttons
            actionsAlignment:
                MainAxisAlignment.spaceBetween, // Arrange buttons properly
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                ),
                onPressed: () async {
                  if (rating == 0.0) {
                    // Show a message if rating is not provided
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please provide a rating!')),
                    );
                    return;
                  }

                  // Get the logged-in user's ID
                  final User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    String uid = user.uid; // Customer UID
                    String review = reviewController.text;

                    try {
                      // Check if the user has already submitted a rating
                      var reviewSnapshot = await FirebaseFirestore.instance
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
                          'rating': rating,
                          'review': review.isNotEmpty ? review : null,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Rating updated successfully!')),
                        );
                      } else {
                        // Add a new review
                        await FirebaseFirestore.instance
                            .collection('customers')
                            .doc(uid)
                            .collection('reviews')
                            .add({
                          'rating': rating,
                          'review': review.isNotEmpty ? review : null,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Rating submitted successfully!')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to submit rating: $e')),
                      );
                    }
                  }

                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

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
          'timestamp':
              FieldValue.serverTimestamp(), // Add a timestamp for sorting
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Book a Bus',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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

            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      // without two way icon

                      // Expanded(
                      //   child: GestureDetector(
                      //     onTap: () async {
                      //       final selectedCity = await Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => CitySelectionPage(),
                      //         ),
                      //       );
                      //
                      //       if (selectedCity != null) {
                      //         setState(() {
                      //           _fromPlace = "${selectedCity['CityName']} - ${selectedCity['CityId']}";
                      //         });
                      //       }
                      //     },
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Row(
                      //         children: [
                      //           Icon(
                      //             Icons.directions_bus, // Bus icon
                      //             size: 40,
                      //             color: Colors.black,
                      //           ),
                      //           SizedBox(width: 10), // Space between the icon and text
                      //           Expanded(
                      //             child: SingleChildScrollView(
                      //               scrollDirection: Axis.horizontal,
                      //               child: Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                      //                 mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                      //                 children: [
                      //                   Text(
                      //                     "From",
                      //                     style: TextStyle(fontSize: 10),
                      //                     overflow: TextOverflow.ellipsis, // This will truncate text with ellipsis
                      //                     maxLines: 1, // Limit the number of lines
                      //                   ),
                      //                   SizedBox(height: 5), // Space between the two texts
                      //                   Text(
                      //                     _fromPlace.split(' - ')[0], // Display selected From place
                      //                     style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Divider(color: Colors.black, thickness: 1), // Divider line
                      // Expanded(
                      //   child: GestureDetector(
                      //     onTap: () async {
                      //       final selectedCity = await Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => CitySelectionPage(),
                      //         ),
                      //       );
                      //
                      //       if (selectedCity != null) {
                      //         setState(() {
                      //           _toPlace = "${selectedCity['CityName']} - ${selectedCity['CityId']}";
                      //         });
                      //       }
                      //     },
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Row(
                      //         children: [
                      //           Icon(
                      //             Icons.directions_bus, // Bus icon
                      //             size: 40,
                      //             color: Colors.black,
                      //           ),
                      //           SizedBox(width: 10), // Space between the icon and text
                      //           Expanded(
                      //             child: SingleChildScrollView(
                      //               scrollDirection: Axis.horizontal,
                      //               child: Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                      //                 mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                      //                 children: [
                      //                   Text(
                      //                     "To",
                      //                     style: TextStyle(fontSize: 10),
                      //                   ),
                      //                   SizedBox(height: 5), // Space between the two texts
                      //                   Text(
                      //                     _toPlace.split(' - ')[0], // Display selected To place
                      //                     style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // with two way icon

                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final selected = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CitySelectionPage(),
                              ),
                            );

                            if (selected != null) {
                              setState(() {
                                if (selected.containsKey('fromPlace') &&
                                    selected.containsKey('toPlace')) {
                                  // If a city pair is selected
                                  _fromPlace = selected['fromPlace'];
                                  _toPlace = selected['toPlace'];
                                } else {
                                  // If a single city is selected
                                  _fromPlace =
                                      "${selected['CityName']} - ${selected['CityId']}";
                                }
                              });

                              // Save the city pair if both fromPlace and toPlace are selected
                              if (_toPlace.isNotEmpty &&
                                  _toPlace != "To City - 0") {
                                _saveCityPairToFirestore(_fromPlace, _toPlace);
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.directions_bus, // Bus icon
                                  size: 40,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                    width:
                                        10), // Space between the icon and text
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "From",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          _fromPlace.split(' - ')[
                                              0], // Display selected From place
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            flex: 7, // 70% of the row for the left divider
                            child: Divider(
                              color: Colors.black,
                              thickness: 1, // Divider thickness
                            ),
                          ),
                          Container(
                            width: 40, // 20% width for the icon container
                            alignment: Alignment
                                .center, // Center the icon inside the container
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Swap the From and To places
                                  final temp = _fromPlace;
                                  _fromPlace = _toPlace;
                                  _toPlace = temp;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.redAccent
                                      .shade700, // Icon background color
                                  shape: BoxShape
                                      .circle, // Circular shape for the icon
                                ),
                                padding: const EdgeInsets.all(
                                    10), // Padding around the icon
                                child: const Icon(
                                  Icons.swap_vert, // Swap icon
                                  size: 20, // Icon size
                                  color: Colors.white, // Icon color
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1, // 10% of the row for the right divider
                            child: Divider(
                              color: Colors.black,
                              thickness: 1, // Divider thickness
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final selected = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CitySelectionPage(),
                              ),
                            );

                            if (selected != null) {
                              setState(() {
                                if (selected.containsKey('fromPlace') &&
                                    selected.containsKey('toPlace')) {
                                  // If a city pair is selected
                                  _fromPlace = selected['fromPlace'];
                                  _toPlace = selected['toPlace'];
                                } else {
                                  // If a single city is selected
                                  _toPlace =
                                      "${selected['CityName']} - ${selected['CityId']}";
                                }
                              });

                              // Save the city pair if both fromPlace and toPlace are selected
                              if (_fromPlace.isNotEmpty &&
                                  _fromPlace != "From City - 0") {
                                _saveCityPairToFirestore(_fromPlace, _toPlace);
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.directions_bus, // Bus icon
                                  size: 40,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                    width:
                                        10), // Space between the icon and text
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "To",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          _toPlace.split(' - ')[
                                              0], // Display selected To place
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                          color: Colors.black, thickness: 1), // Divider line
                      // Expanded(
                      //   child: GestureDetector(
                      //     onTap: () => _selectDate(context), // Your existing date selection function
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Row(
                      //         children: [
                      //           Icon(
                      //             Icons.calendar_today, // Calendar icon
                      //             size: 40,
                      //             color: Colors.black,
                      //           ),
                      //           SizedBox(width: 10), // Space between the icon and text
                      //           Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                      //             mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                      //             children: [
                      //               Text(
                      //                 "Date of Journey",
                      //                 style: TextStyle(fontSize: 10),
                      //               ),
                      //               SizedBox(height: 5), // Space between the text and the date
                      //               Text(
                      //                 "${_selectedDate.toLocal()}".split(' ')[0], // Display the selected date
                      //                 style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      //tomorrow button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(
                              context), // Your existing date selection function
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Space between the text and the button
                              children: [
                                // Date and Text Column
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month, // Calendar icon
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                        width:
                                            10), // Space between the icon and text
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Align text to the start
                                      mainAxisAlignment: MainAxisAlignment
                                          .center, // Center vertically
                                      children: [
                                        const Text(
                                          "Date of Journey",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                            height:
                                                5), // Space between the text and the date
                                        Text(
                                          "${_selectedDate.toLocal()}"
                                                  .split(' ')[
                                              0], // Display the selected date
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Tomorrow Button
                                SizedBox(
                                  height:
                                      40, // Match height with other elements
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_fromPlace == "From City - 0" ||
                                          _toPlace == "To City - 0") {
                                        // Show SnackBar if either source or destination is not selected properly
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Please select source and destination cities!")),
                                        );
                                        return; // Don't navigate to the next page
                                      }
                                      print("From City: $_fromPlace");
                                      print("To City: $_toPlace");
                                      final tomorrow = DateTime.now().add(
                                          const Duration(
                                              days:
                                                  1)); // Calculate tomorrow's date
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BusListPage(
                                            sourceCity:
                                                _fromPlace.split(' - ')[0],
                                            SourceCityId:
                                                _fromPlace.split(' - ')[1],
                                            destinationCity:
                                                _toPlace.split(' - ')[0],
                                            destinationCityId:
                                                _toPlace.split(' - ')[1],
                                            journeyDate: "${tomorrow.toLocal()}"
                                                .split(' ')[0],
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.redAccent
                                          .shade700, // Text color for tomorrow button
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Rounded corners
                                      ),
                                    ),
                                    child: const Text(
                                      "Tomorrow",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //           Expanded(
            //             child: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Row(
            //                 children: [
            //                   Icon(
            //                     Icons.calendar_today, // Calendar icon
            //                     size: 40,
            //                     color: Colors.black,
            //                   ),
            //                   SizedBox(width: 10), // Space between the icon and text
            //                   Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
            //                     mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            //                     children: [
            //                       GestureDetector(
            //                         onTap: () => _selectDate(context), // Your existing date selection function
            //                         child: Text(
            //                           "Date of Journey",
            //                           style: TextStyle(fontSize: 10),
            //                         ),
            //                       ),
            //                       SizedBox(height: 5), // Space between the text and the date
            //                       Text(
            //                         "${_selectedDate.toLocal()}".split(' ')[0], // Display the selected date
            //                         style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

// Inside your widget where the Search button is placed
            // Inside the widget with the "Search" button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_fromPlace == "From City - 0" ||
                        _toPlace == "To City - 0") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please fill all fields!")),
                      );
                      return;
                    }
                    print(_fromPlace.split(' - ')[0]);
                    print(_fromPlace.split(' - ')[1]);
                    print(_toPlace.split(' - ')[0]);
                    print(_toPlace.split(' - ')[1]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BusListPage(
                          // sourceCity: _fromPlace,
                          sourceCity: _fromPlace.split(' - ')[0],
                          SourceCityId: _fromPlace.split(' - ')[1],
                          destinationCity: _toPlace.split(' - ')[0],
                          destinationCityId: _toPlace.split(' - ')[1],
                          journeyDate:
                              "${_selectedDate.toLocal()}".split(' ')[0],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.redAccent.shade700, // Text color
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    "Search Busses",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Offers",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2), // Space between the two texts
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
            // The carousel slider
            // CarouselSlider.builder(
            //   itemCount: imagePaths.length,
            //   itemBuilder: (context, index, realIndex) {
            //     return AnimatedContainer(
            //       duration: Duration(milliseconds: 500),
            //       curve: Curves.easeInOut,
            //       margin: EdgeInsets.symmetric(horizontal: 10.0),
            //       decoration: BoxDecoration(
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.5),
            //             spreadRadius: 5,
            //             blurRadius: 10,
            //             offset: Offset(0, 3),
            //           ),
            //         ],
            //         borderRadius: BorderRadius.circular(20), // Rounded corners
            //       ),
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(20), // Clip images to rounded corners
            //         child: Stack(
            //           children: [
            //             Positioned.fill(
            //               child: Image.asset(
            //                 imagePaths[index],
            //                 fit: BoxFit.cover,
            //                 alignment: Alignment.topCenter,
            //                 // Fade transition for smooth image change
            //               ),
            //             ),
            //             Container(
            //               decoration: BoxDecoration(
            //                 gradient: LinearGradient(
            //                   begin: Alignment.bottomCenter,
            //                   end: Alignment.topCenter,
            //                   colors: [
            //                     Colors.black.withOpacity(0.7),
            //                     Colors.transparent,
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             Positioned(
            //               bottom: 10,
            //               left: 20,
            //               child: Text(
            //                 "Image ${index + 1}",
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.bold,
            //                   color: Colors.white,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            //   options: CarouselOptions(
            //     height: 200,
            //
            //     autoPlay: true,
            //     enlargeCenterPage: true,
            //     autoPlayInterval: Duration(seconds: 3),
            //     aspectRatio: 16 / 9,
            //     viewportFraction: 0.8,
            //     onPageChanged: (index, reason) {
            //       setState(() {
            //         _current = index;
            //       });
            //     },
            //   ),
            // ),

            // SizedBox(height: 10),
            //
            // // Indicators below the carousel
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: imagePaths.asMap().entries.map((entry) {
            //     return GestureDetector(
            //       onTap: () => setState(() => _current = entry.key),
            //       child: AnimatedContainer(
            //         duration: Duration(milliseconds: 300),
            //         width: _current == entry.key ? 12.0 : 8.0,
            //         height: 8.0,
            //         margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: _current == entry.key
            //               ? Colors.pink[300]
            //               : Colors.grey.withOpacity(0.5),
            //         ),
            //       ),
            //     );
            //   }).toList(),
            // ),
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
                  return const Center(child: Text('Something went wrong'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No offers available'));
                }

                final offers = snapshot.data!.docs;

                return CarouselSlider.builder(
                  itemCount: offers.length,
                  options: CarouselOptions(
                    height: 200, // Adjust the height as needed
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
                                  maxWidth: MediaQuery.of(context).size.width -
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
            // Ratings Functionality

            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align "Rate Us" to left
                    children: [
                      // "Rate Us" Text at the center-left
                      FadeInDown(
                        child: const Align(
                          alignment: Alignment.centerLeft, // Align to left
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
                                    child: SizedBox(
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
                              SizedBox(
                                height: 50,
                                width: 400,
                                child: ElasticIn(
                                  child: ElevatedButton(
                                    onPressed: () => _showRateDialog(context),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          Colors.redAccent.shade700,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 60, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      elevation: 10,
                                      shadowColor: Colors.redAccent.shade700
                                          .withOpacity(0.5),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Align items to opposite ends
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Trending Videos",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to the "View More" page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewMorePage()),
                              );
                            },
                            child: Column(
                              children: [
                                const Text(
                                  "View More",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  height: 3, // Height of the underline
                                  width: 90, // Width of the underline
                                  color:
                                      Colors.indigo, // Color of the underline
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      buildVideoCarousel(),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Align items to opposite ends
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Trending Shorts",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to the "View More" page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ViewMoreShortsScreen()),
                              );
                            },
                            child: Column(
                              children: [
                                const Text(
                                  "View More",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  height: 3, // Height of the underline
                                  width: 90, // Width of the underline
                                  color:
                                      Colors.indigo, // Color of the underline
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      buildShortVideoCarousel(),
                    ],
                  ),
                ),
              ],
            ),
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
