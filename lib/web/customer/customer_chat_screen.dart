// bus_booking_application

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

class CustomerChatScreen extends StatefulWidget {
  @override
  _CustomerChatScreenState createState() => _CustomerChatScreenState();
}

class _CustomerChatScreenState extends State<CustomerChatScreen> {
  final _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String customerId; // To hold the logged-in customer's ID

  @override
  void initState() {
    super.initState();
    _getCustomerId();
    _listenForMessages(); // Start listening for new messages
  }


// Listen for incoming messages
  void _listenForMessages() {
    _firestore
        .collection('customers')
        .doc(customerId) // Customer-specific document
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final messageData = change.doc.data();
          final isAdminMessage = messageData?['isAdminMessage'] ?? false;

          if (isAdminMessage) {
            // If it's an admin message, show a notification to the customer
            _showNotification('New Message', 'Admin: ${messageData?['text']}');
          }
        }
      }
    });
  }

  void _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // Channel ID
      'your_channel_name', // Channel name
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title, // Notification title
      body, // Notification body
      platformChannelSpecifics,
      payload: 'New message received',
    );
  }



  // Get the current user's ID
  void _getCustomerId() {
    User? user = _auth.currentUser; // Fetch the current user
    if (user != null) {
      customerId = user.uid; // Use the user's ID as the customer ID
    } else {
      // Handle the case when the user is not logged in
      print("No user is currently logged in.");
      // Optionally, you can navigate back or show a message
    }
  }

  // Function to send messages to the customer-specific 'messages' subcollection
  void _sendMessage() {
    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      _firestore
          .collection('customers')
          .doc(customerId) // Use the specific customer's document ID
          .collection('messages') // Store the message in the customer's 'messages' subcollection
          .add({
        'text': messageText,
        'senderId': customerId, // Link the message to the customer
        'isAdminMessage': false, // Flag to indicate it's from the customer, not the admin
        'timestamp': FieldValue.serverTimestamp(),
      }).then((_) {
        _messageController.clear(); // Clear the input field after sending
      }).catchError((error) {
        print("Error sending message: $error");
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent.shade700,
        title: Text('Customer Chat'),
      ),
      body: Column(
        children: [
          // Display messages
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('customers')
                  .doc(customerId) // Query messages for this specific customer
                  .collection('messages') // Only get messages from this customer's 'messages' subcollection
                  .orderBy('timestamp', descending: false) // Sort messages by timestamp ascending
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data!.docs;

                // Group messages by date
                Map<String, List<Map<String, dynamic>>> groupedMessages = {};
                for (var message in messages) {
                  final messageData = message.data() as Map<String, dynamic>;
                  final timestamp = messageData['timestamp'] as Timestamp?;
                  if (timestamp != null) {
                    final date = DateFormat('yyyy-MM-dd').format(timestamp.toDate());
                    if (!groupedMessages.containsKey(date)) {
                      groupedMessages[date] = [];
                    }
                    groupedMessages[date]!.add(messageData);
                  }
                }

                // Create a list of message widgets
                List<Widget> messageWidgets = [];
                groupedMessages.forEach((date, messages) {
                  // Get the day name from the date
                  final dayName = DateFormat('EEEE').format(DateTime.parse(date));

                  // Add a centered date header
                  messageWidgets.add(
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Text(
                            dayName, // Day name
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            date, // Date
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  );
                  for (var messageData in messages) {
                    final isAdminMessage = messageData['isAdminMessage'] ?? false;

                    // Extracting the timestamp for the time display
                    final timestamp = messageData['timestamp'] as Timestamp?;
                    String messageTime = '';
                    if (timestamp != null) {
                      messageTime = DateFormat('hh:mm a').format(timestamp.toDate()); // Formatting the time
                    }
                    messageWidgets.add(
                      Align(
                        alignment: isAdminMessage ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isAdminMessage ? Colors.blue[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: isAdminMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              Text(messageData['text'],style: TextStyle(color: Colors.black),), // Message text
                              SizedBox(height: 4), // Space between text and time
                              Text(
                                messageTime, // Message time
                                style: TextStyle(fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                });

                return ListView(children: messageWidgets);
              },
            ),
          ),
          // Message input field and send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Send a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}