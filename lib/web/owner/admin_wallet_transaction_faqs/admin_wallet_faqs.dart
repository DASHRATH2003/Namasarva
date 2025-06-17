// bus_booking_application

import 'dart:io';
import 'package:bus_booking_app/owner/admin_process_payments_and_refund_faqs/view_admin_payments_and_refund_faqs.dart';
import 'package:bus_booking_app/owner/admin_tick_bok_faqs/view_admin_ticket_book_faqs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'admin_view_wallet_faqs.dart';




class AdminWalletFaqs extends StatefulWidget {
  @override
  State<AdminWalletFaqs> createState() => _AdminWalletFaqsState();
}

class _AdminWalletFaqsState extends State<AdminWalletFaqs> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _videoLinkController = TextEditingController(); // Controller for YouTube link

  List<File> _uploadedImages = [];
  final ImagePicker _imagePicker = ImagePicker(); // Same picker for images

  // Function to pick images
  Future<void> _pickImages() async {
    final pickedFiles = await _imagePicker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _uploadedImages = pickedFiles.map((image) => File(image.path)).toList();
      });
    }
  }

  // Function to save FAQ to Firestore and Storage
  Future<void> _saveFaq() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Save Question, Answer, and Video Link
    final docRef = FirebaseFirestore.instance
        .collection('admin')
        .doc('wallet_faqs')
        .collection('faqs')
        .doc();

    await docRef.set({
      'question': _questionController.text,
      'answer': _answerController.text,
      'video_link': _videoLinkController.text, // Save YouTube link
      'created_at': FieldValue.serverTimestamp(),
    });

    // Upload images to Firebase Storage if any images are uploaded
    if (_uploadedImages.isNotEmpty) {
      for (File image in _uploadedImages) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef =
        FirebaseStorage.instance.ref().child('wallet_faqs_images/$fileName');
        await storageRef.putFile(image);
        String imageUrl = await storageRef.getDownloadURL();
        await docRef.update({
          'images': FieldValue.arrayUnion([imageUrl]),
        });
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('FAQ saved successfully')),
    );

    // Clear form after saving
    _questionController.clear();
    _answerController.clear();
    _videoLinkController.clear(); // Clear video link input
    setState(() {
      _uploadedImages.clear();
    });
  }

  void _viewFAQs() async {
    // Fetch FAQs from Firestore
    final querySnapshot = await FirebaseFirestore.instance
        .collection('admin')
        .doc('wallet_faqs')
        .collection('faqs')
        .get();

    List<Map<String, dynamic>> faqs = querySnapshot.docs.map((doc) {
      // Check if 'video_link' exists and is a string, otherwise set it as null or a default message
      final videoLink = doc.data().containsKey('video_link') && doc['video_link'] != null
          ? doc['video_link']
          : 'No video link available'; // Default message if video link doesn't exist

      // Check if 'images' exists and is a list, otherwise provide an empty list
      return {
        'id': doc.id,
        'question': doc['question'] ?? 'No question available',
        'answer': doc['answer'] ?? 'No answer available',
        'video_link': videoLink, // Fetch YouTube link or default message
        'images': doc.data().containsKey('images') && doc['images'] is List ? doc['images'] : [],
      };
    }).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AdminViewWalletFaqs(faqs: faqs),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text('Wallet FAQs',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 35,),
              // Question Text Box
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Answer Text Box (Bigger)
              TextFormField(
                controller: _answerController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Answer',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an answer';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Video Link Text Box
              TextFormField(
                controller: _videoLinkController,
                decoration: InputDecoration(
                  labelText: 'YouTube Video Link (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Display Uploaded Images
              if (_uploadedImages.isNotEmpty) ...[
                Text('Uploaded Images:'),
                SizedBox(height: 10),
                Wrap(
                  children: _uploadedImages
                      .map((image) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.file(
                      image,
                      width: 100,
                      height: 100,
                    ),
                  ))
                      .toList(),
                ),
              ],
              // Upload Images Button
              Container(
                height: 45,
                width: 350,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )
                  ),
                  onPressed: _pickImages,
                  icon: Icon(Icons.image,color: Colors.white,),
                  label: Text('Upload Images',style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(height: 16),
              // Save Button
              Container(
                height: 45,
                width: 350,
                child: ElevatedButton(
                    onPressed: _saveFaq,
                    child: Text('Save FAQ',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(8),
                        )
                    )
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 45,
                width: 350,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(8),
                      )
                  ),
                  onPressed: _viewFAQs,
                  child: Text('View FAQs',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

