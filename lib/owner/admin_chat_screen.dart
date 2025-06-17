// bus_booking_application

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Ensure this is imported for date formatting

class CustomerMessagesScreen extends StatefulWidget {
  final String customerId;

  const CustomerMessagesScreen({super.key, required this.customerId});

  @override
  _CustomerMessagesScreenState createState() => _CustomerMessagesScreenState();
}

class _CustomerMessagesScreenState extends State<CustomerMessagesScreen> {
  final _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to send messages as an admin
  void _sendMessage() async {
    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      try {
        await _firestore
            .collection('customers')
            .doc(widget.customerId)
            .collection('messages')
            .add({
          'text': messageText,
          'senderId': 'admin', // Admin sends the message
          'isAdminMessage': true,
          'timestamp': FieldValue.serverTimestamp(),
        });
        _messageController.clear();
      } catch (error) {
        print("Error sending message: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat with Customer ${widget.customerId}')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('customers')
                  .doc(widget.customerId)
                  .collection('messages')
                  .orderBy('timestamp', descending: false) // Order by timestamp ascending
                  .snapshots(),
              builder: (context, snapshot) {
                // if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                //   return Center(child: CircularProgressIndicator());
                // }


                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                      strokeWidth: 6.0,
                    ),
                  );
                }


                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return LinearProgressIndicator(
                //     valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                //     minHeight: 5.0,
                //   );
                // }

                final messages = snapshot.data!.docs;

                if (messages.isEmpty) {
                  return const Center(child: Text("No messages yet."));
                }

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

                // Create a list of date headers with day names
                List<Widget> messageWidgets = [];
                groupedMessages.forEach((date, messages) {
                  // Get the day name from the date
                  final dayName = DateFormat('EEEE').format(DateTime.parse(date));

                  messageWidgets.add(
                    Center(
                      child: Column(
                        children: [
                          Text(
                            dayName, // Day name
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            date, // Date
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );

                  for (var messageData in messages) {
                    final isAdminMessage = messageData['isAdminMessage'] ?? false;
                    final timestamp = messageData['timestamp'] as Timestamp?;
                    final time = timestamp != null
                        ? DateFormat('hh:mm a').format(timestamp.toDate())
                        : '';

                    messageWidgets.add(
                      Align(
                        alignment: isAdminMessage ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isAdminMessage ? Colors.blue[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: isAdminMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              Text(messageData['text']),
                              const SizedBox(height: 4),
                              Text(
                                time,
                                style: const TextStyle(fontSize: 12, color: Colors.black54),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Send a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
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






