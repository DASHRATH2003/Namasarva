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


import 'dart:convert';
import 'dart:async'; // For Future.delayed
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

  final int cgstAmount;
  final int cgstRate;
  final int cessAmount;
  final int cessRate;
  final int igstAmount;
  final int igstRate;
  final int sgstAmount;
  final int sgstRate;
  final int taxableAmount;

  const BlockSeatPage({
    Key? key,
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
    required this.taxableAmount,
  }) : super(key: key);

  @override
  _BlockSeatPageState createState() => _BlockSeatPageState();
}
class _BlockSeatPageState extends State<BlockSeatPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _errorMessage = "";

  // Passenger details
  final List<Map<String, dynamic>> _passengers = [];
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();


  String? _selectedGender;
  bool _isSeatBlocked = false; // Track the seat status
  Future<void> _blockSeat() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    print("Mobile Number: ${_phoneController.text.trim()}");

    // Get logged-in user
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      setState(() {
        _errorMessage = "User not logged in.";
      });
      return;
    }
    final String customerId = currentUser.uid;

    // Passenger Data
    Map<String, dynamic> passengerData = {
      "LeadPassenger": true,
      "PassengerId": DateTime.now().millisecondsSinceEpoch, // Unique ID
      "Title": "Mr",
      "FirstName": _firstNameController.text.trim(),
      "LastName": _lastNameController.text.trim(),
      "Email": _emailController.text.trim(),
      "Phoneno": _phoneController.text.trim(),
      "Gender": _selectedGender == "Male" ? "1" : "2",
      "IdType": null,
      "IdNumber": null,
      "Address": _addressController.text.trim(),
      "Age": _ageController.text.trim(),
      "Seat": {
        "ColumnNo": widget.columnNo,
        "Height": widget.height,
        "IsLadiesSeat": widget.isLadiesSeat,
        "IsMalesSeat": widget.isMalesSeat,
        "IsUpper": widget.isUpper,
        "RowNo": widget.rowNo,
        "SeatFare": widget.seatFare,
        "SeatIndex": widget.seatIndex,
        "SeatName": widget.seatName,
        "SeatStatus": widget.seatStatus,
        "SeatType": widget.seatType,
        "Width": widget.width,
        "Price": {
          "CurrencyCode": widget.currencyCode,
          "BasePrice": widget.basePrice,
          "Tax": widget.tax,
          "OtherCharges": widget.otherCharges,
          "Discount": widget.discount,
          "PublishedPrice": widget.publishedPrice,
          "PublishedPriceRoundedOff": widget.publishedPriceRoundedOff,
          "OfferedPrice": widget.offeredPrice,
          "OfferedPriceRoundedOff": widget.offeredPriceRoundedOff,
          "AgentCommission": widget.agentCommission,
          "AgentMarkUp": widget.agentMarkUp,
          "TDS": widget.tds,
          "GST": {
            "CGSTAmount": widget.cgstAmount,
            "CGSTRate": widget.cgstRate,
            "CessAmount": widget.cessAmount,
            "CessRate": widget.cessRate,
            "IGSTAmount": widget.igstAmount,
            "IGSTRate": widget.igstRate,
            "SGSTAmount": widget.sgstAmount,
            "SGSTRate": widget.sgstRate,
            "TaxableAmount": widget.taxableAmount,
          }
        }
      }
    };

    // Save Passenger to Firestore
    try {
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .collection('passengers')
          .add(passengerData);

      print("Passenger details saved to Firestore");
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to save passenger: $e";
      });
      print("Firestore Error: $e");
      return;
    }

    // API Call to Block Seat
    // const String apiUrl = "https://bus.srdvapi.com/v5/rest/Block";
    const String apiUrl = "http://3.7.121.234/bus-api/Block";
    final Map<String, dynamic> requestBody = {
      "ClientId": "180187",
      "UserName": "Namma434",
      "Password": "Namma@4341",
      "ResultIndex": widget.resultIndex,
      "TraceId": widget.traceId,
      "BoardingPointId": widget.boardingPointIndex,
      "DroppingPointId": widget.droppingPointIndex,
      "RefID": "1",
      "Passenger": [passengerData], // Send Passenger Data
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

      if (response.statusCode == 200) {
        setState(() {
          _isSeatBlocked = true;
        });

        // Navigate to Booking Page
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

              columnNo: widget.columnNo,
              height: widget.height,
              isLadiesSeat: widget.isLadiesSeat,
              isMalesSeat: widget.isMalesSeat,
              isUpper: widget.isUpper,
              rowNo: widget.rowNo,
              seatFare: widget.seatFare,
              seatIndex: widget.seatIndex,
              seatName: widget.seatName,
              seatStatus: widget.seatStatus,
              seatType: widget.seatType,
              width: widget.width,

              currencyCode: widget.currencyCode,
              basePrice: widget.basePrice,
              tax: widget.tax,
              otherCharges: widget.otherCharges,
              discount: widget.discount,
              publishedPrice: widget.publishedPrice,
              publishedPriceRoundedOff: widget.publishedPriceRoundedOff,
              offeredPrice: widget.offeredPrice,
              offeredPriceRoundedOff: widget.offeredPriceRoundedOff,
              agentCommission: widget.agentCommission,
              agentMarkUp: widget.agentMarkUp,
              tds: widget.tds,
              cgstAmount: widget.cgstAmount,
              cgstRate: widget.cgstRate,
              cessAmount: widget.cessAmount,
              cessRate: widget.cessRate,
              igstAmount: widget.igstAmount,
              igstRate: widget.igstRate,
              sgstAmount: widget.sgstAmount,
              sgstRate: widget.sgstRate,
              taxableAmount: widget.taxableAmount,
              // Passenger Data
              leadPassenger: passengerData["LeadPassenger"],
              passengerId: passengerData["PassengerId"],
              title: passengerData["Title"],
              firstName: passengerData["FirstName"],
              lastName: passengerData["LastName"],
              email: passengerData["Email"],
              phoneno: passengerData["Phoneno"],
              gender: passengerData["Gender"],
              idType: passengerData["IdType"],
              idNumber: passengerData["IdNumber"],
              address: passengerData["Address"],
              age: passengerData["Age"],
            ),
          ),
        );

        // Unblock Seat After 5 Minutes
        Future.delayed(Duration(minutes: 5), () {
          setState(() {
            _isSeatBlocked = false;
          });
        });

      } else {
        setState(() {
          _errorMessage = "Failed to block seat.";
        });
        print("Error: ${response.body}");
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred: $e";
      });
      print("Exception: $e");
    }
  }
  List<Map<String, dynamic>> _savedPassengers = [];

  @override
  void initState() {
    super.initState();
    _fetchSavedPassengers();
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
      _savedPassengers = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Align text to the center
              children: [
                Text(
                  "Passenger Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 4), // Adds some spacing
                Text(
                  "${widget.sourceCity} -> ${widget.destinationCity}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.redAccent.shade700,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container for First Name, Last Name, Age, and Gender
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Passenger Details",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      _buildTextField(_firstNameController, "First Name", Icons.person),
                      _buildTextField(_lastNameController, "Last Name", Icons.person_outline),
                      _buildTextField(_ageController, "Age", Icons.cake, TextInputType.number),
                      SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _selectedGender,
                        decoration: InputDecoration(
                          labelText: "Gender",
                          prefixIcon: Icon(Icons.wc, color: Colors.redAccent),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        items: ["Male", "Female"]
                            .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                            .toList(),
                        onChanged: (value) => setState(() => _selectedGender = value),
                        validator: (value) => value == null ? "Gender is required" : null,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Container for Mobile Number, Email, and Address
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Contact Details",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      _buildTextField(_phoneController, "Phone Number", Icons.phone, TextInputType.phone),
                      _buildTextField(_emailController, "Email", Icons.email, TextInputType.emailAddress),
                      _buildTextField(_addressController, "State", Icons.home),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Saved Passengers Section
              Text(
                "Saved Passengers",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 10),
              ..._savedPassengers.map((passenger) => Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 4,
                child: ListTile(
                  title: Text("${passenger['FirstName']} ${passenger['LastName']}",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(passenger['Phoneno']!, style: TextStyle(color: Colors.black54)),
                  leading: Icon(Icons.account_circle, color: Colors.blueAccent, size: 40),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                  onTap: () {
                    setState(() {
                      _firstNameController.text = passenger['FirstName']!;
                      _lastNameController.text = passenger['LastName']!;
                      _phoneController.text = passenger['Phoneno']!;
                      _emailController.text = passenger['Email']!;
                      _addressController.text = passenger['Address']!;
                      _ageController.text = passenger['Age']!;
                      _selectedGender = passenger['Gender'] == "1" ? "Male" : "Female";
                    });
                  },
                ),
              )),
              SizedBox(height: 20),

              // Book Seat Button
              ElevatedButton(
                onPressed: _isLoading || _isSeatBlocked ? null : _blockSeat,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isSeatBlocked ? Colors.green : Colors.redAccent,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                  _isSeatBlocked ? "Seat Booked" : "Book Seat",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(_errorMessage, style: TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField(TextEditingController controller, String label, IconData icon, [TextInputType keyboardType = TextInputType.text]) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.redAccent),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: (value) => value!.isEmpty ? "$label is required" : null,
    ),
  );
}