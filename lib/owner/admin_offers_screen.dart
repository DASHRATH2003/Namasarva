// bus_booking_application

import 'dart:io';
import 'package:bus_booking_app/owner/view_admin_offers_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  File? _selectedImage;
  final _offerLineController = TextEditingController();
  final _couponCodeController = TextEditingController();
  final _validTillController = TextEditingController();
  final _termsController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Future<void> _selectOfferImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadOffer() async {
    if (_selectedImage == null ||
        _offerLineController.text.isEmpty ||
        _couponCodeController.text.isEmpty ||
        _validTillController.text.isEmpty ||
        _termsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are mandatory')),
      );
      return;
    }

    try {
      // Upload image to Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('admin_offers/$fileName')
          .putFile(_selectedImage!);

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      // Store offer details in Firestore under the 'offers' sub-collection in 'admin'
      await FirebaseFirestore.instance.collection('admin').doc('admin_offers').collection('offers').add({
        'imageUrl': imageUrl,
        'offerLine': _offerLineController.text,
        'couponCode': _couponCodeController.text,
        'validTill': _validTillController.text,
        'terms': _termsController.text,
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Offer uploaded successfully')),
      );

      // Clear the fields after uploading
      setState(() {
        _selectedImage = null;
      });
      _offerLineController.clear();
      _couponCodeController.clear();
      _validTillController.clear();
      _termsController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload offer: $e')),
      );
    }
  }

  Future<void> _selectValidTillDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _validTillController.text = pickedDate.toLocal().toString().split(' ')[0];
      });
    }
  }
  void _viewOffers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ViewOffersScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload Offer',
                style: TextStyle(fontSize: 16,),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.redAccent.shade100,
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    _selectedImage != null
                        ? Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                        : const SizedBox(),
                    if (_selectedImage == null)
                      const Center(
                        child: Text(
                          'No image selected',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  height: 45,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.shade700,
                    ),
                    onPressed: _selectOfferImage,
                    child: const Text('Select Offer Image',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _offerLineController,
                decoration: const InputDecoration(
                  labelText: 'Offer Line',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _couponCodeController,
                decoration: const InputDecoration(
                  labelText: 'Coupon Code',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _validTillController,
                readOnly: true,
                onTap: () => _selectValidTillDate(context),
                decoration: const InputDecoration(
                  labelText: 'Valid Till',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _termsController,
                maxLines: 8,
                decoration: const InputDecoration(
                  labelText: 'Terms and Conditions',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.shade700,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(0)),
                    ),
                    onPressed: _uploadOffer,
                    child: const Text('Upload Offer',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  height: 45,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.shade700,
                    ),
                    onPressed: _viewOffers,
                    child: const Text('View Offers', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
