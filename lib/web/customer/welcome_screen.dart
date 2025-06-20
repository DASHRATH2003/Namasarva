import 'package:bus_booking_app/customer/home_screen.dart';
import 'package:bus_booking_app/customer/sign_in_screen.dart';
import 'package:bus_booking_app/customer/sign_up_screen.dart';
import 'package:bus_booking_app/customer/version_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart';

import 'home_screen.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isCheckingLoginStatus = true;
  bool _isSigningIn = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   UpdateChecker.checkForUpdate(context);
    // });
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
              MaterialPageRoute(builder: (_) => HomePage()),
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
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          final userRef =
              FirebaseFirestore.instance.collection('customers').doc(user.uid);

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
            MaterialPageRoute(builder: (_) => const HomePage()),
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
                              const SizedBox(width: 10),
                              const Text(
                                'Sign in with Google',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
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
