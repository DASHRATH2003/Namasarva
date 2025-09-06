//
// import 'package:bus_booking_app/firebase_options.dart';
// import 'package:bus_booking_app/customer/welcome_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// import 'customer/customer_prefered_questions.dart';
// import 'customer/customer_registration_screen.dart';
// import 'customer/home_screen.dart';
// import 'owner/admin_prefered_messages.dart';
// import 'owner/admin_sign_in_csreen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is fully initialized
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Welcome Page',
//       theme: ThemeData(
//         primarySwatch: Colors.pink,
//       ),
//       // home: WelcomePage(), // Set WelcomePage as the initial screen
//       home: AdminSignInScreen(), // Set WelcomePage as the initial screen
//       // home: CustomerChatScreen(), // Set WelcomePage as the initial screen
//
//       debugShowCheckedModeBanner: false, // To hide the debug banner
//     );
//   }
// }

//AIzaSyDJX-wndZeS6fQ3nxV60w7ANTAP2BCYLw4

// test 1  for notification

// import 'package:bus_booking_app/firebase_options.dart';
// import 'package:bus_booking_app/customer/welcome_screen.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// import 'customer/customer_prefered_questions.dart';
// import 'customer/customer_registration_screen.dart';
// import 'customer/home_screen.dart';
// import 'owner/admin_prefered_messages.dart';
// import 'owner/admin_sign_in_csreen.dart';
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // Handle background message
//   await Firebase.initializeApp();
//   print('Handling a background message: ${message.messageId}');
// }
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is fully initialized
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Welcome Page',
//       theme: ThemeData(
//         primarySwatch: Colors.pink,
//       ),
//       // home: WelcomePage(), // Set WelcomePage as the initial screen
//       home: AdminSignInScreen(), // Set WelcomePage as the initial screen
//       // home: CustomerChatScreen(), // Set WelcomePage as the initial screen
//
//       debugShowCheckedModeBanner: false, // To hide the debug banner
//     );
//   }
// }

// test 1  for to pop up notification

// import 'package:bus_booking_app/firebase_options.dart';
// import 'package:bus_booking_app/customer/welcome_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import 'customer/cust_loading_screen.dart';
// import 'customer/customer_account_deletion_screen.dart';
// import 'customer/customer_prefered_questions.dart';
// import 'customer/customer_registration_screen.dart';
// import 'customer/dummy_api_bus_booking.dart';
// import 'customer/home_screen.dart';
// import 'owner/admin_prefered_messages.dart';
// import 'owner/admin_sign_in_csreen.dart';
// import 'owner/admin_trendy_loading_screen.dart';
// import 'owner/admin_uploading_youtube_shorts.dart';
// import 'owner/admin_uploading_youtube_videos screen.dart';
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is fully initialized
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
//
//   // Initialize local notifications
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('@mipmap/ic_launcher');
//   const InitializationSettings initializationSettings =
//   InitializationSettings(android: initializationSettingsAndroid);
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Welcome Page',
//       theme: ThemeData(
//         primarySwatch: Colors.pink,
//       ),
//       home: TrendyLoadingScreen(), //  customer
//       // home: SplashScreen(), //  admin
//       // home: DeleteAccountScreen(), // Set WelcomePage as the initial screen
//       // home: PaymentScreen(), // Set WelcomePage as the initial screen
//
//
//       debugShowCheckedModeBanner: false, // To hide the debug banner
//     );
//   }
// }

// rzp_test_782RWKuWujgP9n key id Razorpay

// AJWU65JAbjfPOdOClm0LMvMF key secreat Razorpay

// upgraded bus booking application working properly

// import 'package:bus_booking_app/firebase_options.dart';
// import 'package:bus_booking_app/customer/welcome_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:provider/provider.dart';
//
// import 'customer/bus_search_screen.dart';
// import 'customer/cust_loading_screen.dart';
// import 'customer/customer_account_deletion_screen.dart';
// import 'customer/customer_prefered_questions.dart';
// import 'customer/customer_registration_screen.dart';
// import 'customer/dummy_api_bus_booking.dart';
// import 'customer/home_screen.dart';
// import 'customer/theme_provider.dart';
// import 'owner/admin_prefered_messages.dart';
// import 'owner/admin_sign_in_csreen.dart';
// import 'owner/admin_trendy_loading_screen.dart';
// import 'owner/admin_uploading_youtube_shorts.dart';
// import 'owner/admin_uploading_youtube_videos screen.dart';
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is fully initialized
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
//
//   // Initialize local notifications
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('@mipmap/ic_launcher');
//   const InitializationSettings initializationSettings =
//   InitializationSettings(android: initializationSettingsAndroid);
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ThemeProvider(),
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Get the current theme mode from the provider
//     final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
//     return MaterialApp(
//       title: 'Welcome Page',
//       theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
//       // theme: ThemeData(
//       //   primarySwatch: Colors.pink,
//       // ),
//       home: TrendyLoadingScreen(), //  customer
//       // home: SplashScreen(), //  admin
//       // home: SearchScreen(), // Set WelcomePage as the initial screen
//       // home: PaymentScreen(), // Set WelcomePage as the initial screen
//
//
//       debugShowCheckedModeBanner: false, // To hide the debug banner
//     );
//   }
// }

//final bus app 3/6/2025 for only android

// import 'package:bus_booking_app/firebase_options.dart';
// import 'package:bus_booking_app/customer/welcome_screen.dart';
// import 'package:bus_booking_app/phone_auth_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:provider/provider.dart';
//
// import 'customer/bus_search_screen.dart';
// import 'customer/bus_search_service.dart';
// import 'customer/cust_loading_screen.dart';
// import 'customer/customer_account_deletion_screen.dart';
// import 'customer/customer_prefered_questions.dart';
// import 'customer/customer_registration_screen.dart';
// import 'customer/dummy_api_bus_booking.dart';
// import 'customer/home_screen.dart';
// import 'customer/sign_in_screen.dart';
// import 'customer/theme_provider.dart';
// import 'customer/ticket_details_screen.dart';
// import 'owner/admin_prefered_messages.dart';
// import 'owner/admin_sign_in_csreen.dart';
// import 'owner/admin_trendy_loading_screen.dart';
// import 'owner/admin_uploading_youtube_shorts.dart';
// import 'owner/admin_uploading_youtube_videos screen.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
//
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// void main() async {
//   WidgetsFlutterBinding
//       .ensureInitialized(); // Ensure Flutter is fully initialized
//   await Firebase.initializeApp(
//       options:
//           DefaultFirebaseOptions.currentPlatform
//
//     // options: kIsWeb
//     //     ? FirebaseOptions(
//     //     apiKey: "AIzaSyAhBLX4RrIl2nRM3SIWAx_8nbMosuDqmDc",
//     //     authDomain: "bus-booking-application-aa7e5.firebaseapp.com",
//     //     projectId: "bus-booking-application-aa7e5",
//     //     storageBucket: "bus-booking-application-aa7e5.appspot.com",
//     //     messagingSenderId: "121392168783",
//     //     appId: "1:121392168783:web:d4fc748467fa3ca4144f3a",
//     //     measurementId: "G-QYW2G8MNBZ"
//     // )
//     //     : null,
//
//   );
//
//
//
//   // Initialize local notifications
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   const InitializationSettings initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ThemeProvider(),
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Get the current theme mode from the provider
//     final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
//     return MaterialApp(
//       title: 'Namma Savaari',
//       theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
//       // theme: ThemeData(
//       //   primarySwatch: Colors.pink,
//       // ),
//       // home: HomePage(), //  customer
//       home: TrendyLoadingScreen(), //  customer
//       // home: HomePage(), //  customer
//
//       // home: SplashScreen(), //  admin
//       // home: SearchScreen(), // Set WelcomePage as the initial screen
//       home: Payment(), // Set WelcomePage as the initial screen
//
//       debugShowCheckedModeBanner: false, // To hide the debug banner
//     );
//   }
// }

// With KisWeb updated final 13 production 09/02/2025

// import 'package:bus_booking_app/customer/version_checker.dart';
// import 'package:bus_booking_app/firebase_options.dart';
// import 'package:bus_booking_app/customer/welcome_screen.dart';
// import 'package:bus_booking_app/web/customer/about_Us.dart';
// import 'package:bus_booking_app/web/customer/contact_Us.dart';
// import 'package:bus_booking_app/web/customer/home_screen.dart';
// import 'package:bus_booking_app/web/customer/privacyPolicy_page.dart';
// import 'package:bus_booking_app/web/customer/terms_condition_page.dart';
// import 'package:bus_booking_app/web/customer/visi.dart';
// import 'package:bus_booking_app/web/services.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
//
// // Import the web utility file to check for mobile web
// import 'customer/customer_help_topics.dart';
// import 'web_utils.dart';
//
// import 'customer/theme_provider.dart';
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Initialize Firebase
//   await Firebase.initializeApp(
//     options: kIsWeb ? DefaultFirebaseOptions.currentPlatform : null,
//   );
//
//   // Initialize Local Notifications (only for mobile)
//   if (!kIsWeb &&
//       (defaultTargetPlatform == TargetPlatform.android ||
//           defaultTargetPlatform == TargetPlatform.iOS)) {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );
//
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ThemeProvider()),
//         ChangeNotifierProvider(create: (_) => CityProvider()),
//       ],
//       child: const VersionCheckWrapper(child: MyApp()),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
//     return MaterialApp(
//       title: 'Namma Savaari',
//       // theme: ThemeData(
//       //   fontFamily: kIsWeb ? "Montserrat" : null,
//       // ),
//       theme: ThemeData(
//         fontFamily: kIsWeb ? "Montserrat" : null,
//         brightness: isDarkMode ? Brightness.dark : Brightness.light,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: _getHomeScreen(),
//     );
//   }
//
//
//   /// Determines the correct home screen based on the platform
//   Widget _getHomeScreen() {
//     if (kIsWeb) {
//       // Ensure mobile web is detected correctly
//       return isMobileWeb() ? const WelcomePage() : HomePage_Web();
//     } else if (defaultTargetPlatform == TargetPlatform.android ||
//         defaultTargetPlatform == TargetPlatform.iOS) {
//       // Return the proper mobile home screen
//       return const WelcomePage(); // Change to your actual mobile home screen
//     } else {
//       // Default for other platforms like Windows, macOS, Linux
//       return HomePage_Web();
//     }
//   }
// }



// my dream


// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'myweb/login.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video Sharing App',
//       theme: ThemeData.dark(),
//       home: LoginPage(),
//     );
//   }
// }


// PISS

// import 'package:bus_booking_app/web/customer/about_Us.dart';
// import 'package:bus_booking_app/web/customer/contact_Us.dart';
// import 'package:bus_booking_app/web/customer/home_screen.dart';
// import 'package:bus_booking_app/web/customer/privacyPolicy_page.dart';
// import 'package:bus_booking_app/web/customer/terms_condition_page.dart';
// import 'package:bus_booking_app/web/customer/welcome_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
// import 'package:go_router/go_router.dart';
// import 'dart:html' as html;
//
// import 'customer/Bookings_screen.dart';
// import 'customer/customer_help_topics.dart';
// import 'customer/theme_provider.dart';
// import 'customer/cust_loading_screen.dart';
// import 'firebase_options.dart';
// import 'owner/admin_trendy_loading_screen.dart';
//
// // Local notifications plugin (only for mobile)
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Remove the "#" from the URL for web
//   if (kIsWeb) {
//     usePathUrlStrategy();
//   }
//
//   // Firebase Initialization
//   await Firebase.initializeApp(
//     options: kIsWeb ? DefaultFirebaseOptions.currentPlatform : null,
//   );
//
//   // Initialize Local Notifications (Only for Mobile)
//   if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );
//
//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ThemeProvider(),
//       child: const MyApp(),
//     ),
//   );
// }
//
// // Function to detect if it's mobile web
// bool isMobileWeb() {
//   return kIsWeb && html.window.navigator.userAgent.contains("Mobi");
// }
//
// // Define the Router Configuration
// final GoRouter _router = GoRouter(
//   initialLocation: "/",
//   routes: [
//     GoRoute(
//       path: "/",
//       builder: (context, state) => _getHomeScreen(),
//     ),
//     GoRoute(
//       path: "/home",
//       builder: (context, state) => HomePage_Web(),
//     ),
//     GoRoute(
//       path: "/termsandcondition",
//       builder: (context, state) => TermsAndConditionsScreen(),
//     ),
//     GoRoute(
//       path: "/privacypolicy",
//       builder: (context, state) => PrivacyPolicyScreen(),
//     ),
//     GoRoute(
//       path: "/faq",
//       builder: (context, state) => HelpTopicsScreen(),
//     ),
//     GoRoute(
//       path: "/aboutus",
//       builder: (context, state) => About_Us(),
//     ),
//     GoRoute(
//       path: "/helptopics",
//       builder: (context, state) => HelpTopicsScreen(),
//     ),
//     GoRoute(
//       path: "/contactus",
//       builder: (context, state) => Contact_Us(),
//     ),
//     GoRoute(
//       path: "/myBookings",
//       builder: (context, state) => BookingsScreen(),
//     ),
//     GoRoute(
//       path: "/signin",
//       builder: (context, state) => WelcomePage(),
//     ),
//   ],
// );
//
// // Function to determine the correct home screen based on the platform
// Widget _getHomeScreen() {
//   if (kIsWeb) {
//     return isMobileWeb() ? TrendyLoadingScreen() : HomePage_Web();
//   } else if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
//     return TrendyLoadingScreen(); // Change to your actual mobile home screen if needed
//   } else {
//     return HomePage_Web(); // Default for other platforms like Windows, macOS, Linux
//   }
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
//
//     return MaterialApp.router(
//       title: 'Namma Savaari',
//       theme: ThemeData(
//         fontFamily: kIsWeb ? "Montserrat" : null,
//         brightness: isDarkMode ? Brightness.dark : Brightness.light,
//       ),
//       debugShowCheckedModeBanner: false,
//       routerConfig: _router, // GoRouter navigation
//     );
//   }
// }
//
//



//kisweb


// import 'package:bus_booking_app/firebase_options.dart';
// import 'package:bus_booking_app/customer/welcome_screen.dart';
// import 'package:bus_booking_app/phone_auth_screen.dart';
// import 'package:bus_booking_app/web/customer/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
//
// // Import for detecting mobile web
// import 'dart:html' as html;
//
// import 'customer/bus_search_screen.dart';
// import 'customer/bus_search_service.dart';
// import 'customer/cust_loading_screen.dart';
// import 'customer/customer_account_deletion_screen.dart';
// import 'customer/customer_prefered_questions.dart';
// import 'customer/customer_registration_screen.dart';
// import 'customer/dummy_api_bus_booking.dart';
// import 'customer/home_screen.dart';
// import 'customer/sign_in_screen.dart';
// import 'customer/theme_provider.dart';
// import 'customer/ticket_details_screen.dart';
// import 'owner/admin_prefered_messages.dart';
// import 'owner/admin_sign_in_csreen.dart';
// import 'owner/admin_trendy_loading_screen.dart';
// import 'owner/admin_uploading_youtube_shorts.dart';
// import 'owner/admin_uploading_youtube_videos screen.dart';
//
// // Web-specific imports
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is fully initialized
//   await Firebase.initializeApp(
//     options: kIsWeb
//         ? FirebaseOptions(
//       apiKey: "AIzaSyAhBLX4RrIl2nRM3SIWAx_8nbMosuDqmDc",
//       authDomain: "bus-booking-application-aa7e5.firebaseapp.com",
//       projectId: "bus-booking-application-aa7e5",
//       storageBucket: "bus-booking-application-aa7e5.appspot.com",
//       messagingSenderId: "121392168783",
//       appId: "1:121392168783:web:d4fc748467fa3ca4144f3a",
//       measurementId: "G-QYW2G8MNBZ",
//     )
//         : null,
//   );
//
//   // Initialize local notifications for mobile
//   if (!kIsWeb) {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     const InitializationSettings initializationSettings =
//     InitializationSettings(android: initializationSettingsAndroid);
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ThemeProvider(),
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
//
//     // Detect if running on mobile web
//     bool isMobileWeb = kIsWeb && html.window.navigator.userAgent.contains("Mobi");
//
//     return MaterialApp(
//       title: 'Namma Savaari',
//       theme: ThemeData(fontFamily: kIsWeb ? "Montserrat" : null),
//       debugShowCheckedModeBanner: false,
//       home: (kIsWeb && !isMobileWeb) ? HomePage_Web() : TrendyLoadingScreen(),
//     );
//   }
// }


// sadhana cart application

//
// import 'package:bus_booking_app/sadhanaCart/customer/customer_home_screen.dart';
// import 'package:bus_booking_app/sadhanaCart/seller/sadhana_seller_home_layout.dart';
// import 'package:bus_booking_app/sadhanaCart/seller/seller_signin.dart';
// import 'package:flutter/material.dart';
// import 'package:animations/animations.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart'; // This file will be generated by `flutterfire configure`.
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform, // Add this line
//   );
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Bottom Navigation Bar Demo',
//       // theme: ThemeData(primarySwatch: Colors.blue),
//       theme: ThemeData(
//         appBarTheme: AppBarTheme(
//             iconTheme: IconThemeData(color: Colors.white),
//             foregroundColor: Colors.white),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0x3ff4a89f7),
//               foregroundColor: Colors.white,
//               elevation: 2,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
//           ),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//             filled: true,
//             fillColor: Colors.grey[100],
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: Colors.blue,
//                 width: 1,
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: Colors.blue,
//                 width: 1,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: Colors.blue,
//                 width: 1,
//               ),
//             ),
//             labelStyle: TextStyle(color: Colors.blue)
//         ),
//         primarySwatch: Colors.blue,
//       ),
//       home: SellerSignInScreen(),
//       // home: ImageToVideoScreen(),
//     );
//   }
// }
//




//



import 'package:bus_booking_app/customer/version_checker.dart';
import 'package:bus_booking_app/firebase_options.dart';
import 'package:bus_booking_app/customer/welcome_screen.dart';
import 'package:bus_booking_app/web/customer/about_Us.dart';
import 'package:bus_booking_app/web/customer/contact_Us.dart';
import 'package:bus_booking_app/web/customer/home_screen.dart';
import 'package:bus_booking_app/web/customer/privacyPolicy_page.dart';
import 'package:bus_booking_app/web/customer/terms_condition_page.dart';
import 'package:bus_booking_app/web/customer/visi.dart';
import 'package:bus_booking_app/web/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;

// Import utilities
import 'customer/customer_help_topics.dart';
import 'web_utils.dart';
import 'customer/theme_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: kIsWeb ? DefaultFirebaseOptions.currentPlatform : null,
  );

  // Initialize Local Notifications (only for mobile)
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CityProvider()),
      ],
      child: const VersionCheckWrapper(child: MyApp()),
    ),
  );
}

// ✅ GoRouter setup
final GoRouter _router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => _getHomeScreen(),
    ),
    GoRoute(
      path: "/home",
      builder: (context, state) => HomePage_Web(),
    ),
    GoRoute(
      path: "/termsandcondition",
      builder: (context, state) => TermsAndConditionsScreen(),
    ),
    GoRoute(
      path: "/privacypolicy",
      builder: (context, state) => PrivacyPolicyScreen(),
    ),
    GoRoute(
      path: "/faq",
      builder: (context, state) => HelpTopicsScreen(),
    ),
    GoRoute(
      path: "/aboutus",
      builder: (context, state) => About_Us(),
    ),
    GoRoute(
      path: "/contactus",
      builder: (context, state) => Contact_Us(),
    ),
    // GoRoute(
    //   path: "/services",
    //   builder: (context, state) => ServicesPage(),
    // ),
    // GoRoute(
    //   path: "/visi",
    //   builder: (context, state) => VisiPage(),
    // ),
    GoRoute(
      path: "/signin",
      builder: (context, state) => WelcomePage(),
    ),
  ],
);

/// Determines the correct home screen based on the platform
Widget _getHomeScreen() {
  if (kIsWeb) {
    // Ensure mobile web is detected correctly
    return isMobileWeb() ? const WelcomePage() : HomePage_Web();
  } else if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    return const WelcomePage(); // Mobile home
  } else {
    return HomePage_Web(); // Desktop
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return MaterialApp.router(
      title: 'Namma Savaari',
      theme: ThemeData(
        fontFamily: kIsWeb ? "Montserrat" : null,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router, // ✅ GoRouter instead of home:
    );
  }
}
