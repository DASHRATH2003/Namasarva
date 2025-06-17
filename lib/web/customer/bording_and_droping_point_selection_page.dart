//API Response in console


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BoardingDroppingPage extends StatefulWidget {
//   @override
//   _BoardingDroppingPageState createState() => _BoardingDroppingPageState();
// }
//
// class _BoardingDroppingPageState extends State<BoardingDroppingPage> {
//   bool _isLoading = false;
//   String _errorMessage = "";
//
//   Future<void> _fetchBoardingPointDetails() async {
//     const String apiUrl = "https://bus.srdvtest.com/v5/rest/GetBoardingPointDetails";
//     const Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": "1",
//     };
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//     });
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//         debugPrint("Boarding Point Details Response: $responseBody", wrapWidth: null); // Full response
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch details: ${response.body}";
//         });
//         debugPrint("Error: ${response.body}", wrapWidth: null);
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//       });
//       debugPrint("Exception: ${e.toString()}", wrapWidth: null);
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchBoardingPointDetails();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("Boarding & Dropping Points"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : Center(
//         child: Text(
//           "API Response printed in console.",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }



//API Response in screen


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BoardingDroppingPage extends StatefulWidget {
//   @override
//   _BoardingDroppingPageState createState() => _BoardingDroppingPageState();
// }
//
// class _BoardingDroppingPageState extends State<BoardingDroppingPage> {
//   bool _isLoading = false;
//   String _errorMessage = "";
//   String _responseData = "";  // Store the API response
//
//   Future<void> _fetchBoardingPointDetails() async {
//     const String apiUrl = "https://bus.srdvtest.com/v5/rest/GetBoardingPointDetails";
//     const Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": "1",
//     };
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//       _responseData = ""; // Clear previous response
//     });
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//         setState(() {
//           _responseData = jsonEncode(responseBody); // Store the response in the variable
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch details: ${response.body}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchBoardingPointDetails();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("Boarding & Dropping Points"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "API Response:",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               _responseData.isNotEmpty ? _responseData : "No response yet",
//               style: TextStyle(fontSize: 14),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



//API Response Testing


//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BoardingDroppingPage extends StatefulWidget {
//   @override
//   _BoardingDroppingPageState createState() => _BoardingDroppingPageState();
// }
//
// class _BoardingDroppingPageState extends State<BoardingDroppingPage> {
//   bool _isLoading = false;
//   String _errorMessage = "";
//   List<dynamic> _boardingPointsDetails = []; // Store Boarding Points details
//   List<dynamic> _droppingPointsDetails = []; // Store Dropping Points details
//
//   Future<void> _fetchBoardingPointDetails() async {
//     const String apiUrl = "https://bus.srdvtest.com/v5/rest/GetBoardingPointDetails";
//     const Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": "1",
//     };
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//     });
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//         setState(() {
//           // Assuming the response contains "BoardingPointsDetails" and "DroppingPointsDetails"
//           _boardingPointsDetails = responseBody['GetBusRouteDetailResult']['BoardingPointsDetails'] ?? [];
//           _droppingPointsDetails = responseBody['GetBusRouteDetailResult']['DroppingPointsDetails'] ?? [];
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch details: ${response.body}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchBoardingPointDetails();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("Boarding & Dropping Points"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             // Left Side: Boarding Points
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.only(right: 8.0),
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.pink),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Boarding Points Details:",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     _boardingPointsDetails.isEmpty
//                         ? Text("No Boarding Points available")
//                         : ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: _boardingPointsDetails.length,
//                       itemBuilder: (context, index) {
//                         final boardingPoint = _boardingPointsDetails[index];
//                         return ListTile(
//                           title: Text(boardingPoint['CityPointName'] ?? 'Unknown'),
//                           subtitle: Text(boardingPoint['CityPointLocation'] ?? 'No location available'),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Right Side: Dropping Points
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.only(left: 8.0),
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.pink),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Dropping Points Details:",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     _droppingPointsDetails.isEmpty
//                         ? Text("No Dropping Points available")
//                         : ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: _droppingPointsDetails.length,
//                       itemBuilder: (context, index) {
//                         final droppingPoint = _droppingPointsDetails[index];
//                         return ListTile(
//                           title: Text(droppingPoint['CityPointName'] ?? 'Unknown'),
//                           subtitle: Text(droppingPoint['CityPointLocation'] ?? 'No location available'),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// Fishing



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BoardingDroppingPage extends StatefulWidget {
//   @override
//   _BoardingDroppingPageState createState() => _BoardingDroppingPageState();
// }
//
// class _BoardingDroppingPageState extends State<BoardingDroppingPage> with SingleTickerProviderStateMixin {
//   bool _isLoading = false;
//   String _errorMessage = "";
//   List<dynamic> _boardingPointsDetails = []; // Store Boarding Points details
//   List<dynamic> _droppingPointsDetails = []; // Store Dropping Points details
//   late TabController _tabController;
//
//   Future<void> _fetchBoardingPointDetails() async {
//     const String apiUrl = "https://bus.srdvtest.com/v5/rest/GetBoardingPointDetails";
//     const Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": "1",
//     };
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//     });
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//         setState(() {
//           // Assuming the response contains "BoardingPointsDetails" and "DroppingPointsDetails"
//           _boardingPointsDetails = responseBody['GetBusRouteDetailResult']['BoardingPointsDetails'] ?? [];
//           _droppingPointsDetails = responseBody['GetBusRouteDetailResult']['DroppingPointsDetails'] ?? [];
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch details: ${response.body}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _fetchBoardingPointDetails();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("Boarding & Dropping Points"),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(text: "Boarding Points"),
//             Tab(text: "Dropping Points"),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : TabBarView(
//         controller: _tabController,
//         children: [
//           _buildBoardingPointsTab(),
//           _buildDroppingPointsTab(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBoardingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _boardingPointsDetails.isEmpty
//               ? Text("No Boarding Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _boardingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final boardingPoint = _boardingPointsDetails[index];
//               String cityPointTime = boardingPoint['CityPointTime'] ?? '';
//               // Extract hours and minutes from CityPointTime
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(boardingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(boardingPoint['CityPointLocation'] ?? 'No location available'),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDroppingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _droppingPointsDetails.isEmpty
//               ? Text("No Dropping Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _droppingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final droppingPoint = _droppingPointsDetails[index];
//               String cityPointTime = droppingPoint['CityPointTime'] ?? '';
//
//               // Extract hours and minutes from CityPointTime
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(droppingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(droppingPoint['CityPointLocation'] ?? 'No location available'),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }



//testing pass



// import 'dart:convert';
// import 'package:bus_booking_app/customer/passenger_details_form.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'block_ticket_screen.dart';
//
// class BoardingDroppingPage extends StatefulWidget {
//   @override
//   _BoardingDroppingPageState createState() => _BoardingDroppingPageState();
// }
//
// class _BoardingDroppingPageState extends State<BoardingDroppingPage> with SingleTickerProviderStateMixin {
//   bool _isLoading = false;
//   String _errorMessage = "";
//   List<dynamic> _boardingPointsDetails = [];
//   List<dynamic> _droppingPointsDetails = [];
//   late TabController _tabController;
//
//   String? _selectedBoardingPoint;
//   String? _selectedDroppingPoint;
//
//   Future<void> _fetchBoardingPointDetails() async {
//     const String apiUrl = "https://bus.srdvtest.com/v5/rest/GetBoardingPointDetails";
//     const Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": "1",
//     };
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//     });
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//         setState(() {
//           _boardingPointsDetails = responseBody['GetBusRouteDetailResult']['BoardingPointsDetails'] ?? [];
//           _droppingPointsDetails = responseBody['GetBusRouteDetailResult']['DroppingPointsDetails'] ?? [];
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch details: ${response.body}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _fetchBoardingPointDetails();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("Boarding & Dropping Points"),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text("Boarding Points"),
//                     if (_selectedBoardingPoint != null)
//                       Text(
//                         "$_selectedBoardingPoint",
//                         style: TextStyle(fontSize: 12,color: Colors.white),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             Tab(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text("Dropping Points"),
//                     if (_selectedDroppingPoint != null)
//                       Text(
//                         "$_selectedDroppingPoint",
//                         style: TextStyle(fontSize: 12,color: Colors.white),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : TabBarView(
//         controller: _tabController,
//         children: [
//           _buildBoardingPointsTab(),
//           _buildDroppingPointsTab(),
//         ],
//       ),
//     );
//   }
//   Widget _buildBoardingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _boardingPointsDetails.isEmpty
//               ? Text("No Boarding Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _boardingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final boardingPoint = _boardingPointsDetails[index];
//               String cityPointTime = boardingPoint['CityPointTime'] ?? '';
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(boardingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(boardingPoint['CityPointLocation'] ?? 'No location available'),
//                 onTap: () {
//                   setState(() {
//                     _selectedBoardingPoint = boardingPoint['CityPointName'] ?? 'Unknown';
//                   });
//                   _tabController.animateTo(1);
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDroppingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _droppingPointsDetails.isEmpty
//               ? Text("No Dropping Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _droppingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final droppingPoint = _droppingPointsDetails[index];
//               String cityPointTime = droppingPoint['CityPointTime'] ?? '';
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(droppingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(droppingPoint['CityPointLocation'] ?? 'No location available'),
//                 onTap: () {
//                   setState(() {
//                     _selectedDroppingPoint = droppingPoint['CityPointName'] ?? 'Unknown';
//                   });
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => BlockPage(
//                         selectedBoardingPoint: _selectedBoardingPoint ?? 'Unknown',
//                         selectedDroppingPoint: _selectedDroppingPoint ?? 'Unknown',
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }



// Fussy


// import 'dart:convert';
// import 'package:bus_booking_app/customer/passenger_details_form.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BoardingDroppingPage extends StatefulWidget {
//   @override
//   _BoardingDroppingPageState createState() => _BoardingDroppingPageState();
// }
//
// class _BoardingDroppingPageState extends State<BoardingDroppingPage> with SingleTickerProviderStateMixin {
//   bool _isLoading = false;
//   String _errorMessage = "";
//   List<dynamic> _boardingPointsDetails = [];
//   List<dynamic> _droppingPointsDetails = [];
//   late TabController _tabController;
//
//   String? _selectedBoardingPoint;
//   String? _selectedDroppingPoint;
//
//   Future<void> _fetchBoardingPointDetails() async {
//     const String apiUrl = "https://bus.srdvtest.com/v5/rest/GetBoardingPointDetails";
//     const Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": "1",
//     };
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//     });
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//         setState(() {
//           _boardingPointsDetails = responseBody['GetBusRouteDetailResult']['BoardingPointsDetails'] ?? [];
//           _droppingPointsDetails = responseBody['GetBusRouteDetailResult']['DroppingPointsDetails'] ?? [];
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch details: ${response.body}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _fetchBoardingPointDetails();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("Boarding & Dropping Points"),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text("Boarding Points"),
//                     if (_selectedBoardingPoint != null)
//                       Text(
//                         "$_selectedBoardingPoint",
//                         style: TextStyle(fontSize: 12, color: Colors.white),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             Tab(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text("Dropping Points"),
//                     if (_selectedDroppingPoint != null)
//                       Text(
//                         "$_selectedDroppingPoint",
//                         style: TextStyle(fontSize: 12, color: Colors.white),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : TabBarView(
//         controller: _tabController,
//         children: [
//           _buildBoardingPointsTab(),
//           _buildDroppingPointsTab(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBoardingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _boardingPointsDetails.isEmpty
//               ? Text("No Boarding Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _boardingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final boardingPoint = _boardingPointsDetails[index];
//               String cityPointTime = boardingPoint['CityPointTime'] ?? '';
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(boardingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(boardingPoint['CityPointLocation'] ?? 'No location available'),
//                 onTap: () {
//                   setState(() {
//                     _selectedBoardingPoint = boardingPoint['CityPointName'] ?? 'Unknown';
//                   });
//                   _tabController.animateTo(1);
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDroppingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _droppingPointsDetails.isEmpty
//               ? Text("No Dropping Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _droppingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final droppingPoint = _droppingPointsDetails[index];
//               String cityPointTime = droppingPoint['CityPointTime'] ?? '';
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(droppingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(droppingPoint['CityPointLocation'] ?? 'No location available'),
//                 onTap: () {
//                   setState(() {
//                     _selectedDroppingPoint = droppingPoint['CityPointName'] ?? 'Unknown';
//                   });
//                   // Navigate to the BlockPage
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => BlockPage(
//                         selectedBoardingPoint: _selectedBoardingPoint ?? 'Unknown',
//                         selectedDroppingPoint: _selectedDroppingPoint ?? 'Unknown',
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }



//Testing dhee



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BoardingDroppingPage extends StatefulWidget {
//   final String resultIndex;
//   final int columnNo;
//   final int rowNo;
//   final double seatFare;
//   final String seatIndex;
//   final String seatName;
//   final double basePrice;
//   final double publishedPrice;
//   final double publishedPriceRoundedOff;
//   final double offeredPrice;
//   final double offeredPriceRoundedOff;
//
//   const BoardingDroppingPage({
//     required this.resultIndex,
//     required this.columnNo,
//     required this.rowNo,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatName,
//     required this.basePrice,
//     required this.publishedPrice,
//     required this.publishedPriceRoundedOff,
//     required this.offeredPrice,
//     required this.offeredPriceRoundedOff,
//   });
//
//   @override
//   _BoardingDroppingPageState createState() => _BoardingDroppingPageState();
// }
//
// class _BoardingDroppingPageState extends State<BoardingDroppingPage> with SingleTickerProviderStateMixin {
//   bool _isLoading = false;
//   String _errorMessage = "";
//   List<dynamic> _boardingPointsDetails = [];
//   List<dynamic> _droppingPointsDetails = [];
//   late TabController _tabController;
//
//   String? _selectedBoardingPoint;
//   String? _selectedDroppingPoint;
//
//   Future<void> _fetchBoardingPointDetails() async {
//     const String apiUrl = "https://bus.srdvtest.com/v5/rest/GetBoardingPointDetails";
//     Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       // "ResultIndex": "1",
//       "ResultIndex": widget.resultIndex, // Using resultIndex parameter
//     };
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//     });
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//         setState(() {
//           _boardingPointsDetails = responseBody['GetBusRouteDetailResult']['BoardingPointsDetails'] ?? [];
//           _droppingPointsDetails = responseBody['GetBusRouteDetailResult']['DroppingPointsDetails'] ?? [];
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch details: ${response.body}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _fetchBoardingPointDetails();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("Boarding & Dropping Points"),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text("Boarding Points"),
//                     if (_selectedBoardingPoint != null)
//                       Text(
//                         "$_selectedBoardingPoint",
//                         style: TextStyle(fontSize: 12, color: Colors.white),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             Tab(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text("Dropping Points"),
//                     if (_selectedDroppingPoint != null)
//                       Text(
//                         "$_selectedDroppingPoint",
//                         style: TextStyle(fontSize: 12, color: Colors.white),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : TabBarView(
//         controller: _tabController,
//         children: [
//           _buildBoardingPointsTab(),
//           _buildDroppingPointsTab(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBoardingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _boardingPointsDetails.isEmpty
//               ? Text("No Boarding Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _boardingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final boardingPoint = _boardingPointsDetails[index];
//               String cityPointTime = boardingPoint['CityPointTime'] ?? '';
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(boardingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(boardingPoint['CityPointLocation'] ?? 'No location available'),
//                 onTap: () {
//                   setState(() {
//                     _selectedBoardingPoint = boardingPoint['CityPointName'] ?? 'Unknown';
//                   });
//                   _tabController.animateTo(1);
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDroppingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _droppingPointsDetails.isEmpty
//               ? Text("No Dropping Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _droppingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final droppingPoint = _droppingPointsDetails[index];
//               String cityPointTime = droppingPoint['CityPointTime'] ?? '';
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(droppingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(droppingPoint['CityPointLocation'] ?? 'No location available'),
//                 onTap: () {
//                   setState(() {
//                     _selectedDroppingPoint = droppingPoint['CityPointName'] ?? 'Unknown';
//                   });
//                   // Navigate to the BlockPage
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => BlockPage(
//                         selectedBoardingPoint: _selectedBoardingPoint ?? 'Unknown',
//                         selectedDroppingPoint: _selectedDroppingPoint ?? 'Unknown',
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class BlockPage extends StatelessWidget {
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//
//   const BlockPage({required this.selectedBoardingPoint, required this.selectedDroppingPoint});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Boarding & Dropping Details")),
//       body: Center(
//         child: Text(
//           "Boarding Point: $selectedBoardingPoint\nDropping Point: $selectedDroppingPoint",
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }




// Testing


// import 'dart:convert';
// import 'package:bus_booking_app/customer/passenger_details_form.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BoardingDroppingPage extends StatefulWidget {
//   final List<String> selectedSeats;
//
//   const BoardingDroppingPage({Key? key, required this.selectedSeats}) : super(key: key);
//
//   @override
//   _BoardingDroppingPageState createState() => _BoardingDroppingPageState();
// }
//
// class _BoardingDroppingPageState extends State<BoardingDroppingPage> with SingleTickerProviderStateMixin {
//   bool _isLoading = false;
//   String _errorMessage = "";
//   List<dynamic> _boardingPointsDetails = [];
//   List<dynamic> _droppingPointsDetails = [];
//   late TabController _tabController;
//
//   String? _selectedBoardingPoint;
//   String? _selectedDroppingPoint;
//
//   Future<void> _fetchBoardingPointDetails() async {
//     const String apiUrl = "https://bus.srdvtest.com/v5/rest/GetBoardingPointDetails";
//     const Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": "1",
//     };
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//     });
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//         setState(() {
//           _boardingPointsDetails = responseBody['GetBusRouteDetailResult']['BoardingPointsDetails'] ?? [];
//           _droppingPointsDetails = responseBody['GetBusRouteDetailResult']['DroppingPointsDetails'] ?? [];
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch details: ${response.body}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _fetchBoardingPointDetails();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("Boarding & Dropping Points"),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(
//               child: Column(
//                 children: [
//                   Text("Boarding Points"),
//                   if (_selectedBoardingPoint != null)
//                     Text(
//                       "$_selectedBoardingPoint",
//                       style: TextStyle(fontSize: 12, color: Colors.white),
//                     ),
//                 ],
//               ),
//             ),
//             Tab(
//               child: Column(
//                 children: [
//                   Text("Dropping Points"),
//                   if (_selectedDroppingPoint != null)
//                     Text(
//                       "$_selectedDroppingPoint",
//                       style: TextStyle(fontSize: 12, color: Colors.white),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : TabBarView(
//         controller: _tabController,
//         children: [
//           _buildBoardingPointsTab(),
//           _buildDroppingPointsTab(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBoardingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _boardingPointsDetails.isEmpty
//               ? Text("No Boarding Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _boardingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final boardingPoint = _boardingPointsDetails[index];
//               String cityPointTime = boardingPoint['CityPointTime'] ?? '';
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(boardingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(boardingPoint['CityPointLocation'] ?? 'No location available'),
//                 onTap: () {
//                   setState(() {
//                     _selectedBoardingPoint = boardingPoint['CityPointName'] ?? 'Unknown';
//                   });
//                   _tabController.animateTo(1);
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDroppingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _droppingPointsDetails.isEmpty
//               ? Text("No Dropping Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _droppingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final droppingPoint = _droppingPointsDetails[index];
//               String cityPointTime = droppingPoint['CityPointTime'] ?? '';
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(droppingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(droppingPoint['CityPointLocation'] ?? 'No location available'),
//                 onTap: () {
//                   setState(() {
//                     _selectedDroppingPoint = droppingPoint['CityPointName'] ?? 'Unknown';
//                   });
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => BlockPage(
//                         boardingPoint: _selectedBoardingPoint!,
//                         droppingPoint: _selectedDroppingPoint!,
//                         selectedSeats: widget.selectedSeats, selectedBoardingPoint: '', selectedDroppingPoint: '',
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PassengerDetailsForm extends StatelessWidget {
//   final String boardingPoint;
//   final String droppingPoint;
//   final List<String> selectedSeats;
//
//   const PassengerDetailsForm({
//     Key? key,
//     required this.boardingPoint,
//     required this.droppingPoint,
//     required this.selectedSeats,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Passenger Details'),
//       ),
//       body: Center(
//         child: Text(
//           "Boarding Point: $boardingPoint\n"
//               "Dropping Point: $droppingPoint\n"
//               "Selected Seats: ${selectedSeats.join(', ')}",
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }




// Testing


// import 'dart:convert';
// import 'package:bus_booking_app/customer/passenger_details_form.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BoardingDroppingPage extends StatefulWidget {
//   late final String resultIndex;
//   late final String traceId;
//   late final String sourceCity;
//   late final String destinationCity;
//   late final String journeyDate;
//   late final String travelName;
//   late final String busType;
//   late final String arrivalTime;
//   late final String departureTime;
//   final List<Map<String, dynamic>> selectedSeats; // Accept selected seat details
//
//   BoardingDroppingPage({required this.resultIndex, required this.traceId, required this.sourceCity, required this.destinationCity, required this.journeyDate, required this.travelName, required this.busType, required this.arrivalTime, required this.departureTime, required this.selectedSeats});
//
//   @override
//   _BoardingDroppingPageState createState() => _BoardingDroppingPageState();
// }
//
// class _BoardingDroppingPageState extends State<BoardingDroppingPage> with SingleTickerProviderStateMixin {
//   bool _isLoading = false;
//   String _errorMessage = "";
//   List<dynamic> _boardingPointsDetails = [];
//   List<dynamic> _droppingPointsDetails = [];
//   late TabController _tabController;
//
//   String? _selectedBoardingPoint;
//   String? _selectedDroppingPoint;
//
//   Future<void> _fetchBoardingPointDetails() async {
//     const String apiUrl = "https://bus.srdvapi.com/v8/rest/GetBoardingPointDetails";
//     Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": widget.traceId,
//       "ResultIndex": widget.resultIndex,
//     };
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//     });
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//         setState(() {
//           // Updated to match the actual keys in the response
//           _boardingPointsDetails = responseBody['BoardingPoints'] ?? [];
//           _droppingPointsDetails = responseBody['DroppingPoints'] ?? [];
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch details: ${response.body}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _fetchBoardingPointDetails();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("Boarding & Dropping Points"),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text("Boarding Points"),
//                     if (_selectedBoardingPoint != null)
//                       Text(
//                         "$_selectedBoardingPoint",
//                         style: TextStyle(fontSize: 12, color: Colors.white),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             Tab(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text("Dropping Points"),
//                     if (_selectedDroppingPoint != null)
//                       Text(
//                         "$_selectedDroppingPoint",
//                         style: TextStyle(fontSize: 12, color: Colors.white),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : TabBarView(
//         controller: _tabController,
//         children: [
//           _buildBoardingPointsTab(),
//           _buildDroppingPointsTab(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBoardingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _boardingPointsDetails.isEmpty
//               ? Text("No Boarding Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _boardingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final boardingPoint = _boardingPointsDetails[index];
//               String cityPointTime = boardingPoint['CityPointTime'] ?? '';
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(boardingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(boardingPoint['CityPointLocation'] ?? 'No location available'),
//                 onTap: () {
//                   setState(() {
//                     _selectedBoardingPoint = boardingPoint['CityPointName'] ?? 'Unknown';
//                   });
//                   _tabController.animateTo(1);
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDroppingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _droppingPointsDetails.isEmpty
//               ? Text("No Dropping Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _droppingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final droppingPoint = _droppingPointsDetails[index];
//               String cityPointTime = droppingPoint['CityPointTime'] ?? '';
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(droppingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(droppingPoint['CityPointLocation'] ?? 'No location available'),
//                 onTap: () {
//                   setState(() {
//                     _selectedDroppingPoint = droppingPoint['CityPointName'] ?? 'Unknown';
//                   });
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => BlockPage(
//                         // selectedBoardingPoint: _selectedBoardingPoint ?? 'Unknown',
//                         // selectedDroppingPoint: _selectedDroppingPoint ?? 'Unknown',
//                         selectedBoardingPoint: _selectedBoardingPoint ?? 'Unknown',
//                         selectedDroppingPoint: _selectedDroppingPoint ?? 'Unknown',
//                         resultIndex: widget.resultIndex,
//                         traceId: widget.traceId,
//                         sourceCity: widget.sourceCity,
//                         destinationCity: widget.destinationCity,
//                         journeyDate: widget.journeyDate,
//                         travelName: widget.travelName,
//                         busType: widget.busType,
//                         arrivalTime: widget.arrivalTime,
//                         departureTime: widget.departureTime,
//                         selectedSeats: widget.selectedSeats, // Pass the selected seats
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }



//Testing 31



// import 'dart:convert';
// import 'package:bus_booking_app/customer/passenger_details_form.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BoardingDroppingPage extends StatefulWidget {
//   late final String resultIndex;
//   late final String traceId;
//   late final String sourceCity;
//   late final String destinationCity;
//   late final String journeyDate;
//   late final String travelName;
//   late final String busType;
//   late final String arrivalTime;
//   late final String departureTime;
//   final int columnNo;
//   final int height;
//   final bool isLadiesSeat;
//   final bool isMalesSeat;
//   final bool isUpper;
//   final int rowNo;
//   final int seatFare;
//   final String seatIndex;
//   final String seatName;
//   final bool seatStatus;
//   final int seatType;
//   final int width;
//
//   // Price details
//   final String currencyCode;
//   final dynamic basePrice;
//   final dynamic tax;
//   final dynamic otherCharges;
//   final dynamic discount;
//   final dynamic publishedPrice;
//   final dynamic publishedPriceRoundedOff;
//   final dynamic offeredPrice;
//   final dynamic offeredPriceRoundedOff;
//   final dynamic agentCommission;
//   final dynamic agentMarkUp;
//   final dynamic tds;
//   //
//   // GST details
//   final dynamic cgstAmount;
//   final dynamic cgstRate;
//   final dynamic cessAmount;
//   final dynamic cessRate;
//   final dynamic igstAmount;
//   final dynamic igstRate;
//   final dynamic sgstAmount;
//   final dynamic sgstRate;
//   final dynamic taxableAmount;
//   // final Map<String, dynamic> priceDetails;
//   // final List<Map<String, dynamic>> selectedSeats; // Accept selected seat details
//
//   BoardingDroppingPage(
//   {required this.resultIndex, required this.traceId, required this.sourceCity, required this.destinationCity, required this.journeyDate, required this.travelName, required this.busType, required this.arrivalTime, required this.departureTime, required this.seatName,required this.seatFare, required this.seatIndex, required this.seatStatus, required this.seatType, required this.height, required this.width, required this.rowNo, required this.columnNo, required this.isLadiesSeat, required this.isMalesSeat, required this.isUpper, required this.currencyCode, required this.basePrice, required this.tax, required this.otherCharges, required this.discount, required this.publishedPrice, required this.publishedPriceRoundedOff, required this.offeredPrice, required this.offeredPriceRoundedOff, required this.agentCommission, required this.agentMarkUp,
//     required this.tds,
//     required this.cgstAmount,
//     required this.cgstRate,
//     required this.cessAmount,
//     required this.cessRate,
//     required this.igstAmount,
//     required this.igstRate,
//     required this.sgstAmount,
//     required this.sgstRate,
//     required this.taxableAmount
//   }
//   );
//
//   @override
//   _BoardingDroppingPageState createState() => _BoardingDroppingPageState();
// }
//
// class _BoardingDroppingPageState extends State<BoardingDroppingPage> with SingleTickerProviderStateMixin {
//   bool _isLoading = false;
//   String _errorMessage = "";
//   List<dynamic> _boardingPointsDetails = [];
//   List<dynamic> _droppingPointsDetails = [];
//   late TabController _tabController;
//
//   String? _selectedBoardingPoint;
//   int? _selectedBoardingPointIndex;
//   String? _selectedDroppingPoint;
//   int? _selectedDroppingPointIndex;
//
//   Future<void> _fetchBoardingPointDetails() async {
//     const String apiUrl = "https://bus.srdvapi.com/v8/rest/GetBoardingPointDetails";
//     Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": widget.traceId,
//       "ResultIndex": widget.resultIndex,
//     };
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//     });
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//         setState(() {
//           // _boardingPointsDetails = responseBody['GetBusRouteDetailResult']['BoardingPointsDetails'] ?? [];
//           // _droppingPointsDetails = responseBody['GetBusRouteDetailResult']['DroppingPointsDetails'] ?? [];
//           // Updated to match the actual keys in the response
//           _boardingPointsDetails = responseBody['BoardingPoints'] ?? [];
//           _droppingPointsDetails = responseBody['DroppingPoints'] ?? [];
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch details: ${response.body}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _fetchBoardingPointDetails();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("Boarding & Dropping Points"),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text("Boarding Points"),
//                     if (_selectedBoardingPoint != null)
//                       Text(
//                         "$_selectedBoardingPoint",
//                         style: TextStyle(fontSize: 12, color: Colors.white),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             Tab(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text("Dropping Points"),
//                     if (_selectedDroppingPoint != null)
//                       Text(
//                         "$_selectedDroppingPoint",
//                         style: TextStyle(fontSize: 12, color: Colors.white),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : TabBarView(
//         controller: _tabController,
//         children: [
//           _buildBoardingPointsTab(),
//           _buildDroppingPointsTab(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBoardingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _boardingPointsDetails.isEmpty
//               ? Text("No Boarding Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _boardingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final boardingPoint = _boardingPointsDetails[index];
//               String cityPointTime = boardingPoint['CityPointTime'] ?? '';
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(boardingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(boardingPoint['CityPointLocation'] ?? 'No location available'),
//                 onTap: () {
//                   setState(() {
//                     _selectedBoardingPoint = boardingPoint['CityPointName'] ?? 'Unknown';
//                     _selectedBoardingPointIndex = boardingPoint['CityPointIndex']; // Extract CityPointIndex
//                   });
//                   _tabController.animateTo(1);
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDroppingPointsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: [
//           _droppingPointsDetails.isEmpty
//               ? Text("No Dropping Points available")
//               : ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _droppingPointsDetails.length,
//             itemBuilder: (context, index) {
//               final droppingPoint = _droppingPointsDetails[index];
//               String cityPointTime = droppingPoint['CityPointTime'] ?? '';
//               String formattedTime = cityPointTime.contains('T')
//                   ? cityPointTime.split('T')[1].split(':').take(2).join(':')
//                   : cityPointTime.split(':').take(2).join(':');
//
//               return ListTile(
//                 leading: Text(
//                   formattedTime,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 title: Text(droppingPoint['CityPointName'] ?? 'Unknown'),
//                 subtitle: Text(droppingPoint['CityPointLocation'] ?? 'No location available'),
//                 onTap: () {
//                   setState(() {
//                     _selectedDroppingPoint = droppingPoint['CityPointName'] ?? 'Unknown';
//                     _selectedDroppingPointIndex = droppingPoint['CityPointIndex']; // Store CityPointIndex
//                   });
//                   print("Column No: ${widget.columnNo}");
//                   print("Seat Name: ${widget.seatName}");
//                   print("Seat Status: ${widget.seatStatus}");
//                   print("Height: ${widget.height}");
//                   print("Width: ${widget.width}");
//                   print("Is Male Seat: ${widget.isMalesSeat}");
//                   print("Is Ladies Seat: ${widget.isLadiesSeat}");
//                   print("Is Upper: ${widget.isUpper}");
//                   print("Row No: ${widget.rowNo}");
//                   print("Seat Fare: ${widget.seatFare}");
//                   print("Seat Index: ${widget.seatIndex}");
//                   print("Seat Type: ${widget.seatType}");
//                   print("Currency Code: ${widget.currencyCode}");
//                   print("Base Price: ${widget.basePrice}");
//                   print("Tax: ${widget.tax}");
//                   print("Other Charges: ${widget.otherCharges}");
//                   print("Discount: ${widget.discount}");
//                   print("Published Price: ${widget.publishedPrice}");
//                   print("Published Price RoundedOff: ${widget.publishedPriceRoundedOff}");
//                   print("Offer Price: ${widget.offeredPrice}");
//                   print("Offer Price RoundedOff: ${widget.offeredPriceRoundedOff}");
//                   print("Agent Commission: ${widget.agentCommission}");
//                   print("Agent MarkUp: ${widget.agentMarkUp}");
//                   print("Tds: ${widget.tds}");
//                   print("CGST Amount: ${widget.cgstAmount}");
//                   print("CGST Rate: ${widget.cgstRate}");
//                   print("CESS Amount: ${widget.cessAmount}");
//                   print("CESS Rate: ${widget.cessRate}");
//                   print("IGST Amount: ${widget.igstAmount}");
//                   print("IGST Rate: ${widget.igstRate}");
//                   print("SGST Amount: ${widget.sgstAmount}");
//                   print("SGST Rate: ${widget.sgstRate}");
//                   print("Taxable Amount: ${widget.taxableAmount}");
//                   print("Selected Boarding Point: $_selectedBoardingPoint");
//                   print("Selected Boarding Point Index: $_selectedBoardingPointIndex");
//                   print("Selected Droping Point: $_selectedDroppingPoint");
//                   print("Selected Droping Point Index: $_selectedDroppingPointIndex");
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => BlockSeatPage(
//                         boardingPointIndex: _selectedBoardingPointIndex,
//                         droppingPointIndex: _selectedDroppingPointIndex,
//                         // selectedBoardingPoint: _selectedBoardingPoint ?? 'Unknown',
//                         // selectedDroppingPoint: _selectedDroppingPoint ?? 'Unknown',
//                         selectedBoardingPoint: _selectedBoardingPoint ?? 'Unknown',
//                         selectedDroppingPoint: _selectedDroppingPoint ?? 'Unknown',
//                         resultIndex: widget.resultIndex,
//                         traceId: widget.traceId,
//                         sourceCity: widget.sourceCity,
//                         destinationCity: widget.destinationCity,
//                         journeyDate: widget.journeyDate,
//                         travelName: widget.travelName,
//                         busType: widget.busType,
//                         arrivalTime: widget.arrivalTime,
//                         departureTime: widget.departureTime,
//
//
//                         columnNo: widget.columnNo,
//                         height: widget.height,
//                         isLadiesSeat: widget.isLadiesSeat,
//                         isMalesSeat: widget.isMalesSeat,
//                         isUpper: widget.isUpper,
//                         rowNo: widget.rowNo,
//                         seatFare: widget.seatFare,
//                         seatIndex: widget.seatIndex,
//                         seatName: widget.seatName,
//                         seatStatus: widget.seatStatus,
//                         seatType: widget.seatType,
//                         width: widget.width,
//
//                         currencyCode: widget.currencyCode,
//                         basePrice: widget.basePrice,
//                         tax: widget.tax,
//                         otherCharges: widget.otherCharges,
//                         discount: widget.discount,
//                         publishedPrice: widget.publishedPrice,
//                         publishedPriceRoundedOff: widget.publishedPriceRoundedOff,
//                         offeredPrice: widget.offeredPrice,
//                         offeredPriceRoundedOff: widget.offeredPriceRoundedOff,
//                         agentCommission: widget.agentCommission,
//                         agentMarkUp: widget.agentMarkUp,
//                         tds: widget.tds,
//                         cgstAmount: widget.cgstAmount,
//                         cgstRate: widget.cgstRate,
//                         cessAmount: widget.cessAmount,
//                         cessRate: widget.cessRate,
//                         igstAmount: widget.igstAmount,
//                         igstRate: widget.igstRate,
//                         sgstAmount: widget.sgstAmount,
//                         sgstRate: widget.sgstRate,
//                         taxableAmount: widget.taxableAmount,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }





//tin



import 'dart:convert';
import 'package:bus_booking_app/customer/passenger_details_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BoardingDroppingPage extends StatefulWidget {
  late final String resultIndex;
  late final String traceId;
  late final String sourceCity;
  late final String destinationCity;
  late final String journeyDate;
  late final String travelName;
  late final String busType;
  late final String arrivalTime;
  late final String departureTime;
  final dynamic columnNo;
  final int height;
  final bool isLadiesSeat;
  final bool isMalesSeat;
  final bool isUpper;
  final dynamic rowNo;
  final dynamic seatFare;
  final dynamic seatIndex;
  final String seatName;
  final bool seatStatus;
  final int seatType;
  final int width;
  //
  // // Price details
  final String currencyCode;
  final dynamic basePrice;
  final int tax;
  final int otherCharges;
  final int discount;
  final dynamic publishedPrice;
  final int publishedPriceRoundedOff;
  final dynamic offeredPrice;
  final int offeredPriceRoundedOff;
  final dynamic agentCommission;
  final int agentMarkUp;
  final dynamic tds;
  // //
  // // GST details
  final int cgstAmount;
  final int cgstRate;
  final int cessAmount;
  final int cessRate;
  final int igstAmount;
  final int igstRate;
  final int sgstAmount;
  final int sgstRate;
  final int taxableAmount;


  BoardingDroppingPage(
      {
        required this.resultIndex,
        required this.traceId,
        required this.sourceCity,
        required this.destinationCity,
        required this.journeyDate,
        required this.travelName,
        required this.busType,
        required this.arrivalTime,
        required this.departureTime,
        required this.seatName,
        required this.seatFare,
        required this.seatIndex,
        required this.seatStatus,
        required this.seatType,
        required this.height,
        required this.width,
        required this.rowNo,
        required this.columnNo,
        required this.isLadiesSeat,
        required this.isMalesSeat,
        required this.isUpper,
        required this.currencyCode,
        required this.basePrice,
        required this.tax,
        required this.otherCharges,
        required this.discount,
        required this.publishedPrice,
        required this.publishedPriceRoundedOff,
        required this.offeredPrice,
        required this.offeredPriceRoundedOff,
        required this.agentCommission,
        required this.agentMarkUp,
        required this.tds,
        required this.cgstAmount,
        required this.cgstRate,
        required this.cessAmount,
        required this.cessRate,
        required this.igstAmount,
        required this.igstRate,
        required this.sgstAmount,
        required this.sgstRate,
        required this.taxableAmount
      }
  );

  @override
  _BoardingDroppingPageState createState() => _BoardingDroppingPageState();
}

class _BoardingDroppingPageState extends State<BoardingDroppingPage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  String _errorMessage = "";
  List<dynamic> _boardingPointsDetails = [];
  List<dynamic> _droppingPointsDetails = [];
  late TabController _tabController;

  String? _selectedBoardingPoint;
  int? _selectedBoardingPointIndex;
  String? _selectedDroppingPoint;
  int? _selectedDroppingPointIndex;

  Future<void> _fetchBoardingPointDetails() async {
    // const String apiUrl = "https://bus.srdvapi.com/v5/rest/GetBoardingPointDetails";
    const String apiUrl = "http://3.7.121.234/bus-api/GetBoardingPointDetails";

    Map<String, dynamic> requestBody = {
      "ClientId": "180187",
      "UserName": "Namma434",
      "Password": "Namma@4341",
      "TraceId": widget.traceId,
      "ResultIndex": widget.resultIndex,
    };
    const headers = {
      "Content-Type": "application/json",
      "Api-Token": "Namma@90434#34",
    };

    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          // Extract BoardingPointsDetails and DroppingPointsDetails
          _boardingPointsDetails =
              responseBody['GetBusRouteDetailResult']['BoardingPointsDetails'] ?? [];
          _droppingPointsDetails =
              responseBody['GetBusRouteDetailResult']['DroppingPointsDetails'] ?? [];
        });
      } else {
        setState(() {
          _errorMessage = "Failed to fetch details: ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Error: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchBoardingPointDetails();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent.shade700,
        title: Text("Boarding & Dropping Points",style: TextStyle(color: Colors.white),),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Boarding Points",style: TextStyle(color: Colors.blueGrey.shade200),),
                    if (_selectedBoardingPoint != null)
                      Text(
                        "$_selectedBoardingPoint",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                  ],
                ),
              ),
            ),
            Tab(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Dropping Points",style: TextStyle(color: Colors.blueGrey.shade200),),
                    if (_selectedDroppingPoint != null)
                      Text(
                        "$_selectedDroppingPoint",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : TabBarView(
        controller: _tabController,
        children: [
          _buildBoardingPointsTab(),
          _buildDroppingPointsTab(),
        ],
      ),
    );
  }

  Widget _buildBoardingPointsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _boardingPointsDetails.isEmpty
              ? Text("No Boarding Points available")
              : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _boardingPointsDetails.length,
            itemBuilder: (context, index) {
              final boardingPoint = _boardingPointsDetails[index];
              String cityPointTime = boardingPoint['CityPointTime'] ?? '';
              String formattedTime = cityPointTime.contains('T')
                  ? cityPointTime.split('T')[1].split(':').take(2).join(':')
                  : cityPointTime.split(':').take(2).join(':');

              return ListTile(
                leading: Text(
                  formattedTime,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                title: Text(boardingPoint['CityPointName'] ?? 'Unknown'),
                subtitle: Text(boardingPoint['CityPointLocation'] ?? 'No location available'),
                onTap: () {
                  setState(() {
                    _selectedBoardingPoint = boardingPoint['CityPointName'] ?? 'Unknown';
                    _selectedBoardingPointIndex = boardingPoint['CityPointIndex']; // Extract CityPointIndex
                  });
                  _tabController.animateTo(1);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDroppingPointsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _droppingPointsDetails.isEmpty
              ? Text("No Dropping Points available")
              : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _droppingPointsDetails.length,
            itemBuilder: (context, index) {
              final droppingPoint = _droppingPointsDetails[index];
              String cityPointTime = droppingPoint['CityPointTime'] ?? '';
              String formattedTime = cityPointTime.contains('T')
                  ? cityPointTime.split('T')[1].split(':').take(2).join(':')
                  : cityPointTime.split(':').take(2).join(':');

              return ListTile(
                leading: Text(
                  formattedTime,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                title: Text(droppingPoint['CityPointName'] ?? 'Unknown'),
                subtitle: Text(droppingPoint['CityPointLocation'] ?? 'No location available'),
                onTap: () {
                  setState(() {
                    _selectedDroppingPoint = droppingPoint['CityPointName'] ?? 'Unknown';
                    _selectedDroppingPointIndex = droppingPoint['CityPointIndex']; // Extract CityPointIndex
                  });
                  print("Result Index: ${widget.resultIndex}");
                  print("Trace ID: ${widget.traceId}");
                  print("Source City: ${widget.sourceCity}");
                  print("Destination City: ${widget.destinationCity}");
                  print("Journey Date: ${widget.journeyDate}");
                  print("Arrival Time: ${widget.arrivalTime}");
                  print("Departure Time: ${widget.departureTime}");
                  print("Travel Name: ${widget.travelName}");
                  print("Bus Type: ${widget.busType}");
                  print("Column No: ${widget.columnNo}");
                  print("Seat Name: ${widget.seatName}");
                  print("Seat Status: ${widget.seatStatus}");
                  print("Height: ${widget.height}");
                  print("Width: ${widget.width}");
                  print("Is Male Seat: ${widget.isMalesSeat}");
                  print("Is Ladies Seat: ${widget.isLadiesSeat}");
                  print("Is Upper: ${widget.isUpper}");
                  print("Row No: ${widget.rowNo}");
                  print("Seat Fare: ${widget.seatFare}");
                  print("Seat Index: ${widget.seatIndex}");
                  print("Seat Type: ${widget.seatType}");
                  print("Currency Code: ${widget.currencyCode}");
                  print("Base Price: ${widget.basePrice}");
                  print("Tax: ${widget.tax}");
                  print("Other Charges: ${widget.otherCharges}");
                  print("Discount: ${widget.discount}");
                  print("Published Price: ${widget.publishedPrice}");
                  print("Published Price RoundedOff: ${widget.publishedPriceRoundedOff}");
                  print("Offer Price: ${widget.offeredPrice}");
                  print("Offer Price RoundedOff: ${widget.offeredPriceRoundedOff}");
                  print("Agent Commission: ${widget.agentCommission}");
                  print("Agent MarkUp: ${widget.agentMarkUp}");
                  print("Tds: ${widget.tds}");
                  print("CGST Amount: ${widget.cgstAmount}");
                  print("CGST Rate: ${widget.cgstRate}");
                  print("CESS Amount: ${widget.cessAmount}");
                  print("CESS Rate: ${widget.cessRate}");
                  print("IGST Amount: ${widget.igstAmount}");
                  print("IGST Rate: ${widget.igstRate}");
                  print("SGST Amount: ${widget.sgstAmount}");
                  print("SGST Rate: ${widget.sgstRate}");
                  print("Taxable Amount: ${widget.taxableAmount}");
                  print("Selected Boarding Point: $_selectedBoardingPoint");
                  print("Selected Boarding Point Index: $_selectedBoardingPointIndex");
                  print("Selected Droping Point: $_selectedDroppingPoint");
                  print("Selected Droping Point Index: $_selectedDroppingPointIndex");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => BlockSeatPage(
                  //       boardingPointIndex: _selectedBoardingPointIndex,
                  //       droppingPointIndex: _selectedDroppingPointIndex,
                  //       // selectedBoardingPoint: _selectedBoardingPoint ?? 'Unknown',
                  //       // selectedDroppingPoint: _selectedDroppingPoint ?? 'Unknown',
                  //       selectedBoardingPoint: _selectedBoardingPoint ?? 'Unknown',
                  //       selectedDroppingPoint: _selectedDroppingPoint ?? 'Unknown',
                  //       resultIndex: widget.resultIndex,
                  //       traceId: widget.traceId,
                  //       sourceCity: widget.sourceCity,
                  //       destinationCity: widget.destinationCity,
                  //       journeyDate: widget.journeyDate,
                  //       travelName: widget.travelName,
                  //       busType: widget.busType,
                  //       arrivalTime: widget.arrivalTime,
                  //       departureTime: widget.departureTime,
                  //
                  //       columnNo: widget.columnNo,
                  //       height: widget.height,
                  //       isLadiesSeat: widget.isLadiesSeat,
                  //       isMalesSeat: widget.isMalesSeat,
                  //       isUpper: widget.isUpper,
                  //       rowNo: widget.rowNo,
                  //       seatFare: widget.seatFare,
                  //       seatIndex: widget.seatIndex,
                  //       seatName: widget.seatName,
                  //       seatStatus: widget.seatStatus,
                  //       seatType: widget.seatType,
                  //       width: widget.width,
                  //
                  //       currencyCode: widget.currencyCode,
                  //       basePrice: widget.basePrice,
                  //       tax: widget.tax,
                  //       otherCharges: widget.otherCharges,
                  //       discount: widget.discount,
                  //       publishedPrice: widget.publishedPrice,
                  //       publishedPriceRoundedOff: widget.publishedPriceRoundedOff,
                  //       offeredPrice: widget.offeredPrice,
                  //       offeredPriceRoundedOff: widget.offeredPriceRoundedOff,
                  //       agentCommission: widget.agentCommission,
                  //       agentMarkUp: widget.agentMarkUp,
                  //       tds: widget.tds,
                  //       cgstAmount: widget.cgstAmount,
                  //       cgstRate: widget.cgstRate,
                  //       cessAmount: widget.cessAmount,
                  //       cessRate: widget.cessRate,
                  //       igstAmount: widget.igstAmount,
                  //       igstRate: widget.igstRate,
                  //       sgstAmount: widget.sgstAmount,
                  //       sgstRate: widget.sgstRate,
                  //       taxableAmount: widget.taxableAmount,
                  //     ),
                  //   ),
                  // );

                  },
              );
            },
          ),
        ],
      ),
    );
  }
}