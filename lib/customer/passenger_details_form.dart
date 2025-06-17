// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BlockPage extends StatefulWidget {
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//
//   BlockPage({required this.selectedBoardingPoint, required this.selectedDroppingPoint});
//
//   @override
//   _BlockPageState createState() => _BlockPageState();
// }
//
// class _BlockPageState extends State<BlockPage> {
//   bool _isLoading = false;
//   String _errorMessage = "";
//   late TextEditingController _firstNameController;
//   late TextEditingController _lastNameController;
//   late TextEditingController _emailController;
//   late TextEditingController _phoneController;
//   late TextEditingController _ageController;
//   late TextEditingController _genderController;
//
//   @override
//   void initState() {
//     super.initState();
//     _firstNameController = TextEditingController();
//     _lastNameController = TextEditingController();
//     _emailController = TextEditingController();
//     _phoneController = TextEditingController();
//     _ageController = TextEditingController();
//     _genderController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _ageController.dispose();
//     _genderController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _sendBookingRequest() async {
//     const String apiUrl = "https://bus.srdvtest.com/v5/rest/Block";
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     final requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": "1",
//       "FirstName": _firstNameController.text,
//       "LastName": _lastNameController.text,
//       "Email": _emailController.text,
//       "Phoneno": _phoneController.text,
//       "Gender": _genderController.text,
//       "Age": _ageController.text,
//       "ColumnNo": "000",
//       "Height": 1,
//       "IsLadiesSeat": false,
//       "IsMaleSeat": false,
//       "IsUpper": false,
//       "RowNo": "000",
//       "SeatFare": 400,
//       "SeatIndex": 1,
//       "SeatName": "1",
//       "SeatStatus": true,
//       "SeatType": 1,
//       "width": 1,
//       "CurrencyCode": "INR",
//       "BasePrice": 400,
//       "Tax": 0,
//       "OtherCharges": 0,
//       "Discount": 0,
//       "PublishedPrice": 400,
//       "PublishedPriceRoundedOff": 400,
//       "OfferedPrice": "380",
//       "OfferedPriceRoundedOff": 380,
//       "AgentCommission": 20,
//       "AgentMarkUp": 0,
//       "TDS": 8,
//       "CGSTAmount": 0,
//       "CGSTRate": 0,
//       "CessAmount": 0,
//       "CessRate": 0,
//       "IGSTAmount": 0,
//       "IGSTRate": 18,
//       "SGSTAmount": 0,
//       "SGSTRate": 0,
//       "TaxableAmount": 0
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
//         // Handle successful response
//         print('API Response: ${response.body}');
//       } else {
//         setState(() {
//           _errorMessage = "Failed to send booking request: ${response.body}";
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
//   String _getFormattedDateTime() {
//     final now = DateTime.now();
//     final formattedDate = "${now.day}-${now.month}-${now.year}";
//     final formattedTime = "${now.hour}:${now.minute}";
//     final weekday = now.weekday;
//
//     return "$formattedDate $formattedTime (${_getDayName(weekday)})";
//   }
//
//   String _getDayName(int weekday) {
//     switch (weekday) {
//       case 1:
//         return "Monday";
//       case 2:
//         return "Tuesday";
//       case 3:
//         return "Wednesday";
//       case 4:
//         return "Thursday";
//       case 5:
//         return "Friday";
//       case 6:
//         return "Saturday";
//       case 7:
//         return "Sunday";
//       default:
//         return "";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Block Seat"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               "Boarding Point: ${widget.selectedBoardingPoint}",
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               "Dropping Point: ${widget.selectedDroppingPoint}",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             Text(
//               "Date and Time: ${_getFormattedDateTime()}",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             _buildTextField(_firstNameController, "First Name"),
//             _buildTextField(_lastNameController, "Last Name"),
//             _buildTextField(_emailController, "Email"),
//             _buildTextField(_phoneController, "Phone Number"),
//             _buildTextField(_ageController, "Age"),
//             _buildTextField(_genderController, "Gender"),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _sendBookingRequest,
//               child: Text("Send Booking Request"),
//             ),
//             if (_errorMessage.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: Text(
//                   _errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String label) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
// }
//
//



// testing



// import 'dart:convert';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BlockPage extends StatefulWidget {
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   final List<String> selectedSeats;
//
//   const BlockPage({
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.selectedSeats,
//     Key? key, required String boardingPoint, required String droppingPoint,
//   }) : super(key: key);
//
//   @override
//   _BlockPageState createState() => _BlockPageState();
// }
//
// class _BlockPageState extends State<BlockPage> {
//   bool _isLoading = false;
//   String _message = "";
//   Set<String> _disabledSeats = {}; // Set to track disabled seats
//
//   // Function to disable selected seats for 5 minutes
//   void _disableSeatsFor5Minutes(List<String> seatsToDisable) {
//     setState(() {
//       _disabledSeats.addAll(seatsToDisable); // Add selected seats to disabled set
//     });
//
//     // Set a timer to re-enable the seats after 5 minutes (300 seconds)
//     Timer(Duration(minutes: 5), () {
//       setState(() {
//         _disabledSeats.removeAll(seatsToDisable); // Remove the seats after 5 minutes
//       });
//     });
//   }
//
//   Future<void> _blockSeat() async {
//     const String apiUrl = "https://bus.srdvtest.com/v5/rest/Block";
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     // Print the selected seat names in the console
//     print("Selected Seats: ${widget.selectedSeats.join(', ')}");
//
//     // You might want to include `widget.selectedSeats` in the requestBody as needed
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": "1",
//       "BordingPointId": "1",
//       "DropingPointId": "1",
//       "RefID": "1",
//       "LeadPassenger": "1",
//       "PassangerId": "1",
//       "Title": "T",
//       "FirstName": "Ashok",
//       "LastName": "Bunga",
//       "Email": "ashokbunga83@gmail.com",
//       "Gender": "Male",
//       "Address": "Bengaluru",
//       "Age": "24",
//       "ColumnNo": "000",
//       "Height": 1,
//       "IsLadiesSeat": false,
//       "IsMaleSeat": false,
//       "IsUpper": false,
//       "RowNo": "000",
//       "SeatFare": 400,
//       "SeatIndex": 1,
//       "SeatName": widget.selectedSeats.join(', '),
//       "SeatStatus": true,
//       "SeatType": 1,
//       "width": 1,
//       "CurrencyCode": "INR",
//       "BasePrice": 400,
//       "Tax": 0,
//       "OtherCharges": 0,
//       "Discount": 0,
//       "PublishedPrice": 400,
//       "PublishedPriceRoundedOff": 400,
//       "OfferedPrice": "380",
//       "OfferedPriceRoundedOff": 380,
//       "AgentCommission": 20,
//       "AgentMarkUp": 0,
//       "TDS": 8,
//       "CGSTAmount": 0,
//       "CGSTRate": 0,
//       "CessAmount": 0,
//       "CessRate": 0,
//       "IGSTAmount": 0,
//       "IGSTRate": 18,
//       "SGSTAmount": 0,
//       "SGSTRate": 0,
//       "TaxableAmount": 0,
//     };
//
//     setState(() {
//       _isLoading = true;
//       _message = "";
//     });
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       print("Response Status Code: ${response.statusCode}");
//       print("Response Body: ${response.body}"); // Logging the response body
//
//       if (response.statusCode == 200) {
//         // After successfully blocking the seat, disable the seats for 5 minutes
//         _disableSeatsFor5Minutes(widget.selectedSeats);
//
//         final responseBody = jsonDecode(response.body);
//         setState(() {
//           _message = "Seat blocked successfully: ${responseBody['message']}";
//         });
//       } else {
//         setState(() {
//           _message = "Failed to block seat: ${response.body}";
//         });
//       }
//     } catch (e) {
//       print("Error: ${e.toString()}"); // Logging error
//       setState(() {
//         _message = "Error: ${e.toString()}";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("Block Seat"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Selected Boarding Point: ${widget.selectedBoardingPoint}",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Selected Dropping Point: ${widget.selectedDroppingPoint}",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Selected Seats: ${widget.selectedSeats.join(', ')}",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             _isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : ElevatedButton(
//               onPressed: _blockSeat,
//               child: Text("Block Seat"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.pink,
//                 padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
//                 textStyle: TextStyle(fontSize: 18),
//               ),
//             ),
//             SizedBox(height: 20),
//             if (_message.isNotEmpty)
//               Text(
//                 _message,
//                 style: TextStyle(
//                   color: _message.contains("successfully") ? Colors.green : Colors.red,
//                   fontSize: 16,
//                 ),
//               ),
//             SizedBox(height: 20),
//             // Displaying disabled seats to the user
//             Text(
//               "Currently Disabled Seats: ${_disabledSeats.join(', ')}",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             // Displaying seats as buttons
//             Wrap(
//               children: widget.selectedSeats.map((seat) {
//                 return ElevatedButton(
//                   onPressed: _disabledSeats.contains(seat) ? null : () {}, // Disable interaction if the seat is in the _disabledSeats set
//                   child: Text(seat),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: _disabledSeats.contains(seat) ? Colors.grey : Colors.pink, // Change color if disabled
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





// Testing

// import 'dart:convert';
// import 'package:bus_booking_app/customer/ticket_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BlockPage extends StatefulWidget {
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//
//   BlockPage({required this.selectedBoardingPoint, required this.selectedDroppingPoint});
//
//   @override
//   _BlockPageState createState() => _BlockPageState();
// }
//
// class _BlockPageState extends State<BlockPage> {
//   bool _isLoading = false;
//   String _errorMessage = "";
//   String _responseStatus = '';
//   String _arrivalTime = '';
//   String _busType = '';
//   String _departureTime = '';
//
//   Future<void> _blockSeat() async {
//     const String apiUrl = "https://bus.srdvtest.com/v5/rest/Block";
//     const Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": "1",
//       "BordingPointId": "1",
//       "DropingPointId": "1",
//       "RefID": "1",
//       "LeadPassenger": true,
//       "PassangerId": 0,
//       "Title": "Mr",
//       "FirstName": "Rajesh",
//       "LastName": "Tomar",
//       "Email": "rajesh@srdvtechnologies.com",
//       "Phoneno": "8555003861",
//       "Gender": "1",
//       "Address": "Modinagar",
//       "Age": "28",
//       "ColumnNo": "002",
//       "Height": 1,
//       "IsLadiesSeat": false,
//       "IsMaleSeat": false,
//       "IsUpper": false,
//       "RowNo": "004",
//       "SeatFare": 400,
//       "SeatIndex": 18,
//       "SeatName": "18",
//       "SeatStatus": true,
//       "SeatType": 1,
//       "width": 1,
//       "CurrencyCode": "INR",
//       "BasePrice": 400,
//       "Tax": 0,
//       "OtherCharges": 0,
//       "Discount": 0,
//       "PublishedPrice": 400,
//       "PublishedPriceRoundedOff": 400,
//       "OfferedPrice": "380",
//       "OfferedPriceRoundedOff": 380,
//       "AgentCommission": 20,
//       "AgentMarkUp": 0,
//       "TDS": 8,
//       "CGSTAmount": 0,
//       "CGSTRate": 0,
//       "CessAmount": 0,
//       "CessRate": 0,
//       "IGSTAmount": 0,
//       "IGSTRate": 18,
//       "SGSTAmount": 0,
//       "SGSTRate": 0,
//       "TaxableAmount": 0
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
//         headers: {
//           "Content-Type": "application/json",
//           "Api-Token": "Namma@90434#34",
//         },
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//
//         // Extract the fields you need
//         setState(() {
//           _responseStatus = responseBody['Result']['ResponseStatus'].toString();
//           _arrivalTime = responseBody['Result']['ArrivalTime'] ?? 'Not Available';
//           _busType = responseBody['Result']['BusType'] ?? 'Not Available';
//           _departureTime = responseBody['Result']['DepartureTime'] ?? 'Not Available';
//         });
//
//         // Print response to console
//         print("ResponseStatus: $_responseStatus");
//         print("ArrivalTime: $_arrivalTime");
//         print("BusType: $_busType");
//         print("DepartureTime: $_departureTime");
//       } else {
//         setState(() {
//           _errorMessage = "Failed to block the seat. Status Code: ${response.statusCode}";
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
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text('Block Seat'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text("Boarding Point: ${widget.selectedBoardingPoint}"),
//             Text("Dropping Point: ${widget.selectedDroppingPoint}"),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _blockSeat,
//               child: Text("Block Seat"),
//             ),
//             SizedBox(height: 20),
//             if (_errorMessage.isNotEmpty)
//               Text(
//                 _errorMessage,
//                 style: TextStyle(color: Colors.red),
//               ),
//             if (_responseStatus.isNotEmpty) ...[
//               SizedBox(height: 20),
//               Text("Response Status: $_responseStatus"),
//               Text("Arrival Time: $_arrivalTime"),
//               Text("Bus Type: $_busType"),
//               Text("Departure Time: $_departureTime"),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => BookPage(),
//                     ),
//                   );
//                 },
//                 child: Text("Book Ticket"),
//               ),
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }


//Test


// import 'dart:convert';
// import 'package:bus_booking_app/customer/ticket_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BlockPage extends StatefulWidget {
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   final String resultIndex;
//   final String traceId;
//   final String sourceCity;
//   final String destinationCity;
//   final String journeyDate;
//   final String travelName;
//   final String busType;
//   final String arrivalTime;
//   final String departureTime;
//   final List<Map<String, dynamic>> selectedSeats;
//
//   BlockPage({required this.selectedBoardingPoint, required this.selectedDroppingPoint, required this.resultIndex, required this.traceId, required this.sourceCity, required this.destinationCity, required this.journeyDate, required this.travelName, required this.busType, required this.arrivalTime, required this.departureTime, required this.selectedSeats});
//
//   @override
//   _BlockPageState createState() => _BlockPageState();
// }
//
// class _BlockPageState extends State<BlockPage> {
//   bool _isLoading = false;
//   String _errorMessage = "";
//   String _responseStatus = '';
//   String _arrivalTime = '';
//   String _busType = '';
//   String _departureTime = '';
//
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//
//   Future<void> _blockSeat() async {
//     const String apiUrl = "https://bus.srdvtest.com/v5/rest/Block";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": "1",
//       "BordingPointId": "1",
//       "DropingPointId": "1",
//       "RefID": "1",
//       "LeadPassenger": true,
//       "PassangerId": 0,
//       "Title": "Mr",
//       "FirstName": _firstNameController.text,
//       "LastName": _lastNameController.text,
//       "Email": _emailController.text,
//       "Phoneno": _phoneNumberController.text,
//       "Gender": _genderController.text,
//       "Address": _addressController.text,
//       "Age": _ageController.text,
//       "ColumnNo": "002",
//       "Height": 1,
//       "IsLadiesSeat": false,
//       "IsMaleSeat": false,
//       "IsUpper": false,
//       "RowNo": "004",
//       "SeatFare": 400,
//       "SeatIndex": 18,
//       "SeatName": "18",
//       "SeatStatus": true,
//       "SeatType": 1,
//       "width": 1,
//       "CurrencyCode": "INR",
//       "BasePrice": 400,
//       "Tax": 0,
//       "OtherCharges": 0,
//       "Discount": 0,
//       "PublishedPrice": 400,
//       "PublishedPriceRoundedOff": 400,
//       "OfferedPrice": "380",
//       "OfferedPriceRoundedOff": 380,
//       "AgentCommission": 20,
//       "AgentMarkUp": 0,
//       "TDS": 8,
//       "CGSTAmount": 0,
//       "CGSTRate": 0,
//       "CessAmount": 0,
//       "CessRate": 0,
//       "IGSTAmount": 0,
//       "IGSTRate": 18,
//       "SGSTAmount": 0,
//       "SGSTRate": 0,
//       "TaxableAmount": 0
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
//         headers: {
//           "Content-Type": "application/json",
//           "Api-Token": "Namma@90434#34",
//         },
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//
//         // Extract the fields you need
//         setState(() {
//           _responseStatus = responseBody['Result']['ResponseStatus'].toString();
//           _arrivalTime = responseBody['Result']['ArrivalTime'] ?? 'Not Available';
//           _busType = responseBody['Result']['BusType'] ?? 'Not Available';
//           _departureTime = responseBody['Result']['DepartureTime'] ?? 'Not Available';
//         });
//
//         // Print response to console
//         print("ResponseStatus: $_responseStatus");
//         print("ArrivalTime: $_arrivalTime");
//         print("BusType: $_busType");
//         print("DepartureTime: $_departureTime");
//       } else {
//         setState(() {
//           _errorMessage = "Failed to block the seat. Status Code: ${response.statusCode}";
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
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text('Block Seat'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Text("Boarding Point: ${widget.selectedBoardingPoint}"),
//               Text("Dropping Point: ${widget.selectedDroppingPoint}"),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(labelText: 'First Name'),
//               ),
//               TextField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(labelText: 'Last Name'),
//               ),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//               ),
//               TextField(
//                 controller: _phoneNumberController,
//                 decoration: InputDecoration(labelText: 'Phone Number'),
//               ),
//               TextField(
//                 controller: _genderController,
//                 decoration: InputDecoration(labelText: 'Gender'),
//               ),
//               TextField(
//                 controller: _ageController,
//                 decoration: InputDecoration(labelText: 'Age'),
//               ),
//               TextField(
//                 controller: _addressController,
//                 decoration: InputDecoration(labelText: 'Address'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _blockSeat,
//                 child: Text("Block Seat"),
//               ),
//               SizedBox(height: 20),
//               if (_errorMessage.isNotEmpty)
//                 Text(
//                   _errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               if (_responseStatus.isNotEmpty) ...[
//                 SizedBox(height: 20),
//                 Text("Response Status: $_responseStatus"),
//                 Text("Arrival Time: $_arrivalTime"),
//                 Text("Bus Type: $_busType"),
//                 Text("Departure Time: $_departureTime"),
//                 SizedBox(height: 20),
//     ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => BookPage(),
//                     ),
//                   );
//                 },
//                 child: Text("Book Ticket"),
//               ),
//               ]
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// testing_1


// Future<void> _blockSeat() async {
//   const String apiUrl = "https://bus.srdvtest.com/v5/rest/Block";
//
//   // Build the list of passengers based on the selectedSeats data
//   List<Map<String, dynamic>> passengers = widget.selectedSeats.map((seat) {
//     return {
//       "LeadPassenger": true, // Set to true for the first passenger, else false
//       "PassengerId": 0,
//       "Title": "Mr",
//       "FirstName": _firstNameController.text,
//       "LastName": _lastNameController.text,
//       "Email": _emailController.text,
//       "Phoneno": _phoneNumberController.text,
//       "Gender": _genderController.text == "Male" ? 1 : 2,
//       "IdType": "Pan", // Replace with actual ID type if required
//       "IdNumber": "ABC12345", // Replace with actual ID number
//       "Address": _addressController.text,
//       "Age": _ageController.text,
//       "Seat": [
//         {
//           "ColumnNo": seat["ColumnNo"],
//           "Height": 1, // Example value, update accordingly
//           "IsLadiesSeat": false,
//           "IsMalesSeat": true,
//           "IsUpper": false,
//           "RowNo": seat["RowNo"],
//           "SeatFare": seat["SeatFare"],
//           "SeatIndex": seat["SeatIndex"],
//           "SeatName": seat["SeatName"],
//           "SeatStatus": true,
//           "SeatType": 1, // Update as per seat type
//           "Width": 1, // Example value
//           "Price": {
//             "CurrencyCode": "INR",
//             "BasePrice": seat["BasePrice"],
//             "Tax": 0,
//             "OtherCharges": 0,
//             "Discount": 0,
//             "PublishedPrice": seat["PublishedPrice"],
//             "PublishedPriceRoundedOff": seat["PublishedPriceRoundedOff"],
//             "OfferedPrice": seat["OfferedPrice"],
//             "OfferedPriceRoundedOff": seat["OfferedPriceRoundedOff"],
//           },
//         },
//       ],
//     };
//   }).toList();
//
//   final Map<String, dynamic> requestBody = {
//     "ClientId": "180131",
//     "UserName": "Namma434",
//     "Password": "Namma@4341",
//     "TraceId": widget.traceId,
//     "ResultIndex": int.parse(widget.resultIndex),
//     "BoardingPointId": 1, // Replace with actual Boarding Point ID
//     "DroppingPointId": 1, // Replace with actual Dropping Point ID
//     "RefID": 1, // Replace with actual RefID if required
//     "Passenger": passengers,
//   };
//
//   setState(() {
//     _isLoading = true;
//     _errorMessage = "";
//   });
//
//   try {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         "Content-Type": "application/json",
//         "Api-Token": "Namma@90434#34",
//       },
//       body: jsonEncode(requestBody),
//     );
//
//     if (response.statusCode == 200) {
//       final responseBody = jsonDecode(response.body);
//
//       setState(() {
//         _responseStatus = responseBody['Result']['ResponseStatus'].toString();
//         _arrivalTime = responseBody['Result']['ArrivalTime'] ?? 'Not Available';
//         _busType = responseBody['Result']['BusType'] ?? 'Not Available';
//         _departureTime = responseBody['Result']['DepartureTime'] ?? 'Not Available';
//       });
//
//       print("Response: $_responseStatus, $_arrivalTime, $_busType, $_departureTime");
//     } else {
//       setState(() {
//         _errorMessage = "Failed to block the seat. Status Code: ${response.statusCode}";
//       });
//     }
//   } catch (e) {
//     setState(() {
//       _errorMessage = "Error: ${e.toString()}";
//     });
//   } finally {
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }






// 1_1_2025


//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BlockSeatPage extends StatefulWidget {
//   final int? boardingPointIndex;
//   final int? droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   final String resultIndex;
//   final String traceId;
//   final String sourceCity;
//   final String destinationCity;
//   final String journeyDate;
//   final String travelName;
//   final String busType;
//   final String arrivalTime;
//   final String departureTime;
//
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
//
//   final dynamic cgstAmount;
//   final dynamic cgstRate;
//   final dynamic cessAmount;
//   final dynamic cessRate;
//   final dynamic igstAmount;
//   final dynamic igstRate;
//   final dynamic sgstAmount;
//   final dynamic sgstRate;
//   final dynamic taxableAmount;
//   // final List<Map<String, dynamic>> selectedSeats;
//
//   const BlockSeatPage({
//     Key? key,
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     // required this.selectedSeats,
//
//     required this.seatName,required this.seatFare, required this.seatIndex, required this.seatStatus, required this.seatType, required this.height, required this.width, required this.rowNo, required this.columnNo, required this.isLadiesSeat, required this.isMalesSeat, required this.isUpper, required this.currencyCode, required this.basePrice, required this.tax, required this.otherCharges, required this.discount, required this.publishedPrice, required this.publishedPriceRoundedOff, required this.offeredPrice, required this.offeredPriceRoundedOff, required this.agentCommission, required this.agentMarkUp,
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
//   }) : super(key: key);
//
//   @override
//   _BlockSeatPageState createState() => _BlockSeatPageState();
// }
//
// class _BlockSeatPageState extends State<BlockSeatPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   String _errorMessage = "";
//
//   // Passenger details
//   final List<Map<String, dynamic>> _passengers = [];
//   final TextEditingController _leadPassengerNameController = TextEditingController();
//   final TextEditingController _leadPassengerEmailController = TextEditingController();
//   final TextEditingController _leadPassengerPhoneController = TextEditingController();
//
//   Future<void> _blockSeat() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     const String apiUrl = "https://bus.srdvapi.com/v8/rest/Block";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "Passenger": _passengers,
//     };
//
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
//     print(response.body);
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//         if (responseBody['IsPriceChanged'] == true) {
//           setState(() {
//             _errorMessage = "Price has changed. Please try again.";
//           });
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Seat successfully blocked!")),
//           );
//         }
//       }  else {
//         setState(() {
//           _errorMessage = "Failed to block seat: ${response.statusCode} - ${response.body}";
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
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("Block Seat"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               Text(
//                 "Lead Passenger Details",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               TextFormField(
//                 controller: _leadPassengerNameController,
//                 decoration: InputDecoration(labelText: "Full Name"),
//                 validator: (value) => value!.isEmpty ? "Name is required" : null,
//                 onSaved: (value) {
//                   _passengers.add({
//                     "LeadPassenger": true,
//                     "FirstName": value,
//                     "LastName": "",
//                     "Email": _leadPassengerEmailController.text,
//                     "Phoneno": _leadPassengerPhoneController.text,
//                     "Gender": 1, // Default Male
//                   });
//                 },
//               ),
//               TextFormField(
//                 controller: _leadPassengerEmailController,
//                 decoration: InputDecoration(labelText: "Email"),
//                 validator: (value) => value!.isEmpty ? "Email is required" : null,
//               ),
//               TextFormField(
//                 controller: _leadPassengerPhoneController,
//                 decoration: InputDecoration(labelText: "Phone Number"),
//                 validator: (value) => value!.isEmpty ? "Phone number is required" : null,
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _blockSeat,
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text("Block Seat"),
//               ),
//               if (_errorMessage.isNotEmpty) ...[
//                 SizedBox(height: 16),
//                 Text(
//                   _errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




//success 1





// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BlockSeatPage extends StatefulWidget {
//   final int? boardingPointIndex;
//   final int? droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   final String resultIndex;
//   final String traceId;
//   final String sourceCity;
//   final String destinationCity;
//   final String journeyDate;
//   final String travelName;
//   final String busType;
//   final String arrivalTime;
//   final String departureTime;
//
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
//
//   final dynamic cgstAmount;
//   final dynamic cgstRate;
//   final dynamic cessAmount;
//   final dynamic cessRate;
//   final dynamic igstAmount;
//   final dynamic igstRate;
//   final dynamic sgstAmount;
//   final dynamic sgstRate;
//   final dynamic taxableAmount;
//   // final List<Map<String, dynamic>> selectedSeats;
//
//   const BlockSeatPage({
//     Key? key,
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     // required this.selectedSeats,
//
//     required this.seatName,required this.seatFare, required this.seatIndex, required this.seatStatus, required this.seatType, required this.height, required this.width, required this.rowNo, required this.columnNo, required this.isLadiesSeat, required this.isMalesSeat, required this.isUpper, required this.currencyCode, required this.basePrice, required this.tax, required this.otherCharges, required this.discount, required this.publishedPrice, required this.publishedPriceRoundedOff, required this.offeredPrice, required this.offeredPriceRoundedOff, required this.agentCommission, required this.agentMarkUp,
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
//   }) : super(key: key);
//
//   @override
//   _BlockSeatPageState createState() => _BlockSeatPageState();
// }
//
// class _BlockSeatPageState extends State<BlockSeatPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   String _errorMessage = "";
//
//   // Passenger details
//   final List<Map<String, dynamic>> _passengers = [];
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//
//   String? _selectedGender;
//   Future<void> _blockSeat() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     // Clear previous passengers list and add the current passenger
//     _passengers.clear();
//     _passengers.add({
//       "LeadPassenger": true,
//       "PassengerId": 1, // Adjusted as per provided format
//       "Title": "Mr", // Can be dynamic based on gender
//       "FirstName": _firstNameController.text.trim(),
//       "LastName": _lastNameController.text.trim(),
//       "Email": _emailController.text.trim(),
//       "Mobile": _phoneController.text.trim(),
//       "Gender": _selectedGender == "Male" ? "1" : "2", // Gender as string
//       "Address": "123 Main Street", // Example address
//       "Age": "30", // Example age
//       "SeatIndex": widget.seatIndex, // Single SeatIndex instead of nested seat details
//     });
//
//     const String apiUrl = "https://bus.srdvapi.com/v8/rest/Block";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": widget.traceId,
//       "ResultIndex": widget.resultIndex,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": "1",
//       "Passenger": _passengers, // Use the updated passengers list
//     };
//
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
//       print("Response status code: ${response.statusCode}");
//       print("Response body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         // Handle success
//       } else {
//         // Handle error
//         print("Error: ${response.body}");
//       }
//     } catch (e) {
//       print("Exception: $e");
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("${widget.seatIndex}"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               Text(
//                 "Passenger Details",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               TextFormField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(labelText: "First Name"),
//                 validator: (value) => value!.isEmpty ? "First Name is required" : null,
//               ),
//               TextFormField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(labelText: "Last Name"),
//                 validator: (value) => value!.isEmpty ? "Last Name is required" : null,
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: "Email"),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) => value!.isEmpty ? "Email is required" : null,
//               ),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: "Phone Number"),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) => value!.isEmpty ? "Phone number is required" : null,
//               ),
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 decoration: InputDecoration(labelText: "Gender"),
//                 items: ["Male", "Female"]
//                     .map((gender) => DropdownMenuItem(
//                   value: gender,
//                   child: Text(gender),
//                 ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedGender = value;
//                   });
//                 },
//                 validator: (value) => value == null ? "Gender is required" : null,
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _blockSeat,
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text("Block Seat"),
//               ),
//               if (_errorMessage.isNotEmpty) ...[
//                 SizedBox(height: 16),
//                 Text(
//                   _errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





//success 1 testing




// import 'dart:convert';
// import 'dart:async'; // For Future.delayed
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BlockSeatPage extends StatefulWidget {
//   final int? boardingPointIndex;
//   final int? droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   final String resultIndex;
//   final String traceId;
//   final String sourceCity;
//   final String destinationCity;
//   final String journeyDate;
//   final String travelName;
//   final String busType;
//   final String arrivalTime;
//   final String departureTime;
//
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
//
//   final dynamic cgstAmount;
//   final dynamic cgstRate;
//   final dynamic cessAmount;
//   final dynamic cessRate;
//   final dynamic igstAmount;
//   final dynamic igstRate;
//   final dynamic sgstAmount;
//   final dynamic sgstRate;
//   final dynamic taxableAmount;
//
//   const BlockSeatPage({
//     Key? key,
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.seatName,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatStatus,
//     required this.seatType,
//     required this.height,
//     required this.width,
//     required this.rowNo,
//     required this.columnNo,
//     required this.isLadiesSeat,
//     required this.isMalesSeat,
//     required this.isUpper,
//     required this.currencyCode,
//     required this.basePrice,
//     required this.tax,
//     required this.otherCharges,
//     required this.discount,
//     required this.publishedPrice,
//     required this.publishedPriceRoundedOff,
//     required this.offeredPrice,
//     required this.offeredPriceRoundedOff,
//     required this.agentCommission,
//     required this.agentMarkUp,
//     required this.tds,
//     required this.cgstAmount,
//     required this.cgstRate,
//     required this.cessAmount,
//     required this.cessRate,
//     required this.igstAmount,
//     required this.igstRate,
//     required this.sgstAmount,
//     required this.sgstRate,
//     required this.taxableAmount,
//   }) : super(key: key);
//
//   @override
//   _BlockSeatPageState createState() => _BlockSeatPageState();
// }
//
// class _BlockSeatPageState extends State<BlockSeatPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   String _errorMessage = "";
//   bool _isSeatBlocked = false; // Variable to keep track of seat status
//
//   // Passenger details
//   final List<Map<String, dynamic>> _passengers = [];
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//
//   String? _selectedGender;
//
//   Future<void> _blockSeat() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     // Clear previous passengers list and add the current passenger
//     _passengers.clear();
//     _passengers.add({
//       "LeadPassenger": true,
//       "PassengerId": 1,
//       "Title": "Mr", // Can be dynamic based on gender
//       "FirstName": _firstNameController.text.trim(),
//       "LastName": _lastNameController.text.trim(),
//       "Email": _emailController.text.trim(),
//       "Mobile": _phoneController.text.trim(),
//       "Gender": _selectedGender == "Male" ? "1" : "2",
//       "Address": "123 Main Street", // Example address
//       "Age": "30", // Example age
//       "SeatIndex": widget.seatIndex,
//     });
//
//     const String apiUrl = "https://bus.srdvapi.com/v8/rest/Block";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": widget.traceId,
//       "ResultIndex": widget.resultIndex,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": "1",
//       "Passenger": _passengers,
//     };
//
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
//       print("Response status code: ${response.statusCode}");
//       print("Response body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         // Success: Update the seat status to blocked
//         setState(() {
//           _isSeatBlocked = true;
//         });
//
//         // Log the success message
//         print("Seat ${widget.seatIndex} blocked successfully");
//
//         // Timer to unblock the seat after 5 minutes
//         Future.delayed(Duration(minutes: 5), () {
//           setState(() {
//             _isSeatBlocked = false; // Reset the seat block status
//           });
//           print("Seat ${widget.seatIndex} is now available again.");
//         });
//       } else {
//         // Handle error
//         setState(() {
//           _errorMessage = "Failed to block the seat.";
//         });
//         print("Error: ${response.body}");
//       }
//     } catch (e) {
//       print("Exception: $e");
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("${widget.seatIndex}"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               Text(
//                 "Passenger Details",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               TextFormField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(labelText: "First Name"),
//                 validator: (value) => value!.isEmpty ? "First Name is required" : null,
//               ),
//               TextFormField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(labelText: "Last Name"),
//                 validator: (value) => value!.isEmpty ? "Last Name is required" : null,
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: "Email"),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) => value!.isEmpty ? "Email is required" : null,
//               ),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: "Phone Number"),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) => value!.isEmpty ? "Phone number is required" : null,
//               ),
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 decoration: InputDecoration(labelText: "Gender"),
//                 items: ["Male", "Female"]
//                     .map((gender) => DropdownMenuItem(
//                   value: gender,
//                   child: Text(gender),
//                 ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedGender = value;
//                   });
//                 },
//                 validator: (value) => value == null ? "Gender is required" : null,
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _isLoading || _isSeatBlocked ? null : _blockSeat,
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text("Block Seat"),
//               ),
//               if (_errorMessage.isNotEmpty) ...[
//                 SizedBox(height: 16),
//                 Text(
//                   _errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ],
//               if (_isSeatBlocked) ...[
//                 SizedBox(height: 16),
//                 Text(
//                   "This seat is blocked and will be available in 5 minutes.",
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ]
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





//new seat Blocking success



// import 'dart:convert';
// import 'dart:async'; // For Future.delayed
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BlockSeatPage extends StatefulWidget {
//   final int? boardingPointIndex;
//   final int? droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   final String resultIndex;
//   final String traceId;
//   final String sourceCity;
//   final String destinationCity;
//   final String journeyDate;
//   final String travelName;
//   final String busType;
//   final String arrivalTime;
//   final String departureTime;
//
//   final dynamic columnNo;
//   final int height;
//   final bool isLadiesSeat;
//   final bool isMalesSeat;
//   final bool isUpper;
//   final dynamic rowNo;
//   final dynamic seatFare;
//   final dynamic seatIndex;
//   final String seatName;
//   final bool seatStatus;
//   final int seatType;
//   final int width;
//
//   final String currencyCode;
//   final dynamic basePrice;
//   final int tax;
//   final int otherCharges;
//   final int discount;
//   final dynamic publishedPrice;
//   final int publishedPriceRoundedOff;
//   final dynamic offeredPrice;
//   final int offeredPriceRoundedOff;
//   final dynamic agentCommission;
//   final int agentMarkUp;
//   final dynamic tds;
//
//   final int cgstAmount;
//   final int cgstRate;
//   final int cessAmount;
//   final int cessRate;
//   final int igstAmount;
//   final int igstRate;
//   final int sgstAmount;
//   final int sgstRate;
//   final int taxableAmount;
//
//   const BlockSeatPage({
//     Key? key,
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.seatName,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatStatus,
//     required this.seatType,
//     required this.height,
//     required this.width,
//     required this.rowNo,
//     required this.columnNo,
//     required this.isLadiesSeat,
//     required this.isMalesSeat,
//     required this.isUpper,
//     required this.currencyCode,
//     required this.basePrice,
//     required this.tax,
//     required this.otherCharges,
//     required this.discount,
//     required this.publishedPrice,
//     required this.publishedPriceRoundedOff,
//     required this.offeredPrice,
//     required this.offeredPriceRoundedOff,
//     required this.agentCommission,
//     required this.agentMarkUp,
//     required this.tds,
//     required this.cgstAmount,
//     required this.cgstRate,
//     required this.cessAmount,
//     required this.cessRate,
//     required this.igstAmount,
//     required this.igstRate,
//     required this.sgstAmount,
//     required this.sgstRate,
//     required this.taxableAmount,
//   }) : super(key: key);
//
//   @override
//   _BlockSeatPageState createState() => _BlockSeatPageState();
// }
// class _BlockSeatPageState extends State<BlockSeatPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   String _errorMessage = "";
//
//   // Passenger details
//   final List<Map<String, dynamic>> _passengers = [];
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//
//   String? _selectedGender;
//   bool _isSeatBlocked = false; // Track the seat status
//
//
//   Future<void> _blockSeat() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//     print("Mobile Number: ${_phoneController.text.trim()}");
//
//     // Clear previous passengers list and add the current passenger
//     _passengers.clear();
//     _passengers.add({
//       "LeadPassenger": true,
//       "PassengerId": 2, // Adjusted as per provided format
//       "Title": "Mr", // Can be dynamic based on gender
//       "FirstName": _firstNameController.text.trim(),
//       "LastName": _lastNameController.text.trim(),
//       "Email": _emailController.text.trim(),
//       "Phoneno": _phoneController.text.trim(), // Phoneno instead of Mobile
//       "Gender": _selectedGender == "Male" ? "1" : "2", // Gender as string
//       "IdType": null, // Assuming null, modify if necessary
//       "IdNumber": null, // Assuming null, modify if necessary
//       "Address": "123 Main Street", // Example address
//       "Age": "30", // Example age
//       "Seat": {
//         "ColumnNo": widget.columnNo, // Use widget.columnNo instead of hardcoded
//         "Height": widget.height,
//         "IsLadiesSeat": widget.isLadiesSeat,
//         "IsMalesSeat": widget.isMalesSeat,
//         "IsUpper": widget.isUpper,
//         "RowNo": widget.rowNo, // Use widget.rowNo
//         "SeatFare": widget.seatFare,
//         "SeatIndex": widget.seatIndex,
//         "SeatName": widget.seatName,
//         "SeatStatus": widget.seatStatus,
//         "SeatType": widget.seatType,
//         "Width": widget.width,
//         "Price": {
//           "CurrencyCode": widget.currencyCode,
//           "BasePrice": widget.basePrice,
//           "Tax": widget.tax,
//           "OtherCharges": widget.otherCharges,
//           "Discount": widget.discount,
//           "PublishedPrice": widget.publishedPrice,
//           "PublishedPriceRoundedOff": widget.publishedPriceRoundedOff,
//           "OfferedPrice": widget.offeredPrice,
//           "OfferedPriceRoundedOff": widget.offeredPriceRoundedOff,
//           "AgentCommission": widget.agentCommission,
//           "AgentMarkUp": widget.agentMarkUp,
//           "TDS": widget.tds,
//           "GST": {
//             "CGSTAmount": widget.cgstAmount,
//             "CGSTRate": widget.cgstRate,
//             "CessAmount": widget.cessAmount,
//             "CessRate": widget.cessRate,
//             "IGSTAmount": widget.igstAmount,
//             "IGSTRate": widget.igstRate,
//             "SGSTAmount": widget.sgstAmount,
//             "SGSTRate": widget.sgstRate,
//             "TaxableAmount": widget.taxableAmount,
//           }
//         }
//       }
//     });
//
//     // Optional: Add additional passengers if needed by repeating the block above with different data
//
//     const String apiUrl = "https://bus.srdvapi.com/v5/rest/Block";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": "1",
//       "Passenger": _passengers, // Use the updated passengers list
//     };
//
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
//       print("Response status code: ${response.statusCode}");
//       print("Response body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         setState(() {
//           _isSeatBlocked = true; // Mark seat as blocked
//         });
//
//         // Set a timer to unblock the seat after 5 minutes
//         Future.delayed(Duration(minutes: 5), () {
//           setState(() {
//             _isSeatBlocked = false; // Reset seat status after 5 minutes
//           });
//         });
//
//         // Handle success - You can display a confirmation message here if needed
//       } else {
//         // Handle error
//         setState(() {
//           _errorMessage = "Failed to block seat.";
//         });
//         print("Error: ${response.body}");
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "An error occurred: $e";
//       });
//       print("Exception: $e");
//     }
//   }
//
//   Future<bool> _fetchSeatStatus() async {
//     const String seatStatusApiUrl = "https://bus.srdvapi.com/v5/rest/SeatStatus";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//     };
//
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(seatStatusApiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List<dynamic> seatDetails = data['Seats'] ?? [];
//         final selectedSeat = seatDetails.firstWhere(
//                 (seat) => seat['SeatIndex'] == widget.seatIndex,
//             orElse: () => null);
//
//         return selectedSeat != null && selectedSeat['SeatStatus'] == "Blocked";
//       } else {
//         throw Exception("Failed to fetch seat status");
//       }
//     } catch (e) {
//       print("Error fetching seat status: $e");
//       return false; // Default to not blocked if there's an error
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("${widget.seatIndex}"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               Text(
//                 "Passenger Details",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               TextFormField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(labelText: "First Name"),
//                 validator: (value) => value!.isEmpty ? "First Name is required" : null,
//               ),
//               TextFormField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(labelText: "Last Name"),
//                 validator: (value) => value!.isEmpty ? "Last Name is required" : null,
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: "Email"),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) => value!.isEmpty ? "Email is required" : null,
//               ),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: "Phone Number"),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) => value!.isEmpty ? "Phone number is required" : null,
//               ),
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 decoration: InputDecoration(labelText: "Gender"),
//                 items: ["Male", "Female"]
//                     .map((gender) => DropdownMenuItem(
//                   value: gender,
//                   child: Text(gender),
//                 ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedGender = value;
//                   });
//                 },
//                 validator: (value) => value == null ? "Gender is required" : null,
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _isLoading || _isSeatBlocked ? null : _blockSeat,  // Disable the button if the seat is blocked
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text(_isSeatBlocked ? "Seat Blocked" : "Block Seat"),
//               ),
//               if (_errorMessage.isNotEmpty) ...[
//                 SizedBox(height: 16),
//                 Text(
//                   _errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// seat block success


//
// import 'dart:convert';
// import 'dart:async'; // For Future.delayed
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BlockSeatPage extends StatefulWidget {
//   final int? boardingPointIndex;
//   final int? droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   final String resultIndex;
//   final String traceId;
//   final String sourceCity;
//   final String destinationCity;
//   final String journeyDate;
//   final String travelName;
//   final String busType;
//   final String arrivalTime;
//   final String departureTime;
//
//   final dynamic columnNo;
//   final int height;
//   final bool isLadiesSeat;
//   final bool isMalesSeat;
//   final bool isUpper;
//   final dynamic rowNo;
//   final dynamic seatFare;
//   final dynamic seatIndex;
//   final String seatName;
//   final bool seatStatus;
//   final int seatType;
//   final int width;
//
//   final String currencyCode;
//   final dynamic basePrice;
//   final int tax;
//   final int otherCharges;
//   final int discount;
//   final dynamic publishedPrice;
//   final int publishedPriceRoundedOff;
//   final dynamic offeredPrice;
//   final int offeredPriceRoundedOff;
//   final dynamic agentCommission;
//   final int agentMarkUp;
//   final dynamic tds;
//
//   final int cgstAmount;
//   final int cgstRate;
//   final int cessAmount;
//   final int cessRate;
//   final int igstAmount;
//   final int igstRate;
//   final int sgstAmount;
//   final int sgstRate;
//   final int taxableAmount;
//
//   const BlockSeatPage({
//     Key? key,
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.seatName,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatStatus,
//     required this.seatType,
//     required this.height,
//     required this.width,
//     required this.rowNo,
//     required this.columnNo,
//     required this.isLadiesSeat,
//     required this.isMalesSeat,
//     required this.isUpper,
//     required this.currencyCode,
//     required this.basePrice,
//     required this.tax,
//     required this.otherCharges,
//     required this.discount,
//     required this.publishedPrice,
//     required this.publishedPriceRoundedOff,
//     required this.offeredPrice,
//     required this.offeredPriceRoundedOff,
//     required this.agentCommission,
//     required this.agentMarkUp,
//     required this.tds,
//     required this.cgstAmount,
//     required this.cgstRate,
//     required this.cessAmount,
//     required this.cessRate,
//     required this.igstAmount,
//     required this.igstRate,
//     required this.sgstAmount,
//     required this.sgstRate,
//     required this.taxableAmount,
//   }) : super(key: key);
//
//   @override
//   _BlockSeatPageState createState() => _BlockSeatPageState();
// }
// class _BlockSeatPageState extends State<BlockSeatPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   String _errorMessage = "";
//
//   // Passenger details
//   final List<Map<String, dynamic>> _passengers = [];
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//
//   String? _selectedGender;
//   bool _isSeatBlocked = false; // Track the seat status
//
//
//   Future<void> _blockSeat() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//     print("Mobile Number: ${_phoneController.text.trim()}");
//
//     // Clear previous passengers list and add the current passenger
//     _passengers.clear();
//     _passengers.add({
//       "LeadPassenger": true,
//       "PassengerId": 2, // Adjusted as per provided format
//       "Title": "Mr", // Can be dynamic based on gender
//       "FirstName": _firstNameController.text.trim(),
//       "LastName": _lastNameController.text.trim(),
//       "Email": _emailController.text.trim(),
//       "Phoneno": _phoneController.text.trim(), // Phoneno instead of Mobile
//       "Gender": _selectedGender == "Male" ? "1" : "2", // Gender as string
//       "IdType": null, // Assuming null, modify if necessary
//       "IdNumber": null, // Assuming null, modify if necessary
//       "Address": "123 Main Street", // Example address
//       "Age": "30", // Example age
//       "Seat": {
//         "ColumnNo": widget.columnNo, // Use widget.columnNo instead of hardcoded
//         "Height": widget.height,
//         "IsLadiesSeat": widget.isLadiesSeat,
//         "IsMalesSeat": widget.isMalesSeat,
//         "IsUpper": widget.isUpper,
//         "RowNo": widget.rowNo, // Use widget.rowNo
//         "SeatFare": widget.seatFare,
//         "SeatIndex": widget.seatIndex,
//         "SeatName": widget.seatName,
//         "SeatStatus": widget.seatStatus,
//         "SeatType": widget.seatType,
//         "Width": widget.width,
//         "Price": {
//           "CurrencyCode": widget.currencyCode,
//           "BasePrice": widget.basePrice,
//           "Tax": widget.tax,
//           "OtherCharges": widget.otherCharges,
//           "Discount": widget.discount,
//           "PublishedPrice": widget.publishedPrice,
//           "PublishedPriceRoundedOff": widget.publishedPriceRoundedOff,
//           "OfferedPrice": widget.offeredPrice,
//           "OfferedPriceRoundedOff": widget.offeredPriceRoundedOff,
//           "AgentCommission": widget.agentCommission,
//           "AgentMarkUp": widget.agentMarkUp,
//           "TDS": widget.tds,
//           "GST": {
//             "CGSTAmount": widget.cgstAmount,
//             "CGSTRate": widget.cgstRate,
//             "CessAmount": widget.cessAmount,
//             "CessRate": widget.cessRate,
//             "IGSTAmount": widget.igstAmount,
//             "IGSTRate": widget.igstRate,
//             "SGSTAmount": widget.sgstAmount,
//             "SGSTRate": widget.sgstRate,
//             "TaxableAmount": widget.taxableAmount,
//           }
//         }
//       }
//     });
//
//     // Optional: Add additional passengers if needed by repeating the block above with different data
//
//     const String apiUrl = "https://bus.srdvapi.com/v5/rest/Block";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": "1",
//       "Passenger": _passengers, // Use the updated passengers list
//     };
//
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
//       print("Response status code: ${response.statusCode}");
//       print("Response body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         setState(() {
//           _isSeatBlocked = true; // Mark seat as blocked
//         });
//
//         // Set a timer to unblock the seat after 5 minutes
//         Future.delayed(Duration(minutes: 5), () {
//           setState(() {
//             _isSeatBlocked = false; // Reset seat status after 5 minutes
//           });
//         });
//
//         // Handle success - You can display a confirmation message here if needed
//       } else {
//         // Handle error
//         setState(() {
//           _errorMessage = "Failed to block seat.";
//         });
//         print("Error: ${response.body}");
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "An error occurred: $e";
//       });
//       print("Exception: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink,
//         title: Text("${widget.seatIndex}"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               Text(
//                 "Passenger Details",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               TextFormField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(labelText: "First Name"),
//                 validator: (value) => value!.isEmpty ? "First Name is required" : null,
//               ),
//               TextFormField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(labelText: "Last Name"),
//                 validator: (value) => value!.isEmpty ? "Last Name is required" : null,
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: "Email"),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) => value!.isEmpty ? "Email is required" : null,
//               ),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: "Phone Number"),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) => value!.isEmpty ? "Phone number is required" : null,
//               ),
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 decoration: InputDecoration(labelText: "Gender"),
//                 items: ["Male", "Female"]
//                     .map((gender) => DropdownMenuItem(
//                   value: gender,
//                   child: Text(gender),
//                 ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedGender = value;
//                   });
//                 },
//                 validator: (value) => value == null ? "Gender is required" : null,
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _isLoading || _isSeatBlocked ? null : _blockSeat,  // Disable the button if the seat is blocked
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text(_isSeatBlocked ? "Seat Blocked" : "Block Seat"),
//               ),
//               if (_errorMessage.isNotEmpty) ...[
//                 SizedBox(height: 16),
//                 Text(
//                   _errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//




// improving the seat block




//
// import 'dart:convert';
// import 'dart:async'; // For Future.delayed
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'book_seat_screen.dart';
//
// class BlockSeatPage extends StatefulWidget {
//   final int? boardingPointIndex;
//   final int? droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   final String resultIndex;
//   final String traceId;
//   final String sourceCity;
//   final String destinationCity;
//   final String journeyDate;
//   final String travelName;
//   final String busType;
//   final String arrivalTime;
//   final String departureTime;
//
//   final dynamic columnNo;
//   final int height;
//   final bool isLadiesSeat;
//   final bool isMalesSeat;
//   final bool isUpper;
//   final dynamic rowNo;
//   final dynamic seatFare;
//   final dynamic seatIndex;
//   final String seatName;
//   final bool seatStatus;
//   final int seatType;
//   final int width;
//
//   final String currencyCode;
//   final dynamic basePrice;
//   final int tax;
//   final int otherCharges;
//   final int discount;
//   final dynamic publishedPrice;
//   final int publishedPriceRoundedOff;
//   final dynamic offeredPrice;
//   final int offeredPriceRoundedOff;
//   final dynamic agentCommission;
//   final int agentMarkUp;
//   final dynamic tds;
//
//   final int cgstAmount;
//   final int cgstRate;
//   final int cessAmount;
//   final int cessRate;
//   final int igstAmount;
//   final int igstRate;
//   final int sgstAmount;
//   final int sgstRate;
//   final int taxableAmount;
//
//   const BlockSeatPage({
//     Key? key,
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.seatName,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatStatus,
//     required this.seatType,
//     required this.height,
//     required this.width,
//     required this.rowNo,
//     required this.columnNo,
//     required this.isLadiesSeat,
//     required this.isMalesSeat,
//     required this.isUpper,
//     required this.currencyCode,
//     required this.basePrice,
//     required this.tax,
//     required this.otherCharges,
//     required this.discount,
//     required this.publishedPrice,
//     required this.publishedPriceRoundedOff,
//     required this.offeredPrice,
//     required this.offeredPriceRoundedOff,
//     required this.agentCommission,
//     required this.agentMarkUp,
//     required this.tds,
//     required this.cgstAmount,
//     required this.cgstRate,
//     required this.cessAmount,
//     required this.cessRate,
//     required this.igstAmount,
//     required this.igstRate,
//     required this.sgstAmount,
//     required this.sgstRate,
//     required this.taxableAmount,
//   }) : super(key: key);

//   @override
//   _BlockSeatPageState createState() => _BlockSeatPageState();
// }
// class _BlockSeatPageState extends State<BlockSeatPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   String _errorMessage = "";
//
//   // Passenger details
//   final List<Map<String, dynamic>> _passengers = [];
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//
//
//   String? _selectedGender;
//   bool _isSeatBlocked = false; // Track the seat status
//
//   //
//   // Future<void> _blockSeat() async {
//   //   if (!_formKey.currentState!.validate()) {
//   //     return;
//   //   }
//   //   print("Mobile Number: ${_phoneController.text.trim()}");
//   //
//   //   // Clear previous passengers list and add the current passenger
//   //   _passengers.clear();
//   //   _passengers.add({
//   //     "LeadPassenger": true,
//   //     "PassengerId": 2, // Adjusted as per provided format
//   //     "Title": "Mr", // Can be dynamic based on gender
//   //     "FirstName": _firstNameController.text.trim(),
//   //     "LastName": _lastNameController.text.trim(),
//   //     "Email": _emailController.text.trim(),
//   //     "Phoneno": _phoneController.text.trim(), // Phoneno instead of Mobile
//   //     "Gender": _selectedGender == "Male" ? "1" : "2", // Gender as string
//   //     "IdType": null, // Assuming null, modify if necessary
//   //     "IdNumber": null, // Assuming null, modify if necessary
//   //     "Address": _addressController.text.trim(), // Example address
//   //     "Age": _ageController.text.trim(), // Example age
//   //     "Seat": {
//   //       "ColumnNo": widget.columnNo, // Use widget.columnNo instead of hardcoded
//   //       "Height": widget.height,
//   //       "IsLadiesSeat": widget.isLadiesSeat,
//   //       "IsMalesSeat": widget.isMalesSeat,
//   //       "IsUpper": widget.isUpper,
//   //       "RowNo": widget.rowNo, // Use widget.rowNo
//   //       "SeatFare": widget.seatFare,
//   //       "SeatIndex": widget.seatIndex,
//   //       "SeatName": widget.seatName,
//   //       "SeatStatus": widget.seatStatus,
//   //       "SeatType": widget.seatType,
//   //       "Width": widget.width,
//   //       "Price": {
//   //         "CurrencyCode": widget.currencyCode,
//   //         "BasePrice": widget.basePrice,
//   //         "Tax": widget.tax,
//   //         "OtherCharges": widget.otherCharges,
//   //         "Discount": widget.discount,
//   //         "PublishedPrice": widget.publishedPrice,
//   //         "PublishedPriceRoundedOff": widget.publishedPriceRoundedOff,
//   //         "OfferedPrice": widget.offeredPrice,
//   //         "OfferedPriceRoundedOff": widget.offeredPriceRoundedOff,
//   //         "AgentCommission": widget.agentCommission,
//   //         "AgentMarkUp": widget.agentMarkUp,
//   //         "TDS": widget.tds,
//   //         "GST": {
//   //           "CGSTAmount": widget.cgstAmount,
//   //           "CGSTRate": widget.cgstRate,
//   //           "CessAmount": widget.cessAmount,
//   //           "CessRate": widget.cessRate,
//   //           "IGSTAmount": widget.igstAmount,
//   //           "IGSTRate": widget.igstRate,
//   //           "SGSTAmount": widget.sgstAmount,
//   //           "SGSTRate": widget.sgstRate,
//   //           "TaxableAmount": widget.taxableAmount,
//   //         }
//   //       }
//   //     }
//   //   });
//   //
//   //   // Optional: Add additional passengers if needed by repeating the block above with different data
//   //
//   //   const String apiUrl = "https://bus.srdvapi.com/v5/rest/Block";
//   //   final Map<String, dynamic> requestBody = {
//   //     "ClientId": "180187",
//   //     "UserName": "Namma434",
//   //     "Password": "Namma@4341",
//   //     "ResultIndex": widget.resultIndex,
//   //     "TraceId": widget.traceId,
//   //     "BoardingPointId": widget.boardingPointIndex,
//   //     "DroppingPointId": widget.droppingPointIndex,
//   //     "RefID": "1",
//   //     "Passenger": _passengers, // Use the updated passengers list
//   //   };
//   //
//   //   const headers = {
//   //     "Content-Type": "application/json",
//   //     "Api-Token": "Namma@90434#34",
//   //   };
//   //
//   //   setState(() {
//   //     _isLoading = true;
//   //     _errorMessage = "";
//   //   });
//   //
//   //   try {
//   //     final response = await http.post(
//   //       Uri.parse(apiUrl),
//   //       headers: headers,
//   //       body: jsonEncode(requestBody),
//   //     );
//   //
//   //     print("Response status code: ${response.statusCode}");
//   //     print("Response body: ${response.body}");
//   //
//   //     if (response.statusCode == 200) {
//   //       setState(() {
//   //         _isSeatBlocked = true; // Mark seat as blocked
//   //       });
//   //
//   //       // Navigate to the next screen with parameters
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => BookSeat(
//   //             resultIndex: widget.resultIndex,
//   //             traceId: widget.traceId,
//   //             sourceCity: widget.sourceCity,
//   //             destinationCity: widget.destinationCity,
//   //             boardingPointIndex: widget.boardingPointIndex,
//   //             droppingPointIndex: widget.droppingPointIndex,
//   //             selectedBoardingPoint: widget.selectedBoardingPoint,
//   //             selectedDroppingPoint: widget.selectedDroppingPoint,
//   //             journeyDate: widget.journeyDate,
//   //             travelName: widget.travelName,
//   //             busType: widget.busType,
//   //             arrivalTime: widget.arrivalTime,
//   //             departureTime: widget.departureTime,
//   //
//   //             columnNo: widget.columnNo,
//   //             height: widget.height,
//   //             isLadiesSeat: widget.isLadiesSeat,
//   //             isMalesSeat: widget.isMalesSeat,
//   //             isUpper: widget.isUpper,
//   //             rowNo: widget.rowNo,
//   //             seatFare: widget.seatFare,
//   //             seatIndex: widget.seatIndex,
//   //             seatName: widget.seatName,
//   //             seatStatus: widget.seatStatus,
//   //             seatType: widget.seatType,
//   //             width: widget.width,
//   //
//   //             currencyCode: widget.currencyCode,
//   //             basePrice: widget.basePrice,
//   //             tax: widget.tax,
//   //             otherCharges: widget.otherCharges,
//   //             discount: widget.discount,
//   //             publishedPrice: widget.publishedPrice,
//   //             publishedPriceRoundedOff: widget.publishedPriceRoundedOff,
//   //             offeredPrice: widget.offeredPrice,
//   //             offeredPriceRoundedOff: widget.offeredPriceRoundedOff,
//   //             agentCommission: widget.agentCommission,
//   //             agentMarkUp: widget.agentMarkUp,
//   //             tds: widget.tds,
//   //             cgstAmount: widget.cgstAmount,
//   //             cgstRate: widget.cgstRate,
//   //             cessAmount: widget.cessAmount,
//   //             cessRate: widget.cessRate,
//   //             igstAmount: widget.igstAmount,
//   //             igstRate: widget.igstRate,
//   //             sgstAmount: widget.sgstAmount,
//   //             sgstRate: widget.sgstRate,
//   //             taxableAmount: widget.taxableAmount,
//   //
//   //             leadPassenger: _passengers[0]["LeadPassenger"],
//   //             passengerId: _passengers[0]["PassengerId"],
//   //             title: _passengers[0]["Title"],
//   //             firstName: _passengers[0]["FirstName"],
//   //             lastName: _passengers[0]["LastName"],
//   //             email: _passengers[0]["Email"],
//   //             phoneno: _passengers[0]["Phoneno"],
//   //             gender: _passengers[0]["Gender"],
//   //             idType: _passengers[0]["IdType"],
//   //             idNumber: _passengers[0]["IdNumber"],
//   //             address: _passengers[0]["Address"],
//   //             age: _passengers[0]["Age"],
//   //           ),
//   //         ),
//   //       );
//   //
//   //       // Set a timer to unblock the seat after 5 minutes
//   //       Future.delayed(Duration(minutes: 5), () {
//   //         setState(() {
//   //           _isSeatBlocked = false; // Reset seat status after 5 minutes
//   //         });
//   //       });
//   //
//   //       // Handle success - You can display a confirmation message here if needed
//   //     } else {
//   //       // Handle error
//   //       setState(() {
//   //         _errorMessage = "Failed to block seat.";
//   //       });
//   //       print("Error: ${response.body}");
//   //     }
//   //   } catch (e) {
//   //     setState(() {
//   //       _errorMessage = "An error occurred: $e";
//   //     });
//   //     print("Exception: $e");
//   //   }
//   // }
//
//   Future<void> _blockSeat() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     print("Mobile Number: ${_phoneController.text.trim()}");
//
//     // Get logged-in user
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//       setState(() {
//         _errorMessage = "User not logged in.";
//       });
//       return;
//     }
//     final String customerId = currentUser.uid;
//
//     // Passenger Data
//     Map<String, dynamic> passengerData = {
//       "LeadPassenger": true,
//       "PassengerId": DateTime.now().millisecondsSinceEpoch, // Unique ID
//       "Title": "Mr",
//       "FirstName": _firstNameController.text.trim(),
//       "LastName": _lastNameController.text.trim(),
//       "Email": _emailController.text.trim(),
//       "Phoneno": _phoneController.text.trim(),
//       "Gender": _selectedGender == "Male" ? "1" : "2",
//       "IdType": null,
//       "IdNumber": null,
//       "Address": _addressController.text.trim(),
//       "Age": _ageController.text.trim(),
//       "Seat": {
//         "ColumnNo": widget.columnNo,
//         "Height": widget.height,
//         "IsLadiesSeat": widget.isLadiesSeat,
//         "IsMalesSeat": widget.isMalesSeat,
//         "IsUpper": widget.isUpper,
//         "RowNo": widget.rowNo,
//         "SeatFare": widget.seatFare,
//         "SeatIndex": widget.seatIndex,
//         "SeatName": widget.seatName,
//         "SeatStatus": widget.seatStatus,
//         "SeatType": widget.seatType,
//         "Width": widget.width,
//         "Price": {
//           "CurrencyCode": widget.currencyCode,
//           "BasePrice": widget.basePrice,
//           "Tax": widget.tax,
//           "OtherCharges": widget.otherCharges,
//           "Discount": widget.discount,
//           "PublishedPrice": widget.publishedPrice,
//           "PublishedPriceRoundedOff": widget.publishedPriceRoundedOff,
//           "OfferedPrice": widget.offeredPrice,
//           "OfferedPriceRoundedOff": widget.offeredPriceRoundedOff,
//           "AgentCommission": widget.agentCommission,
//           "AgentMarkUp": widget.agentMarkUp,
//           "TDS": widget.tds,
//           "GST": {
//             "CGSTAmount": widget.cgstAmount,
//             "CGSTRate": widget.cgstRate,
//             "CessAmount": widget.cessAmount,
//             "CessRate": widget.cessRate,
//             "IGSTAmount": widget.igstAmount,
//             "IGSTRate": widget.igstRate,
//             "SGSTAmount": widget.sgstAmount,
//             "SGSTRate": widget.sgstRate,
//             "TaxableAmount": widget.taxableAmount,
//           }
//         }
//       }
//     };
//
//     // Save Passenger to Firestore
//     try {
//       await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('passengers')
//           .add(passengerData);
//
//       print("Passenger details saved to Firestore");
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Failed to save passenger: $e";
//       });
//       print("Firestore Error: $e");
//       return;
//     }
//
//     // API Call to Block Seat
//     // const String apiUrl = "https://bus.srdvapi.com/v5/rest/Block";
//     const String apiUrl = "http://3.7.121.234/bus-api/Block";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": "1",
//       "Passenger": [passengerData], // Send Passenger Data
//     };
//
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
//       print("Response status code: ${response.statusCode}");
//       print("Response body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         setState(() {
//           _isSeatBlocked = true;
//         });
//
//         // Navigate to Booking Page
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BookSeat(
//               resultIndex: widget.resultIndex,
//               traceId: widget.traceId,
//               sourceCity: widget.sourceCity,
//               destinationCity: widget.destinationCity,
//               boardingPointIndex: widget.boardingPointIndex,
//               droppingPointIndex: widget.droppingPointIndex,
//               selectedBoardingPoint: widget.selectedBoardingPoint,
//               selectedDroppingPoint: widget.selectedDroppingPoint,
//               journeyDate: widget.journeyDate,
//               travelName: widget.travelName,
//               busType: widget.busType,
//               arrivalTime: widget.arrivalTime,
//               departureTime: widget.departureTime,
//
//               columnNo: widget.columnNo,
//               height: widget.height,
//               isLadiesSeat: widget.isLadiesSeat,
//               isMalesSeat: widget.isMalesSeat,
//               isUpper: widget.isUpper,
//               rowNo: widget.rowNo,
//               seatFare: widget.seatFare,
//               seatIndex: widget.seatIndex,
//               seatName: widget.seatName,
//               seatStatus: widget.seatStatus,
//               seatType: widget.seatType,
//               width: widget.width,
//
//               currencyCode: widget.currencyCode,
//               basePrice: widget.basePrice,
//               tax: widget.tax,
//               otherCharges: widget.otherCharges,
//               discount: widget.discount,
//               publishedPrice: widget.publishedPrice,
//               publishedPriceRoundedOff: widget.publishedPriceRoundedOff,
//               offeredPrice: widget.offeredPrice,
//               offeredPriceRoundedOff: widget.offeredPriceRoundedOff,
//               agentCommission: widget.agentCommission,
//               agentMarkUp: widget.agentMarkUp,
//               tds: widget.tds,
//               cgstAmount: widget.cgstAmount,
//               cgstRate: widget.cgstRate,
//               cessAmount: widget.cessAmount,
//               cessRate: widget.cessRate,
//               igstAmount: widget.igstAmount,
//               igstRate: widget.igstRate,
//               sgstAmount: widget.sgstAmount,
//               sgstRate: widget.sgstRate,
//               taxableAmount: widget.taxableAmount,
//               // Passenger Data
//               leadPassenger: passengerData["LeadPassenger"],
//               passengerId: passengerData["PassengerId"],
//               title: passengerData["Title"],
//               firstName: passengerData["FirstName"],
//               lastName: passengerData["LastName"],
//               email: passengerData["Email"],
//               phoneno: passengerData["Phoneno"],
//               gender: passengerData["Gender"],
//               idType: passengerData["IdType"],
//               idNumber: passengerData["IdNumber"],
//               address: passengerData["Address"],
//               age: passengerData["Age"],
//             ),
//           ),
//         );
//
//         // Unblock Seat After 5 Minutes
//         Future.delayed(Duration(minutes: 5), () {
//           setState(() {
//             _isSeatBlocked = false;
//           });
//         });
//
//       } else {
//         setState(() {
//           _errorMessage = "Failed to block seat.";
//         });
//         print("Error: ${response.body}");
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "An error occurred: $e";
//       });
//       print("Exception: $e");
//     }
//   }
//   List<Map<String, dynamic>> _savedPassengers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSavedPassengers();
//   }
//
//   void _fetchSavedPassengers() async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;
//
//     final snapshot = await FirebaseFirestore.instance
//         .collection('customers')
//         .doc(currentUser.uid)
//         .collection('passengers')
//         .get();
//
//     setState(() {
//       _savedPassengers = snapshot.docs.map((doc) => doc.data()).toList();
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     backgroundColor: Colors.redAccent.shade700,
//     //     title: Text("${widget.seatIndex}"),
//     //   ),
//     //   body: Padding(
//     //     padding: const EdgeInsets.all(16.0),
//     //     child: Form(
//     //       key: _formKey,
//     //       child: ListView(
//     //         children: [
//     //           Text(
//     //             "Passenger Details",
//     //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//     //           ),
//     //           TextFormField(
//     //             controller: _firstNameController,
//     //             decoration: InputDecoration(labelText: "First Name"),
//     //             validator: (value) => value!.isEmpty ? "First Name is required" : null,
//     //           ),
//     //           TextFormField(
//     //             controller: _lastNameController,
//     //             decoration: InputDecoration(labelText: "Last Name"),
//     //             validator: (value) => value!.isEmpty ? "Last Name is required" : null,
//     //           ),
//     //           TextFormField(
//     //             controller: _emailController,
//     //             decoration: InputDecoration(labelText: "Email"),
//     //             keyboardType: TextInputType.emailAddress,
//     //             validator: (value) => value!.isEmpty ? "Email is required" : null,
//     //           ),
//     //           TextFormField(
//     //             controller: _phoneController,
//     //             decoration: InputDecoration(labelText: "Phone Number"),
//     //             keyboardType: TextInputType.phone,
//     //             validator: (value) => value!.isEmpty ? "Phone number is required" : null,
//     //           ),
//     //           TextFormField(
//     //             controller: _ageController,
//     //             decoration: InputDecoration(labelText: "Age"),
//     //             keyboardType: TextInputType.number,
//     //             validator: (value) => value!.isEmpty ? "Age is required" : null,
//     //           ),
//     //           TextFormField(
//     //             controller: _addressController,
//     //             decoration: InputDecoration(labelText: "Address"),
//     //             keyboardType: TextInputType.text,
//     //             validator: (value) => value!.isEmpty ? "Address is required" : null,
//     //           ),
//     //           DropdownButtonFormField<String>(
//     //             value: _selectedGender,
//     //             decoration: InputDecoration(labelText: "Gender"),
//     //             items: ["Male", "Female"]
//     //                 .map((gender) => DropdownMenuItem(
//     //               value: gender,
//     //               child: Text(gender),
//     //             ))
//     //                 .toList(),
//     //             onChanged: (value) {
//     //               setState(() {
//     //                 _selectedGender = value;
//     //               });
//     //             },
//     //             validator: (value) => value == null ? "Gender is required" : null,
//     //           ),
//     //           Column(
//     //             children: [
//     //               Text("Saved Passengers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//     //               SizedBox(height: 10),
//     //               for (var passenger in _savedPassengers)
//     //                 ListTile(
//     //                   title: Text("${passenger['FirstName']} ${passenger['LastName']}"),
//     //                   subtitle: Text(passenger['Phoneno']),
//     //                   onTap: () {
//     //                     setState(() {
//     //                       _firstNameController.text = passenger['FirstName'];
//     //                       _lastNameController.text = passenger['LastName'];
//     //                       _phoneController.text = passenger['Phoneno'];
//     //                       _emailController.text = passenger['Email'];
//     //                       _addressController.text = passenger['Address'];
//     //                       _ageController.text = passenger['Age'];
//     //                       _selectedGender = passenger['Gender'] == "1" ? "Male" : "Female";
//     //                     });
//     //                   },
//     //                 ),
//     //             ],
//     //           ),
//     //           SizedBox(height: 16),
//     //           ElevatedButton(
//     //             onPressed: _isLoading || _isSeatBlocked ? null : _blockSeat,  // Disable the button if the seat is blocked
//     //             child: _isLoading
//     //                 ? CircularProgressIndicator(color: Colors.white)
//     //                 : Text(_isSeatBlocked ? "Seat Boocked" : "Boock Seat"),
//     //           ),
//     //           if (_errorMessage.isNotEmpty) ...[
//     //             SizedBox(height: 16),
//     //             Text(
//     //               _errorMessage,
//     //               style: TextStyle(color: Colors.red),
//     //             ),
//     //           ],
//     //         ],
//     //       ),
//     //     ),
//     //   ),
//     // );
//
//     // 2/7/2025
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center, // Align text to the center
//               children: [
//                 Text(
//                   "Passenger Information",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 SizedBox(height: 4), // Adds some spacing
//                 Text(
//                   "${widget.sourceCity} -> ${widget.destinationCity}",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         backgroundColor: Colors.redAccent.shade700,
//         centerTitle: true,
//       ),
//
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Container for First Name, Last Name, Age, and Gender
//               Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Passenger Details",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
//                       ),
//                       _buildTextField(_firstNameController, "First Name", Icons.person),
//                       _buildTextField(_lastNameController, "Last Name", Icons.person_outline),
//                       _buildTextField(_ageController, "Age", Icons.cake, TextInputType.number),
//                       SizedBox(height: 12),
//                       DropdownButtonFormField<String>(
//                         value: _selectedGender,
//                         decoration: InputDecoration(
//                           labelText: "Gender",
//                           prefixIcon: Icon(Icons.wc, color: Colors.redAccent),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                           filled: true,
//                           fillColor: Colors.grey[200],
//                         ),
//                         items: ["Male", "Female"]
//                             .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
//                             .toList(),
//                         onChanged: (value) => setState(() => _selectedGender = value),
//                         validator: (value) => value == null ? "Gender is required" : null,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Container for Mobile Number, Email, and Address
//               Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Contact Details",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
//                       ),
//                       _buildTextField(_phoneController, "Phone Number", Icons.phone, TextInputType.phone),
//                       _buildTextField(_emailController, "Email", Icons.email, TextInputType.emailAddress),
//                       _buildTextField(_addressController, "State", Icons.home),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Saved Passengers Section
//               Text(
//                 "Saved Passengers",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
//               ),
//               SizedBox(height: 10),
//               ..._savedPassengers.map((passenger) => Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 elevation: 4,
//                 child: ListTile(
//                   title: Text("${passenger['FirstName']} ${passenger['LastName']}",
//                       style: TextStyle(fontWeight: FontWeight.w600)),
//                   subtitle: Text(passenger['Phoneno']!, style: TextStyle(color: Colors.black54)),
//                   leading: Icon(Icons.account_circle, color: Colors.blueAccent, size: 40),
//                   trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
//                   onTap: () {
//                     setState(() {
//                       _firstNameController.text = passenger['FirstName']!;
//                       _lastNameController.text = passenger['LastName']!;
//                       _phoneController.text = passenger['Phoneno']!;
//                       _emailController.text = passenger['Email']!;
//                       _addressController.text = passenger['Address']!;
//                       _ageController.text = passenger['Age']!;
//                       _selectedGender = passenger['Gender'] == "1" ? "Male" : "Female";
//                     });
//                   },
//                 ),
//               )),
//               SizedBox(height: 20),
//
//               // Book Seat Button
//               ElevatedButton(
//                 onPressed: _isLoading || _isSeatBlocked ? null : _blockSeat,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: _isSeatBlocked ? Colors.green : Colors.redAccent,
//                   minimumSize: Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 ),
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text(
//                   _isSeatBlocked ? "Seat Booked" : "Book Seat",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               if (_errorMessage.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text(_errorMessage, style: TextStyle(color: Colors.red)),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget _buildTextField(TextEditingController controller, String label, IconData icon, [TextInputType keyboardType = TextInputType.text]) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8.0),
//     child: TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.redAccent),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         filled: true,
//         fillColor: Colors.grey[200],
//       ),
//       validator: (value) => value!.isEmpty ? "$label is required" : null,
//     ),
//   );
// }




// adding the passengers to firestore




// import 'dart:convert';
// import 'dart:async'; // For Future.delayed
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'book_seat_screen.dart';
//
// class BlockSeatPage extends StatefulWidget {
//   final int? boardingPointIndex;
//   final int? droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   final String resultIndex;
//   final String traceId;
//   final String sourceCity;
//   final String destinationCity;
//   final String journeyDate;
//   final String travelName;
//   final String busType;
//   final String arrivalTime;
//   final String departureTime;
//
//   final dynamic columnNo;
//   final int height;
//   final bool isLadiesSeat;
//   final bool isMalesSeat;
//   final bool isUpper;
//   final dynamic rowNo;
//   final dynamic seatFare;
//   final dynamic seatIndex;
//   final String seatName;
//   final bool seatStatus;
//   final int seatType;
//   final int width;
//
//   final String currencyCode;
//   final dynamic basePrice;
//   final int tax;
//   final int otherCharges;
//   final int discount;
//   final dynamic publishedPrice;
//   final int publishedPriceRoundedOff;
//   final dynamic offeredPrice;
//   final int offeredPriceRoundedOff;
//   final dynamic agentCommission;
//   final int agentMarkUp;
//   final dynamic tds;
//
//   final int cgstAmount;
//   final int cgstRate;
//   final int cessAmount;
//   final int cessRate;
//   final int igstAmount;
//   final int igstRate;
//   final int sgstAmount;
//   final int sgstRate;
//   final int taxableAmount;
//
//   const BlockSeatPage({
//     Key? key,
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.seatName,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatStatus,
//     required this.seatType,
//     required this.height,
//     required this.width,
//     required this.rowNo,
//     required this.columnNo,
//     required this.isLadiesSeat,
//     required this.isMalesSeat,
//     required this.isUpper,
//     required this.currencyCode,
//     required this.basePrice,
//     required this.tax,
//     required this.otherCharges,
//     required this.discount,
//     required this.publishedPrice,
//     required this.publishedPriceRoundedOff,
//     required this.offeredPrice,
//     required this.offeredPriceRoundedOff,
//     required this.agentCommission,
//     required this.agentMarkUp,
//     required this.tds,
//     required this.cgstAmount,
//     required this.cgstRate,
//     required this.cessAmount,
//     required this.cessRate,
//     required this.igstAmount,
//     required this.igstRate,
//     required this.sgstAmount,
//     required this.sgstRate,
//     required this.taxableAmount,
//   }) : super(key: key);
//
//   @override
//   _BlockSeatPageState createState() => _BlockSeatPageState();
// }
// class _BlockSeatPageState extends State<BlockSeatPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   String _errorMessage = "";
//
//   // Passenger details
//   final List<Map<String, dynamic>> _passengers = [];
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//
//
//   String? _selectedGender;
//   bool _isSeatBlocked = false; // Track the seat status
//   Future<void> _blockSeat() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     print("Mobile Number: ${_phoneController.text.trim()}");
//
//     // Get logged-in user
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//       setState(() {
//         _errorMessage = "User not logged in.";
//       });
//       return;
//     }
//     final String customerId = currentUser.uid;
//
//     // Passenger Data
//     Map<String, dynamic> passengerData = {
//       "LeadPassenger": true,
//       "PassengerId": DateTime.now().millisecondsSinceEpoch, // Unique ID
//       "Title": "Mr",
//       "FirstName": _firstNameController.text.trim(),
//       "LastName": _lastNameController.text.trim(),
//       "Email": _emailController.text.trim(),
//       "Phoneno": _phoneController.text.trim(),
//       "Gender": _selectedGender == "Male" ? "1" : "2",
//       "IdType": null,
//       "IdNumber": null,
//       "Address": _addressController.text.trim(),
//       "Age": _ageController.text.trim(),
//       "Seat": {
//         "ColumnNo": widget.columnNo,
//         "Height": widget.height,
//         "IsLadiesSeat": widget.isLadiesSeat,
//         "IsMalesSeat": widget.isMalesSeat,
//         "IsUpper": widget.isUpper,
//         "RowNo": widget.rowNo,
//         "SeatFare": widget.seatFare,
//         "SeatIndex": widget.seatIndex,
//         "SeatName": widget.seatName,
//         "SeatStatus": widget.seatStatus,
//         "SeatType": widget.seatType,
//         "Width": widget.width,
//         "Price": {
//           "CurrencyCode": widget.currencyCode,
//           "BasePrice": widget.basePrice,
//           "Tax": widget.tax,
//           "OtherCharges": widget.otherCharges,
//           "Discount": widget.discount,
//           "PublishedPrice": widget.publishedPrice,
//           "PublishedPriceRoundedOff": widget.publishedPriceRoundedOff,
//           "OfferedPrice": widget.offeredPrice,
//           "OfferedPriceRoundedOff": widget.offeredPriceRoundedOff,
//           "AgentCommission": widget.agentCommission,
//           "AgentMarkUp": widget.agentMarkUp,
//           "TDS": widget.tds,
//           "GST": {
//             "CGSTAmount": widget.cgstAmount,
//             "CGSTRate": widget.cgstRate,
//             "CessAmount": widget.cessAmount,
//             "CessRate": widget.cessRate,
//             "IGSTAmount": widget.igstAmount,
//             "IGSTRate": widget.igstRate,
//             "SGSTAmount": widget.sgstAmount,
//             "SGSTRate": widget.sgstRate,
//             "TaxableAmount": widget.taxableAmount,
//           }
//         }
//       }
//     };
//
//     // Save Passenger to Firestore
//     try {
//       await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('passengers')
//           .add(passengerData);
//
//       print("Passenger details saved to Firestore");
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Failed to save passenger: $e";
//       });
//       print("Firestore Error: $e");
//       return;
//     }
//
//     // API Call to Block Seat
//     // const String apiUrl = "https://bus.srdvapi.com/v5/rest/Block";
//     const String apiUrl = "http://3.7.121.234/bus-api/Block";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": "1",
//       "Passenger": [passengerData], // Send Passenger Data
//     };
//
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
//       print("Response status code: ${response.statusCode}");
//       print("Response body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         setState(() {
//           _isSeatBlocked = true;
//         });
//
//         // Navigate to Booking Page
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BookSeat(
//               resultIndex: widget.resultIndex,
//               traceId: widget.traceId,
//               sourceCity: widget.sourceCity,
//               destinationCity: widget.destinationCity,
//               boardingPointIndex: widget.boardingPointIndex,
//               droppingPointIndex: widget.droppingPointIndex,
//               selectedBoardingPoint: widget.selectedBoardingPoint,
//               selectedDroppingPoint: widget.selectedDroppingPoint,
//               journeyDate: widget.journeyDate,
//               travelName: widget.travelName,
//               busType: widget.busType,
//               arrivalTime: widget.arrivalTime,
//               departureTime: widget.departureTime,
//
//               columnNo: widget.columnNo,
//               height: widget.height,
//               isLadiesSeat: widget.isLadiesSeat,
//               isMalesSeat: widget.isMalesSeat,
//               isUpper: widget.isUpper,
//               rowNo: widget.rowNo,
//               seatFare: widget.seatFare,
//               seatIndex: widget.seatIndex,
//               seatName: widget.seatName,
//               seatStatus: widget.seatStatus,
//               seatType: widget.seatType,
//               width: widget.width,
//
//               currencyCode: widget.currencyCode,
//               basePrice: widget.basePrice,
//               tax: widget.tax,
//               otherCharges: widget.otherCharges,
//               discount: widget.discount,
//               publishedPrice: widget.publishedPrice,
//               publishedPriceRoundedOff: widget.publishedPriceRoundedOff,
//               offeredPrice: widget.offeredPrice,
//               offeredPriceRoundedOff: widget.offeredPriceRoundedOff,
//               agentCommission: widget.agentCommission,
//               agentMarkUp: widget.agentMarkUp,
//               tds: widget.tds,
//               cgstAmount: widget.cgstAmount,
//               cgstRate: widget.cgstRate,
//               cessAmount: widget.cessAmount,
//               cessRate: widget.cessRate,
//               igstAmount: widget.igstAmount,
//               igstRate: widget.igstRate,
//               sgstAmount: widget.sgstAmount,
//               sgstRate: widget.sgstRate,
//               taxableAmount: widget.taxableAmount,
//               // Passenger Data
//               leadPassenger: passengerData["LeadPassenger"],
//               passengerId: passengerData["PassengerId"],
//               title: passengerData["Title"],
//               firstName: passengerData["FirstName"],
//               lastName: passengerData["LastName"],
//               email: passengerData["Email"],
//               phoneno: passengerData["Phoneno"],
//               gender: passengerData["Gender"],
//               idType: passengerData["IdType"],
//               idNumber: passengerData["IdNumber"],
//               address: passengerData["Address"],
//               age: passengerData["Age"],
//             ),
//           ),
//         );
//
//         // Unblock Seat After 5 Minutes
//         Future.delayed(Duration(minutes: 5), () {
//           setState(() {
//             _isSeatBlocked = false;
//           });
//         });
//
//       } else {
//         setState(() {
//           _errorMessage = "Failed to block seat.";
//         });
//         print("Error: ${response.body}");
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "An error occurred: $e";
//       });
//       print("Exception: $e");
//     }
//   }
//   List<Map<String, dynamic>> _savedPassengers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSavedPassengers();
//   }
//
//   void _fetchSavedPassengers() async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;
//
//     final snapshot = await FirebaseFirestore.instance
//         .collection('customers')
//         .doc(currentUser.uid)
//         .collection('passengers')
//         .get();
//
//     setState(() {
//       _savedPassengers = snapshot.docs.map((doc) => doc.data()).toList();
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center, // Align text to the center
//               children: [
//                 Text(
//                   "Passenger Information",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 SizedBox(height: 4), // Adds some spacing
//                 Text(
//                   "${widget.sourceCity} -> ${widget.destinationCity}",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         backgroundColor: Colors.redAccent.shade700,
//         centerTitle: true,
//       ),
//
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Container for First Name, Last Name, Age, and Gender
//               Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Passenger Details",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
//                       ),
//                       _buildTextField(_firstNameController, "First Name", Icons.person),
//                       _buildTextField(_lastNameController, "Last Name", Icons.person_outline),
//                       _buildTextField(_ageController, "Age", Icons.cake, TextInputType.number),
//                       SizedBox(height: 12),
//                       DropdownButtonFormField<String>(
//                         value: _selectedGender,
//                         decoration: InputDecoration(
//                           labelText: "Gender",
//                           prefixIcon: Icon(Icons.wc, color: Colors.redAccent),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                           filled: true,
//                           fillColor: Colors.grey[200],
//                         ),
//                         items: ["Male", "Female"]
//                             .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
//                             .toList(),
//                         onChanged: (value) => setState(() => _selectedGender = value),
//                         validator: (value) => value == null ? "Gender is required" : null,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Container for Mobile Number, Email, and Address
//               Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Contact Details",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
//                       ),
//                       _buildTextField(_phoneController, "Phone Number", Icons.phone, TextInputType.phone),
//                       _buildTextField(_emailController, "Email", Icons.email, TextInputType.emailAddress),
//                       _buildTextField(_addressController, "State", Icons.home),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Saved Passengers Section
//               Text(
//                 "Saved Passengers",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
//               ),
//               SizedBox(height: 10),
//               ..._savedPassengers.map((passenger) => Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 elevation: 4,
//                 child: ListTile(
//                   title: Text("${passenger['FirstName']} ${passenger['LastName']}",
//                       style: TextStyle(fontWeight: FontWeight.w600)),
//                   subtitle: Text(passenger['Phoneno']!, style: TextStyle(color: Colors.black54)),
//                   leading: Icon(Icons.account_circle, color: Colors.blueAccent, size: 40),
//                   trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
//                   onTap: () {
//                     setState(() {
//                       _firstNameController.text = passenger['FirstName']!;
//                       _lastNameController.text = passenger['LastName']!;
//                       _phoneController.text = passenger['Phoneno']!;
//                       _emailController.text = passenger['Email']!;
//                       _addressController.text = passenger['Address']!;
//                       _ageController.text = passenger['Age']!;
//                       _selectedGender = passenger['Gender'] == "1" ? "Male" : "Female";
//                     });
//                   },
//                 ),
//               )),
//               SizedBox(height: 20),
//
//               // Book Seat Button
//               ElevatedButton(
//                 onPressed: _isLoading || _isSeatBlocked ? null : _blockSeat,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: _isSeatBlocked ? Colors.green : Colors.redAccent,
//                   minimumSize: Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 ),
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text(
//                   _isSeatBlocked ? "Seat Booked" : "Book Seat",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               if (_errorMessage.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text(_errorMessage, style: TextStyle(color: Colors.red)),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget _buildTextField(TextEditingController controller, String label, IconData icon, [TextInputType keyboardType = TextInputType.text]) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8.0),
//     child: TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.redAccent),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         filled: true,
//         fillColor: Colors.grey[200],
//       ),
//       validator: (value) => value!.isEmpty ? "$label is required" : null,
//     ),
//   );
// }


// male can book ladies seat but it wont book amount will deduct


// import 'dart:convert';
// import 'dart:async'; // For Future.delayed
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'book_seat_screen.dart';
//
// class BlockSeatPage extends StatefulWidget {
//   final int? boardingPointIndex;
//   final int? droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   final String resultIndex;
//   final String traceId;
//   final String sourceCity;
//   final String destinationCity;
//   final String journeyDate;
//   final String travelName;
//   final String busType;
//   final String arrivalTime;
//   final String departureTime;
//
//   final dynamic columnNo;
//   final int height;
//   final bool isLadiesSeat;
//   final bool isMalesSeat;
//   final bool isUpper;
//   final dynamic rowNo;
//   final dynamic seatFare;
//   final dynamic seatIndex;
//   final String seatName;
//   final bool seatStatus;
//   final int seatType;
//   final int width;
//
//   final String currencyCode;
//   final dynamic basePrice;
//   final int tax;
//   final int otherCharges;
//   final int discount;
//   final dynamic publishedPrice;
//   final int publishedPriceRoundedOff;
//   final dynamic offeredPrice;
//   final int offeredPriceRoundedOff;
//   final dynamic agentCommission;
//   final int agentMarkUp;
//   final dynamic tds;
//
//   final int cgstAmount;
//   final int cgstRate;
//   final int cessAmount;
//   final int cessRate;
//   final int igstAmount;
//   final int igstRate;
//   final int sgstAmount;
//   final int sgstRate;
//   final int taxableAmount;
//
//   const BlockSeatPage({
//     Key? key,
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.seatName,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatStatus,
//     required this.seatType,
//     required this.height,
//     required this.width,
//     required this.rowNo,
//     required this.columnNo,
//     required this.isLadiesSeat,
//     required this.isMalesSeat,
//     required this.isUpper,
//     required this.currencyCode,
//     required this.basePrice,
//     required this.tax,
//     required this.otherCharges,
//     required this.discount,
//     required this.publishedPrice,
//     required this.publishedPriceRoundedOff,
//     required this.offeredPrice,
//     required this.offeredPriceRoundedOff,
//     required this.agentCommission,
//     required this.agentMarkUp,
//     required this.tds,
//     required this.cgstAmount,
//     required this.cgstRate,
//     required this.cessAmount,
//     required this.cessRate,
//     required this.igstAmount,
//     required this.igstRate,
//     required this.sgstAmount,
//     required this.sgstRate,
//     required this.taxableAmount,
//   }) : super(key: key);
//
//   @override
//   _BlockSeatPageState createState() => _BlockSeatPageState();
// }
// class _BlockSeatPageState extends State<BlockSeatPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   String _errorMessage = "";
//
//   // Passenger details
//   final List<Map<String, dynamic>> _passengers = [];
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//
//
//   String? _selectedGender;
//   bool _isSeatBlocked = false; // Track the seat status
//   Future<void> _blockSeat() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     print("Mobile Number: ${_phoneController.text.trim()}");
//
//     // Get logged-in user
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//       setState(() {
//         _errorMessage = "User not logged in.";
//       });
//       return;
//     }
//     final String customerId = currentUser.uid;
//
//     // Passenger Data
//     Map<String, dynamic> passengerData = {
//       "LeadPassenger": true,
//       "PassengerId": DateTime.now().millisecondsSinceEpoch, // Unique ID
//       "Title": "Mr",
//       "FirstName": _firstNameController.text.trim(),
//       "LastName": _lastNameController.text.trim(),
//       "Email": _emailController.text.trim(),
//       "Phoneno": _phoneController.text.trim(),
//       "Gender": _selectedGender == "Male" ? "1" : "2",
//       "IdType": null,
//       "IdNumber": null,
//       "Address": _addressController.text.trim(),
//       "Age": _ageController.text.trim(),
//       "Seat": {
//         "ColumnNo": widget.columnNo,
//         "Height": widget.height,
//         "IsLadiesSeat": widget.isLadiesSeat,
//         "IsMalesSeat": widget.isMalesSeat,
//         "IsUpper": widget.isUpper,
//         "RowNo": widget.rowNo,
//         "SeatFare": widget.seatFare,
//         "SeatIndex": widget.seatIndex,
//         "SeatName": widget.seatName,
//         "SeatStatus": widget.seatStatus,
//         "SeatType": widget.seatType,
//         "Width": widget.width,
//         "Price": {
//           "CurrencyCode": widget.currencyCode,
//           "BasePrice": widget.basePrice,
//           "Tax": widget.tax,
//           "OtherCharges": widget.otherCharges,
//           "Discount": widget.discount,
//           "PublishedPrice": widget.publishedPrice,
//           "PublishedPriceRoundedOff": widget.publishedPriceRoundedOff,
//           "OfferedPrice": widget.offeredPrice,
//           "OfferedPriceRoundedOff": widget.offeredPriceRoundedOff,
//           "AgentCommission": widget.agentCommission,
//           "AgentMarkUp": widget.agentMarkUp,
//           "TDS": widget.tds,
//           "GST": {
//             "CGSTAmount": widget.cgstAmount,
//             "CGSTRate": widget.cgstRate,
//             "CessAmount": widget.cessAmount,
//             "CessRate": widget.cessRate,
//             "IGSTAmount": widget.igstAmount,
//             "IGSTRate": widget.igstRate,
//             "SGSTAmount": widget.sgstAmount,
//             "SGSTRate": widget.sgstRate,
//             "TaxableAmount": widget.taxableAmount,
//           }
//         }
//       }
//     };
//
//     // Save Passenger to Firestore
//     try {
//       await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('passengers')
//           .add(passengerData);
//
//       print("Passenger details saved to Firestore");
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Failed to save passenger: $e";
//       });
//       print("Firestore Error: $e");
//       return;
//     }
//
//     // API Call to Block Seat
//     // const String apiUrl = "https://bus.srdvapi.com/v5/rest/Block";
//     const String apiUrl = "http://3.7.121.234/bus-api/Block";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": "1",
//       "Passenger": [passengerData], // Send Passenger Data
//     };
//
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
//       print("Response status code: ${response.statusCode}");
//       print("Response body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         setState(() {
//           _isSeatBlocked = true;
//         });
//
//         // Navigate to Booking Page
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BookSeat(
//               resultIndex: widget.resultIndex,
//               traceId: widget.traceId,
//               sourceCity: widget.sourceCity,
//               destinationCity: widget.destinationCity,
//               boardingPointIndex: widget.boardingPointIndex,
//               droppingPointIndex: widget.droppingPointIndex,
//               selectedBoardingPoint: widget.selectedBoardingPoint,
//               selectedDroppingPoint: widget.selectedDroppingPoint,
//               journeyDate: widget.journeyDate,
//               travelName: widget.travelName,
//               busType: widget.busType,
//               arrivalTime: widget.arrivalTime,
//               departureTime: widget.departureTime,
//
//               columnNo: widget.columnNo,
//               height: widget.height,
//               isLadiesSeat: widget.isLadiesSeat,
//               isMalesSeat: widget.isMalesSeat,
//               isUpper: widget.isUpper,
//               rowNo: widget.rowNo,
//               seatFare: widget.seatFare,
//               seatIndex: widget.seatIndex,
//               seatName: widget.seatName,
//               seatStatus: widget.seatStatus,
//               seatType: widget.seatType,
//               width: widget.width,
//
//               currencyCode: widget.currencyCode,
//               basePrice: widget.basePrice,
//               tax: widget.tax,
//               otherCharges: widget.otherCharges,
//               discount: widget.discount,
//               publishedPrice: widget.publishedPrice,
//               publishedPriceRoundedOff: widget.publishedPriceRoundedOff,
//               offeredPrice: widget.offeredPrice,
//               offeredPriceRoundedOff: widget.offeredPriceRoundedOff,
//               agentCommission: widget.agentCommission,
//               agentMarkUp: widget.agentMarkUp,
//               tds: widget.tds,
//               cgstAmount: widget.cgstAmount,
//               cgstRate: widget.cgstRate,
//               cessAmount: widget.cessAmount,
//               cessRate: widget.cessRate,
//               igstAmount: widget.igstAmount,
//               igstRate: widget.igstRate,
//               sgstAmount: widget.sgstAmount,
//               sgstRate: widget.sgstRate,
//               taxableAmount: widget.taxableAmount,
//               // Passenger Data
//               leadPassenger: passengerData["LeadPassenger"],
//               passengerId: passengerData["PassengerId"],
//               title: passengerData["Title"],
//               firstName: passengerData["FirstName"],
//               lastName: passengerData["LastName"],
//               email: passengerData["Email"],
//               phoneno: passengerData["Phoneno"],
//               gender: passengerData["Gender"],
//               idType: passengerData["IdType"],
//               idNumber: passengerData["IdNumber"],
//               address: passengerData["Address"],
//               age: passengerData["Age"],
//             ),
//           ),
//         );
//
//         // Unblock Seat After 5 Minutes
//         Future.delayed(Duration(minutes: 5), () {
//           setState(() {
//             _isSeatBlocked = false;
//           });
//         });
//
//       } else {
//         setState(() {
//           _errorMessage = "Failed to block seat.";
//         });
//         print("Error: ${response.body}");
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "An error occurred: $e";
//       });
//       print("Exception: $e");
//     }
//   }
//   List<Map<String, dynamic>> _savedPassengers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSavedPassengers();
//   }
//
//   void _fetchSavedPassengers() async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;
//
//     final snapshot = await FirebaseFirestore.instance
//         .collection('customers')
//         .doc(currentUser.uid)
//         .collection('passengers')
//         .get();
//
//     setState(() {
//       _savedPassengers = snapshot.docs.map((doc) => doc.data()).toList();
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center, // Align text to the center
//               children: [
//                 Text(
//                   "Passenger Information",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 SizedBox(height: 4), // Adds some spacing
//                 Text(
//                   "${widget.sourceCity} -> ${widget.destinationCity}",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         backgroundColor: Colors.redAccent.shade700,
//         centerTitle: true,
//       ),
//
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Container for First Name, Last Name, Age, and Gender
//               Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 5,
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Passenger Details",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                       _buildTextField(_firstNameController, "First Name", Icons.person),
//                       _buildTextField(_lastNameController, "Last Name", Icons.person_outline),
//                       _buildTextField(_ageController, "Age", Icons.cake, TextInputType.number),
//                       SizedBox(height: 12),
//                       DropdownButtonFormField<String>(
//                         value: _selectedGender,
//                         decoration: InputDecoration(
//                           labelText: "Gender",
//                           prefixIcon: Icon(Icons.wc, color: Colors.redAccent),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                           filled: true,
//                           fillColor: Colors.grey[200],
//                         ),
//                         items: ["Male", "Female"]
//                             .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
//                             .toList(),
//                         onChanged: (value) => setState(() => _selectedGender = value),
//                         validator: (value) => value == null ? "Gender is required" : null,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Container for Mobile Number, Email, and Address
//               Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 5,
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Contact Details",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                       _buildTextField(_phoneController, "Phone Number", Icons.phone, TextInputType.phone),
//                       _buildTextField(_emailController, "Email", Icons.email, TextInputType.emailAddress),
//                       _buildTextField(_addressController, "State", Icons.home),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Saved Passengers Section
//               Text(
//                 "Saved Passengers",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//               ),
//               SizedBox(height: 10),
//               ..._savedPassengers.map((passenger) => Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 elevation: 4,
//                 child: ListTile(
//                   title: Text("${passenger['FirstName']} ${passenger['LastName']}",
//                       style: TextStyle(fontWeight: FontWeight.w600)),
//                   subtitle: Text(passenger['Phoneno']!, style: TextStyle(color: Colors.grey)),
//                   leading: Icon(Icons.account_circle, color: Colors.blueAccent, size: 40),
//                   trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
//                   onTap: () {
//                     setState(() {
//                       _firstNameController.text = passenger['FirstName']!;
//                       _lastNameController.text = passenger['LastName']!;
//                       _phoneController.text = passenger['Phoneno']!;
//                       _emailController.text = passenger['Email']!;
//                       _addressController.text = passenger['Address']!;
//                       _ageController.text = passenger['Age']!;
//                       _selectedGender = passenger['Gender'] == "1" ? "Male" : "Female";
//                     });
//                   },
//                 ),
//               )),
//               SizedBox(height: 20),
//
//               // Book Seat Button
//               ElevatedButton(
//                 onPressed: _isLoading || _isSeatBlocked ? null : _blockSeat,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: _isSeatBlocked ? Colors.green : Colors.redAccent,
//                   minimumSize: Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 ),
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text(
//                   _isSeatBlocked ? "Seat Booked" : "Book Seat",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               if (_errorMessage.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text(_errorMessage, style: TextStyle(color: Colors.red)),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget _buildTextField(TextEditingController controller, String label, IconData icon, [TextInputType keyboardType = TextInputType.text]) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8.0),
//     child: TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.redAccent),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         filled: true,
//         fillColor: Colors.grey[200],
//       ),
//       validator: (value) => value!.isEmpty ? "$label is required" : null,
//     ),
//   );
// }





// main multiple seats are not booking




// import 'dart:convert';
// import 'dart:async'; // For Future.delayed
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'book_seat_screen.dart';
//
// class BlockSeatPage extends StatefulWidget {
//   final int? boardingPointIndex;
//   final int? droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   final String resultIndex;
//   final String traceId;
//   final String sourceCity;
//   final String destinationCity;
//   final String journeyDate;
//   final String travelName;
//   final String busType;
//   final String arrivalTime;
//   final String departureTime;
//
//   final dynamic columnNo;
//   final int height;
//   final bool isLadiesSeat;
//   final bool isMalesSeat;
//   final bool isUpper;
//   final dynamic rowNo;
//   final dynamic seatFare;
//   final dynamic seatIndex;
//   final String seatName;
//   final bool seatStatus;
//   final int seatType;
//   final int width;
//
//   final String currencyCode;
//   final dynamic basePrice;
//   final int tax;
//   final int otherCharges;
//   final int discount;
//   final dynamic publishedPrice;
//   final int publishedPriceRoundedOff;
//   final dynamic offeredPrice;
//   final int offeredPriceRoundedOff;
//   final dynamic agentCommission;
//   final int agentMarkUp;
//   final dynamic tds;
//
//   final int cgstAmount;
//   final int cgstRate;
//   final int cessAmount;
//   final int cessRate;
//   final int igstAmount;
//   final int igstRate;
//   final int sgstAmount;
//   final int sgstRate;
//   final int taxableAmount;
//
//   const BlockSeatPage({
//     Key? key,
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.seatName,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatStatus,
//     required this.seatType,
//     required this.height,
//     required this.width,
//     required this.rowNo,
//     required this.columnNo,
//     required this.isLadiesSeat,
//     required this.isMalesSeat,
//     required this.isUpper,
//     required this.currencyCode,
//     required this.basePrice,
//     required this.tax,
//     required this.otherCharges,
//     required this.discount,
//     required this.publishedPrice,
//     required this.publishedPriceRoundedOff,
//     required this.offeredPrice,
//     required this.offeredPriceRoundedOff,
//     required this.agentCommission,
//     required this.agentMarkUp,
//     required this.tds,
//     required this.cgstAmount,
//     required this.cgstRate,
//     required this.cessAmount,
//     required this.cessRate,
//     required this.igstAmount,
//     required this.igstRate,
//     required this.sgstAmount,
//     required this.sgstRate,
//     required this.taxableAmount,
//   }) : super(key: key);
//
//   @override
//   _BlockSeatPageState createState() => _BlockSeatPageState();
// }
// class _BlockSeatPageState extends State<BlockSeatPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   String _errorMessage = "";
//
//   // Passenger details
//   final List<Map<String, dynamic>> _passengers = [];
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//
//
//   String? _selectedGender;
//   bool _isSeatBlocked = false; // Track the seat status
//   // Future<void> _blockSeat() async {
//   //   if (!_formKey.currentState!.validate()) {
//   //     return;
//   //   }
//   //
//   //   print("Mobile Number: ${_phoneController.text.trim()}");
//   //
//   //   // Get logged-in user
//   //   final currentUser = FirebaseAuth.instance.currentUser;
//   //   if (currentUser == null) {
//   //     setState(() {
//   //       _errorMessage = "User not logged in.";
//   //     });
//   //     return;
//   //   }
//   //   final String customerId = currentUser.uid;
//   //
//   //   // Passenger Data
//   //   Map<String, dynamic> passengerData = {
//   //     "LeadPassenger": true,
//   //     "PassengerId": DateTime.now().millisecondsSinceEpoch, // Unique ID
//   //     "Title": "Mr",
//   //     "FirstName": _firstNameController.text.trim(),
//   //     "LastName": _lastNameController.text.trim(),
//   //     "Email": _emailController.text.trim(),
//   //     "Phoneno": _phoneController.text.trim(),
//   //     "Gender": _selectedGender == "Male" ? "1" : "2",
//   //     "IdType": null,
//   //     "IdNumber": null,
//   //     "Address": _addressController.text.trim(),
//   //     "Age": _ageController.text.trim(),
//   //     "Seat": {
//   //       "ColumnNo": widget.columnNo,
//   //       "Height": widget.height,
//   //       "IsLadiesSeat": widget.isLadiesSeat,
//   //       "IsMalesSeat": widget.isMalesSeat,
//   //       "IsUpper": widget.isUpper,
//   //       "RowNo": widget.rowNo,
//   //       "SeatFare": widget.seatFare,
//   //       "SeatIndex": widget.seatIndex,
//   //       "SeatName": widget.seatName,
//   //       "SeatStatus": widget.seatStatus,
//   //       "SeatType": widget.seatType,
//   //       "Width": widget.width,
//   //       "Price": {
//   //         "CurrencyCode": widget.currencyCode,
//   //         "BasePrice": widget.basePrice,
//   //         "Tax": widget.tax,
//   //         "OtherCharges": widget.otherCharges,
//   //         "Discount": widget.discount,
//   //         "PublishedPrice": widget.publishedPrice,
//   //         "PublishedPriceRoundedOff": widget.publishedPriceRoundedOff,
//   //         "OfferedPrice": widget.offeredPrice,
//   //         "OfferedPriceRoundedOff": widget.offeredPriceRoundedOff,
//   //         "AgentCommission": widget.agentCommission,
//   //         "AgentMarkUp": widget.agentMarkUp,
//   //         "TDS": widget.tds,
//   //         "GST": {
//   //           "CGSTAmount": widget.cgstAmount,
//   //           "CGSTRate": widget.cgstRate,
//   //           "CessAmount": widget.cessAmount,
//   //           "CessRate": widget.cessRate,
//   //           "IGSTAmount": widget.igstAmount,
//   //           "IGSTRate": widget.igstRate,
//   //           "SGSTAmount": widget.sgstAmount,
//   //           "SGSTRate": widget.sgstRate,
//   //           "TaxableAmount": widget.taxableAmount,
//   //         }
//   //       }
//   //     }
//   //   };
//   //
//   //   // Save Passenger to Firestore
//   //   try {
//   //     await FirebaseFirestore.instance
//   //         .collection('customers')
//   //         .doc(customerId)
//   //         .collection('passengers')
//   //         .add(passengerData);
//   //
//   //     print("Passenger details saved to Firestore");
//   //   } catch (e) {
//   //     setState(() {
//   //       _errorMessage = "Failed to save passenger: $e";
//   //     });
//   //     print("Firestore Error: $e");
//   //     return;
//   //   }
//   //
//   //   // API Call to Block Seat
//   //   // const String apiUrl = "https://bus.srdvapi.com/v5/rest/Block";
//   //   const String apiUrl = "http://3.7.121.234/bus-api/Block";
//   //   final Map<String, dynamic> requestBody = {
//   //     "ClientId": "180187",
//   //     "UserName": "Namma434",
//   //     "Password": "Namma@4341",
//   //     "ResultIndex": widget.resultIndex,
//   //     "TraceId": widget.traceId,
//   //     "BoardingPointId": widget.boardingPointIndex,
//   //     "DroppingPointId": widget.droppingPointIndex,
//   //     "RefID": "1",
//   //     "Passenger": [passengerData], // Send Passenger Data
//   //   };
//   //
//   //   const headers = {
//   //     "Content-Type": "application/json",
//   //     "Api-Token": "Namma@90434#34",
//   //   };
//   //
//   //   setState(() {
//   //     _isLoading = true;
//   //     _errorMessage = "";
//   //   });
//   //
//   //   try {
//   //     final response = await http.post(
//   //       Uri.parse(apiUrl),
//   //       headers: headers,
//   //       body: jsonEncode(requestBody),
//   //     );
//   //
//   //     print("Response status code: ${response.statusCode}");
//   //     print("Response body: ${response.body}");
//   //
//   //     if (response.statusCode == 200) {
//   //       setState(() {
//   //         _isSeatBlocked = true;
//   //       });
//   //
//   //       // Navigate to Booking Page
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => BookSeat(
//   //             resultIndex: widget.resultIndex,
//   //             traceId: widget.traceId,
//   //             sourceCity: widget.sourceCity,
//   //             destinationCity: widget.destinationCity,
//   //             boardingPointIndex: widget.boardingPointIndex,
//   //             droppingPointIndex: widget.droppingPointIndex,
//   //             selectedBoardingPoint: widget.selectedBoardingPoint,
//   //             selectedDroppingPoint: widget.selectedDroppingPoint,
//   //             journeyDate: widget.journeyDate,
//   //             travelName: widget.travelName,
//   //             busType: widget.busType,
//   //             arrivalTime: widget.arrivalTime,
//   //             departureTime: widget.departureTime,
//   //
//   //             columnNo: widget.columnNo,
//   //             height: widget.height,
//   //             isLadiesSeat: widget.isLadiesSeat,
//   //             isMalesSeat: widget.isMalesSeat,
//   //             isUpper: widget.isUpper,
//   //             rowNo: widget.rowNo,
//   //             seatFare: widget.seatFare,
//   //             seatIndex: widget.seatIndex,
//   //             seatName: widget.seatName,
//   //             seatStatus: widget.seatStatus,
//   //             seatType: widget.seatType,
//   //             width: widget.width,
//   //
//   //             currencyCode: widget.currencyCode,
//   //             basePrice: widget.basePrice,
//   //             tax: widget.tax,
//   //             otherCharges: widget.otherCharges,
//   //             discount: widget.discount,
//   //             publishedPrice: widget.publishedPrice,
//   //             publishedPriceRoundedOff: widget.publishedPriceRoundedOff,
//   //             offeredPrice: widget.offeredPrice,
//   //             offeredPriceRoundedOff: widget.offeredPriceRoundedOff,
//   //             agentCommission: widget.agentCommission,
//   //             agentMarkUp: widget.agentMarkUp,
//   //             tds: widget.tds,
//   //             cgstAmount: widget.cgstAmount,
//   //             cgstRate: widget.cgstRate,
//   //             cessAmount: widget.cessAmount,
//   //             cessRate: widget.cessRate,
//   //             igstAmount: widget.igstAmount,
//   //             igstRate: widget.igstRate,
//   //             sgstAmount: widget.sgstAmount,
//   //             sgstRate: widget.sgstRate,
//   //             taxableAmount: widget.taxableAmount,
//   //             // Passenger Data
//   //             leadPassenger: passengerData["LeadPassenger"],
//   //             passengerId: passengerData["PassengerId"],
//   //             title: passengerData["Title"],
//   //             firstName: passengerData["FirstName"],
//   //             lastName: passengerData["LastName"],
//   //             email: passengerData["Email"],
//   //             phoneno: passengerData["Phoneno"],
//   //             gender: passengerData["Gender"],
//   //             idType: passengerData["IdType"],
//   //             idNumber: passengerData["IdNumber"],
//   //             address: passengerData["Address"],
//   //             age: passengerData["Age"],
//   //           ),
//   //         ),
//   //       );
//   //
//   //       // Unblock Seat After 5 Minutes
//   //       Future.delayed(Duration(minutes: 5), () {
//   //         setState(() {
//   //           _isSeatBlocked = false;
//   //         });
//   //       });
//   //
//   //     } else {
//   //       setState(() {
//   //         _errorMessage = "Failed to block seat.";
//   //       });
//   //       print("Error: ${response.body}");
//   //     }
//   //   } catch (e) {
//   //     setState(() {
//   //       _errorMessage = "An error occurred: $e";
//   //     });
//   //     print("Exception: $e");
//   //   }
//   // }
//   Future<void> _blockSeat() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     // Get logged-in user
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//       setState(() {
//         _errorMessage = "User not logged in.";
//       });
//       return;
//     }
//     final String customerId = currentUser.uid;
//
//     // Passenger Data
//     Map<String, dynamic> passengerData = {
//       "LeadPassenger": true,
//       "PassengerId": DateTime.now().millisecondsSinceEpoch,
//       "Title": "Mr",
//       "FirstName": _firstNameController.text.trim(),
//       "LastName": _lastNameController.text.trim(),
//       "Email": _emailController.text.trim(),
//       "Phoneno": _phoneController.text.trim(),
//       "Gender": _selectedGender == "Male" ? "1" : "2",
//       "IdType": null,
//       "IdNumber": null,
//       "Address": _addressController.text.trim(),
//       "Age": _ageController.text.trim(),
//       "Seat": {
//         "ColumnNo": widget.columnNo,
//         "Height": widget.height,
//         "IsLadiesSeat": widget.isLadiesSeat,
//         "IsMalesSeat": widget.isMalesSeat,
//         "IsUpper": widget.isUpper,
//         "RowNo": widget.rowNo,
//         "SeatFare": widget.seatFare,
//         "SeatIndex": widget.seatIndex,
//         "SeatName": widget.seatName,
//         "SeatStatus": widget.seatStatus,
//         "SeatType": widget.seatType,
//         "Width": widget.width,
//         "Price": {
//           "CurrencyCode": widget.currencyCode,
//           "BasePrice": widget.basePrice,
//           "Tax": widget.tax,
//           "OtherCharges": widget.otherCharges,
//           "Discount": widget.discount,
//           "PublishedPrice": widget.publishedPrice,
//           "PublishedPriceRoundedOff": widget.publishedPriceRoundedOff,
//           "OfferedPrice": widget.offeredPrice,
//           "OfferedPriceRoundedOff": widget.offeredPriceRoundedOff,
//           "AgentCommission": widget.agentCommission,
//           "AgentMarkUp": widget.agentMarkUp,
//           "TDS": widget.tds,
//           "GST": {
//             "CGSTAmount": widget.cgstAmount,
//             "CGSTRate": widget.cgstRate,
//             "CessAmount": widget.cessAmount,
//             "CessRate": widget.cessRate,
//             "IGSTAmount": widget.igstAmount,
//             "IGSTRate": widget.igstRate,
//             "SGSTAmount": widget.sgstAmount,
//             "SGSTRate": widget.sgstRate,
//             "TaxableAmount": widget.taxableAmount,
//           }
//         }
//       }
//     };
//
//     // Save Passenger to Firestore
//     try {
//       await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('passengers')
//           .add(passengerData);
//       print("Passenger details saved to Firestore");
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Failed to save passenger: $e";
//       });
//       print("Firestore Error: $e");
//       return;
//     }
//
//     // API Call to Block Seat
//     const String apiUrl = "http://3.7.121.234/bus-api/Block";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": "1",
//       "Passenger": [passengerData],
//     };
//
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
//       print("Response status code: ${response.statusCode}");
//       print("Response body: ${response.body}");
//
//       final responseData = jsonDecode(response.body);
//
//       if (response.statusCode == 200) {
//         // Check if the response contains the expected Result data
//         if (responseData['Result'] != null &&
//             responseData['Result']['ArrivalTime'] != null &&
//             responseData['Result']['BoardingPointdetails'] != null) {
//
//           setState(() {
//             _isSeatBlocked = true;
//           });
//
//           // Navigate to Booking Page
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BookSeat(
//                 resultIndex: widget.resultIndex,
//                 traceId: widget.traceId,
//                 sourceCity: widget.sourceCity,
//                 destinationCity: widget.destinationCity,
//                 boardingPointIndex: widget.boardingPointIndex,
//                 droppingPointIndex: widget.droppingPointIndex,
//                 selectedBoardingPoint: widget.selectedBoardingPoint,
//                 selectedDroppingPoint: widget.selectedDroppingPoint,
//                 journeyDate: widget.journeyDate,
//                 travelName: widget.travelName,
//                 busType: widget.busType,
//                 arrivalTime: widget.arrivalTime,
//                 departureTime: widget.departureTime,
//
//                 columnNo: widget.columnNo,
//                 height: widget.height,
//                 isLadiesSeat: widget.isLadiesSeat,
//                 isMalesSeat: widget.isMalesSeat,
//                 isUpper: widget.isUpper,
//                 rowNo: widget.rowNo,
//                 seatFare: widget.seatFare,
//                 seatIndex: widget.seatIndex,
//                 seatName: widget.seatName,
//                 seatStatus: widget.seatStatus,
//                 seatType: widget.seatType,
//                 width: widget.width,
//
//                 currencyCode: widget.currencyCode,
//                 basePrice: widget.basePrice,
//                 tax: widget.tax,
//                 otherCharges: widget.otherCharges,
//                 discount: widget.discount,
//                 publishedPrice: widget.publishedPrice,
//                 publishedPriceRoundedOff: widget.publishedPriceRoundedOff,
//                 offeredPrice: widget.offeredPrice,
//                 offeredPriceRoundedOff: widget.offeredPriceRoundedOff,
//                 agentCommission: widget.agentCommission,
//                 agentMarkUp: widget.agentMarkUp,
//                 tds: widget.tds,
//                 cgstAmount: widget.cgstAmount,
//                 cgstRate: widget.cgstRate,
//                 cessAmount: widget.cessAmount,
//                 cessRate: widget.cessRate,
//                 igstAmount: widget.igstAmount,
//                 igstRate: widget.igstRate,
//                 sgstAmount: widget.sgstAmount,
//                 sgstRate: widget.sgstRate,
//                 taxableAmount: widget.taxableAmount,
//                 // Passenger Data
//                 leadPassenger: passengerData["LeadPassenger"],
//                 passengerId: passengerData["PassengerId"],
//                 title: passengerData["Title"],
//                 firstName: passengerData["FirstName"],
//                 lastName: passengerData["LastName"],
//                 email: passengerData["Email"],
//                 phoneno: passengerData["Phoneno"],
//                 gender: passengerData["Gender"],
//                 idType: passengerData["IdType"],
//                 idNumber: passengerData["IdNumber"],
//                 address: passengerData["Address"],
//                 age: passengerData["Age"],
//               ),
//             ),
//           );
//
//           // Unblock Seat After 5 Minutes
//           Future.delayed(Duration(minutes: 5), () {
//             setState(() {
//               _isSeatBlocked = false;
//             });
//           });
//         } else {
//           // Show error message from response or default message
//           final errorMessage = responseData['Error']?['ErrorMessage'] ?? "Failed to block seat. Please try again.";
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(errorMessage),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       } else {
//         // Handle non-200 status codes
//         final errorMessage = responseData['Error']?['ErrorMessage'] ?? "Failed to block seat. Status code: ${response.statusCode}";
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(errorMessage),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("An error occurred: $e"),
//           backgroundColor: Colors.red,
//         ),
//       );
//       print("Exception: $e");
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//   List<Map<String, dynamic>> _savedPassengers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSavedPassengers();
//   }
//
//   void _fetchSavedPassengers() async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;
//
//     final snapshot = await FirebaseFirestore.instance
//         .collection('customers')
//         .doc(currentUser.uid)
//         .collection('passengers')
//         .get();
//
//     setState(() {
//       _savedPassengers = snapshot.docs.map((doc) => doc.data()).toList();
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center, // Align text to the center
//               children: [
//                 Text(
//                   "Passenger Information",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 SizedBox(height: 4), // Adds some spacing
//                 Text(
//                   "${widget.sourceCity} -> ${widget.destinationCity}",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         backgroundColor: Colors.redAccent.shade700,
//         centerTitle: true,
//       ),
//
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Container for First Name, Last Name, Age, and Gender
//               Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 5,
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Passenger Details",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                       _buildTextField(_firstNameController, "First Name", Icons.person),
//                       _buildTextField(_lastNameController, "Last Name", Icons.person_outline),
//                       _buildTextField(_ageController, "Age", Icons.cake, TextInputType.number),
//                       SizedBox(height: 12),
//                       DropdownButtonFormField<String>(
//                         value: _selectedGender,
//                         decoration: InputDecoration(
//                           labelText: "Gender",
//                           prefixIcon: Icon(Icons.wc, color: Colors.redAccent),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                           filled: true,
//                           fillColor: Colors.grey[200],
//                         ),
//                         items: ["Male", "Female"]
//                             .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
//                             .toList(),
//                         onChanged: (value) => setState(() => _selectedGender = value),
//                         validator: (value) => value == null ? "Gender is required" : null,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Container for Mobile Number, Email, and Address
//               Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 5,
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Contact Details",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                       _buildTextField(_phoneController, "Phone Number", Icons.phone, TextInputType.phone),
//                       _buildTextField(_emailController, "Email", Icons.email, TextInputType.emailAddress),
//                       _buildTextField(_addressController, "State", Icons.home),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Saved Passengers Section
//               Text(
//                 "Saved Passengers",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//               ),
//               SizedBox(height: 10),
//               ..._savedPassengers.map((passenger) => Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 elevation: 4,
//                 child: ListTile(
//                   title: Text("${passenger['FirstName']} ${passenger['LastName']}",
//                       style: TextStyle(fontWeight: FontWeight.w600)),
//                   subtitle: Text(passenger['Phoneno']!, style: TextStyle(color: Colors.grey)),
//                   leading: Icon(Icons.account_circle, color: Colors.blueAccent, size: 40),
//                   trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
//                   onTap: () {
//                     setState(() {
//                       _firstNameController.text = passenger['FirstName']!;
//                       _lastNameController.text = passenger['LastName']!;
//                       _phoneController.text = passenger['Phoneno']!;
//                       _emailController.text = passenger['Email']!;
//                       _addressController.text = passenger['Address']!;
//                       _ageController.text = passenger['Age']!;
//                       _selectedGender = passenger['Gender'] == "1" ? "Male" : "Female";
//                     });
//                   },
//                 ),
//               )),
//               SizedBox(height: 20),
//
//               // Book Seat Button
//               ElevatedButton(
//                 onPressed: _isLoading || _isSeatBlocked ? null : _blockSeat,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: _isSeatBlocked ? Colors.green : Colors.redAccent,
//                   minimumSize: Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 ),
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text(
//                   _isSeatBlocked ? "Seat Booked" : "Book Seat",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               if (_errorMessage.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text(_errorMessage, style: TextStyle(color: Colors.red)),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget _buildTextField(TextEditingController controller, String label, IconData icon, [TextInputType keyboardType = TextInputType.text]) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8.0),
//     child: TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.redAccent),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         filled: true,
//         fillColor: Colors.grey[200],
//       ),
//       validator: (value) => value!.isEmpty ? "$label is required" : null,
//     ),
//   );
// }



// pussy


// import 'dart:convert';
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'book_seat_screen.dart';
//
// class BlockSeatPage extends StatefulWidget {
//   final int? boardingPointIndex;
//   final int? droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   final String resultIndex;
//   final String traceId;
//   final String sourceCity;
//   final String destinationCity;
//   final String journeyDate;
//   final String travelName;
//   final String busType;
//   final String arrivalTime;
//   final String departureTime;
//   final List<Map<String, dynamic>> selectedSeats; // Changed to accept list of seats
//
//   const BlockSeatPage({
//     Key? key,
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.selectedSeats,
//   }) : super(key: key);
//
//   @override
//   _BlockSeatPageState createState() => _BlockSeatPageState();
// }
//
// class _BlockSeatPageState extends State<BlockSeatPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   String _errorMessage = "";
//
//   // Passenger details
//   final List<Map<String, dynamic>> _passengers = [];
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//
//   String? _selectedGender;
//   bool _isSeatBlocked = false;
//   List<Map<String, dynamic>> _savedPassengers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSavedPassengers();
//   }
//
//   void _fetchSavedPassengers() async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;
//
//     final snapshot = await FirebaseFirestore.instance
//         .collection('customers')
//         .doc(currentUser.uid)
//         .collection('passengers')
//         .get();
//
//     setState(() {
//       _savedPassengers = snapshot.docs.map((doc) => doc.data()).toList();
//     });
//   }
//
//   Future<void> _blockSeat() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//       setState(() {
//         _errorMessage = "User not logged in.";
//       });
//       return;
//     }
//     final String customerId = currentUser.uid;
//
//     // Create passenger data for each selected seat
//     List<Map<String, dynamic>> passengersData = widget.selectedSeats.map((seat) {
//       return {
//         "LeadPassenger": widget.selectedSeats.indexOf(seat) == 0, // First passenger is lead
//         "PassengerId": DateTime.now().millisecondsSinceEpoch + widget.selectedSeats.indexOf(seat),
//         "Title": "Mr",
//         "FirstName": _firstNameController.text.trim(),
//         "LastName": _lastNameController.text.trim(),
//         "Email": _emailController.text.trim(),
//         "Phoneno": _phoneController.text.trim(),
//         "Gender": _selectedGender == "Male" ? "1" : "2",
//         "IdType": null,
//         "IdNumber": null,
//         "Address": _addressController.text.trim(),
//         "Age": _ageController.text.trim(),
//         "Seat": {
//           "ColumnNo": seat['ColumnNo'],
//           "Height": seat['Height'],
//           "IsLadiesSeat": seat['IsLadiesSeat'],
//           "IsMalesSeat": seat['IsMalesSeat'],
//           "IsUpper": seat['IsUpper'],
//           "RowNo": seat['RowNo'],
//           "SeatFare": seat['SeatFare'],
//           "SeatIndex": seat['SeatIndex'],
//           "SeatName": seat['SeatName'],
//           "SeatStatus": seat['SeatStatus'],
//           "SeatType": seat['SeatType'],
//           "Width": seat['Width'],
//           "Price": seat['Price'] ?? {
//             "CurrencyCode": "INR",
//             "BasePrice": seat['SeatFare'],
//             "Tax": 0,
//             "OtherCharges": 0,
//             "Discount": 0,
//             "PublishedPrice": seat['SeatFare'],
//             "PublishedPriceRoundedOff": seat['SeatFare'],
//             "OfferedPrice": seat['SeatFare'],
//             "OfferedPriceRoundedOff": seat['SeatFare'],
//             "AgentCommission": 0,
//             "AgentMarkUp": 0,
//             "TDS": 0,
//             "GST": {
//               "CGSTAmount": 0,
//               "CGSTRate": 0,
//               "CessAmount": 0,
//               "CessRate": 0,
//               "IGSTAmount": 0,
//               "IGSTRate": 0,
//               "SGSTAmount": 0,
//               "SGSTRate": 0,
//               "TaxableAmount": seat['SeatFare'],
//             }
//           }
//         }
//       };
//     }).toList();
//
//     // Save all passengers to Firestore
//     try {
//       final batch = FirebaseFirestore.instance.batch();
//       final passengersRef = FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('passengers');
//
//       for (var passenger in passengersData) {
//         batch.set(passengersRef.doc(), passenger);
//       }
//       await batch.commit();
//       print("All passengers saved to Firestore");
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Failed to save passengers: $e";
//       });
//       print("Firestore Error: $e");
//       return;
//     }
//
//     // API Call to Block Seats
//     const String apiUrl = "http://3.7.121.234/bus-api/Block";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": "1",
//       "Passenger": passengersData,
//     };
//
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
//       print("Response status code: ${response.statusCode}");
//       print("Response body: ${response.body}");
//
//       final responseData = jsonDecode(response.body);
//
//       if (response.statusCode == 200) {
//         if (responseData['Result'] != null) {
//           setState(() {
//             _isSeatBlocked = true;
//           });
//
//           // Navigate to Booking Page with all selected seats
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BookSeat(
//                 resultIndex: widget.resultIndex,
//                 traceId: widget.traceId,
//                 sourceCity: widget.sourceCity,
//                 destinationCity: widget.destinationCity,
//                 boardingPointIndex: widget.boardingPointIndex,
//                 droppingPointIndex: widget.droppingPointIndex,
//                 selectedBoardingPoint: widget.selectedBoardingPoint,
//                 selectedDroppingPoint: widget.selectedDroppingPoint,
//                 journeyDate: widget.journeyDate,
//                 travelName: widget.travelName,
//                 busType: widget.busType,
//                 arrivalTime: widget.arrivalTime,
//                 departureTime: widget.departureTime,
//                 selectedSeats: widget.selectedSeats,
//                 // Passenger Data (for lead passenger)
//                 leadPassenger: passengersData[0]["LeadPassenger"],
//                 passengerId: passengersData[0]["PassengerId"],
//                 title: passengersData[0]["Title"],
//                 firstName: passengersData[0]["FirstName"],
//                 lastName: passengersData[0]["LastName"],
//                 email: passengersData[0]["Email"],
//                 phoneno: passengersData[0]["Phoneno"],
//                 gender: passengersData[0]["Gender"],
//                 idType: passengersData[0]["IdType"],
//                 idNumber: passengersData[0]["IdNumber"],
//                 address: passengersData[0]["Address"],
//                 age: passengersData[0]["Age"],
//               ),
//             ),
//           );
//
//           // Unblock Seats After 5 Minutes
//           Future.delayed(Duration(minutes: 5), () {
//             setState(() {
//               _isSeatBlocked = false;
//             });
//           });
//         } else {
//           final errorMessage = responseData['Error']?['ErrorMessage'] ?? "Failed to block seats. Please try again.";
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
//           );
//         }
//       } else {
//         final errorMessage = responseData['Error']?['ErrorMessage'] ?? "Failed to block seats. Status code: ${response.statusCode}";
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("An error occurred: $e"), backgroundColor: Colors.red),
//       );
//       print("Exception: $e");
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "Passenger Information",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "${widget.sourceCity} -> ${widget.destinationCity}",
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "Selected Seats: ${widget.selectedSeats.map((s) => s['SeatName']).join(', ')}",
//                   style: TextStyle(fontSize: 12, color: Colors.white),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         backgroundColor: Colors.redAccent.shade700,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Passenger Details Card
//               Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 5,
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text("Passenger Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                       _buildTextField(_firstNameController, "First Name", Icons.person),
//                       _buildTextField(_lastNameController, "Last Name", Icons.person_outline),
//                       _buildTextField(_ageController, "Age", Icons.cake, TextInputType.number),
//                       SizedBox(height: 12),
//                       DropdownButtonFormField<String>(
//                         value: _selectedGender,
//                         decoration: InputDecoration(
//                           labelText: "Gender",
//                           prefixIcon: Icon(Icons.wc, color: Colors.redAccent),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                           filled: true,
//                           fillColor: Colors.grey[200],
//                         ),
//                         items: ["Male", "Female"]
//                             .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
//                             .toList(),
//                         onChanged: (value) => setState(() => _selectedGender = value),
//                         validator: (value) => value == null ? "Gender is required" : null,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Contact Details Card
//               Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 5,
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text("Contact Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                       _buildTextField(_phoneController, "Phone Number", Icons.phone, TextInputType.phone),
//                       _buildTextField(_emailController, "Email", Icons.email, TextInputType.emailAddress),
//                       _buildTextField(_addressController, "State", Icons.home),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Saved Passengers Section
//               Text("Saved Passengers", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               SizedBox(height: 10),
//               ..._savedPassengers.map((passenger) => Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 elevation: 4,
//                 child: ListTile(
//                   title: Text("${passenger['FirstName']} ${passenger['LastName']}", style: TextStyle(fontWeight: FontWeight.w600)),
//                   subtitle: Text(passenger['Phoneno']!, style: TextStyle(color: Colors.grey)),
//                   leading: Icon(Icons.account_circle, color: Colors.blueAccent, size: 40),
//                   trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
//                   onTap: () {
//                     setState(() {
//                       _firstNameController.text = passenger['FirstName']!;
//                       _lastNameController.text = passenger['LastName']!;
//                       _phoneController.text = passenger['Phoneno']!;
//                       _emailController.text = passenger['Email']!;
//                       _addressController.text = passenger['Address']!;
//                       _ageController.text = passenger['Age']!;
//                       _selectedGender = passenger['Gender'] == "1" ? "Male" : "Female";
//                     });
//                   },
//                 ),
//               )),
//               SizedBox(height: 20),
//
//               // Book Seats Button
//               ElevatedButton(
//                 onPressed: _isLoading || _isSeatBlocked ? null : _blockSeat,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: _isSeatBlocked ? Colors.green : Colors.redAccent,
//                   minimumSize: Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 ),
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text(
//                   _isSeatBlocked ? "Seats Booked" : "Book ${widget.selectedSeats.length} Seats",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               if (_errorMessage.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text(_errorMessage, style: TextStyle(color: Colors.red)),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String label, IconData icon, [TextInputType keyboardType = TextInputType.text]) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon, color: Colors.redAccent),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//           filled: true,
//           fillColor: Colors.grey[200],
//         ),
//         validator: (value) => value!.isEmpty ? "$label is required" : null,
//       ),
//     );
//   }
// }



// updating



import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'book_seat_screen.dart';

class BlockSeatPage extends StatefulWidget {
  final int? boardingPointIndex;
  final int? droppingPointIndex;
  final String selectedBoardingPoint;
  final String selectedDroppingPoint;
  final String resultIndex;
  final String traceId;
  final String sourceCity;
  final String destinationCity;
  final String journeyDate;
  final String travelName;
  final String busType;
  final String arrivalTime;
  final String departureTime;
  final List<Map<String, dynamic>> selectedSeats;

  const BlockSeatPage({
    super.key,
    required this.boardingPointIndex,
    required this.droppingPointIndex,
    required this.selectedBoardingPoint,
    required this.selectedDroppingPoint,
    required this.resultIndex,
    required this.traceId,
    required this.sourceCity,
    required this.destinationCity,
    required this.journeyDate,
    required this.travelName,
    required this.busType,
    required this.arrivalTime,
    required this.departureTime,
    required this.selectedSeats,
  });

  @override
  _BlockSeatPageState createState() => _BlockSeatPageState();
}

class _BlockSeatPageState extends State<BlockSeatPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _errorMessage = "";
  bool _isSeatBlocked = false;
  List<Map<String, dynamic>> _savedPassengers = [];
  List<Map<String, dynamic>> _passengerForms = [];

  @override
  void initState() {
    super.initState();
    _initializePassengerForms();
    _fetchSavedPassengers();
  }

  void _initializePassengerForms() {
    _passengerForms = widget.selectedSeats.map((seat) {
      return {
        'seat': seat,
        'firstName': '',
        'lastName': '',
        'age': '',
        'gender': null,
        'phone': '',
        'email': '',
        'address': '',
        'isUsingSavedPassenger': false,
        'savedPassengerId': null,
      };
    }).toList();
  }

  void _fetchSavedPassengers() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('customers')
        .doc(currentUser.uid)
        .collection('passengers')
        .get();

    setState(() {
      _savedPassengers = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          ...data,
          'id': doc.id,
        };
      }).toList();
    });
  }

  void _onSavedPassengerSelected(int passengerIndex, Map<String, dynamic> passenger) {
    setState(() {
      _passengerForms[passengerIndex] = {
        ..._passengerForms[passengerIndex],
        'firstName': passenger['FirstName'] ?? '',
        'lastName': passenger['LastName'] ?? '',
        'age': passenger['Age'] ?? '',
        'gender': passenger['Gender'] == "1" ? "Male" : "Female",
        'phone': passenger['Phoneno'] ?? '',
        'email': passenger['Email'] ?? '',
        'address': passenger['Address'] ?? '',
        'isUsingSavedPassenger': true,
        'savedPassengerId': passenger['id'],
      };
    });
  }

  void _clearPassengerForm(int index) {
    setState(() {
      _passengerForms[index] = {
        'seat': _passengerForms[index]['seat'],
        'firstName': '',
        'lastName': '',
        'age': '',
        'gender': null,
        'phone': '',
        'email': '',
        'address': '',
        'isUsingSavedPassenger': false,
        'savedPassengerId': null,
      };
    });
  }

  bool _validateForms() {
    // Check for empty fields in all forms
    for (var form in _passengerForms) {
      if (form['firstName'].isEmpty ||
          form['lastName'].isEmpty ||
          form['age'].isEmpty ||
          form['gender'] == null ||
          form['phone'].isEmpty ||
          form['email'].isEmpty ||
          form['address'].isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please fill all details for all passengers"),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }

    // Check for duplicate phone numbers
    final phoneNumbers = _passengerForms.map((p) => p['phone'].toString().trim()).toList();
    final uniquePhoneNumbers = phoneNumbers.toSet();
    if (phoneNumbers.length != uniquePhoneNumbers.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Each passenger must have a unique phone number"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Check for duplicate emails
    final emails = _passengerForms.map((p) => p['email'].toString().trim().toLowerCase()).toList();
    final uniqueEmails = emails.toSet();
    if (emails.length != uniqueEmails.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Each passenger must have a unique email address"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Validate email formats
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    for (var email in emails) {
      if (!emailRegex.hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter valid email addresses for all passengers"),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }

    // Validate phone number formats (basic validation)
    for (var phone in phoneNumbers) {
      if (phone.length < 10 || !RegExp(r'^[0-9]+$').hasMatch(phone)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter valid phone numbers for all passengers (minimum 10 digits)"),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }

    return true;
  }

  Future<void> _blockSeat() async {
    if (!_validateForms()) {
      return;
    }

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      setState(() {
        _errorMessage = "User not logged in.";
      });
      return;
    }
    final String customerId = currentUser.uid;

    // Create passenger data for each selected seat
    List<Map<String, dynamic>> passengersData = _passengerForms.map((form) {
      return {
        "LeadPassenger": _passengerForms.indexOf(form) == 0, // First passenger is lead
        "PassengerId": DateTime.now().millisecondsSinceEpoch + _passengerForms.indexOf(form),
        "Title": "Mr",
        "FirstName": form['firstName'],
        "LastName": form['lastName'],
        "Email": form['email'],
        "Phoneno": form['phone'],
        "Gender": form['gender'] == "Male" ? "1" : "2",
        "IdType": null,
        "IdNumber": null,
        "Address": form['address'],
        "Age": form['age'],
        "Seat": {
          "ColumnNo": form['seat']['ColumnNo'],
          "Height": form['seat']['Height'],
          "IsLadiesSeat": form['seat']['IsLadiesSeat'],
          "IsMalesSeat": form['seat']['IsMalesSeat'],
          "IsUpper": form['seat']['IsUpper'],
          "RowNo": form['seat']['RowNo'],
          "SeatFare": form['seat']['SeatFare'],
          "SeatIndex": form['seat']['SeatIndex'],
          "SeatName": form['seat']['SeatName'],
          "SeatStatus": form['seat']['SeatStatus'],
          "SeatType": form['seat']['SeatType'],
          "Width": form['seat']['Width'],
          "Price": form['seat']['Price'] ?? {
            "CurrencyCode": "INR",
            "BasePrice": form['seat']['SeatFare'],
            "Tax": 0,
            "OtherCharges": 0,
            "Discount": 0,
            "PublishedPrice": form['seat']['SeatFare'],
            "PublishedPriceRoundedOff": form['seat']['SeatFare'],
            "OfferedPrice": form['seat']['SeatFare'],
            "OfferedPriceRoundedOff": form['seat']['SeatFare'],
            "AgentCommission": 0,
            "AgentMarkUp": 0,
            "TDS": 0,
            "GST": {
              "CGSTAmount": 0,
              "CGSTRate": 0,
              "CessAmount": 0,
              "CessRate": 0,
              "IGSTAmount": 0,
              "IGSTRate": 0,
              "SGSTAmount": 0,
              "SGSTRate": 0,
              "TaxableAmount": form['seat']['SeatFare'],
            }
          }
        }
      };
    }).toList();

    // Save new passengers to Firestore (only those not using saved passengers)
    try {
      final passengersRef = FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .collection('passengers');

      // First get the current count of saved passengers
      final currentPassengers = await passengersRef.get();
      final currentCount = currentPassengers.size;
      const maxPassengers = 6;

      // Calculate how many new passengers we're adding (those not using saved passengers)
      final newPassengersCount = passengersData
          .asMap()
          .entries
          .where((entry) => !_passengerForms[entry.key]['isUsingSavedPassenger'])
          .length;

      // Calculate total passengers after adding new ones
      final totalPassengersAfterAdd = currentCount + newPassengersCount;

      final batch = FirebaseFirestore.instance.batch();

      // If we'll exceed the limit, delete enough to stay at maxPassengers
      if (totalPassengersAfterAdd > maxPassengers) {
        // Calculate how many to delete (bring us down to maxPassengers - newPassengersCount)
        final passengersToDelete = totalPassengersAfterAdd - maxPassengers;

        // Get oldest passengers to delete
        final oldestPassengers = await passengersRef
            .orderBy('createdAt')
            .limit(passengersToDelete)
            .get();

        for (final doc in oldestPassengers.docs) {
          batch.delete(doc.reference);
        }
      }

      // Add new passengers (only those not using saved passengers)
      // But only if we have room (currentCount - deleted + new <= maxPassengers)
      final remainingCapacity = maxPassengers - (currentCount - (totalPassengersAfterAdd > maxPassengers ? (totalPassengersAfterAdd - maxPassengers) : 0));

          if (remainingCapacity > 0) {
        int addedCount = 0;
        for (var i = 0; i < passengersData.length && addedCount < remainingCapacity; i++) {
          if (!_passengerForms[i]['isUsingSavedPassenger']) {
            batch.set(passengersRef.doc(), {
              "FirstName": passengersData[i]["FirstName"],
              "LastName": passengersData[i]["LastName"],
              "Email": passengersData[i]["Email"],
              "Phoneno": passengersData[i]["Phoneno"],
              "Gender": passengersData[i]["Gender"],
              "Address": passengersData[i]["Address"],
              "Age": passengersData[i]["Age"],
              "createdAt": FieldValue.serverTimestamp(),
            });
            addedCount++;
          }
        }
      }

      await batch.commit();
      print("Passengers saved to Firestore (strict 6-passenger limit enforced)");
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to save passengers: $e";
      });
      print("Firestore Error: $e");
      return;
    }

    // API Call to Block Seats
    const String apiUrl = "http://65.0.115.185/bus-api/Block";
    final Map<String, dynamic> requestBody = {
      "ClientId": "180187",
      "UserName": "Namma434",
      "Password": "Namma@4341",
      "ResultIndex": widget.resultIndex,
      "TraceId": widget.traceId,
      "BoardingPointId": widget.boardingPointIndex,
      "DroppingPointId": widget.droppingPointIndex,
      "RefID": "1",
      "Passenger": passengersData,
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

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['Result'] != null) {
          setState(() {
            _isSeatBlocked = true;
          });

          // Navigate to Booking Page with all selected seats
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookSeat(
                resultIndex: widget.resultIndex,
                traceId: widget.traceId,
                sourceCity: widget.sourceCity,
                destinationCity: widget.destinationCity,
                boardingPointIndex: widget.boardingPointIndex,
                droppingPointIndex: widget.droppingPointIndex,
                selectedBoardingPoint: widget.selectedBoardingPoint,
                selectedDroppingPoint: widget.selectedDroppingPoint,
                journeyDate: widget.journeyDate,
                travelName: widget.travelName,
                busType: widget.busType,
                arrivalTime: widget.arrivalTime,
                departureTime: widget.departureTime,
                selectedSeats: widget.selectedSeats,
                // Passenger Data (for lead passenger)
                leadPassenger: passengersData[0]["LeadPassenger"],
                passengerId: passengersData[0]["PassengerId"],
                title: passengersData[0]["Title"],
                firstName: passengersData[0]["FirstName"],
                lastName: passengersData[0]["LastName"],
                email: passengersData[0]["Email"],
                phoneno: passengersData[0]["Phoneno"],
                gender: passengersData[0]["Gender"],
                idType: passengersData[0]["IdType"],
                idNumber: passengersData[0]["IdNumber"],
                address: passengersData[0]["Address"],
                age: passengersData[0]["Age"],
                passengers: passengersData,

                                onNavigateToHome: () {
                  Navigator.popUntil(context, (route) => route.isFirst); // Go back to HomePage
                  // Optional: If HomePage is stateful, find a way to call _onItemTapped(0)
                },
              ),
            ),
          );

          // Unblock Seats After 5 Minutes
          Future.delayed(const Duration(minutes: 5), () {
            setState(() {
              _isSeatBlocked = false;
            });
          });
        } else {
          final errorMessage = responseData['Error']?['ErrorMessage'] ?? "Failed to block seats. Please try again.";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
          );
        }
      } else {
        final errorMessage = responseData['Error']?['ErrorMessage'] ?? "Failed to block seats. Status code: ${response.statusCode}";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e"), backgroundColor: Colors.red),
      );
      print("Exception: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Passenger Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  "${widget.sourceCity} -> ${widget.destinationCity}",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                // SizedBox(height: 4),
                // Text(
                //   "Selected Seats: ${widget.selectedSeats.map((s) => s['SeatName']).join(', ')}",
                //   style: TextStyle(fontSize: 12, color: Colors.white),
                // ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.redAccent.shade700,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Passenger Forms for each seat
              ..._passengerForms.asMap().entries.map((entry) {
                final index = entry.key;
                final form = entry.value;
                final seat = form['seat'];

                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Seat ${seat['SeatName']}",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            if (form['isUsingSavedPassenger'])
                              Chip(
                                label: const Text("Saved Passenger"),
                                backgroundColor: Colors.green[100],
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Saved Passenger Selection
                        if (!form['isUsingSavedPassenger'] && _savedPassengers.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Select from saved passengers:", style: TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _savedPassengers.map((passenger) {
                                  return ChoiceChip(
                                    label: Text("${passenger['FirstName']} ${passenger['LastName']}"),
                                    selected: false,
                                    onSelected: (_) => _onSavedPassengerSelected(index, passenger),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 16),
                              const Divider(),
                            ],
                          ),

                        // Passenger Form
                        _buildTextField(
                          index,
                          'firstName',
                          form['firstName'],
                          "First Name",
                          Icons.person,
                              (value) => setState(() => _passengerForms[index]['firstName'] = value),
                        ),
                        _buildTextField(
                          index,
                          'lastName',
                          form['lastName'],
                          "Last Name",
                          Icons.person_outline,
                              (value) => setState(() => _passengerForms[index]['lastName'] = value),
                        ),
                        _buildTextField(
                          index,
                          'age',
                          form['age'],
                          "Age",
                          Icons.cake,
                              (value) => setState(() => _passengerForms[index]['age'] = value),
                          TextInputType.number,
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: form['gender'],
                          decoration: InputDecoration(
                            labelText: "Gender",
                            prefixIcon: const Icon(Icons.wc, color: Colors.redAccent),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          items: ["Male", "Female"]
                              .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                              .toList(),
                          onChanged: (value) => setState(() => _passengerForms[index]['gender'] = value),
                          validator: (value) => value == null ? "Gender is required" : null,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          index,
                          'phone',
                          form['phone'],
                          "Phone Number",
                          Icons.phone,
                              (value) => setState(() => _passengerForms[index]['phone'] = value),
                          TextInputType.phone,
                        ),
                        _buildTextField(
                          index,
                          'email',
                          form['email'],
                          "Email",
                          Icons.email,
                              (value) => setState(() => _passengerForms[index]['email'] = value),
                          TextInputType.emailAddress,
                        ),
                        _buildTextField(
                          index,
                          'address',
                          form['address'],
                          "State",
                          Icons.home,
                              (value) => setState(() => _passengerForms[index]['address'] = value),
                        ),

                        // Clear button if using saved passenger
                        if (form['isUsingSavedPassenger'])
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => _clearPassengerForm(index),
                              child: const Text("Clear Saved Passenger", style: TextStyle(color: Colors.red)),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Book Seats Button
              ElevatedButton(
                onPressed: _isLoading || _isSeatBlocked ? null : _blockSeat,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isSeatBlocked ? Colors.green : Colors.redAccent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                  _isSeatBlocked ? "Seats Booked" : "Book ${widget.selectedSeats.length} Seats",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(_errorMessage, style: const TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      int passengerIndex,
      String fieldKey,
      String value,
      String label,
      IconData icon,
      Function(String) onChanged, [
        TextInputType keyboardType = TextInputType.text,
      ]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: value,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.redAccent),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onChanged: onChanged,
        validator: (value) => value!.isEmpty ? "$label is required" : null,
      ),
    );
  }
}









