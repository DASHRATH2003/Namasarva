// bus_booking_application


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'admin_chat_screen.dart';
//
// class AdminChatScreen extends StatefulWidget {
//   @override
//   State<AdminChatScreen> createState() => _AdminChatScreenState();
// }
//
// class _AdminChatScreenState extends State<AdminChatScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   late String adminId;
//
//   @override
//   void initState() {
//     super.initState();
//     _getAdminId();
//   }
//
//   void _getAdminId() {
//     User? user = _auth.currentUser;
//     if (user != null) {
//       adminId = user.uid;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Messages from Customers')),
//       body: StreamBuilder<QuerySnapshot>(
//         // Listen to changes in the 'customers' collection
//         stream: _firestore.collection('customers').snapshots(),
//         builder: (context, customerSnapshot) {
//           if (!customerSnapshot.hasData || customerSnapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No customers found'));
//           }
//
//           final customerDocs = customerSnapshot.data!.docs;
//
//           // Create a list to hold future streams for latest messages
//           List<Stream<Map<String, dynamic>>> messageStreams = [];
//
//           for (var customerDoc in customerDocs) {
//             final customerId = customerDoc.id;
//
//             // Create a stream for the latest message for each customer
//             final messageStream = _firestore
//                 .collection('customers')
//                 .doc(customerId)
//                 .collection('messages')
//                 .orderBy('timestamp', descending: true)
//                 .limit(1)
//                 .snapshots()
//                 .map((messageSnapshot) {
//               if (messageSnapshot.docs.isNotEmpty) {
//                 final latestMessageDoc = messageSnapshot.docs.first;
//                 return {
//                   'customerId': customerId,
//                   'latestMessage': latestMessageDoc['text'],
//                   'timestamp': latestMessageDoc['timestamp'],
//                 };
//               }
//               return {
//                 'customerId': customerId,
//                 'latestMessage': '',
//                 'timestamp': null,
//               };
//             });
//             messageStreams.add(messageStream);
//           }
//
//           // Using a FutureBuilder to combine results
//           return StreamBuilder<List<Map<String, dynamic>>>(
//             stream: Stream.periodic(Duration(seconds: 1)).asyncMap((_) async {
//               List<Map<String, dynamic>> results = [];
//               for (var stream in messageStreams) {
//                 final message = await stream.first; // Wait for the first value
//                 results.add(message);
//               }
//               return results;
//             }),
//             builder: (context, messageSnapshot) {
//               // if (messageSnapshot.connectionState == ConnectionState.waiting) {
//               //   return Center(child: CircularProgressIndicator());
//               // }
//
//               if (messageSnapshot.connectionState == ConnectionState.waiting) {
//                 return LinearProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
//                   minHeight: 5.0,
//                 );
//               }
//
//               // Filter out customers without messages
//               final customerMessages = messageSnapshot.data ?? [];
//               final filteredMessages = customerMessages.where((msg) => msg['latestMessage'] != '').toList();
//
//               if (filteredMessages.isEmpty) {
//                 return Center(child: Text('No messages found'));
//               }
//
//               // Sort messages by the timestamp of the latest message (latest first)
//               filteredMessages.sort((a, b) {
//                 if (a['timestamp'] == null) return 1; // Handle null timestamp
//                 if (b['timestamp'] == null) return -1;
//                 return b['timestamp'].compareTo(a['timestamp']);
//               });
//
//               return ListView.separated(
//                 itemCount: filteredMessages.length,
//                 itemBuilder: (context, index) {
//                   final customer = filteredMessages[index];
//                   final customerId = customer['customerId'];
//                   final latestMessage = customer['latestMessage'];
//
//                   return ListTile(
//                     title: Text('Customer ID: $customerId'),
//                     subtitle: Text(latestMessage),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CustomerMessagesScreen(customerId: customerId),
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 separatorBuilder: (context, index) => Divider(),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   // Function to send a message (this can be called from another part of your app)
//   void sendMessage(String customerId, String message) async {
//     await _firestore.collection('customers').doc(customerId).collection('messages').add({
//       'text': message,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'admin_chat_screen.dart';

class AdminChatScreen extends StatefulWidget {
  const AdminChatScreen({super.key});

  @override
  State<AdminChatScreen> createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String adminId;

  @override
  void initState() {
    super.initState();
    _getAdminId();
  }

  void _getAdminId() {
    User? user = _auth.currentUser;
    if (user != null) {
      adminId = user.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages from Customers')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('customers').snapshots(),
        builder: (context, customerSnapshot) {
          if (!customerSnapshot.hasData || customerSnapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No customers found'));
          }

          final customerDocs = customerSnapshot.data!.docs;
          List<Stream<Map<String, dynamic>>> messageStreams = [];

          for (var customerDoc in customerDocs) {
            final customerId = customerDoc.id;
            final customerData = customerDoc.data() as Map<String, dynamic>;
            final customerName = customerData['name'] ?? 'Unknown';
            final customerEmail = customerData['email'] ?? 'No Email';

            final messageStream = _firestore
                .collection('customers')
                .doc(customerId)
                .collection('messages')
                .orderBy('timestamp', descending: true)
                .limit(1)
                .snapshots()
                .map((messageSnapshot) {
              if (messageSnapshot.docs.isNotEmpty) {
                final latestMessageDoc = messageSnapshot.docs.first;
                return {
                  'customerId': customerId,
                  'customerName': customerName,
                  'customerEmail': customerEmail,
                  'latestMessage': latestMessageDoc['text'],
                  'timestamp': latestMessageDoc['timestamp'],
                };
              }
              return {
                'customerId': customerId,
                'customerName': customerName,
                'customerEmail': customerEmail,
                'latestMessage': '',
                'timestamp': null,
              };
            });
            messageStreams.add(messageStream);
          }

          return StreamBuilder<List<Map<String, dynamic>>>(
            stream: Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
              List<Map<String, dynamic>> results = [];
              for (var stream in messageStreams) {
                final message = await stream.first;
                results.add(message);
              }
              return results;
            }),
            builder: (context, messageSnapshot) {
              if (messageSnapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent.shade700),
                  minHeight: 5.0,
                );
              }

              final customerMessages = messageSnapshot.data ?? [];
              final filteredMessages = customerMessages.where((msg) => msg['latestMessage'] != '').toList();

              if (filteredMessages.isEmpty) {
                return const Center(child: Text('No messages found'));
              }

              filteredMessages.sort((a, b) {
                if (a['timestamp'] == null) return 1;
                if (b['timestamp'] == null) return -1;
                return b['timestamp'].compareTo(a['timestamp']);
              });

              return ListView.separated(
                itemCount: filteredMessages.length,
                itemBuilder: (context, index) {
                  final customer = filteredMessages[index];
                  final customerId = customer['customerId'];
                  final customerName = customer['customerName'];
                  final customerEmail = customer['customerEmail'];
                  final latestMessage = customer['latestMessage'];

                  return ListTile(
                    title: Text(customerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('Customer ID: $customerId', style: TextStyle(color: Colors.grey)),
                        Text('$customerEmail', style: const TextStyle(color: Colors.grey)),
                        Text('$latestMessage',style: TextStyle(color: Colors.redAccent.shade700)),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerMessagesScreen(customerId: customerId),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            },
          );
        },
      ),
    );
  }
}














