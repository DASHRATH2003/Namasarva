// bus_booking_application

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../customer/commission_adding_screen.dart';
import 'FAQS_Admin.dart';
import 'admin_chat_overview.dart';
import 'admin_new_bus_booking_help_predefined.dart';
import 'admin_offers_predefined_messages_screen.dart';
import 'admin_offers_screen.dart';
import 'admin_prefered_messages.dart';
import 'admin_uploading_youtube_shorts.dart';
import 'admin_uploading_youtube_videos screen.dart';
import 'admin_wallet_history_screen.dart';
import 'admin_wallet_screen.dart';
class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedScreenIndex = 0; // Holds the selected screen index.

  File? _profileImage;
  String? _profileImageUrl;
  String? _adminName;
  String? _adminEmail;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  double _commissionPercentage = 0.0;


  @override
  void initState() {
    super.initState();
    _fetchProfileData();
    _loadCommission();
  }

  Future<void> _loadCommission() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _commissionPercentage = prefs.getDouble('commission_percentage') ?? 0.0;
    });
  }

  double _calculateCommissionPrice(double basePrice) {
    return basePrice * (1 + _commissionPercentage / 100);
  }

  // Fetches the profile image URL from Firestore if it exists.
  Future<void> _fetchProfileData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('admin').doc(user.uid).get();

      if (doc.exists) {
        setState(() {
          _profileImageUrl = doc.data()?['profileImage'];
          _adminName = doc.data()?['name']; // Make this optional; it will be null if not present
          _adminEmail = doc.data()?['email'] ?? 'admin@example.com';
        });
      }
    }
  }



  // Allows the user to pick an image and upload it to Firebase Storage.
  Future<void> _pickAndUploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });

      final user = _auth.currentUser;
      if (user != null && _profileImage != null) {
        try {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('adminProfileImages')
              .child('${user.uid}.jpg');

          await storageRef.putFile(_profileImage!);
          final imageUrl = await storageRef.getDownloadURL();

          // Save the download URL in Firestore.
          await FirebaseFirestore.instance
              .collection('admin')
              .doc(user.uid)
              .update({'profileImage': imageUrl});

          setState(() {
            _profileImageUrl = imageUrl;
          });
        } catch (e) {
          print('Error uploading profile image: $e');
        }
      }
    }
  }


  // List of screens to navigate to.
  final List<Widget> _screens = [
    const AdminChatScreen(), // Default Chat screen
    const AdminPredefinedMessagesScreen(),
    const AdminNewBusBookingHelpPredefinedMessagesScreen(),
    const AdminHelpTopicsScreen(),
    const OffersScreen(),
    const AdminOffersPredefinedMessagesScreen(),
    const AdminUploadingYoutubeVideosScreen(),
    const ShortVideoUploadPage(),
    const BalanceScreen(),
    const BalanceLogScreen(),
    const CommissionSettings(), // Add this new screen
  ];

  // List of drawer options (Text).
  final List<String> _drawerOptions = [
    'Chat',
    'Predefined Messages',
    'NewBusBookingPredefinedMessages',
    'FAQS',
    'Offers',
    'OffersPredefinedMessagesScreen',
    'AdminUploadingYoutubeVideosScreen',
    'ShortVideoUploadPage',
    'Wallet',
    'Wallet History',
    'Commission Settings', // Add this new option
  ];

  // List of titles for the AppBar corresponding to each screen.
  final List<String> _appBarTitles = [
    'Admin Chat',
    'Predefined Messages',
    'NewBusBookingPredefinedMessages',
    'FAQS',
    'Offers',
    'OffersPredefinedMessagesScreen',
    'AdminUploadingYoutubeVideosScreen',
    'ShortVideoUploadPage',
    'Wallet',
    'Wallet History',
    'Commission Settings', // Add this new title
  ];

  // Function to handle drawer item selection.
  void _onSelectDrawerItem(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
    Navigator.pop(context); // Close the drawer after selection.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedScreenIndex]), // Dynamic AppBar title
        backgroundColor: Colors.redAccent.shade700, // Pink color for app bar.
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Opens the drawer.
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings,color: Colors.white,size: 30,),
            onPressed: () async {
              final newCommission = await Navigator.push<double>(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommissionSettings(),
                ),
              );
              if (newCommission != null) {
                setState(() {
                  _commissionPercentage = newCommission;
                });
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.pink, Colors.deepOrange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 42,
                                backgroundImage: _profileImageUrl != null
                                    ? NetworkImage(_profileImageUrl!)
                                    : null,
                                child: _profileImageUrl == null
                                    ? Icon(Icons.person, size: 42, color: Colors.grey[400])
                                    : null,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 4,
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.redAccent.shade700,
                                    size: 16,
                                  ),
                                  onPressed: _pickAndUploadImage,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2), // Space between the avatar and the text fields.
                        Text(
                          _adminName ?? '', // Display the admin name or an empty string if not available.
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 1), // Space between the name and the email.
                        SizedBox(
                          width: double.infinity, // Takes full width
                          child: Align(
                            alignment: Alignment.center, // Ensures text is centered when short
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                _adminEmail ?? 'admin@example.com',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Drawer items.
            ListTile(
              leading: const Icon(Icons.chat),
              title: Text(_drawerOptions[0]), // Chat
              onTap: () => _onSelectDrawerItem(0),
            ),
            ListTile(
              leading: const Icon(Icons.report_gmailerrorred_outlined),
              title: Text(_drawerOptions[1]), // Predefined Messages
              onTap: () => _onSelectDrawerItem(1),
            ),
            ListTile(
              leading: const Icon(Icons.ad_units),
              title: Text(_drawerOptions[2]), // Advertisements
              onTap: () => _onSelectDrawerItem(2),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: Text(_drawerOptions[3]), // FAQS
              onTap: () => _onSelectDrawerItem(3),
            ),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: Text(_drawerOptions[4]), // Profile
              onTap: () => _onSelectDrawerItem(4),
            ),
            ListTile(
              leading: const Icon(Icons.stars),
              title: Text(_drawerOptions[5]), // Profile
              onTap: () => _onSelectDrawerItem(5),
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: Text(_drawerOptions[6]), // youtube videos
              onTap: () => _onSelectDrawerItem(6),
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: Text(_drawerOptions[7]), // youtube videos
              onTap: () => _onSelectDrawerItem(7),
            ),
            ListTile(
              leading: const Icon(Icons.wallet_rounded),
              title: Text(_drawerOptions[8]), // youtube videos
              onTap: () => _onSelectDrawerItem(8),
            ),
            ListTile(
              leading: const Icon(Icons.wallet_rounded),
              title: Text(_drawerOptions[9]), // youtube videos
              onTap: () => _onSelectDrawerItem(9),
            ),
            // ListTile(
            //   leading: Icon(Icons.monetization_on),
            //   title: Text(_drawerOptions[10]), // Commission Settings
            //   onTap: () => _onSelectDrawerItem(10),
            // ),
          ],
        ),
      ),
      body: _screens[_selectedScreenIndex], // Display selected screen.
    );
  }
}



// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'FAQS_Admin.dart';
// import 'admin_chat_overview.dart';
// import 'admin_chat_screen.dart';
// import 'admin_new_bus_booking_help_predefined.dart';
// import 'admin_offers_predefined_messages_screen.dart';
// import 'admin_offers_screen.dart';
// import 'admin_prefered_messages.dart';
// import 'admin_uploading_youtube_shorts.dart';
// import 'admin_uploading_youtube_videos screen.dart';
// import 'admin_wallet_history_screen.dart';
// import 'admin_wallet_screen.dart';
//
// class AdminHomeScreen extends StatefulWidget {
//   @override
//   _AdminHomeScreenState createState() => _AdminHomeScreenState();
// }
//
// class _AdminHomeScreenState extends State<AdminHomeScreen> {
//   int _selectedScreenIndex = 0;
//   File? _profileImage;
//   String? _profileImageUrl;
//   String? _adminName;
//   String? _adminEmail;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchProfileData();
//   }
//
//   Future<void> _fetchProfileData() async {
//     final user = _auth.currentUser;
//     if (user != null) {
//       final doc = await FirebaseFirestore.instance.collection('admin').doc(user.uid).get();
//       if (doc.exists) {
//         setState(() {
//           _profileImageUrl = doc.data()?['profileImage'];
//           _adminName = doc.data()?['name'];
//           _adminEmail = doc.data()?['email'] ?? 'admin@example.com';
//         });
//       }
//     }
//   }
//
//   Future<void> _pickAndUploadImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _profileImage = File(pickedFile.path);
//       });
//
//       final user = _auth.currentUser;
//       if (user != null && _profileImage != null) {
//         try {
//           final storageRef = FirebaseStorage.instance
//               .ref()
//               .child('adminProfileImages')
//               .child('${user.uid}.jpg');
//
//           await storageRef.putFile(_profileImage!);
//           final imageUrl = await storageRef.getDownloadURL();
//
//           await FirebaseFirestore.instance
//               .collection('admin')
//               .doc(user.uid)
//               .update({'profileImage': imageUrl});
//
//           setState(() {
//             _profileImageUrl = imageUrl;
//           });
//         } catch (e) {
//           print('Error uploading profile image: $e');
//         }
//       }
//     }
//   }
//
//   // Updated lists with all 10 items
//   final List<Widget> _screens = [
//     AdminChatScreen(),
//     AdminPredefinedMessagesScreen(),
//     AdminNewBusBookingHelpPredefinedMessagesScreen(),
//     AdminHelpTopicsScreen(),
//     OffersScreen(),
//     AdminOffersPredefinedMessagesScreen(),
//     AdminUploadingYoutubeVideosScreen(),
//     ShortVideoUploadPage(),
//     BalanceScreen(),
//     BalanceLogScreen(),
//   ];
//
//   final List<String> _drawerOptions = [
//     'Chat',
//     'Predefined Messages',
//     'NewBusBooking Help',
//     'FAQS',
//     'Offers',
//     'Offers Predefined Messages',
//     'YouTube Videos',
//     'YouTube Shorts',
//     'Wallet',
//     'Wallet History'
//   ];
//
//   final List<String> _appBarTitles = [
//     'Admin Chat',
//     'Predefined Messages',
//     'NewBusBooking Help',
//     'FAQS',
//     'Offers',
//     'Offers Predefined Messages',
//     'YouTube Videos',
//     'YouTube Shorts',
//     'Wallet',
//     'Wallet History'
//   ];
//
//   void _onSelectDrawerItem(int index) {
//     setState(() {
//       _selectedScreenIndex = index;
//     });
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_appBarTitles[_selectedScreenIndex]),
//         backgroundColor: Colors.pink,
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.menu),
//             onPressed: () => Scaffold.of(context).openDrawer(),
//           ),
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.pink, Colors.deepOrange],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.3),
//                     spreadRadius: 2,
//                     blurRadius: 6,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       CircleAvatar(
//                         radius: 45,
//                         backgroundColor: Colors.white,
//                         child: CircleAvatar(
//                           radius: 42,
//                           backgroundImage: _profileImageUrl != null
//                               ? NetworkImage(_profileImageUrl!)
//                               : null,
//                           child: _profileImageUrl == null
//                               ? Icon(Icons.person, size: 42, color: Colors.grey[400])
//                               : null,
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 4,
//                         child: CircleAvatar(
//                           radius: 14,
//                           backgroundColor: Colors.white,
//                           child: IconButton(
//                             icon: Icon(
//                               Icons.edit,
//                               color: Colors.pink,
//                               size: 16,
//                             ),
//                             onPressed: _pickAndUploadImage,
//                             padding: EdgeInsets.zero,
//                             constraints: BoxConstraints(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 2),
//                   Text(
//                     _adminName ?? '',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 2),
//                   Text(
//                     _adminEmail ?? 'admin@example.com',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Drawer items
//             ListTile(
//               leading: Icon(Icons.chat),
//               title: Text(_drawerOptions[0]),
//               onTap: () => _onSelectDrawerItem(0),
//             ),
//             ListTile(
//               leading: Icon(Icons.report_gmailerrorred_outlined),
//               title: Text(_drawerOptions[1]),
//               onTap: () => _onSelectDrawerItem(1),
//             ),
//             ListTile(
//               leading: Icon(Icons.ad_units),
//               title: Text(_drawerOptions[2]),
//               onTap: () => _onSelectDrawerItem(2),
//             ),
//             ListTile(
//               leading: Icon(Icons.help),
//               title: Text(_drawerOptions[3]),
//               onTap: () => _onSelectDrawerItem(3),
//             ),
//             ListTile(
//               leading: Icon(Icons.local_offer),
//               title: Text(_drawerOptions[4]),
//               onTap: () => _onSelectDrawerItem(4),
//             ),
//             ListTile(
//               leading: Icon(Icons.stars),
//               title: Text(_drawerOptions[5]),
//               onTap: () => _onSelectDrawerItem(5),
//             ),
//             ListTile(
//               leading: Icon(Icons.video_library),
//               title: Text(_drawerOptions[6]),
//               onTap: () => _onSelectDrawerItem(6),
//             ),
//             ListTile(
//               leading: Icon(Icons.video_library),
//               title: Text(_drawerOptions[7]),
//               onTap: () => _onSelectDrawerItem(7),
//             ),
//             ListTile(
//               leading: Icon(Icons.wallet_rounded),
//               title: Text(_drawerOptions[8]),
//               onTap: () => _onSelectDrawerItem(8),
//             ),
//             ListTile(
//               leading: Icon(Icons.history),
//               title: Text(_drawerOptions[9]),
//               onTap: () => _onSelectDrawerItem(9),
//             ),
//           ],
//         ),
//       ),
//       body: _screens[_selectedScreenIndex],
//     );
//   }
// }


