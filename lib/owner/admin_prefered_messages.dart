// bus_booking_application


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AdminPredefinedMessagesScreen extends StatefulWidget {
//   @override
//   State<AdminPredefinedMessagesScreen> createState() => _AdminPredefinedMessagesScreenState();
// }
//
// class _AdminPredefinedMessagesScreenState extends State<AdminPredefinedMessagesScreen> {
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
//     final doc = await FirebaseFirestore.instance.collection('admin').doc('admin_prefred_messages').get();
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
//       await FirebaseFirestore.instance.collection('admin').doc('admin_prefred_messages').set({
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
//     final doc = await FirebaseFirestore.instance.collection('admin').doc('admin_prefred_messages').get();
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
//         await FirebaseFirestore.instance.collection('admin').doc('admin_prefred_messages').set({
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
//     final doc = await FirebaseFirestore.instance.collection('admin').doc('admin_prefred_messages').get();
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
//         await FirebaseFirestore.instance.collection('admin').doc('admin_prefred_messages').set({
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
//       appBar: AppBar(title: Text('Predefined Messages')),
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


//hurry

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPredefinedMessagesScreen extends StatefulWidget {
  const AdminPredefinedMessagesScreen({super.key});

  @override
  State<AdminPredefinedMessagesScreen> createState() => _AdminPredefinedMessagesScreenState();
}

class _AdminPredefinedMessagesScreenState extends State<AdminPredefinedMessagesScreen> {
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
          .doc('admin_prefred_messages')
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching messages: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveMessage() async {
    String question = _questionController.text.trim();
    String answer = _answerController.text.trim();

    if (question.isEmpty || answer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Both fields must be filled out.')),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      if (_editingIndex != null) {
        await _updateMessage(question, answer);
      } else {
        await FirebaseFirestore.instance
            .collection('admin')
            .doc('admin_prefred_messages')
            .set({
          'questions': FieldValue.arrayUnion([question]),
          'answers': FieldValue.arrayUnion([answer]),
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message saved successfully!')),
        );
      }

      _questionController.clear();
      _answerController.clear();
      _editingIndex = null;
      await _fetchMessages();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving message: ${e.toString()}')),
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Future<void> _updateMessage(String question, String answer) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('admin')
          .doc('admin_prefred_messages')
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
              .doc('admin_prefred_messages')
              .set({
            'questions': questions,
            'answers': answers,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Message updated successfully!')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating message: ${e.toString()}')),
      );
      rethrow;
    }
  }

  Future<void> _deleteMessage(int index) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this message?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmDelete != true) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('admin')
          .doc('admin_prefred_messages')
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
              .doc('admin_prefred_messages')
              .set({
            'questions': questions,
            'answers': answers,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Message deleted successfully!')),
          );

          await _fetchMessages();
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting message: ${e.toString()}')),
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Predefined Messages', style: TextStyle(fontWeight: FontWeight.bold)),
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Form Section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _editingIndex != null ? 'Edit Message' : 'Add New Message',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _questionController,
                      decoration: const InputDecoration(
                        labelText: 'Question',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _answerController,
                      decoration: const InputDecoration(
                        labelText: 'Answer',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isSaving ? null : _saveMessage,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                        backgroundColor: _editingIndex != null
                            ? Theme.of(context).primaryColor
                            : Colors.redAccent.shade700,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(double.infinity, 50), // Full width
                        animationDuration: const Duration(milliseconds: 200),
                        enableFeedback: true,
                      ).copyWith(
                        elevation: WidgetStateProperty.resolveWith<double>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.pressed)) return 1;
                            if (states.contains(WidgetState.disabled)) return 0;
                            return 2;
                          },
                        ),
                        overlayColor: WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.pressed)) {
                              return Colors.white.withOpacity(0.1);
                            }
                            return Colors.transparent;
                          },
                        ),
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
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_editingIndex != null)
                            const Icon(Icons.edit, size: 20),
                          if (_editingIndex != null) const SizedBox(width: 8),
                          Text(
                            _editingIndex != null ? 'UPDATE MESSAGE' : 'SAVE NEW MESSAGE',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_editingIndex != null) ...[
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () {
                          _questionController.clear();
                          _answerController.clear();
                          _editingIndex = null;
                          setState(() {});
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'CANCEL',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Messages List
            Expanded(
              child: _filteredMessages.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.message, size: 60, color: Colors.grey[400]),
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
                        child: const Text('Clear search'),
                      ),
                  ],
                ),
              )
                  : ListView.separated(
                itemCount: _filteredMessages.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _filteredMessages[index]['question']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _filteredMessages[index]['answer']!,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => _editMessage(index),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                ),
                                child: const Text('Edit'),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () => _deleteMessage(index),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                child: const Text('Delete'),
                              ),
                            ],
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