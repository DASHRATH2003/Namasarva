import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue as...',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/customerLogin');
                },
                icon: Icon(Icons.person_outline),
                label: Text('Customer'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 60),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/driverLogin');
                },
                icon: Icon(Icons.directions_car),
                label: Text('Driver'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 60),
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
