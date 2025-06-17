// bus_booking_application



import 'package:bus_booking_app/phone_auth_screen.dart';
import 'package:bus_booking_app/customer/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cust_forgot_password_screen.dart';
import 'home_screen.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false; // Track password visibility
  bool isSigning = false;

  // Future<void> _signIn() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       final email = _emailController.text.trim();
  //       final password = _passwordController.text.trim();
  //
  //       // Sign in user with email and password
  //       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //
  //       // Get the current user
  //       User? user = userCredential.user;
  //
  //       // Check if the user is not null
  //       if (user != null) {
  //         // Set the logged-in status
  //         final SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setBool('isLoggedIn', true);
  //
  //         // Store logged-in status in Firestore
  //         CollectionReference customers = FirebaseFirestore.instance.collection('customers');
  //         await customers.doc(user.uid).set({
  //           'isLoggedIn': true,
  //           'email': email, // Store the email or any other user info you need
  //           // You can also include other user information here
  //         }, SetOptions(merge: true)); // Use merge to avoid overwriting existing data
  //
  //         // Navigate to Home page
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => HomePage()),
  //         );
  //
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Sign In Successful!'),
  //             backgroundColor: Colors.blue,
  //           ),
  //         );
  //       }
  //     } on FirebaseAuthException catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(e.message ?? 'An error occurred'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }
  // }


  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();

        // Sign in user with email and password
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Set the logged-in status in SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        // Update logged-in status in Firestore
        final userId = userCredential.user?.uid; // Get the user ID
        if (userId != null) {
          await FirebaseFirestore.instance.collection('customers').doc(userId).set({
            'status': 'loggedIn',
          }, SetOptions(merge: true)); // Use merge to avoid overwriting existing data
        }

        // Navigate to Home page
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomePage()),
        // );

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage_Web()),
              (Route<dynamic> route) => false,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign In Successful!'),
            backgroundColor: Colors.blue,
          ),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'An error occurred'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }



  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // best

  // Future<void> _signInWithGoogle() async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  //   try {
  //     setState(() => isSigning = true);
  //
  //     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;
  //
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         idToken: googleSignInAuthentication.idToken,
  //         accessToken: googleSignInAuthentication.accessToken,
  //       );
  //
  //       UserCredential userCredential = await auth.signInWithCredential(credential);
  //       User? user = userCredential.user;
  //
  //       if (user != null) {
  //         final userRef = FirebaseFirestore.instance.collection('customers').doc(user.uid);
  //
  //         final docSnapshot = await userRef.get();
  //         if (!docSnapshot.exists) {
  //           await userRef.set({
  //             'email': user.email,
  //             'name': user.displayName,
  //             'createdAt': FieldValue.serverTimestamp(),
  //             'status': 'loggedIn', // Store loggedIn status
  //           });
  //         } else {
  //           await userRef.update({'status': 'loggedIn'}); // Update status to loggedIn if user exists
  //         }
  //
  //         // Save login status locally
  //         final SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setBool('isLoggedIn', true);
  //
  //         setState(() => isSigning = false);
  //
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (_) => HomePage()),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     setState(() => isSigning = false);
  //     Fluttertoast.showToast(msg: "Error $e");
  //   }
  // }

  //testing


  Future<void> _signInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    // Ensure Web Client ID is provided for Flutter Web
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: "849785301363-crltobi7dpniijhb07104ug0vem1vj25.apps.googleusercontent.com", // Web Client ID
      scopes: ['email'],
    );

    try {
      setState(() => isSigning = true);

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        setState(() => isSigning = false);
        Fluttertoast.showToast(msg: "Sign-in canceled");
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
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

        setState(() => isSigning = false);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage_Web()),
        );
      }
    } catch (e) {
      setState(() => isSigning = false);
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[300],
      // appBar: AppBar(
      //   title: Text("Sign In"),
      //   backgroundColor: Colors.pink[300],
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title Text
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // Email TextField
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@gmail.com')) {
                        return 'Email must be in the format of @gmail.com';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Password TextField
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible, // Password visibility
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Sign In Button
                  ElevatedButton(
                    onPressed: _signIn,
                    child: Text('Sign In'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.pink[300], backgroundColor: Colors.white, // Text color
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  // "Don't Have an account? Sign Up" Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do not have an account?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Sign In Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()), // Ensure you have a SignInScreen widget
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey[400],
                          thickness: 1,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Or login with',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[400],
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 55,
                    child: ElevatedButton(
                      // onPressed: () {
                      //   // Handle Google login
                      // },
                      onPressed: _signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        // side: BorderSide(color: Colors.grey),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Image.asset(
                                'assets/google_logo_officiall.png', // Add your Google logo image in the assets
                                width: 24,
                                height: 24,
                              ),
                            ),
                            TextSpan(
                              text: 'oogle',
                              style: TextStyle(color: Colors.black),
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
      ),
    );
  }
}




