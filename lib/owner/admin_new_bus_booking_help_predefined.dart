// bus_booking_application

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AdminNewBusBookingHelpPredefinedMessagesScreen extends StatefulWidget {
//   @override
//   State<AdminNewBusBookingHelpPredefinedMessagesScreen> createState() => _AdminNewBusBookingHelpPredefinedMessagesScreenState();
// }
//
// class _AdminNewBusBookingHelpPredefinedMessagesScreenState extends State<AdminNewBusBookingHelpPredefinedMessagesScreen> {
//   final TextEditingController _questionController = TextEditingController();
//   final TextEditingController _answerController = TextEditingController();
//   final TextEditingController _searchController = TextEditingController();
//
//   // List to hold fetched messages
//   List<Map<String, String>> _messages = [];
//   List<Map<String, String>> _filteredMessages = []; // List to hold search results
//   int? _editingIndex; // To track which message is being edited
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchMessages(); // Fetch messages on initialization
//     _searchController.addListener(_filterMessages); // Listen for search input changes
//   }
//
//   Future<void> _fetchMessages() async {
//     // Fetch the predefined messages from Firestore
//     final doc = await FirebaseFirestore.instance.collection('admin').doc('admin_new_bus_booking_prefred_messages').get();
//
//     if (doc.exists) {
//       final data = doc.data();
//       if (data != null) {
//         // Get the list of questions and answers
//         List<dynamic> questions = data['questions'] ?? [];
//         List<dynamic> answers = data['answers'] ?? [];
//
//         // Combine questions and answers into a single list
//         _messages = [];
//         for (int i = 0; i < questions.length; i++) {
//           _messages.add({
//             'question': questions[i] as String,
//             'answer': answers.length > i ? answers[i] as String : '',
//           });
//         }
//       }
//     }
//     _filteredMessages = List.from(_messages); // Initially, all messages are shown
//     setState(() {}); // Rebuild the UI
//   }
//
//   Future<void> _saveMessage() async {
//     String question = _questionController.text.trim();
//     String answer = _answerController.text.trim();
//
//     // Validate that fields are not empty
//     if (question.isEmpty || answer.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Both fields must be filled out.')),
//       );
//       return;
//     }
//
//     // Check if we are updating an existing message
//     if (_editingIndex != null) {
//       // Update the existing message
//       await _updateMessage(question, answer);
//     } else {
//       // Add a new message
//       await FirebaseFirestore.instance.collection('admin').doc('admin_new_bus_booking_prefred_messages').set({
//         'questions': FieldValue.arrayUnion([question]),
//         'answers': FieldValue.arrayUnion([answer]),
//       }, SetOptions(merge: true)); // Use merge to avoid overwriting
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Message saved successfully!')),
//       );
//     }
//
//     // Clear text fields after saving
//     _questionController.clear();
//     _answerController.clear();
//     _editingIndex = null; // Reset the editing index
//
//     // Fetch messages again to update the displayed list
//     _fetchMessages();
//   }
//
//   Future<void> _updateMessage(String question, String answer) async {
//     // Get the current questions and answers
//     final doc = await FirebaseFirestore.instance.collection('admin').doc('admin_new_bus_booking_prefred_messages').get();
//     if (doc.exists) {
//       final data = doc.data();
//       if (data != null) {
//         List<dynamic> questions = List.from(data['questions']);
//         List<dynamic> answers = List.from(data['answers']);
//
//         // Update the question and answer at the editing index
//         questions[_editingIndex!] = question;
//         answers[_editingIndex!] = answer;
//
//         // Update Firestore
//         await FirebaseFirestore.instance.collection('admin').doc('admin_new_bus_booking_prefred_messages').set({
//           'questions': questions,
//           'answers': answers,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Message updated successfully!')),
//         );
//       }
//     }
//   }
//
//   Future<void> _deleteMessage(int index) async {
//     // Get the current questions and answers
//     final doc = await FirebaseFirestore.instance.collection('admin').doc('admin_new_bus_booking_prefred_messages').get();
//     if (doc.exists) {
//       final data = doc.data();
//       if (data != null) {
//         List<dynamic> questions = List.from(data['questions']);
//         List<dynamic> answers = List.from(data['answers']);
//
//         // Remove the question and answer at the specified index
//         questions.removeAt(index);
//         answers.removeAt(index);
//
//         // Update Firestore
//         await FirebaseFirestore.instance.collection('admin').doc('admin_new_bus_booking_prefred_messages').set({
//           'questions': questions,
//           'answers': answers,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Message deleted successfully!')),
//         );
//
//         // Fetch messages again to update the displayed list
//         _fetchMessages();
//       }
//     }
//   }
//
//   void _editMessage(int index) {
//     _editingIndex = index; // Set the editing index
//     _questionController.text = _filteredMessages[index]['question']!;
//     _answerController.text = _filteredMessages[index]['answer']!;
//   }
//
//   // Function to filter messages based on search input
//   void _filterMessages() {
//     String query = _searchController.text.trim().toLowerCase();
//     if (query.isEmpty) {
//       _filteredMessages = List.from(_messages); // Reset to all messages if search is empty
//     } else {
//       _filteredMessages = _messages
//           .where((message) => message['question']!.toLowerCase().contains(query))
//           .toList();
//     }
//     setState(() {}); // Rebuild the UI
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(title: Text('New Bus Booking Predefined Messages')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Search Bar
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Search by Question',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _questionController,
//               decoration: InputDecoration(
//                 labelText: 'Question',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _answerController,
//               decoration: InputDecoration(
//                 labelText: 'Answer',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _saveMessage,
//               child: Text(_editingIndex != null ? 'Update' : 'Save'),
//             ),
//             SizedBox(height: 16.0),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _filteredMessages.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 8.0),
//                     child: ListTile(
//                       title: Text(_filteredMessages[index]['question']!),
//                       subtitle: Text(_filteredMessages[index]['answer']!),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.edit),
//                             onPressed: () => _editMessage(index),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete),
//                             onPressed: () => _deleteMessage(index),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// hurry



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminNewBusBookingHelpPredefinedMessagesScreen extends StatefulWidget {
  const AdminNewBusBookingHelpPredefinedMessagesScreen({super.key});

  @override
  State<AdminNewBusBookingHelpPredefinedMessagesScreen> createState() =>
      _AdminNewBusBookingHelpPredefinedMessagesScreenState();
}

class _AdminNewBusBookingHelpPredefinedMessagesScreenState
    extends State<AdminNewBusBookingHelpPredefinedMessagesScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> _messages = [];
  List<Map<String, String>> _filteredMessages = [];
  int? _editingIndex;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _fetchMessages();
    _searchController.addListener(_filterMessages);
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchMessages() async {
    setState(() => _isLoading = true);
    try {
      final doc = await FirebaseFirestore.instance
          .collection('admin')
          .doc('admin_new_bus_booking_prefred_messages')
          .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          List<dynamic> questions = data['questions'] ?? [];
          List<dynamic> answers = data['answers'] ?? [];

          _messages = [];
          for (int i = 0; i < questions.length; i++) {
            _messages.add({
              'question': questions[i] as String,
              'answer': answers.length > i ? answers[i] as String : '',
            });
          }
        }
      }
      _filteredMessages = List.from(_messages);
    } catch (e) {
      _showErrorSnackbar('Error fetching messages: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveMessage() async {
    String question = _questionController.text.trim();
    String answer = _answerController.text.trim();

    if (question.isEmpty || answer.isEmpty) {
      _showErrorSnackbar('Both fields must be filled out');
      return;
    }

    setState(() => _isSaving = true);
    try {
      if (_editingIndex != null) {
        await _updateMessage(question, answer);
      } else {
        await FirebaseFirestore.instance
            .collection('admin')
            .doc('admin_new_bus_booking_prefred_messages')
            .set({
          'questions': FieldValue.arrayUnion([question]),
          'answers': FieldValue.arrayUnion([answer]),
        }, SetOptions(merge: true));

        _showSuccessSnackbar('Message saved successfully!');
      }

      _questionController.clear();
      _answerController.clear();
      _editingIndex = null;
      await _fetchMessages();
    } catch (e) {
      _showErrorSnackbar('Error saving message: ${e.toString()}');
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Future<void> _updateMessage(String question, String answer) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('admin')
          .doc('admin_new_bus_booking_prefred_messages')
          .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          List<dynamic> questions = List.from(data['questions']);
          List<dynamic> answers = List.from(data['answers']);

          questions[_editingIndex!] = question;
          answers[_editingIndex!] = answer;

          await FirebaseFirestore.instance
              .collection('admin')
              .doc('admin_new_bus_booking_prefred_messages')
              .set({
            'questions': questions,
            'answers': answers,
          });

          _showSuccessSnackbar('Message updated successfully!');
        }
      }
    } catch (e) {
      _showErrorSnackbar('Error updating message: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> _deleteMessage(int index) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to delete this message? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('CANCEL', style: TextStyle(color: Colors.grey[600])),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('DELETE', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmDelete != true) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('admin')
          .doc('admin_new_bus_booking_prefred_messages')
          .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          List<dynamic> questions = List.from(data['questions']);
          List<dynamic> answers = List.from(data['answers']);

          questions.removeAt(index);
          answers.removeAt(index);

          await FirebaseFirestore.instance
              .collection('admin')
              .doc('admin_new_bus_booking_prefred_messages')
              .set({
            'questions': questions,
            'answers': answers,
          });

          _showSuccessSnackbar('Message deleted successfully!');
          await _fetchMessages();
        }
      }
    } catch (e) {
      _showErrorSnackbar('Error deleting message: ${e.toString()}');
    }
  }

  void _editMessage(int index) {
    _editingIndex = index;
    _questionController.text = _filteredMessages[index]['question']!;
    _answerController.text = _filteredMessages[index]['answer']!;
  }

  void _filterMessages() {
    String query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      _filteredMessages = List.from(_messages);
    } else {
      _filteredMessages = _messages
          .where((message) => message['question']!.toLowerCase().contains(query))
          .toList();
    }
    setState(() {});
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Bus Booking Help Messages',
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 20,
      //     ),
      //   ),
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: Colors.blue[800],
      //   foregroundColor: Colors.white,
      //   actions: [
      //     if (_editingIndex != null)
      //       IconButton(
      //         icon: Icon(Icons.close),
      //         onPressed: () {
      //           _questionController.clear();
      //           _answerController.clear();
      //           _editingIndex = null;
      //           setState(() {});
      //         },
      //       ),
      //   ],
      // ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search messages...',
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () {
                      _searchController.clear();
                      _filterMessages();
                    },
                  )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Form Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _editingIndex != null
                          ? '✏️ Edit Message'
                          : '➕ Add New Message',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent.shade700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _questionController,
                      decoration: InputDecoration(
                        labelText: 'Customer Question',
                        labelStyle: TextStyle(color: Colors.grey[600]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.redAccent.shade700),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _answerController,
                      decoration: InputDecoration(
                        labelText: 'Admin Response',
                        labelStyle: TextStyle(color: Colors.grey[600]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.redAccent.shade700),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _saveMessage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.shade700,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          shadowColor: Colors.transparent,
                        ),
                        child: _isSaving
                            ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          _editingIndex != null
                              ? 'UPDATE MESSAGE'
                              : 'SAVE NEW MESSAGE',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Messages List Header
            Row(
              children: [
                Text(
                  'Predefined Messages',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent.shade700,
                  ),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text('${_filteredMessages.length} messages'),
                  backgroundColor: Colors.redAccent.shade200,
                  labelStyle: TextStyle(color: Colors.redAccent.shade700),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Messages List
            Expanded(
              child: _filteredMessages.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.help_outline,
                      size: 60,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No messages found',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          _searchController.clear();
                          _filterMessages();
                        },
                        child: Text(
                          'Clear search',
                          style: TextStyle(color: Colors.redAccent.shade700),
                        ),
                      ),
                  ],
                ),
              )
                  : ListView.separated(
                itemCount: _filteredMessages.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.question_answer,
                                  size: 20,
                                  color: Colors.redAccent.shade700),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _filteredMessages[index]['question']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: Text(
                              _filteredMessages[index]['answer']!,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Wrap(
                              spacing: 8,
                              children: [
                                OutlinedButton.icon(
                                  icon: const Icon(Icons.edit, size: 18),
                                  label: const Text('Edit'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.blue,
                                    side: const BorderSide(color: Colors.blue),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () => _editMessage(index),
                                ),
                                OutlinedButton.icon(
                                  icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                                  label: const Text('Delete'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    side: const BorderSide(color: Colors.red),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () => _deleteMessage(index),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
