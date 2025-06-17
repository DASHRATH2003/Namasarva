import 'package:flutter/material.dart';

import '../owner/FAQS_Admin.dart';
import '../owner/admin_home_screen.dart';
import 'customer_chat_screen.dart';
import 'customer_help_topics.dart';
import 'customer_new_bus_booking_predefined_messages.dart';
import 'customer_offers_predefined_screen.dart';
import 'customer_prefered_questions.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final List<HelpItem> helpItems = [
    HelpItem(
      title: 'Bus Tickets',
      icon: Icons.confirmation_number,
      destination: HelpTopicsScreen(),
    ),
    HelpItem(
      title: 'Technical Issues',
      icon: Icons.settings_suggest,
      destination: TechnicalSupportScreen(),
    ),
    HelpItem(
      title: 'New Bus Booking Help',
      icon: Icons.directions_bus,
      destination: CustomerNewBusBookingPredefinedScreen(),
    ),
    HelpItem(
      title: 'Offers Help',
      icon: Icons.local_offer,
      destination: CustomerOffersPredefinedScreen(),
    ),
    HelpItem(
      title: 'Chat with Us',
      icon: Icons.chat,
      destination: CustomerChatScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support"),
        backgroundColor: Colors.redAccent,
      ),
      body: Row(
        children: [
          _buildSideMenu(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select a Help Topic',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: helpItems.length,
                      itemBuilder: (context, index) {
                        return _buildHelpCard(helpItems[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideMenu() {
    return Container(
      width: 250,
      color: Colors.grey[200],
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Help Menu',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(),
          ...helpItems.map((item) => ListTile(
            leading: Icon(item.icon, color: Colors.redAccent),
            title: Text(item.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item.destination),
              );
            },
          )),
        ],
      ),
    );
  }

  Widget _buildHelpCard(HelpItem item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => item.destination),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(item.icon, color: Colors.redAccent, size: 30),
              SizedBox(width: 15),
              Text(
                item.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpItem {
  final String title;
  final IconData icon;
  final Widget destination;

  HelpItem({
    required this.title,
    required this.icon,
    required this.destination,
  });
}
