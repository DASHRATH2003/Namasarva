import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? selectedVideo;
  String title = "";

  Future<void> pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      setState(() {
        selectedVideo = File(result.files.single.path!);
      });
    }
  }

  Future<void> uploadVideo() async {
    if (selectedVideo == null || title.isEmpty) return;

    final filename = DateTime.now().millisecondsSinceEpoch.toString();
    final storageRef = FirebaseStorage.instance.ref().child('videos/$filename.mp4');

    await storageRef.putFile(selectedVideo!);
    final url = await storageRef.getDownloadURL();

    await FirebaseFirestore.instance.collection('videos').add({
      'title': title,
      'url': url,
      'timestamp': FieldValue.serverTimestamp(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Video")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextField(
            onChanged: (val) => title = val,
            decoration: const InputDecoration(labelText: "Video Title"),
          ),
          ElevatedButton(onPressed: pickVideo, child: const Text("Pick Video")),
          const SizedBox(height: 10),
          if (selectedVideo != null) Text("Selected: ${selectedVideo!.path}"),
          const Spacer(),
          ElevatedButton(onPressed: uploadVideo, child: const Text("Upload")),
        ]),
      ),
    );
  }
}
