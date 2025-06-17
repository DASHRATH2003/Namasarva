import 'package:bus_booking_app/myweb/upload_vid.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'enjoy_vid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePag extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

   HomePag({super.key});

  void logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final videosRef = FirebaseFirestore.instance.collection('videos').orderBy('timestamp', descending: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Feed"),
        actions: [
          IconButton(onPressed: () => logout(context), icon: const Icon(Icons.logout)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UploadPage())),
        child: const Icon(Icons.upload),
      ),
      body: StreamBuilder(
        stream: videosRef.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(
            children: snapshot.data!.docs.map((doc) => VideoCard(url: doc['url'], title: doc['title'])).toList(),
          );
        },
      ),
    );
  }
}
