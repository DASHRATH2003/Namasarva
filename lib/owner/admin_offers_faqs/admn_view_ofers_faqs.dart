// bus_booking_application

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart'; // Add this import for clipboard functionality

class AdmnViewOfersFaqs extends StatelessWidget {
  final List<Map<String, dynamic>> faqs;

  const AdmnViewOfersFaqs({super.key, required this.faqs});

  Future<void> _launchURL(String url) async {
    print('Attempting to launch URL: $url');

    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          final question = faq['question'] ?? 'No question available';
          final answer = faq['answer'] ?? 'No answer available';
          final images = faq['images'] != null && faq['images'] is List ? faq['images'] : [];
          final videoLink = faq.containsKey('video_link') && faq['video_link'] != null ? faq['video_link'] : null;

          return Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(answer, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                  if (videoLink != null) ...[
                    const Text('Watch Video:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: videoLink));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Video link copied to clipboard!')),
                        );
                        _launchURL(videoLink);
                      },
                      child: Text(
                        videoLink,
                        style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (images.isNotEmpty) ...[
                    const Text('Images:'),
                    SizedBox(
                      height: 400,
                      child: PageView.builder(
                        itemCount: images.length,
                        itemBuilder: (context, imageIndex) {
                          return Center(
                            child: Image.network(
                              images[imageIndex],
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          );
                        },
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
