import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  // Variables to hold the balance and credit limit
  String balance = "Loading...";
  String creditLimit = "Loading...";

  // Function to fetch the balance
  Future<void> fetchBalance() async {
    // const String apiUrl = "https://bus.srdvapi.com/v5/rest/Balance";
    const String apiUrl =
        "https://namma-savaari-api-backend-9mpl.vercel.app/balance";

    // Request body
    final Map<String, String> requestBody = {
      "EndUserIp": "157.48.136.69", // Replace with the actual IP
      "ClientId": "180187", // Replace with your Client ID
      "UserName": "Namma434", // Replace with your User Name
      "Password": "Namma@4341", // Replace with your Password
    };

    try {
      // Make the API request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Api-Token": "Namma@90434#34", // Add the actual API token
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        // Parse the response
        final responseData = json.decode(response.body);

        // Extract the balance and credit limit from the response
        setState(() {
          balance = responseData['Balance'] ?? "Not Available";
          creditLimit = responseData['CreditLimit'] ?? "Not Available";
        });

        print("Balance API Response: $responseData");
      } else {
        print("Failed to fetch balance. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (error) {
      print("An error occurred: $error");
      setState(() {
        balance = "Error fetching balance";
        creditLimit = "Error fetching credit limit";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBalance(); // Call the API when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Balance",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Colors.redAccent.shade700,
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Balance: $balance,",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent.shade700),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Credit Limit: $creditLimit",
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey[50],
    );
  }
}
