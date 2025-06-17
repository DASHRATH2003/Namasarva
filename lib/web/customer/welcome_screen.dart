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

import 'package:bus_booking_app/customer/sign_in_screen.dart';
import 'package:bus_booking_app/customer/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class WelcomePage_Web extends StatefulWidget {
  @override
  _WelcomePage_WebState createState() => _WelcomePage_WebState();
}

class _WelcomePage_WebState extends State<WelcomePage_Web> {
  Future<void> _signInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    bool isSigning = false;

    try {
      setState(() => isSigning = true);

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

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);

          setState(() => isSigning = false);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage_Web()),
          );
        }
      }
    } catch (e) {
      setState(() => isSigning = false);
      Fluttertoast.showToast(msg: "Error $e");
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
                    SizedBox(height: 20),
                    Text(
                      'Welcome to\nNamma Savaari!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        'assets/Namma_Savaari_LOGO1.png',
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Your journey starts here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.yellow,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
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
                    Container(
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
                            SizedBox(width: 10),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}