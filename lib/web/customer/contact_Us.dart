import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';


class Contact_Us extends StatefulWidget {
  const Contact_Us({super.key});

  @override
  State<Contact_Us> createState() => _About_UsState();
}

class _About_UsState extends State<Contact_Us> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 4,
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
                  icon: Icon(Icons.help_outline, color: Colors.black),
                  label: Text(
                    'Help',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                SizedBox(width: 16),
                PopupMenuButton<String>(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.account_circle_outlined, color: Colors.black),
                    label: Text(
                      'Account',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(
                      value: 'Cancel Ticket',
                      child: ListTile(
                        leading: Icon(Icons.cancel_outlined, color: Colors.black),
                        title: Text('Cancel Ticket', style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/home'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Change Travel Date',
                      child: ListTile(
                        leading: Icon(Icons.calendar_month_outlined, color: Colors.black),
                        title: Text('Change Travel Date', style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/home'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Show My Ticket',
                      child: ListTile(
                        leading: Icon(Icons.confirmation_number_outlined, color: Colors.black),
                        title: Text('Show My Ticket', style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/myBookings'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Email/SMS',
                      child: ListTile(
                        leading: Icon(Icons.email_outlined, color: Colors.black),
                        title: Text('Email/SMS', style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/home'),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'Login/Sign Up',
                      child: ListTile(
                        leading: Icon(Icons.login, color: Colors.black),
                        title: Text('Login/Sign Up', style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/signin'),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Background Image
                Image.asset(
                  'assets/contact_us.png',
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                ),

                Positioned(
                    left: 660,
                    top: 130,
                    child: Text('Contact Us',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Colors.black)
                    )
                ),
              ],
            ),

            Container(
              color: Color(0xFF141C27), // Dark background color
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Corporate Head Office-Bangalore",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // First Address Block
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "BANGALORE",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Namma Savaari, "
                                "\nFloor No: Ground floor,"
                                "\nBuilding No./Flat No: Sy.No/Plot No 50.51,"
                                "\nHAL 2nd Stage, Kodihalli Village,"
                                "\nName Of Premises/Building: Behind wadarahatti bus stand,"
                                "\nRoad/Street: Koppal Main Road wadarahatti,"
                                "\nGangawati, Koppal, Karnataka - 560008.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),

                      // Contact & Support Block
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ph: +91 9380690434",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "For any Support or Complaints: ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // Add your support chat link
                                },
                                child: Text(
                                  "Chat with Us",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Support Time : 24*7",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "For Press enquiries: nammasavaari1@gmail.com",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                          Text(
                            "Only for enquiries",
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
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
                    SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,  // Align items to the top
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Even spacing
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
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: 300,  // Set a fixed width for text to avoid overflow
                                    child: Text(
                                      "Namma Savaari is India's largest online bus ticket booking service trusted by over 25 million happy customers globally. We offer bookings through our website and mobile apps.",
                                      style: TextStyle(color: Colors.black87, fontSize: 14),
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
                                  {"title": "About us", "destination": "/aboutus"},
                                  {"title": "Contact us", "destination": "/contactus"},
                                  {"title": "Namma Savaari on mobile", "destination": "https://play.google.com/store/apps/details?id=com.app.nammasavari.android"},
                                ],
                              ),
                            ),

                            // Info
                            Flexible(
                              child: buildColumn_footer(
                                "Info",
                                [
                                  {"title": "T&C", "destination": "/termsandcondition"},
                                  {"title": "Privacy policy", "destination": "/privacypolicy"},
                                  {"title": "FAQ", "destination": "/faq"},
                                ],
                              ),
                            ),

                            // Social Media
                            Flexible(
                              child: buildColumn_footer(
                                "Social Media",
                                [
                                  {"title": "Facebook", "destination": "https://www.facebook.com/people/Namma-Savaari/61573070618808/#"},
                                  {"title": "Instagram", "destination": "https://www.instagram.com/namma.savaari/?igsh=ODUxbm04ZmRucm13#"},
                                  {"title": "Twitter", "destination": "https://twitter.com"},  // Provide valid links
                                  {"title": "LinkedIn", "destination": "https://linkedin.com"},
                                ],
                              ),
                            ),
                          ],
                        ),


                        SizedBox(height: 20),

                        // Copyright & Social Media
                        Column(
                          children: [
                            Divider(color: Colors.grey.shade300),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "© 2025 Namma Savaari India Pvt Ltd. All rights reserved",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/facebook.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/instagram.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/linkedin.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/twitter.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
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

  Widget buildColumn_footer(String heading, List<Map<String, dynamic>> options) {
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
        SizedBox(height: 10),
        ...options.map((option) {
          return GestureDetector(
            onTap: () async {
              final destination = option['destination'];

              if (destination is String && Uri.tryParse(destination)?.hasScheme == true) {
                // Launch external URLs (Facebook, Instagram)
                if (await canLaunchUrl(Uri.parse(destination))) {
                  await launchUrl(Uri.parse(destination), mode: LaunchMode.externalApplication);
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
}