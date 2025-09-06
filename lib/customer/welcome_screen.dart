// bus_booking_application

//success


// import 'dart:math';
//
// import 'package:bus_booking_app/customer/sign_in_screen.dart';
// import 'package:bus_booking_app/customer/sign_up_screen.dart';
// import 'package:flutter/material.dart';
//
// class WelcomePage extends StatefulWidget {
//   @override
//   _WelcomePageState createState() => _WelcomePageState();
// }
//
// class _WelcomePageState extends State<WelcomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.redAccent.shade700,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0), // Padding for the entire screen
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start, // Aligns all children to the left
//             children: [
//               // Welcome text
//               SizedBox(height: 50,),
//               Row(
//                 children: [
//                   Text(
//                     'Welcome',
//                     style: TextStyle(
//                       fontSize: 35,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white, // You can change this color
//                     ),
//                   ),
//                   SizedBox(width: 5),
//                   Text(
//                     'to',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.yellow, // Change color as needed
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'Namma Savaari!',
//                 style: TextStyle(
//                   fontSize: 50,
//                   fontFamily: 'DancingScript',
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white, // You can change this color
//                 ),
//               ),
//
//               SizedBox(height: 80), // Space between texts
//
//               // Centered subtitle
//               Center(
//                 child: Text(
//                   'Your journey starts here.',
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.yellow, // Change color as needed
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 20), // Space between subtitle and description
//
//               // Description text
//               Text(
//                 'Find, book, and travel with ease. Explore seamless bus ticket booking, special deals, '
//                     'and a hassle-free travel experience—just for you!',
//                 textAlign: TextAlign.center, // Center-aligns the text
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.white, // Change color as needed
//                 ),
//               ),
//
//               SizedBox(height: 50), // Space between description and buttons
//
//               // Sign-Up Button
//               Container(
//                 height: 50,
//                 width: double.infinity, // Full width button
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Navigate to Sign-Up screen
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => SignUpScreen()),
//                     );
//                   },
//                   child: Text('Sign Up',style: TextStyle(color: Colors.redAccent.shade700),),
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadiusDirectional.circular(8)
//                     ),
//                     backgroundColor: Colors.white, // Button color
//                     textStyle: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 20), // Space between buttons
//
//               // Sign-In Button
//               Container(
//                 height: 50,
//                 width: double.infinity, // Full width button
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Navigate to Sign-In screen
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => SignInScreen()),
//                     );
//                   },
//                   child: Text('Sign In',style: TextStyle(color: Colors.redAccent.shade700),),
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadiusDirectional.circular(8)
//                     ),
//                     backgroundColor: Colors.white, // Button color
//                     textStyle: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// Testing


/// good final updated because of client mindless
library;


// import 'package:bus_booking_app/customer/sign_in_screen.dart';
// import 'package:bus_booking_app/customer/sign_up_screen.dart';
// import 'package:bus_booking_app/web/customer/home_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'home_screen.dart';
//
// class WelcomePage extends StatefulWidget {
//   @override
//   _WelcomePageState createState() => _WelcomePageState();
// }
//
// class _WelcomePageState extends State<WelcomePage> {
//
//   Future<void> _signInWithGoogle() async {
//     final FirebaseAuth auth = FirebaseAuth.instance;
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//     bool isSigning = false;
//
//
//     try {
//       setState(() => isSigning = true);
//
//       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount.authentication;
//
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication.idToken,
//           accessToken: googleSignInAuthentication.accessToken,
//         );
//
//         UserCredential userCredential = await auth.signInWithCredential(credential);
//         User? user = userCredential.user;
//
//         if (user != null) {
//           final userRef = FirebaseFirestore.instance.collection('customers').doc(user.uid);
//
//           final docSnapshot = await userRef.get();
//           if (!docSnapshot.exists) {
//             await userRef.set({
//               'email': user.email,
//               'name': user.displayName,
//               'createdAt': FieldValue.serverTimestamp(),
//               'status': 'loggedIn', // Store loggedIn status
//             });
//           } else {
//             await userRef.update({'status': 'loggedIn'}); // Update status to loggedIn if user exists
//           }
//
//           // Save login status locally
//           final SharedPreferences prefs = await SharedPreferences.getInstance();
//           await prefs.setBool('isLoggedIn', true);
//
//           setState(() => isSigning = false);
//
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => HomePage()),
//           );
//         }
//       }
//     } catch (e) {
//       setState(() => isSigning = false);
//       Fluttertoast.showToast(msg: "Error $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.redAccent.shade700,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Top Section
//
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 20), // Add spacing at the top
//                   // Welcome Text
//                   Text(
//                     'Welcome to\nNamma Savaari!',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 36,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       height: 1.5,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//                   // Middle Section - Illustration
//                   Center(
//                     child: Image.asset(
//                       'assets/Namma_Savaari_LOGO1.png', // Replace with your asset image path
//                       height: 250,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Subtitle Text
//                   Text(
//                     'Your journey starts here.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.yellow,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//
//                   // Description Text
//                   Text(
//                     'Find, book, and travel with ease. Explore seamless bus ticket booking, special deals, '
//                         'and a hassle-free travel experience—just for you!',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                       height: 1.4,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//
//
//             // Bottom Section - Buttons
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 55,
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       // onPressed: () {
//                       //   // Handle Google login
//                       // },
//                       onPressed: _signInWithGoogle,
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.black,
//                         backgroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         // side: BorderSide(color: Colors.grey),
//                       ),
//                       child: RichText(
//                         text: TextSpan(
//                           children: [
//                             WidgetSpan(
//                               alignment: PlaceholderAlignment.middle,
//                               child: Image.asset(
//                                 'assets/google_logo_officiall.png', // Add your Google logo image in the assets
//                                 width: 24,
//                                 height: 24,
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'oogle',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 20), // Add spacing at the bottom
//           ],
//         ),
//       ),
//     );
//   }
// }



// susyyy



// import 'package:bus_booking_app/customer/sign_in_screen.dart';
// import 'package:bus_booking_app/customer/sign_up_screen.dart';
// import 'package:bus_booking_app/web/customer/home_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/scheduler.dart';
//
// import 'home_screen.dart';
//
// class WelcomePage extends StatefulWidget {
//   @override
//   _WelcomePageState createState() => _WelcomePageState();
// }
//
// class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   bool _isCheckingLoginStatus = true;
//   bool _isSigningIn = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     )..repeat();
//
//     // Check login status when widget initializes
//     _checkLoginStatus();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _checkLoginStatus() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//
//     if (isLoggedIn) {
//       // Get the current user ID
//       final User? user = FirebaseAuth.instance.currentUser;
//       final String? userId = user?.uid;
//
//       if (userId != null) {
//         // Fetch the login status from Firestore
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('customers')
//             .doc(userId)
//             .get();
//
//         if (userDoc.exists && userDoc['status'] == 'loggedIn') {
//           // Navigate to HomePage if the status is 'loggedIn'
//           SchedulerBinding.instance.addPostFrameCallback((_) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => HomePage()),
//             );
//           });
//           return;
//         }
//       }
//     }
//
//     // If not logged in or status not 'loggedIn', show sign-in options
//     setState(() {
//       _isCheckingLoginStatus = false;
//     });
//   }
//
//   Future<void> _signInWithGoogle() async {
//     setState(() {
//       _isSigningIn = true;
//     });
//
//     final FirebaseAuth auth = FirebaseAuth.instance;
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//
//     try {
//       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount.authentication;
//
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication.idToken,
//           accessToken: googleSignInAuthentication.accessToken,
//         );
//
//         UserCredential userCredential = await auth.signInWithCredential(credential);
//         User? user = userCredential.user;
//
//         if (user != null) {
//           final userRef = FirebaseFirestore.instance.collection('customers').doc(user.uid);
//
//           final docSnapshot = await userRef.get();
//           if (!docSnapshot.exists) {
//             await userRef.set({
//               'email': user.email,
//               'name': user.displayName,
//               'createdAt': FieldValue.serverTimestamp(),
//               'status': 'loggedIn',
//             });
//           } else {
//             await userRef.update({'status': 'loggedIn'});
//           }
//
//           // Save login status locally
//           final SharedPreferences prefs = await SharedPreferences.getInstance();
//           await prefs.setBool('isLoggedIn', true);
//
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => HomePage()),
//           );
//         }
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error $e");
//     } finally {
//       setState(() {
//         _isSigningIn = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.redAccent.shade700,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Top Section
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 20),
//                   Text(
//                     'Welcome to\nNamma Savaari!',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 36,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       height: 1.5,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Center(
//                     child: Image.asset(
//                       'assets/Namma_Savaari_LOGO1.png',
//                       height: 250,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Your journey starts here.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.yellow,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Find, book, and travel with ease. Explore seamless bus ticket booking, special deals, '
//                         'and a hassle-free travel experience—just for you!',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                       height: 1.4,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Bottom Section - Conditional rendering
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Column(
//                 children: [
//                   if (_isCheckingLoginStatus || _isSigningIn)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 20),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(5),
//                         child: LinearProgressIndicator(
//                           valueColor: _controller.drive(
//                             ColorTween(
//                               begin: Colors.white,
//                               end: Colors.pink,
//                             ),
//                           ),
//                           backgroundColor: Colors.white.withOpacity(0.3),
//                         ),
//                       ),
//                     )
//                   else
//                     Container(
//                       height: 55,
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: _signInWithGoogle,
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.black,
//                           backgroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         child: RichText(
//                           text: TextSpan(
//                             children: [
//                               WidgetSpan(
//                                 alignment: PlaceholderAlignment.middle,
//                                 child: Image.asset(
//                                   'assets/google_logo_officiall.png',
//                                   width: 24,
//                                   height: 24,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: 'oogle',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   SizedBox(height: 50),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// updating ui



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart';

import '../web/customer/home_screen.dart';
import 'home_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isCheckingLoginStatus = true;
  bool _isSigningIn = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Check login status when widget initializes
    _checkLoginStatus();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Get the current user ID
      final User? user = FirebaseAuth.instance.currentUser;
      final String? userId = user?.uid;

      if (userId != null) {
        // Fetch the login status from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('customers')
            .doc(userId)
            .get();

        if (userDoc.exists && userDoc['status'] == 'loggedIn') {
          // Navigate to HomePage if the status is 'loggedIn'
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomePage_Web()),
            );
          });
          return;
        }
      }
    }

    // If not logged in or status not 'loggedIn', show sign-in options
    setState(() {
      _isCheckingLoginStatus = false;
    });
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isSigningIn = true;
    });

    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential userCredential = await auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          final userRef = FirebaseFirestore.instance.collection('customers').doc(user.uid);

          final docSnapshot = await userRef.get();
          if (!docSnapshot.exists) {
            await userRef.set({
              'email': user.email,
              'name': user.displayName,
              'createdAt': FieldValue.serverTimestamp(),
              'status': 'loggedIn',
            });
          } else {
            await userRef.update({'status': 'loggedIn'});
          }

          // Save login status locally
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage_Web()),
          );
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error $e");
    } finally {
      setState(() {
        _isSigningIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.redAccent.shade700, Colors.black87],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome to\nNamma Savaari!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        'assets/Namma_Savaari_LOGO1.png',
                        height: 230,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Your journey starts here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.yellow,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Find, book, and travel with ease.\nEnjoy seamless bus ticket booking!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    if (_isCheckingLoginStatus || _isSigningIn)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: LinearProgressIndicator(
                            valueColor: _controller.drive(
                              ColorTween(
                                begin: Colors.white,
                                end: Colors.pink,
                              ),
                            ),
                            backgroundColor: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        height: 55,
                        width: 600,
                        child: ElevatedButton(
                          onPressed: _signInWithGoogle,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/google_logo_officiall.png',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Sign in with Google',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

