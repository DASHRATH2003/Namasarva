// bus_booking_application

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminNewBusBookingHelpPredefinedMessagesScreen extends StatefulWidget {
  @override
  State<AdminNewBusBookingHelpPredefinedMessagesScreen> createState() => _AdminNewBusBookingHelpPredefinedMessagesScreenState();
}

class _AdminNewBusBookingHelpPredefinedMessagesScreenState extends State<AdminNewBusBookingHelpPredefinedMessagesScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  // List to hold fetched messages
  List<Map<String, String>> _messages = [];
  List<Map<String, String>> _filteredMessages = []; // List to hold search results
  int? _editingIndex; // To track which message is being edited

  @override
  void initState() {
    super.initState();
    _fetchMessages(); // Fetch messages on initialization
    _searchController.addListener(_filterMessages); // Listen for search input changes
  }

  Future<void> _fetchMessages() async {
    // Fetch the predefined messages from Firestore
    final doc = await FirebaseFirestore.instance.collection('admin').doc('admin_new_bus_booking_prefred_messages').get();

    if (doc.exists) {
      final data = doc.data();
      if (data != null) {
        // Get the list of questions and answers
        List<dynamic> questions = data['questions'] ?? [];
        List<dynamic> answers = data['answers'] ?? [];

        // Combine questions and answers into a single list
        _messages = [];
        for (int i = 0; i < questions.length; i++) {
          _messages.add({
            'question': questions[i] as String,
            'answer': answers.length > i ? answers[i] as String : '',
          });
        }
      }
    }
    _filteredMessages = List.from(_messages); // Initially, all messages are shown
    setState(() {}); // Rebuild the UI
  }

  Future<void> _saveMessage() async {
    String question = _questionController.text.trim();
    String answer = _answerController.text.trim();

    // Validate that fields are not empty
    if (question.isEmpty || answer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Both fields must be filled out.')),
      );
      return;
    }

    // Check if we are updating an existing message
    if (_editingIndex != null) {
      // Update the existing message
      await _updateMessage(question, answer);
    } else {
      // Add a new message
      await FirebaseFirestore.instance.collection('admin').doc('admin_new_bus_booking_prefred_messages').set({
        'questions': FieldValue.arrayUnion([question]),
        'answers': FieldValue.arrayUnion([answer]),
      }, SetOptions(merge: true)); // Use merge to avoid overwriting

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Message saved successfully!')),
      );
    }

    // Clear text fields after saving
    _questionController.clear();
    _answerController.clear();
    _editingIndex = null; // Reset the editing index

    // Fetch messages again to update the displayed list
    _fetchMessages();
  }

  Future<void> _updateMessage(String question, String answer) async {
    // Get the current questions and answers
    final doc = await FirebaseFirestore.instance.collection('admin').doc('admin_new_bus_booking_prefred_messages').get();
    if (doc.exists) {
      final data = doc.data();
      if (data != null) {
        List<dynamic> questions = List.from(data['questions']);
        List<dynamic> answers = List.from(data['answers']);

        // Update the question and answer at the editing index
        questions[_editingIndex!] = question;
        answers[_editingIndex!] = answer;

        // Update Firestore
        await FirebaseFirestore.instance.collection('admin').doc('admin_new_bus_booking_prefred_messages').set({
          'questions': questions,
          'answers': answers,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Message updated successfully!')),
        );
      }
    }
  }

  Future<void> _deleteMessage(int index) async {
    // Get the current questions and answers
    final doc = await FirebaseFirestore.instance.collection('admin').doc('admin_new_bus_booking_prefred_messages').get();
    if (doc.exists) {
      final data = doc.data();
      if (data != null) {
        List<dynamic> questions = List.from(data['questions']);
        List<dynamic> answers = List.from(data['answers']);

        // Remove the question and answer at the specified index
        questions.removeAt(index);
        answers.removeAt(index);

        // Update Firestore
        await FirebaseFirestore.instance.collection('admin').doc('admin_new_bus_booking_prefred_messages').set({
          'questions': questions,
          'answers': answers,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Message deleted successfully!')),
        );

        // Fetch messages again to update the displayed list
        _fetchMessages();
      }
    }
  }

  void _editMessage(int index) {
    _editingIndex = index; // Set the editing index
    _questionController.text = _filteredMessages[index]['question']!;
    _answerController.text = _filteredMessages[index]['answer']!;
  }

  // Function to filter messages based on search input
  void _filterMessages() {
    String query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      _filteredMessages = List.from(_messages); // Reset to all messages if search is empty
    } else {
      _filteredMessages = _messages
          .where((message) => message['question']!.toLowerCase().contains(query))
          .toList();
    }
    setState(() {}); // Rebuild the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('New Bus Booking Predefined Messages')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Question',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                labelText: 'Answer',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveMessage,
              child: Text(_editingIndex != null ? 'Update' : 'Save'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredMessages.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(_filteredMessages[index]['question']!),
                      subtitle: Text(_filteredMessages[index]['answer']!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editMessage(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteMessage(index),
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
