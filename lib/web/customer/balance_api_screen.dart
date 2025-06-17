//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BalanceScreen extends StatefulWidget {
//   @override
//   _BalanceScreenState createState() => _BalanceScreenState();
// }
//
// class _BalanceScreenState extends State<BalanceScreen> {
//   bool isLoading = true; // To manage loading state
//   Map<String, dynamic> balanceData = {}; // To store balance API response
//   List<dynamic> balanceLogs = []; // To store balance log data
//
//   // Function to fetch the balance
//   Future<void> fetchBalance() async {
//     const String apiUrl = "https://bus.srdvapi.com/v5/rest/Balance";
//
//     // Request body
//     final Map<String, String> requestBody = {
//       "EndUserIp": "157.48.136.69", // Replace with the actual IP
//       "ClientId": "180187",         // Replace with your Client ID
//       "UserName": "Namma434",       // Replace with your User Name
//       "Password": "Namma@4341",     // Replace with your Password
//     };
//
//     try {
//       // Make the API request
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           "Content-Type": "application/json",
//           "Api-Token": "Namma@90434#34", // Add the actual API token
//         },
//         body: json.encode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         // Parse the response
//         final responseData = json.decode(response.body);
//         setState(() {
//           balanceData = responseData;
//         });
//         print("Balance API Response: $responseData");
//       } else {
//         print("Failed to fetch balance. Status code: ${response.statusCode}");
//         print("Response body: ${response.body}");
//       }
//     } catch (error) {
//       print("An error occurred while fetching balance: $error");
//     }
//   }
//
//   // Function to fetch the balance log
//   Future<void> fetchBalanceLog() async {
//     const String apiUrl = "https://bus.srdvapi.com/v5/rest/BalanceLog";
//
//     // Request body
//     final Map<String, String> requestBody = {
//       "EndUserIp": "157.48.136.69", // Replace with the actual IP
//       "ClientId": "180187",         // Replace with your Client ID
//       "UserName": "Namma434",       // Replace with your User Name
//       "Password": "Namma@4341",     // Replace with your Password
//     };
//
//     try {
//       // Make the API request
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           "Content-Type": "application/json",
//           "Api-Token": "Namma@90434#34", // Add the actual API token
//         },
//         body: json.encode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         // Parse the response
//         final responseData = json.decode(response.body);
//         setState(() {
//           balanceLogs = responseData['BalanceLog'] ?? [];
//           isLoading = false;
//         });
//         print("Balance Log API Response: $responseData");
//       } else {
//         print("Failed to fetch balance log. Status code: ${response.statusCode}");
//         print("Response body: ${response.body}");
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (error) {
//       print("An error occurred while fetching balance log: $error");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch data from both APIs
//     fetchBalance();
//     fetchBalanceLog();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Balance and Logs"),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator()) // Show loading spinner
//           : SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Display Balance API response
//               Text(
//                 "Balance Details:",
//                 style: TextStyle(
//                     fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               Text("Balance: ${balanceData['Balance'] ?? 'N/A'}"),
//               Text("CreditLimit: ${balanceData['CreditLimit'] ?? 'N/A'}"),
//               Divider(),
//
//               // Display Balance Log API response
//               Text(
//                 "Balance Logs:",
//                 style: TextStyle(
//                     fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               balanceLogs.isEmpty
//                   ? Text("No logs available")
//                   : ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: balanceLogs.length,
//                 itemBuilder: (context, index) {
//                   final log = balanceLogs[index];
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 8.0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Column(
//                         crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                         children: [
//                           Text("ID: ${log['ID'] ?? 'N/A'}"),
//                           Text("Date: ${log['Date'] ?? 'N/A'}"),
//                           Text("Client ID: ${log['ClientID'] ?? 'N/A'}"),
//                           Text("Client Name: ${log['ClientName'] ?? 'N/A'}"),
//                           Text("Detail: ${log['Detail'] ?? 'N/A'}"),
//                           Text("Debit: ${log['Debit'] ?? 'N/A'}"),
//                           Text("Credit: ${log['Credit'] ?? 'N/A'}"),
//                           Text("Balance: ${log['Balance'] ?? 'N/A'}"),
//                           Text("Module: ${log['Module'] ?? 'N/A'}"),
//                           Text("Trace ID: ${log['TraceID'] ?? 'N/A'}"),
//                           Text("Ref ID: ${log['RefID'] ?? 'N/A'}"),
//                           Text("Updated By: ${log['UpdatedBy'] ?? 'N/A'}"),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

// balance console

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BalanceScreen extends StatefulWidget {
//   @override
//   _BalanceScreenState createState() => _BalanceScreenState();
// }
//
// class _BalanceScreenState extends State<BalanceScreen> {
//   // Function to fetch the balance
//   Future<void> fetchBalance() async {
//     const String apiUrl = "https://bus.srdvapi.com/v5/rest/Balance";
//
//     // Request body
//     final Map<String, String> requestBody = {
//       "EndUserIp": "157.48.136.69", // Replace with the actual IP
//       "ClientId": "180187",         // Replace with your Client ID
//       "UserName": "Namma434",       // Replace with your User Name
//       "Password": "Namma@4341",     // Replace with your Password
//     };
//
//     try {
//       // Make the API request
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           "Content-Type": "application/json",
//           "Api-Token": "Namma@90434#34", // Add the actual API token
//         },
//         body: json.encode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         // Parse and print the response
//         final responseData = json.decode(response.body);
//         print("Balance API Response: $responseData");
//       } else {
//         print("Failed to fetch balance. Status code: ${response.statusCode}");
//         print("Response body: ${response.body}");
//       }
//     } catch (error) {
//       print("An error occurred: $error");
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchBalance(); // Call the API when the screen initializes
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Balance"),
//       ),
//       body: Center(
//         child: Text(
//           "Fetching balance...",
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }

// Balance Fetching on the screen

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BalanceScreen extends StatefulWidget {
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
      appBar: AppBar(
        title: Text("Balance"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Balance: $balance",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              "Credit Limit: $creditLimit",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
