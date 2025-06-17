// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BookSeat extends StatelessWidget {
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
//   final dynamic boardingPointIndex;
//   final dynamic droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//
//   final bool leadPassenger;
//   final int passengerId;
//   final String title;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneno;
//   final String gender;
//   final String? idType;
//   final String? idNumber;
//   final String address;
//   final String age;
//
//   const BookSeat({
//     Key? key,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.columnNo,
//     required this.height,
//     required this.isMalesSeat,
//     required this.isLadiesSeat,
//     required this.isUpper,
//     required this.rowNo,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatName,
//     required this.seatStatus,
//     required this.width,
//     required this.seatType,
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
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//
//     required this.leadPassenger,
//     required this.passengerId,
//     required this.firstName,
//     required this.title,
//     required this.lastName,
//     required this.address,
//     required this.email,
//     required this.phoneno,
//     required this.age,
//     required this.gender,
//     required this.idNumber,
//     required this.idType
//   }) : super(key: key);
//
//   Future<void> bookSeat() async {
//     const String apiUrl = "https://bus.srdvapi.com/v5/rest/Book";
//
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": resultIndex,
//       "TraceId": traceId,
//       "BoardingPointId": boardingPointIndex,
//       "DroppingPointId": droppingPointIndex,
//       "RefID": "",
//       "Passenger": [
//         {
//           "LeadPassenger": leadPassenger,
//           "PassengerId": passengerId,
//           "Title": title,
//           "FirstName": firstName,
//           "LastName": lastName,
//           "Email": email,
//           "Phoneno": phoneno,
//           "Gender": gender,
//           "IdType": idType,
//           "IdNumber": idNumber,
//           "Address": address,
//           "Age": age,
//           "Seat": {
//             "ColumnNo": columnNo,
//             "Height": height,
//             "IsLadiesSeat": isLadiesSeat,
//             "IsMalesSeat": isMalesSeat,
//             "IsUpper": isUpper,
//             "RowNo": rowNo,
//             "SeatFare": seatFare,
//             "SeatIndex": seatIndex,
//             "SeatName": seatName,
//             "SeatStatus": seatStatus,
//             "SeatType": seatType,
//             "Width": width,
//             "Price": {
//               "CurrencyCode": currencyCode,
//               "BasePrice": basePrice,
//               "Tax": tax,
//               "OtherCharges": otherCharges,
//               "Discount": discount,
//               "PublishedPrice": publishedPrice,
//               "PublishedPriceRoundedOff": publishedPriceRoundedOff,
//               "OfferedPrice": offeredPrice,
//               "OfferedPriceRoundedOff": offeredPriceRoundedOff,
//               "AgentCommission": agentCommission,
//               "AgentMarkUp": agentMarkUp,
//               "TDS": tds,
//               "GST": {
//                 "CGSTAmount": cgstAmount,
//                 "CGSTRate": cgstRate,
//                 "CessAmount": cessAmount,
//                 "CessRate": cessRate,
//                 "IGSTAmount": igstAmount,
//                 "IGSTRate": igstRate,
//                 "SGSTAmount": sgstAmount,
//                 "SGSTRate": sgstRate,
//                 "TaxableAmount": taxableAmount,
//               },
//             },
//           },
//         }
//       ]
//     };
//
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         print("Booking Successful: ${response.body}");
//       } else {
//         print("Booking Failed: ${response.statusCode}");
//         print("Error: ${response.body}");
//       }
//     } catch (e) {
//       print("An error occurred: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Booking Confirmation"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: bookSeat,
//           child: Text("Confirm Booking"),
//         ),
//       ),
//     );
//   }
// }



//new

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class BookSeat extends StatelessWidget {
//   // Fields (same as in your provided code)
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
//   final dynamic boardingPointIndex;
//   final dynamic droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//
//   final bool leadPassenger;
//   final int passengerId;
//   final String title;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneno;
//   final String gender;
//   final String? idType;
//   final String? idNumber;
//   final String address;
//   final String age;
//
//   const BookSeat({
//     Key? key,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.columnNo,
//     required this.height,
//     required this.isMalesSeat,
//     required this.isLadiesSeat,
//     required this.isUpper,
//     required this.rowNo,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatName,
//     required this.seatStatus,
//     required this.width,
//     required this.seatType,
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
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.leadPassenger,
//     required this.passengerId,
//     required this.firstName,
//     required this.title,
//     required this.lastName,
//     required this.address,
//     required this.email,
//     required this.phoneno,
//     required this.age,
//     required this.gender,
//     required this.idNumber,
//     required this.idType,
//   }) : super(key: key);
//
//   Future<void> bookSeat(BuildContext context) async {
//     const String apiUrl = "https://bus.srdvapi.com/v5/rest/Book";
//
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": resultIndex,
//       "TraceId": traceId,
//       "BoardingPointId": boardingPointIndex,
//       "DroppingPointId": droppingPointIndex,
//       "RefID": "",
//       "Passenger": [
//         {
//           "LeadPassenger": leadPassenger,
//           "PassengerId": passengerId,
//           "Title": title,
//           "FirstName": firstName,
//           "LastName": lastName,
//           "Email": email,
//           "Phoneno": phoneno,
//           "Gender": gender,
//           "IdType": idType,
//           "IdNumber": idNumber,
//           "Address": address,
//           "Age": age,
//           "Seat": {
//             "ColumnNo": columnNo,
//             "Height": height,
//             "IsLadiesSeat": isLadiesSeat,
//             "IsMalesSeat": isMalesSeat,
//             "IsUpper": isUpper,
//             "RowNo": rowNo,
//             "SeatFare": seatFare,
//             "SeatIndex": seatIndex,
//             "SeatName": seatName,
//             "SeatStatus": seatStatus,
//             "SeatType": seatType,
//             "Width": width,
//             "Price": {
//               "CurrencyCode": currencyCode,
//               "BasePrice": basePrice,
//               "Tax": tax,
//               "OtherCharges": otherCharges,
//               "Discount": discount,
//               "PublishedPrice": publishedPrice,
//               "PublishedPriceRoundedOff": publishedPriceRoundedOff,
//               "OfferedPrice": offeredPrice,
//               "OfferedPriceRoundedOff": offeredPriceRoundedOff,
//               "AgentCommission": agentCommission,
//               "AgentMarkUp": agentMarkUp,
//               "TDS": tds,
//               "GST": {
//                 "CGSTAmount": cgstAmount,
//                 "CGSTRate": cgstRate,
//                 "CessAmount": cessAmount,
//                 "CessRate": cessRate,
//                 "IGSTAmount": igstAmount,
//                 "IGSTRate": igstRate,
//                 "SGSTAmount": sgstAmount,
//                 "SGSTRate": sgstRate,
//                 "TaxableAmount": taxableAmount,
//               },
//             },
//           },
//         }
//       ]
//     };
//
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         // Booking successful
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("${response.body}"),
//             backgroundColor: Colors.green,
//           ),
//         );
//         print("${response.body}");
//       } else {
//         // Booking failed
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Booking Failed: ${response.body}"),
//             backgroundColor: Colors.red,
//           ),
//         );
//         print("Booking Failed: ${response.statusCode}");
//         print("Error: ${response.body}");
//       }
//     } catch (e) {
//       // Error occurred
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("An error occurred: $e"),
//           backgroundColor: Colors.red,
//         ),
//       );
//       print("An error occurred: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Booking Confirmation"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => bookSeat(context),
//           child: Text("Confirm Booking"),
//         ),
//       ),
//     );
//   }
// }


//test_good


// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class BookSeat extends StatelessWidget {
//   // Fields (same as in your provided code)
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
//   final dynamic boardingPointIndex;
//   final dynamic droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//
//   final bool leadPassenger;
//   final int passengerId;
//   final String title;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneno;
//   final String gender;
//   final String? idType;
//   final String? idNumber;
//   final String address;
//   final String age;
//
//   const BookSeat({
//     Key? key,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.columnNo,
//     required this.height,
//     required this.isMalesSeat,
//     required this.isLadiesSeat,
//     required this.isUpper,
//     required this.rowNo,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatName,
//     required this.seatStatus,
//     required this.width,
//     required this.seatType,
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
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.leadPassenger,
//     required this.passengerId,
//     required this.firstName,
//     required this.title,
//     required this.lastName,
//     required this.address,
//     required this.email,
//     required this.phoneno,
//     required this.age,
//     required this.gender,
//     required this.idNumber,
//     required this.idType,
//   }) : super(key: key);
//
//   // Future<void> bookSeat(BuildContext context) async {
//   //   const String apiUrl = "https://bus.srdvapi.com/v5/rest/Book";
//   //
//   //   final Map<String, dynamic> requestBody = {
//   //     // The same requestBody as before...
//   //
//   //     "ClientId": "180187",
//   //     "UserName": "Namma434",
//   //     "Password": "Namma@4341",
//   //     "ResultIndex": resultIndex,
//   //     "TraceId": traceId,
//   //     "BoardingPointId": boardingPointIndex,
//   //     "DroppingPointId": droppingPointIndex,
//   //     "RefID": "",
//   //     "Passenger": [
//   //       {
//   //         "LeadPassenger": leadPassenger,
//   //         "PassengerId": passengerId,
//   //         "Title": title,
//   //         "FirstName": firstName,
//   //         "LastName": lastName,
//   //         "Email": email,
//   //         "Phoneno": phoneno,
//   //         "Gender": gender,
//   //         "IdType": idType,
//   //         "IdNumber": idNumber,
//   //         "Address": address,
//   //         "Age": age,
//   //         "Seat": {
//   //           "ColumnNo": columnNo,
//   //           "Height": height,
//   //           "IsLadiesSeat": isLadiesSeat,
//   //           "IsMalesSeat": isMalesSeat,
//   //           "IsUpper": isUpper,
//   //           "RowNo": rowNo,
//   //           "SeatFare": seatFare,
//   //           "SeatIndex": seatIndex,
//   //           "SeatName": seatName,
//   //           "SeatStatus": seatStatus,
//   //           "SeatType": seatType,
//   //           "Width": width,
//   //           "Price": {
//   //             "CurrencyCode": currencyCode,
//   //             "BasePrice": basePrice,
//   //             "Tax": tax,
//   //             "OtherCharges": otherCharges,
//   //             "Discount": discount,
//   //             "PublishedPrice": publishedPrice,
//   //             "PublishedPriceRoundedOff": publishedPriceRoundedOff,
//   //             "OfferedPrice": offeredPrice,
//   //             "OfferedPriceRoundedOff": offeredPriceRoundedOff,
//   //             "AgentCommission": agentCommission,
//   //             "AgentMarkUp": agentMarkUp,
//   //             "TDS": tds,
//   //             "GST": {
//   //               "CGSTAmount": cgstAmount,
//   //               "CGSTRate": cgstRate,
//   //               "CessAmount": cessAmount,
//   //               "CessRate": cessRate,
//   //               "IGSTAmount": igstAmount,
//   //               "IGSTRate": igstRate,
//   //               "SGSTAmount": sgstAmount,
//   //               "SGSTRate": sgstRate,
//   //               "TaxableAmount": taxableAmount,
//   //             },
//   //           },
//   //         },
//   //       }
//   //     ]
//   //   };
//   //
//   //   const headers = {
//   //     "Content-Type": "application/json",
//   //     "Api-Token": "Namma@90434#34",
//   //   };
//   //
//   //   try {
//   //     final response = await http.post(
//   //       Uri.parse(apiUrl),
//   //       headers: headers,
//   //       body: jsonEncode(requestBody),
//   //     );
//   //
//   //     if (response.statusCode == 200) {
//   //       // Booking successful, Parse the response
//   //       final responseData = jsonDecode(response.body);
//   //
//   //       // Extract details from response
//   //       final busBookingStatus = responseData['BusBookingStatus'];
//   //       final invoiceAmount = responseData['InvoiceAmount'];
//   //       final busId = responseData['BusId'];
//   //       final ticketNo = responseData['TicketNo'];
//   //       final travelOperatorPNR = responseData['TravelOperatorPNR'];
//   //
//   //       // Assuming 'customerId' is the ID of the logged-in customer
//   //       final String customerId = "customerId"; // Replace this with the actual customer ID if you have it
//   //
//   //       // Store the booking details in Firestore
//   //       final userDocRef = FirebaseFirestore.instance
//   //           .collection('customers')
//   //           .doc(customerId)
//   //           .collection('bookings')
//   //           .add({
//   //         'BusBookingStatus': busBookingStatus,
//   //         'InvoiceAmount': invoiceAmount,
//   //         'BusId': busId,
//   //         'TicketNo': ticketNo,
//   //         'TravelOperatorPNR': travelOperatorPNR,
//   //         'BookingTime': FieldValue.serverTimestamp(), // Add timestamp for reference
//   //       });
//   //
//   //       // Print the response in the console
//   //       print("Booking Successful:");
//   //       print("BusBookingStatus: $busBookingStatus");
//   //       print("InvoiceAmount: $invoiceAmount");
//   //       print("BusId: $busId");
//   //       print("TicketNo: $ticketNo");
//   //       print("TravelOperatorPNR: $travelOperatorPNR");
//   //
//   //       // Show success message
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text("Booking Successful: $ticketNo"),
//   //           backgroundColor: Colors.green,
//   //         ),
//   //       );
//   //     } else {
//   //       // Booking failed
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text("Booking Failed: ${response.body}"),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //       print("Booking Failed: ${response.statusCode}");
//   //       print("Error: ${response.body}");
//   //     }
//   //   } catch (e) {
//   //     // Error occurred
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text("An error occurred: $e"),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );
//   //     print("An error occurred: $e");
//   //   }
//   // }
//
//   Future<void> bookSeat(BuildContext context) async {
//     // const String apiUrl = "https://bus.srdvapi.com/v5/rest/Book";
//     const String apiUrl = "http://3.7.121.234/bus-api/Book";
//
//
//     final Map<String, dynamic> requestBody = {
//       // The same requestBody as before...
//
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": resultIndex,
//       "TraceId": traceId,
//       "BoardingPointId": boardingPointIndex,
//       "DroppingPointId": droppingPointIndex,
//       "RefID": "",
//       "Passenger": [
//         {
//           "LeadPassenger": leadPassenger,
//           "PassengerId": passengerId,
//           "Title": title,
//           "FirstName": firstName,
//           "LastName": lastName,
//           "Email": email,
//           "Phoneno": phoneno,
//           "Gender": gender,
//           "IdType": idType,
//           "IdNumber": idNumber,
//           "Address": address,
//           "Age": age,
//           "Seat": {
//             "ColumnNo": columnNo,
//             "Height": height,
//             "IsLadiesSeat": isLadiesSeat,
//             "IsMalesSeat": isMalesSeat,
//             "IsUpper": isUpper,
//             "RowNo": rowNo,
//             "SeatFare": seatFare,
//             "SeatIndex": seatIndex,
//             "SeatName": seatName,
//             "SeatStatus": seatStatus,
//             "SeatType": seatType,
//             "Width": width,
//             "Price": {
//               "CurrencyCode": currencyCode,
//               "BasePrice": basePrice,
//               "Tax": tax,
//               "OtherCharges": otherCharges,
//               "Discount": discount,
//               "PublishedPrice": publishedPrice,
//               "PublishedPriceRoundedOff": publishedPriceRoundedOff,
//               "OfferedPrice": offeredPrice,
//               "OfferedPriceRoundedOff": offeredPriceRoundedOff,
//               "AgentCommission": agentCommission,
//               "AgentMarkUp": agentMarkUp,
//               "TDS": tds,
//               "GST": {
//                 "CGSTAmount": cgstAmount,
//                 "CGSTRate": cgstRate,
//                 "CessAmount": cessAmount,
//                 "CessRate": cessRate,
//                 "IGSTAmount": igstAmount,
//                 "IGSTRate": igstRate,
//                 "SGSTAmount": sgstAmount,
//                 "SGSTRate": sgstRate,
//                 "TaxableAmount": taxableAmount,
//               },
//             },
//           },
//         }
//       ]
//     };
//
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//       print("Booking Failed: ${response.statusCode}");
//       print("Error: ${response.body}");
//       print("Booking Successful:1");
//
//
//       if (response.statusCode == 200) {
//         // Booking successful, Parse the response
//         final responseData = jsonDecode(response.body);
//
//         // Extract details from response
//         final BusBookingStatus = responseData['BusBookingStatus'];
//         final InvoiceAmount = responseData['InvoiceAmount'];
//         final BusId = responseData['BusId'];
//         final TicketNo = responseData['TicketNo'];
//         final TravelOperatorPNR = responseData['TravelOperatorPNR'];
//
//         // Get the current user from Firebase Authentication
//         final currentUser = FirebaseAuth.instance.currentUser;
//         if (currentUser == null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text("User not logged in"),
//               backgroundColor: Colors.red,
//             ),
//           );
//           return; // Exit the method if the user is not logged in
//         }
//
//         final String customerId = currentUser.uid;
//
//         // Store the booking details in Firestore under the logged-in user's document
//         final userDocRef = FirebaseFirestore.instance
//             .collection('customers')
//             .doc(customerId)
//             .collection('bookings')
//             .add({
//           'BusBookingStatus': BusBookingStatus,
//           'InvoiceAmount': InvoiceAmount,
//           'BusId': BusId,
//           'TicketNo': TicketNo,
//           'TravelOperatorPNR': TravelOperatorPNR,
//           'BookingTime': FieldValue.serverTimestamp(), // Add timestamp for reference
//         });
//
//         // Print the response in the console
//         print("Booking Successful:2");
//         print("BusBookingStatus: $BusBookingStatus");
//         print("InvoiceAmount: $InvoiceAmount");
//         print("BusId: $BusId");
//         print("TicketNo: $TicketNo");
//         print("TravelOperatorPNR: $TravelOperatorPNR");
//
//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Booking Successful: $TicketNo"),
//             backgroundColor: Colors.green,
//           ),
//         );
//       } else {
//         // Booking failed
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Booking Failed: ${response.body}"),
//             backgroundColor: Colors.red,
//           ),
//         );
//         print("Booking Failed: ${response.statusCode}");
//         print("Error: ${response.body}");
//       }
//     } catch (e) {
//       // Error occurred
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("An error occurred: $e"),
//           backgroundColor: Colors.red,
//         ),
//       );
//       print("An error occurred: $e");
//     }
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Booking Confirmation"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => bookSeat(context),
//           child: Text("Confirm Booking"),
//         ),
//       ),
//     );
//   }
// }

// response not printing ofter integrated razorpay wrongly


// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class BookSeat extends StatefulWidget {
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
//   final dynamic boardingPointIndex;
//   final dynamic droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//
//   final bool leadPassenger;
//   final int passengerId;
//   final String title;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneno;
//   final String gender;
//   final String? idType;
//   final String? idNumber;
//   final String address;
//   final String age;
//
//   const BookSeat({
//     Key? key,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.columnNo,
//     required this.height,
//     required this.isMalesSeat,
//     required this.isLadiesSeat,
//     required this.isUpper,
//     required this.rowNo,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatName,
//     required this.seatStatus,
//     required this.width,
//     required this.seatType,
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
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.leadPassenger,
//     required this.passengerId,
//     required this.firstName,
//     required this.title,
//     required this.lastName,
//     required this.address,
//     required this.email,
//     required this.phoneno,
//     required this.age,
//     required this.gender,
//     required this.idNumber,
//     required this.idType,
//   }) : super(key: key);
//
//   @override
//   _BookSeatState createState() => _BookSeatState();
// }
//
// class _BookSeatState extends State<BookSeat> {
//   late Razorpay _razorpay;
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text("Payment Successful! ID: ${response.paymentId}"),
//         backgroundColor: Colors.green,
//       ),
//     );
//     bookSeat(context); // Call bookSeat after successful payment
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text("Payment Failed: ${response.message}"),
//         backgroundColor: Colors.redAccent.shade700,
//       ),
//     );
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text("External Wallet Selected: ${response.walletName}"),
//       ),
//     );
//   }
//
//   void _startPayment() {
//     var options = {
//       // 'key': 'rzp_test_0JqfNU3fC2HG7Z', // Replace with your Razorpay API Key
//       'key': 'rzp_live_jRrlgHE9Hldmk5', // Replace with your Razorpay API Key
//       'amount': (widget.publishedPriceRoundedOff * 100), // Amount in paise
//       'name': 'Namma Savaari',
//       'description': 'Bus Ticket Booking',
//       'prefill': {
//         'contact': widget.phoneno,
//         'email': widget.email,
//       },
//       'theme': {'color': '#D32F2F'},
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   Future<void> bookSeat(BuildContext context) async {
//     const String apiUrl = "http://3.7.121.234/bus-api/Book";
//
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "Passenger": [
//         {
//           "FirstName": widget.firstName,
//           "LastName": widget.lastName,
//           "Email": widget.email,
//           "Phoneno": widget.phoneno,
//           "Seat": {"SeatName": widget.seatName}
//         }
//       ]
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(requestBody),
//       );
//       print("Booking Failed: ${response.statusCode}");
//       print("Error: ${response.body}");
//       print("Booking Successful:1");
//
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Booking Successful!"), backgroundColor: Colors.green),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Booking Failed: ${response.body}"), backgroundColor: Colors.redAccent.shade700),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("An error occurred: $e"), backgroundColor: Colors.redAccent.shade700),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Booking Confirmation")),
//       body: Center(
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.redAccent.shade700,
//           ),
//           onPressed: _startPayment, // Start payment before booking
//           child: Text("Confirm Booking",style: TextStyle(color: Colors.white),),
//         ),
//       ),
//     );
//   }
// }


// correcting night suck

//
// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class BookSeat extends StatefulWidget {
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
//   final dynamic boardingPointIndex;
//   final dynamic droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//
//   final bool leadPassenger;
//   final int passengerId;
//   final String title;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneno;
//   final String gender;
//   final String? idType;
//   final String? idNumber;
//   final String address;
//   final String age;
//
//   const BookSeat({
//     Key? key,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.columnNo,
//     required this.height,
//     required this.isMalesSeat,
//     required this.isLadiesSeat,
//     required this.isUpper,
//     required this.rowNo,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatName,
//     required this.seatStatus,
//     required this.width,
//     required this.seatType,
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
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.leadPassenger,
//     required this.passengerId,
//     required this.firstName,
//     required this.title,
//     required this.lastName,
//     required this.address,
//     required this.email,
//     required this.phoneno,
//     required this.age,
//     required this.gender,
//     required this.idNumber,
//     required this.idType,
//   }) : super(key: key);
//
//   @override
//   _BookSeatState createState() => _BookSeatState();
// }
//
// class _BookSeatState extends State<BookSeat> {
//   late Razorpay _razorpay;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     setState(() {
//       _isLoading = true;
//     });
//     bookSeat(context, response.paymentId!);
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     setState(() {
//       _isLoading = false;
//     });
//     _showDialog(
//       title: "Payment Failed",
//       message: "Error: ${response.message ?? 'Unknown error'}",
//       isSuccess: false,
//     );
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     _showDialog(
//       title: "External Wallet Selected",
//       message: "Wallet: ${response.walletName}",
//       isSuccess: true,
//     );
//   }
//
//   void _openCheckout() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       var options = {
//         'key': 'rzp_live_jRrlgHE9Hldmk5',
//         // 'key': 'rzp_test_0JqfNU3fC2HG7Z', // Replace with your Razorpay key
//         'amount': (widget.offeredPrice * 100).toString(), // Convert to paise
//         'name': 'Namma Savaari',
//         'description': 'Bus Ticket: ${widget.travelName}',
//         'prefill': {
//           'contact': widget.phoneno,
//           'email': widget.email,
//         },
//         'theme': {'color': '#FF2291'},
//       };
//
//       _razorpay.open(options);
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showDialog(
//         title: "Error",
//         message: "Failed to open payment gateway: $e",
//         isSuccess: false,
//       );
//     }
//   }
//
//   void _showDialog({required String title, required String message, required bool isSuccess}) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> bookSeat(BuildContext context, String paymentId) async {
//     const String apiUrl = "http://3.7.121.234/bus-api/Book";
//
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": paymentId, // Using Razorpay payment ID as reference
//       "Passenger": [
//         {
//           "LeadPassenger": widget.leadPassenger,
//           "PassengerId": widget.passengerId,
//           "Title": widget.title,
//           "FirstName": widget.firstName,
//           "LastName": widget.lastName,
//           "Email": widget.email,
//           "Phoneno": widget.phoneno,
//           "Gender": widget.gender,
//           "IdType": widget.idType,
//           "IdNumber": widget.idNumber,
//           "Address": widget.address,
//           "Age": widget.age,
//           "Seat": {
//             "ColumnNo": widget.columnNo,
//             "Height": widget.height,
//             "IsLadiesSeat": widget.isLadiesSeat,
//             "IsMalesSeat": widget.isMalesSeat,
//             "IsUpper": widget.isUpper,
//             "RowNo": widget.rowNo,
//             "SeatFare": widget.seatFare,
//             "SeatIndex": widget.seatIndex,
//             "SeatName": widget.seatName,
//             "SeatStatus": widget.seatStatus,
//             "SeatType": widget.seatType,
//             "Width": widget.width,
//             "Price": {
//               "CurrencyCode": widget.currencyCode,
//               "BasePrice": widget.basePrice,
//               "Tax": widget.tax,
//               "OtherCharges": widget.otherCharges,
//               "Discount": widget.discount,
//               "PublishedPrice": widget.publishedPrice,
//               "PublishedPriceRoundedOff": widget.publishedPriceRoundedOff,
//               "OfferedPrice": widget.offeredPrice,
//               "OfferedPriceRoundedOff": widget.offeredPriceRoundedOff,
//               "AgentCommission": widget.agentCommission,
//               "AgentMarkUp": widget.agentMarkUp,
//               "TDS": widget.tds,
//               "GST": {
//                 "CGSTAmount": widget.cgstAmount,
//                 "CGSTRate": widget.cgstRate,
//                 "CessAmount": widget.cessAmount,
//                 "CessRate": widget.cessRate,
//                 "IGSTAmount": widget.igstAmount,
//                 "IGSTRate": widget.igstRate,
//                 "SGSTAmount": widget.sgstAmount,
//                 "SGSTRate": widget.sgstRate,
//                 "TaxableAmount": widget.taxableAmount,
//               },
//             },
//           },
//         }
//       ]
//     };
//
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//
//         if (responseData['Error'] != null) {
//           // API returned an error
//           setState(() {
//             _isLoading = false;
//           });
//           _showDialog(
//             title: "Booking Failed",
//             message: responseData['Error']['ErrorMessage'] ?? 'Unknown error',
//             isSuccess: false,
//           );
//           return;
//         }
//
//         // Booking successful
//         final currentUser = FirebaseAuth.instance.currentUser;
//         if (currentUser != null) {
//           await FirebaseFirestore.instance
//               .collection('customers')
//               .doc(currentUser.uid)
//               .collection('bookings')
//               .add({
//             'BusBookingStatus': responseData['BusBookingStatus'],
//             'InvoiceAmount': responseData['InvoiceAmount'],
//             'BusId': responseData['BusId'],
//             'TicketNo': responseData['TicketNo'],
//             'TravelOperatorPNR': responseData['TravelOperatorPNR'],
//             'PaymentId': paymentId,
//             'BookingTime': FieldValue.serverTimestamp(),
//             'JourneyDetails': {
//               'source': widget.sourceCity,
//               'destination': widget.destinationCity,
//               'date': widget.journeyDate,
//               'travelName': widget.travelName,
//               'seat': widget.seatName,
//             },
//           });
//         }
//
//         setState(() {
//           _isLoading = false;
//         });
//
//         // Show success dialog with booking details
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) => AlertDialog(
//             title: const Text("Booking Successful"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Ticket No: ${responseData['TicketNo']}"),
//                 Text("PNR: ${responseData['TravelOperatorPNR']}"),
//                 const SizedBox(height: 10),
//                 const Text("Details have been sent to your email."),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Close dialog
//                   Navigator.pop(context); // Go back to previous screen
//                 },
//                 child: const Text("OK"),
//               ),
//             ],
//           ),
//         );
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         _showDialog(
//           title: "Booking Failed",
//           message: "Server error: ${response.statusCode}",
//           isSuccess: false,
//         );
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showDialog(
//         title: "Error",
//         message: "An error occurred: $e",
//         isSuccess: false,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Confirm Booking"),
//         backgroundColor: Colors.redAccent.shade700,
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Booking Summary Card
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Journey Details",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               widget.sourceCity,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const Icon(Icons.arrow_forward),
//                             Text(
//                               widget.destinationCity,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Text("${widget.travelName} (${widget.busType})"),
//                         Text("Date: ${widget.journeyDate}"),
//                         Text("Departure: ${widget.departureTime}"),
//                         Text("Arrival: ${widget.arrivalTime}"),
//                         const Divider(height: 24),
//                         const Text(
//                           "Passenger Details",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text("${widget.title} ${widget.firstName} ${widget.lastName}"),
//                         Text("Age: ${widget.age} | Gender: ${widget.gender}"),
//                         Text("Phone: ${widget.phoneno}"),
//                         Text("Email: ${widget.email}"),
//                         const Divider(height: 24),
//                         const Text(
//                           "Seat Details",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text("Seat: ${widget.seatName}"),
//                         Text("Type: ${widget.seatType == 1 ? "Sleeper" : "Seater"}"),
//                         Text("Boarding: ${widget.selectedBoardingPoint}"),
//                         Text("Dropping: ${widget.selectedDroppingPoint}"),
//                         const Divider(height: 24),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Total Amount:",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               "₹${widget.offeredPrice}",
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.redAccent,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: _isLoading ? null : _openCheckout,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.redAccent.shade700,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: _isLoading
//                       ? const SizedBox(
//                     height: 24,
//                     width: 24,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     ),
//                   )
//                       : const Text(
//                     "PROCEED TO PAY",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   "By proceeding, you agree to our Terms and Conditions",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (_isLoading)
//             const Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }
// }




// BACK PRESS ADDED ALERT DIALOGUE BOX


// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class BookSeat extends StatefulWidget {
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
//   final dynamic boardingPointIndex;
//   final dynamic droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//
//   final bool leadPassenger;
//   final int passengerId;
//   final String title;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneno;
//   final String gender;
//   final String? idType;
//   final String? idNumber;
//   final String address;
//   final String age;
//
//   const BookSeat({
//     Key? key,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.columnNo,
//     required this.height,
//     required this.isMalesSeat,
//     required this.isLadiesSeat,
//     required this.isUpper,
//     required this.rowNo,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatName,
//     required this.seatStatus,
//     required this.width,
//     required this.seatType,
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
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.leadPassenger,
//     required this.passengerId,
//     required this.firstName,
//     required this.title,
//     required this.lastName,
//     required this.address,
//     required this.email,
//     required this.phoneno,
//     required this.age,
//     required this.gender,
//     required this.idNumber,
//     required this.idType,
//   }) : super(key: key);
//
//   @override
//   _BookSeatState createState() => _BookSeatState();
// }
//
// class _BookSeatState extends State<BookSeat> {
//   late Razorpay _razorpay;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   ///automatically payment is refunding to customer
//
//   // void _handlePaymentSuccess(PaymentSuccessResponse response) {
//   //   setState(() {
//   //     _isLoading = true;
//   //   });
//   //   bookSeat(context, response.paymentId!);
//   // }
//
//
//   ///automatically payment is refunding to customer Fixed but not tested
//
//   // void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//   //   setState(() {
//   //     _isLoading = true;
//   //   });
//   //
//   //   // Capture the payment
//   //   String apiUrl = "https://api.razorpay.com/v1/payments/${response.paymentId}/capture";
//   //   String key = "rzp_live_jRrlgHE9Hldmk5"; // Replace with your Razorpay Live Key
//   //   String secret = "YOUR_SECRET_KEY"; // Replace with your Razorpay Secret Key
//   //
//   //   var headers = {
//   //     "Authorization": "Basic ${base64Encode(utf8.encode('$key:$secret'))}",
//   //     "Content-Type": "application/json"
//   //   };
//   //
//   //   var body = jsonEncode({
//   //     "amount": widget.offeredPrice * 100, // Convert amount to paise
//   //     "currency": "INR"
//   //   });
//   //
//   //   try {
//   //     var captureResponse = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
//   //
//   //     if (captureResponse.statusCode == 200) {
//   //       print("Payment Captured Successfully");
//   //
//   //       // Now confirm the booking in Firestore
//   //       bookSeat(context, response.paymentId!);
//   //     } else {
//   //       print("Failed to capture payment: ${captureResponse.body}");
//   //       _showDialog(
//   //         title: "Payment Capture Failed",
//   //         message: "Payment was successful but could not be captured. Contact support.",
//   //         isSuccess: false,
//   //       );
//   //     }
//   //   } catch (e) {
//   //     print("Error capturing payment: $e");
//   //     _showDialog(
//   //       title: "Error",
//   //       message: "Failed to capture the payment. Please try again.",
//   //       isSuccess: false,
//   //     );
//   //   }
//   // }
//
//
//   ///automatically payment is refunding to customer Fixed the Issue Thought to check
//
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     // Capture the payment using Razorpay API
//     String apiUrl = "https://api.razorpay.com/v1/payments/${response.paymentId}/capture";
//     String key = "rzp_live_jRrlgHE9Hldmk5"; // Replace with your Razorpay Live Key
//     String secret = "C1Cvhlrq3ZaqJXSEq7NFeEUm"; // Replace with your Razorpay Secret Key
//
//     var headers = {
//       "Authorization": "Basic ${base64Encode(utf8.encode('$key:$secret'))}",
//       "Content-Type": "application/json"
//     };
//
//     var body = jsonEncode({
//       "amount": widget.offeredPrice * 100, // Convert to paise
//       "currency": "INR"
//     });
//
//     try {
//       var captureResponse = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
//
//       if (captureResponse.statusCode == 200) {
//         print("Payment Captured Successfully");
//
//         // Now confirm the booking in Firestore
//         bookSeat(context, response.paymentId!);
//       } else {
//         print("Failed to capture payment: ${captureResponse.body}");
//         _showDialog(
//           title: "Payment Capture Failed",
//           message: "Payment was successful but could not be captured. Contact support.",
//           isSuccess: false,
//         );
//       }
//     } catch (e) {
//       print("Error capturing payment: $e");
//       _showDialog(
//         title: "Error",
//         message: "Failed to capture the payment. Please try again.",
//         isSuccess: false,
//       );
//     }
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     setState(() {
//       _isLoading = false;
//     });
//     _showDialog(
//       title: "Payment Failed",
//       message: "Error: ${response.message ?? 'Unknown error'}",
//       isSuccess: false,
//     );
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     _showDialog(
//       title: "External Wallet Selected",
//       message: "Wallet: ${response.walletName}",
//       isSuccess: true,
//     );
//   }
//
//   void _openCheckout() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       var options = {
//         'key': 'rzp_live_jRrlgHE9Hldmk5',
//         // 'key': 'rzp_test_0JqfNU3fC2HG7Z',
//         // 'key': 'rzp_test_0JqfNU3fC2HG7Z', // Replace with your Razorpay key
//         'amount': (widget.offeredPrice * 100).toString(), // Convert to paise
//         'name': 'Namma Savaari',
//         'description': 'Bus Ticket: ${widget.travelName}',
//         'prefill': {
//           'contact': widget.phoneno,
//           'email': widget.email,
//         },
//         'theme': {'color': '#FF2291'},
//       };
//
//       _razorpay.open(options);
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showDialog(
//         title: "Error",
//         message: "Failed to open payment gateway: $e",
//         isSuccess: false,
//       );
//     }
//   }
//
//   void _showDialog({required String title, required String message, required bool isSuccess}) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> bookSeat(BuildContext context, String paymentId) async {
//     const String apiUrl = "http://3.7.121.234/bus-api/Book";
//
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": paymentId, // Using Razorpay payment ID as reference
//       "Passenger": [
//         {
//           "LeadPassenger": widget.leadPassenger,
//           "PassengerId": widget.passengerId,
//           "Title": widget.title,
//           "FirstName": widget.firstName,
//           "LastName": widget.lastName,
//           "Email": widget.email,
//           "Phoneno": widget.phoneno,
//           "Gender": widget.gender,
//           "IdType": widget.idType,
//           "IdNumber": widget.idNumber,
//           "Address": widget.address,
//           "Age": widget.age,
//           "Seat": {
//             "ColumnNo": widget.columnNo,
//             "Height": widget.height,
//             "IsLadiesSeat": widget.isLadiesSeat,
//             "IsMalesSeat": widget.isMalesSeat,
//             "IsUpper": widget.isUpper,
//             "RowNo": widget.rowNo,
//             "SeatFare": widget.seatFare,
//             "SeatIndex": widget.seatIndex,
//             "SeatName": widget.seatName,
//             "SeatStatus": widget.seatStatus,
//             "SeatType": widget.seatType,
//             "Width": widget.width,
//             "Price": {
//               "CurrencyCode": widget.currencyCode,
//               "BasePrice": widget.basePrice,
//               "Tax": widget.tax,
//               "OtherCharges": widget.otherCharges,
//               "Discount": widget.discount,
//               "PublishedPrice": widget.publishedPrice,
//               "PublishedPriceRoundedOff": widget.publishedPriceRoundedOff,
//               "OfferedPrice": widget.offeredPrice,
//               "OfferedPriceRoundedOff": widget.offeredPriceRoundedOff,
//               "AgentCommission": widget.agentCommission,
//               "AgentMarkUp": widget.agentMarkUp,
//               "TDS": widget.tds,
//               "GST": {
//                 "CGSTAmount": widget.cgstAmount,
//                 "CGSTRate": widget.cgstRate,
//                 "CessAmount": widget.cessAmount,
//                 "CessRate": widget.cessRate,
//                 "IGSTAmount": widget.igstAmount,
//                 "IGSTRate": widget.igstRate,
//                 "SGSTAmount": widget.sgstAmount,
//                 "SGSTRate": widget.sgstRate,
//                 "TaxableAmount": widget.taxableAmount,
//               },
//             },
//           },
//         }
//       ]
//     };
//
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//
//         // Check if there's an error in the response
//         if (responseData['Error'] != null &&
//             (responseData['Error']['ErrorCode'] != 0 ||
//                 responseData['Error']['ErrorMessage'].isNotEmpty)) {
//           setState(() {
//             _isLoading = false;
//           });
//           _showDialog(
//             title: "Booking Failed",
//             message: responseData['Error']['ErrorMessage'] ?? 'Unknown error',
//             isSuccess: false,
//           );
//           return;
//         }
//
//         // Booking successful - store in Firestore
//         final currentUser = FirebaseAuth.instance.currentUser;
//         if (currentUser != null) {
//           final resultData = responseData['Result'];
//
//           // Create a document with all booking details
//           await FirebaseFirestore.instance
//               .collection('customers')
//               .doc(currentUser.uid)
//               .collection('bookings')
//               .add({
//             // API response data
//             'traceId': resultData['TraceId'],
//             'bookingStatus': resultData['BusBookingStatus'],
//             'invoiceAmount': resultData['InvoiceAmount'],
//             'busId': resultData['BusId'],
//             'ticketNumber': resultData['TicketNo'],
//             'operatorPNR': resultData['TravelOperatorPNR'],
//
//             // Payment information
//             'paymentId': paymentId,
//             'paymentStatus': 'completed',
//             'paymentAmount': widget.offeredPrice,
//             'paymentCurrency': widget.currencyCode,
//             'paymentTime': FieldValue.serverTimestamp(),
//
//             // Journey details
//             'journeyDetails': {
//               'source': widget.sourceCity,
//               'destination': widget.destinationCity,
//               'date': widget.journeyDate,
//               'travelName': widget.travelName,
//               'busType': widget.busType,
//               'seatNumber': widget.seatName,
//               'departureTime': widget.departureTime,
//               'arrivalTime': widget.arrivalTime,
//               'boardingPoint': widget.selectedBoardingPoint,
//               'droppingPoint': widget.selectedDroppingPoint,
//             },
//
//             // Passenger details
//             'passengerDetails': {
//               'name': '${widget.title} ${widget.firstName} ${widget.lastName}',
//               'email': widget.email,
//               'phone': widget.phoneno,
//               'age': widget.age,
//               'gender': widget.gender,
//               'idType': widget.idType,
//               'idNumber': widget.idNumber,
//             },
//
//             // System information
//             'createdAt': FieldValue.serverTimestamp(),
//             'status': 'confirmed',
//             'lastUpdated': FieldValue.serverTimestamp(),
//           });
//
//           // Also create an entry in the global bookings collection
//           await FirebaseFirestore.instance
//               .collection('all_bookings')
//               .add({
//             'userId': currentUser.uid,
//             'ticketNumber': resultData['TicketNo'],
//             'pnr': resultData['TravelOperatorPNR'],
//             'bookingStatus': resultData['BusBookingStatus'],
//             'amount': resultData['InvoiceAmount'],
//             'journey': '${widget.sourceCity} to ${widget.destinationCity}',
//             'travelDate': widget.journeyDate,
//             'bookingTime': FieldValue.serverTimestamp(),
//           });
//         }
//
//         setState(() {
//           _isLoading = false;
//         });
//
//         // Show success dialog with booking details
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) => AlertDialog(
//             title: const Text("Booking Successful"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Ticket No: ${responseData['Result']['TicketNo']}"),
//                 Text("PNR: ${responseData['Result']['TravelOperatorPNR']}"),
//                 Text("Status: ${responseData['Result']['BusBookingStatus']}"),
//                 const SizedBox(height: 10),
//                 const Text("Booking confirmation has been sent to your email."),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Close dialog
//                   Navigator.pop(context); // Go back to previous screen
//                 },
//                 child: const Text("OK"),
//               ),
//             ],
//           ),
//         );
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         _showDialog(
//           title: "Booking Failed",
//           message: "Server error: ${response.statusCode}",
//           isSuccess: false,
//         );
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showDialog(
//         title: "Error",
//         message: "An error occurred: $e",
//         isSuccess: false,
//       );
//     }
//   }
//
//   // Add this new method to your _BookSeatState class
//   // Future<void> _payWithWallet() async {
//   //   setState(() {
//   //     _isLoading = true;
//   //   });
//   //
//   //   try {
//   //     final currentUser = FirebaseAuth.instance.currentUser;
//   //     if (currentUser == null) {
//   //       throw Exception("User not logged in");
//   //     }
//   //
//   //     // Check wallet balance
//   //     final walletDoc = await FirebaseFirestore.instance
//   //         .collection('customers')
//   //         .doc(currentUser.uid)
//   //         .collection('wallets')
//   //         .doc('balance')
//   //         .get();
//   //
//   //     if (!walletDoc.exists || walletDoc['balance'] < widget.offeredPrice) {
//   //       setState(() {
//   //         _isLoading = false;
//   //       });
//   //       _showDialog(
//   //         title: "Insufficient Balance",
//   //         message: "You don't have enough balance in your wallet",
//   //         isSuccess: false,
//   //       );
//   //       return;
//   //     }
//   //
//   //     // Deduct amount from wallet
//   //     await FirebaseFirestore.instance
//   //         .collection('customers')
//   //         .doc(currentUser.uid)
//   //         .collection('wallets')
//   //         .doc('balance')
//   //         .update({
//   //       'balance': FieldValue.increment(-widget.offeredPrice),
//   //       'transactions': FieldValue.arrayUnion([
//   //         {
//   //           'id': DateTime.now().millisecondsSinceEpoch.toString(),
//   //           'amount': widget.offeredPrice,
//   //           'type': 'payment',
//   //           'timestamp': DateTime.now().toIso8601String(),
//   //           'description': 'Bus ticket booking'
//   //         }
//   //       ])
//   //     });
//   //
//   //     // Proceed with booking using a dummy payment ID
//   //     bookSeat(context, "wallet-${DateTime.now().millisecondsSinceEpoch}");
//   //   } catch (e) {
//   //     setState(() {
//   //       _isLoading = false;
//   //     });
//   //     _showDialog(
//   //       title: "Payment Failed",
//   //       message: "Error processing wallet payment: $e",
//   //       isSuccess: false,
//   //     );
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Confirm Booking"),
//         backgroundColor: Colors.redAccent.shade700,
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Booking Summary Card
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Journey Details",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               widget.sourceCity,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const Icon(Icons.arrow_forward),
//                             Text(
//                               widget.destinationCity,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Text("${widget.travelName} (${widget.busType})"),
//                         Text("Date: ${widget.journeyDate}"),
//                         Text("Departure: ${widget.departureTime}"),
//                         Text("Arrival: ${widget.arrivalTime}"),
//                         const Divider(height: 24),
//                         const Text(
//                           "Passenger Details",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text("${widget.title} ${widget.firstName} ${widget.lastName}"),
//                         Text("Age: ${widget.age} | Gender: ${widget.gender}"),
//                         Text("Phone: ${widget.phoneno}"),
//                         Text("Email: ${widget.email}"),
//                         const Divider(height: 24),
//                         const Text(
//                           "Seat Details",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text("Seat: ${widget.seatName}"),
//                         Text("Type: ${widget.seatType == 1 ? "Sleeper" : "Seater"}"),
//                         Text("Boarding: ${widget.selectedBoardingPoint}"),
//                         Text("Dropping: ${widget.selectedDroppingPoint}"),
//                         const Divider(height: 24),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Total Amount:",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               "₹${widget.offeredPrice}",
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.redAccent,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: _isLoading ? null : _openCheckout,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.redAccent.shade700,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: _isLoading
//                       ? const SizedBox(
//                     height: 24,
//                     width: 24,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     ),
//                   )
//                       : const Text(
//                     "PROCEED TO PAY",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 // const SizedBox(height: 16),
//                 // ElevatedButton(
//                 //   onPressed: _isLoading ? null : _payWithWallet,
//                 //   style: ElevatedButton.styleFrom(
//                 //     backgroundColor: Colors.green.shade700,
//                 //     padding: const EdgeInsets.symmetric(vertical: 16),
//                 //     shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(8),
//                 //     ),
//                 //   ),
//                 //   child: _isLoading
//                 //       ? const SizedBox(
//                 //     height: 24,
//                 //     width: 24,
//                 //     child: CircularProgressIndicator(
//                 //       color: Colors.white,
//                 //       strokeWidth: 2,
//                 //     ),
//                 //   )
//                 //       : const Text(
//                 //     "PAY THROUGH WALLET",
//                 //     style: TextStyle(
//                 //       fontSize: 16,
//                 //       fontWeight: FontWeight.bold,
//                 //       color: Colors.white,
//                 //     ),
//                 //   ),
//                 // ),
//                 const SizedBox(height: 16),
//                 Text(
//                   "By proceeding, you agree to our Terms and Conditions",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (_isLoading)
//             const Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }
// }



/// only one seat it is booking
library;



// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class BookSeat extends StatefulWidget {
//   final String resultIndex;
//   final String traceId;
//   final String sourceCity;
//   final String destinationCity;
//   final String journeyDate;
//   final String travelName;
//   final String busType;
//   final String arrivalTime;
//   final String departureTime;
//   final int? boardingPointIndex;
//   final int? droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   // final List<Map<String, dynamic>> selectedSeats; // List of seats
//   final bool leadPassenger;
//   final int passengerId;
//   final String title;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneno;
//   final String gender;
//   final String? idType;
//   final String? idNumber;
//   final String address;
//   final String age;
//   final List<Map<String, dynamic>> selectedSeats; // Changed to accept list of seats
//
//
//   const BookSeat({
//     Key? key,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.selectedSeats,
//     required this.leadPassenger,
//     required this.passengerId,
//     required this.title,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phoneno,
//     required this.gender,
//     this.idType,
//     this.idNumber,
//     required this.address,
//     required this.age,
//   }) : super(key: key);
//
//   @override
//   _BookSeatState createState() => _BookSeatState();
// }
//
// class _BookSeatState extends State<BookSeat> {
//   late Razorpay _razorpay;
//   bool _isLoading = false;
//
//   // Calculate total amount for all seats
//   double get totalAmount => widget.selectedSeats.fold(
//     0.0,
//         (sum, seat) => sum + (seat['Price']['OfferedPrice'] as num).toDouble(),
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     String apiUrl = "https://api.razorpay.com/v1/payments/${response.paymentId}/capture";
//     String key = "rzp_live_jRrlgHE9Hldmk5";
//     String secret = "C1Cvhlrq3ZaqJXSEq7NFeEUm";
//
//     var headers = {
//       "Authorization": "Basic ${base64Encode(utf8.encode('$key:$secret'))}",
//       "Content-Type": "application/json"
//     };
//
//     var body = jsonEncode({
//       "amount": (totalAmount * 100).toInt(), // Total amount in paise
//       "currency": "INR"
//     });
//
//     try {
//       var captureResponse = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
//
//       if (captureResponse.statusCode == 200) {
//         print("Payment Captured Successfully");
//         bookSeat(context, response.paymentId!);
//       } else {
//         print("Failed to capture payment: ${captureResponse.body}");
//         _showDialog(
//           title: "Payment Capture Failed",
//           message: "Payment was successful but could not be captured. Contact support.",
//           isSuccess: false,
//         );
//       }
//     } catch (e) {
//       print("Error capturing payment: $e");
//       _showDialog(
//         title: "Error",
//         message: "Failed to capture the payment. Please try again.",
//         isSuccess: false,
//       );
//     }
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     setState(() {
//       _isLoading = false;
//     });
//     _showDialog(
//       title: "Payment Failed",
//       message: "Error: ${response.message ?? 'Unknown error'}",
//       isSuccess: false,
//     );
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     _showDialog(
//       title: "External Wallet Selected",
//       message: "Wallet: ${response.walletName}",
//       isSuccess: true,
//     );
//   }
//
//   void _openCheckout() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       var options = {
//         'key': 'rzp_live_jRrlgHE9Hldmk5',
//         'amount': (totalAmount * 100).toString(), // Total amount in paise
//         'name': 'Namma Savaari',
//         'description': 'Bus Ticket: ${widget.travelName}',
//         'prefill': {
//           'contact': widget.phoneno,
//           'email': widget.email,
//         },
//         'theme': {'color': '#FF2291'},
//       };
//
//       _razorpay.open(options);
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showDialog(
//         title: "Error",
//         message: "Failed to open payment gateway: $e",
//         isSuccess: false,
//       );
//     }
//   }
//
//   void _showDialog({required String title, required String message, required bool isSuccess}) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> bookSeat(BuildContext context, String paymentId) async {
//     const String apiUrl = "http://3.7.121.234/bus-api/Book";
//
//     // Construct passenger list from selectedSeats and lead passenger data
//     List<Map<String, dynamic>> passengers = widget.selectedSeats.asMap().entries.map((entry) {
//       int index = entry.key;
//       var seat = entry.value;
//       return {
//         "LeadPassenger": index == 0 ? widget.leadPassenger : false,
//         "PassengerId": index == 0 ? widget.passengerId : DateTime.now().millisecondsSinceEpoch + index,
//         "Title": index == 0 ? widget.title : "Mr",
//         "FirstName": index == 0 ? widget.firstName : "Passenger${index + 1}",
//         "LastName": index == 0 ? widget.lastName : "",
//         "Email": index == 0 ? widget.email : "",
//         "Phoneno": index == 0 ? widget.phoneno : "",
//         "Gender": index == 0 ? widget.gender : "1", // Default to Male if not lead
//         "IdType": index == 0 ? widget.idType : null,
//         "IdNumber": index == 0 ? widget.idNumber : null,
//         "Address": index == 0 ? widget.address : "",
//         "Age": index == 0 ? widget.age : "30", // Default age if not lead
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
//           "Price": {
//             "CurrencyCode": seat['Price']['CurrencyCode'],
//             "BasePrice": seat['Price']['BasePrice'],
//             "Tax": seat['Price']['Tax'],
//             "OtherCharges": seat['Price']['OtherCharges'],
//             "Discount": seat['Price']['Discount'],
//             "PublishedPrice": seat['Price']['PublishedPrice'],
//             "PublishedPriceRoundedOff": seat['Price']['PublishedPriceRoundedOff'],
//             "OfferedPrice": seat['Price']['OfferedPrice'],
//             "OfferedPriceRoundedOff": seat['Price']['OfferedPriceRoundedOff'],
//             "AgentCommission": seat['Price']['AgentCommission'],
//             "AgentMarkUp": seat['Price']['AgentMarkUp'],
//             "TDS": seat['Price']['TDS'],
//             "GST": {
//               "CGSTAmount": seat['Price']['GST']['CGSTAmount'],
//               "CGSTRate": seat['Price']['GST']['CGSTRate'],
//               "CessAmount": seat['Price']['GST']['CessAmount'],
//               "CessRate": seat['Price']['GST']['CessRate'],
//               "IGSTAmount": seat['Price']['GST']['IGSTAmount'],
//               "IGSTRate": seat['Price']['GST']['IGSTRate'],
//               "SGSTAmount": seat['Price']['GST']['SGSTAmount'],
//               "SGSTRate": seat['Price']['GST']['SGSTRate'],
//               "TaxableAmount": seat['Price']['GST']['TaxableAmount'],
//             },
//           },
//         },
//       };
//     }).toList();
//
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": paymentId,
//       "Passenger": passengers,
//     };
//
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//
//         if (responseData['Error'] != null &&
//             (responseData['Error']['ErrorCode'] != 0 || responseData['Error']['ErrorMessage'].isNotEmpty)) {
//           setState(() {
//             _isLoading = false;
//           });
//           _showDialog(
//             title: "Booking Failed",
//             message: responseData['Error']['ErrorMessage'] ?? 'Unknown error',
//             isSuccess: false,
//           );
//           return;
//         }
//
//         final currentUser = FirebaseAuth.instance.currentUser;
//         if (currentUser != null) {
//           final resultData = responseData['Result'];
//
//           await FirebaseFirestore.instance
//               .collection('customers')
//               .doc(currentUser.uid)
//               .collection('bookings')
//               .add({
//             'traceId': resultData['TraceId'],
//             'bookingStatus': resultData['BusBookingStatus'],
//             'invoiceAmount': resultData['InvoiceAmount'],
//             'busId': resultData['BusId'],
//             'ticketNumber': resultData['TicketNo'],
//             'operatorPNR': resultData['TravelOperatorPNR'],
//             'paymentId': paymentId,
//             'paymentStatus': 'completed',
//             'paymentAmount': totalAmount,
//             'paymentCurrency': widget.selectedSeats[0]['Price']['CurrencyCode'],
//             'paymentTime': FieldValue.serverTimestamp(),
//             'journeyDetails': {
//               'source': widget.sourceCity,
//               'destination': widget.destinationCity,
//               'date': widget.journeyDate,
//               'travelName': widget.travelName,
//               'busType': widget.busType,
//               'seats': widget.selectedSeats.map((seat) => seat['SeatName']).toList(),
//               'departureTime': widget.departureTime,
//               'arrivalTime': widget.arrivalTime,
//               'boardingPoint': widget.selectedBoardingPoint,
//               'droppingPoint': widget.selectedDroppingPoint,
//             },
//             'passengerDetails': passengers.map((p) => {
//               'name': '${p['Title']} ${p['FirstName']} ${p['LastName']}',
//               'email': p['Email'],
//               'phone': p['Phoneno'],
//               'age': p['Age'],
//               'gender': p['Gender'],
//               'idType': p['IdType'],
//               'idNumber': p['IdNumber'],
//               'seat': p['Seat']['SeatName'],
//             }).toList(),
//             'createdAt': FieldValue.serverTimestamp(),
//             'status': 'confirmed',
//             'lastUpdated': FieldValue.serverTimestamp(),
//           });
//
//           await FirebaseFirestore.instance.collection('all_bookings').add({
//             'userId': currentUser.uid,
//             'ticketNumber': resultData['TicketNo'],
//             'pnr': resultData['TravelOperatorPNR'],
//             'bookingStatus': resultData['BusBookingStatus'],
//             'amount': resultData['InvoiceAmount'],
//             'journey': '${widget.sourceCity} to ${widget.destinationCity}',
//             'travelDate': widget.journeyDate,
//             'bookingTime': FieldValue.serverTimestamp(),
//           });
//         }
//
//         setState(() {
//           _isLoading = false;
//         });
//
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) => AlertDialog(
//             title: const Text("Booking Successful"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Ticket No: ${responseData['Result']['TicketNo']}"),
//                 Text("PNR: ${responseData['Result']['TravelOperatorPNR']}"),
//                 Text("Status: ${responseData['Result']['BusBookingStatus']}"),
//                 const SizedBox(height: 10),
//                 const Text("Booking confirmation has been sent to your email."),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                 },
//                 child: const Text("OK"),
//               ),
//             ],
//           ),
//         );
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         _showDialog(
//           title: "Booking Failed",
//           message: "Server error: ${response.statusCode}",
//           isSuccess: false,
//         );
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showDialog(
//         title: "Error",
//         message: "An error occurred: $e",
//         isSuccess: false,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Confirm Booking"),
//         backgroundColor: Colors.redAccent.shade700,
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Journey Details",
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               widget.sourceCity,
//                               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             const Icon(Icons.arrow_forward),
//                             Text(
//                               widget.destinationCity,
//                               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Text("${widget.travelName} (${widget.busType})"),
//                         Text("Date: ${widget.journeyDate}"),
//                         Text("Departure: ${widget.departureTime}"),
//                         Text("Arrival: ${widget.arrivalTime}"),
//                         const Divider(height: 24),
//                         const Text(
//                           "Passenger & Seat Details",
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 10),
//                         ...widget.selectedSeats.asMap().entries.map((entry) {
//                           int index = entry.key;
//                           var seat = entry.value;
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Passenger ${index + 1}: ${index == 0 ? '${widget.title} ${widget.firstName} ${widget.lastName}' : 'Passenger${index + 1}'}",
//                                   style: const TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text("Seat: ${seat['SeatName']}"),
//                                 Text("Type: ${seat['SeatType'] == 1 ? 'Sleeper' : 'Seater'}"),
//                                 Text("Fare: ₹${seat['Price']['OfferedPrice']}"),
//                                 if (index == 0) ...[
//                                   Text("Age: ${widget.age} | Gender: ${widget.gender}"),
//                                   Text("Phone: ${widget.phoneno}"),
//                                   Text("Email: ${widget.email}"),
//                                 ],
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                         const Divider(height: 24),
//                         const Text(
//                           "Boarding & Dropping",
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 10),
//                         Text("Boarding: ${widget.selectedBoardingPoint}"),
//                         Text("Dropping: ${widget.selectedDroppingPoint}"),
//                         const Divider(height: 24),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Total Amount:",
//                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               "₹${totalAmount.toStringAsFixed(2)}",
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.redAccent,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: _isLoading ? null : _openCheckout,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.redAccent.shade700,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   child: _isLoading
//                       ? const SizedBox(
//                     height: 24,
//                     width: 24,
//                     child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//                   )
//                       : const Text(
//                     "PROCEED TO PAY",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   "By proceeding, you agree to our Terms and Conditions",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//           ),
//           if (_isLoading)
//             const Center(child: CircularProgressIndicator()),
//         ],
//       ),
//     );
//   }
// }



/// updating to book multiple seats at a time


// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// import 'home_screen.dart';
//
// class BookSeat extends StatefulWidget {
//   final String resultIndex;
//   final String traceId;
//   final String sourceCity;
//   final String destinationCity;
//   final String journeyDate;
//   final String travelName;
//   final String busType;
//   final String arrivalTime;
//   final String departureTime;
//   final int? boardingPointIndex;
//   final int? droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//   // final List<Map<String, dynamic>> selectedSeats; // List of seats
//   final bool leadPassenger;
//   final int passengerId;
//   final String title;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneno;
//   final String gender;
//   final String? idType;
//   final String? idNumber;
//   final String address;
//   final String age;
//   final List<Map<String, dynamic>> selectedSeats; // Changed to accept list of seats
//   final List<Map<String, dynamic>> passengers; // All passengers data
//   final VoidCallback onNavigateToHome;
//
//
//
//   const BookSeat({
//     Key? key,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.selectedSeats,
//     required this.leadPassenger,
//     required this.passengerId,
//     required this.title,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phoneno,
//     required this.gender,
//     this.idType,
//     this.idNumber,
//     required this.address,
//     required this.age,
//     required this.passengers,
//     required this.onNavigateToHome
//   }) : super(key: key);
//
//   @override
//   _BookSeatState createState() => _BookSeatState();
// }
//
// class _BookSeatState extends State<BookSeat> {
//   late Razorpay _razorpay;
//   bool _isLoading = false;
//
//   // Calculate total amount for all seats
//   double get totalAmount => widget.selectedSeats.fold(
//     0.0,
//         (sum, seat) => sum + (seat['Price']['OfferedPrice'] as num).toDouble(),
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     String apiUrl = "https://api.razorpay.com/v1/payments/${response.paymentId}/capture";
//     String key = "rzp_live_jRrlgHE9Hldmk5";
//     String secret = "C1Cvhlrq3ZaqJXSEq7NFeEUm";
//
//     var headers = {
//       "Authorization": "Basic ${base64Encode(utf8.encode('$key:$secret'))}",
//       "Content-Type": "application/json"
//     };
//
//     var body = jsonEncode({
//       "amount": (totalAmount * 100).toInt(), // Total amount in paise
//       "currency": "INR"
//     });
//
//     try {
//       var captureResponse = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
//
//       if (captureResponse.statusCode == 200) {
//         print("Payment Captured Successfully");
//         bookSeat(context, response.paymentId!);
//       } else {
//         print("Failed to capture payment: ${captureResponse.body}");
//         _showDialog(
//           title: "Payment Capture Failed",
//           message: "Payment was successful but could not be captured. Contact support.",
//           isSuccess: false,
//         );
//       }
//     } catch (e) {
//       print("Error capturing payment: $e");
//       _showDialog(
//         title: "Error",
//         message: "Failed to capture the payment. Please try again.",
//         isSuccess: false,
//       );
//     }
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     setState(() {
//       _isLoading = false;
//     });
//     _showDialog(
//       title: "Payment Failed",
//       message: "Error: ${response.message ?? 'Unknown error'}",
//       isSuccess: false,
//     );
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     _showDialog(
//       title: "External Wallet Selected",
//       message: "Wallet: ${response.walletName}",
//       isSuccess: true,
//     );
//   }
//
//   void _openCheckout() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       var options = {
//         'key': 'rzp_live_jRrlgHE9Hldmk5',
//         'amount': (totalAmount * 100).toString(), // Total amount in paise
//         'name': 'Namma Savaari',
//         'description': 'Bus Ticket: ${widget.travelName}',
//         'prefill': {
//           'contact': widget.phoneno,
//           'email': widget.email,
//         },
//         'theme': {'color': '#FF2291'},
//       };
//
//       _razorpay.open(options);
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showDialog(
//         title: "Error",
//         message: "Failed to open payment gateway: $e",
//         isSuccess: false,
//       );
//     }
//   }
//
//   void _showDialog({required String title, required String message, required bool isSuccess}) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Future<void> bookSeat(BuildContext context, String paymentId) async {
//   //   const String apiUrl = "http://3.7.121.234/bus-api/Book";
//   //
//   //   // Construct passenger list from selectedSeats and lead passenger data
//   //   List<Map<String, dynamic>> passengers = widget.selectedSeats.asMap().entries.map((entry) {
//   //     int index = entry.key;
//   //     var seat = entry.value;
//   //     return {
//   //       "LeadPassenger": index == 0 ? widget.leadPassenger : false,
//   //       "PassengerId": index == 0 ? widget.passengerId : DateTime.now().millisecondsSinceEpoch + index,
//   //       "Title": index == 0 ? widget.title : "Mr",
//   //       "FirstName": index == 0 ? widget.firstName : "Passenger${index + 1}",
//   //       "LastName": index == 0 ? widget.lastName : "",
//   //       "Email": index == 0 ? widget.email : "",
//   //       "Phoneno": index == 0 ? widget.phoneno : "",
//   //       "Gender": index == 0 ? widget.gender : "1", // Default to Male if not lead
//   //       "IdType": index == 0 ? widget.idType : null,
//   //       "IdNumber": index == 0 ? widget.idNumber : null,
//   //       "Address": index == 0 ? widget.address : "",
//   //       "Age": index == 0 ? widget.age : "30", // Default age if not lead
//   //       "Seat": {
//   //         "ColumnNo": seat['ColumnNo'],
//   //         "Height": seat['Height'],
//   //         "IsLadiesSeat": seat['IsLadiesSeat'],
//   //         "IsMalesSeat": seat['IsMalesSeat'],
//   //         "IsUpper": seat['IsUpper'],
//   //         "RowNo": seat['RowNo'],
//   //         "SeatFare": seat['SeatFare'],
//   //         "SeatIndex": seat['SeatIndex'],
//   //         "SeatName": seat['SeatName'],
//   //         "SeatStatus": seat['SeatStatus'],
//   //         "SeatType": seat['SeatType'],
//   //         "Width": seat['Width'],
//   //         "Price": {
//   //           "CurrencyCode": seat['Price']['CurrencyCode'],
//   //           "BasePrice": seat['Price']['BasePrice'],
//   //           "Tax": seat['Price']['Tax'],
//   //           "OtherCharges": seat['Price']['OtherCharges'],
//   //           "Discount": seat['Price']['Discount'],
//   //           "PublishedPrice": seat['Price']['PublishedPrice'],
//   //           "PublishedPriceRoundedOff": seat['Price']['PublishedPriceRoundedOff'],
//   //           "OfferedPrice": seat['Price']['OfferedPrice'],
//   //           "OfferedPriceRoundedOff": seat['Price']['OfferedPriceRoundedOff'],
//   //           "AgentCommission": seat['Price']['AgentCommission'],
//   //           "AgentMarkUp": seat['Price']['AgentMarkUp'],
//   //           "TDS": seat['Price']['TDS'],
//   //           "GST": {
//   //             "CGSTAmount": seat['Price']['GST']['CGSTAmount'],
//   //             "CGSTRate": seat['Price']['GST']['CGSTRate'],
//   //             "CessAmount": seat['Price']['GST']['CessAmount'],
//   //             "CessRate": seat['Price']['GST']['CessRate'],
//   //             "IGSTAmount": seat['Price']['GST']['IGSTAmount'],
//   //             "IGSTRate": seat['Price']['GST']['IGSTRate'],
//   //             "SGSTAmount": seat['Price']['GST']['SGSTAmount'],
//   //             "SGSTRate": seat['Price']['GST']['SGSTRate'],
//   //             "TaxableAmount": seat['Price']['GST']['TaxableAmount'],
//   //           },
//   //         },
//   //       },
//   //     };
//   //   }).toList();
//   //
//   //   final Map<String, dynamic> requestBody = {
//   //     "ClientId": "180187",
//   //     "UserName": "Namma434",
//   //     "Password": "Namma@4341",
//   //     "ResultIndex": widget.resultIndex,
//   //     "TraceId": widget.traceId,
//   //     "BoardingPointId": widget.boardingPointIndex,
//   //     "DroppingPointId": widget.droppingPointIndex,
//   //     "RefID": paymentId,
//   //     "Passenger": passengers,
//   //   };
//   //
//   //   const headers = {
//   //     "Content-Type": "application/json",
//   //     "Api-Token": "Namma@90434#34",
//   //   };
//   //
//   //   try {
//   //     final response = await http.post(
//   //       Uri.parse(apiUrl),
//   //       headers: headers,
//   //       body: jsonEncode(requestBody),
//   //     );
//   //
//   //     if (response.statusCode == 200) {
//   //       final responseData = jsonDecode(response.body);
//   //
//   //       if (responseData['Error'] != null &&
//   //           (responseData['Error']['ErrorCode'] != 0 || responseData['Error']['ErrorMessage'].isNotEmpty)) {
//   //         setState(() {
//   //           _isLoading = false;
//   //         });
//   //         _showDialog(
//   //           title: "Booking Failed",
//   //           message: responseData['Error']['ErrorMessage'] ?? 'Unknown error',
//   //           isSuccess: false,
//   //         );
//   //         return;
//   //       }
//   //
//   //       final currentUser = FirebaseAuth.instance.currentUser;
//   //       if (currentUser != null) {
//   //         final resultData = responseData['Result'];
//   //
//   //         await FirebaseFirestore.instance
//   //             .collection('customers')
//   //             .doc(currentUser.uid)
//   //             .collection('bookings')
//   //             .add({
//   //           'traceId': resultData['TraceId'],
//   //           'bookingStatus': resultData['BusBookingStatus'],
//   //           'invoiceAmount': resultData['InvoiceAmount'],
//   //           'busId': resultData['BusId'],
//   //           'ticketNumber': resultData['TicketNo'],
//   //           'operatorPNR': resultData['TravelOperatorPNR'],
//   //           'paymentId': paymentId,
//   //           'paymentStatus': 'completed',
//   //           'paymentAmount': totalAmount,
//   //           'paymentCurrency': widget.selectedSeats[0]['Price']['CurrencyCode'],
//   //           'paymentTime': FieldValue.serverTimestamp(),
//   //           'journeyDetails': {
//   //             'source': widget.sourceCity,
//   //             'destination': widget.destinationCity,
//   //             'date': widget.journeyDate,
//   //             'travelName': widget.travelName,
//   //             'busType': widget.busType,
//   //             'seats': widget.selectedSeats.map((seat) => seat['SeatName']).toList(),
//   //             'departureTime': widget.departureTime,
//   //             'arrivalTime': widget.arrivalTime,
//   //             'boardingPoint': widget.selectedBoardingPoint,
//   //             'droppingPoint': widget.selectedDroppingPoint,
//   //           },
//   //           'passengerDetails': passengers.map((p) => {
//   //             'name': '${p['Title']} ${p['FirstName']} ${p['LastName']}',
//   //             'email': p['Email'],
//   //             'phone': p['Phoneno'],
//   //             'age': p['Age'],
//   //             'gender': p['Gender'],
//   //             'idType': p['IdType'],
//   //             'idNumber': p['IdNumber'],
//   //             'seat': p['Seat']['SeatName'],
//   //           }).toList(),
//   //           'createdAt': FieldValue.serverTimestamp(),
//   //           'status': 'confirmed',
//   //           'lastUpdated': FieldValue.serverTimestamp(),
//   //         });
//   //
//   //         await FirebaseFirestore.instance.collection('all_bookings').add({
//   //           'userId': currentUser.uid,
//   //           'ticketNumber': resultData['TicketNo'],
//   //           'pnr': resultData['TravelOperatorPNR'],
//   //           'bookingStatus': resultData['BusBookingStatus'],
//   //           'amount': resultData['InvoiceAmount'],
//   //           'journey': '${widget.sourceCity} to ${widget.destinationCity}',
//   //           'travelDate': widget.journeyDate,
//   //           'bookingTime': FieldValue.serverTimestamp(),
//   //         });
//   //       }
//   //
//   //       setState(() {
//   //         _isLoading = false;
//   //       });
//   //
//   //       showDialog(
//   //         context: context,
//   //         barrierDismissible: false,
//   //         builder: (context) => AlertDialog(
//   //           title: const Text("Booking Successful"),
//   //           content: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Text("Ticket No: ${responseData['Result']['TicketNo']}"),
//   //               Text("PNR: ${responseData['Result']['TravelOperatorPNR']}"),
//   //               Text("Status: ${responseData['Result']['BusBookingStatus']}"),
//   //               const SizedBox(height: 10),
//   //               const Text("Booking confirmation has been sent to your email."),
//   //             ],
//   //           ),
//   //           actions: [
//   //             TextButton(
//   //               onPressed: () {
//   //                 Navigator.pop(context);
//   //                 Navigator.pop(context);
//   //               },
//   //               child: const Text("OK"),
//   //             ),
//   //           ],
//   //         ),
//   //       );
//   //     } else {
//   //       setState(() {
//   //         _isLoading = false;
//   //       });
//   //       _showDialog(
//   //         title: "Booking Failed",
//   //         message: "Server error: ${response.statusCode}",
//   //         isSuccess: false,
//   //       );
//   //     }
//   //   } catch (e) {
//   //     setState(() {
//   //       _isLoading = false;
//   //     });
//   //     _showDialog(
//   //       title: "Error",
//   //       message: "An error occurred: $e",
//   //       isSuccess: false,
//   //     );
//   //   }
//   // }
//
//   Future<void> bookSeat(BuildContext context, String paymentId) async {
//     const String apiUrl = "http://3.7.121.234/bus-api/Book";
//
//     // Construct passenger list from the passengers data
//     List<Map<String, dynamic>> passengers = widget.passengers.map((passenger) {
//       return {
//         "LeadPassenger": passenger["LeadPassenger"],
//         "PassengerId": passenger["PassengerId"],
//         "Title": passenger["Title"],
//         "FirstName": passenger["FirstName"],
//         "LastName": passenger["LastName"],
//         "Email": passenger["Email"],
//         "Phoneno": passenger["Phoneno"],
//         "Gender": passenger["Gender"],
//         "IdType": passenger["IdType"],
//         "IdNumber": passenger["IdNumber"],
//         "Address": passenger["Address"],
//         "Age": passenger["Age"],
//         "Seat": passenger["Seat"],
//       };
//     }).toList();
//
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": paymentId,
//       "Passenger": passengers,
//     };
//
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//
//         if (responseData['Error'] != null &&
//             (responseData['Error']['ErrorCode'] != 0 || responseData['Error']['ErrorMessage'].isNotEmpty)) {
//           setState(() {
//             _isLoading = false;
//           });
//           _showDialog(
//             title: "Booking Failed",
//             message: responseData['Error']['ErrorMessage'] ?? 'Unknown error',
//             isSuccess: false,
//           );
//           return;
//         }
//
//         final currentUser = FirebaseAuth.instance.currentUser;
//         if (currentUser != null) {
//           final resultData = responseData['Result'];
//
//           await FirebaseFirestore.instance
//               .collection('customers')
//               .doc(currentUser.uid)
//               .collection('bookings')
//               .add({
//             'traceId': resultData['TraceId'],
//             'bookingStatus': resultData['BusBookingStatus'],
//             'invoiceAmount': resultData['InvoiceAmount'],
//             'busId': resultData['BusId'],
//             'ticketNumber': resultData['TicketNo'],
//             'operatorPNR': resultData['TravelOperatorPNR'],
//             'paymentId': paymentId,
//             'paymentStatus': 'completed',
//             'paymentAmount': totalAmount,
//             'paymentCurrency': widget.selectedSeats[0]['Price']['CurrencyCode'],
//             'paymentTime': FieldValue.serverTimestamp(),
//             'journeyDetails': {
//               'source': widget.sourceCity,
//               'destination': widget.destinationCity,
//               'date': widget.journeyDate,
//               'travelName': widget.travelName,
//               'busType': widget.busType,
//               'seats': widget.selectedSeats.map((seat) => seat['SeatName']).toList(),
//               'departureTime': widget.departureTime,
//               'arrivalTime': widget.arrivalTime,
//               'boardingPoint': widget.selectedBoardingPoint,
//               'droppingPoint': widget.selectedDroppingPoint,
//             },
//             'passengerDetails': passengers.map((p) => {
//               'name': '${p['Title']} ${p['FirstName']} ${p['LastName']}',
//               'email': p['Email'],
//               'phone': p['Phoneno'],
//               'age': p['Age'],
//               'gender': p['Gender'],
//               'idType': p['IdType'],
//               'idNumber': p['IdNumber'],
//               'seat': p['Seat']['SeatName'],
//             }).toList(),
//             'createdAt': FieldValue.serverTimestamp(),
//             'status': 'confirmed',
//             'lastUpdated': FieldValue.serverTimestamp(),
//           });
//
//           await FirebaseFirestore.instance.collection('all_bookings').add({
//             'userId': currentUser.uid,
//             'ticketNumber': resultData['TicketNo'],
//             'pnr': resultData['TravelOperatorPNR'],
//             'bookingStatus': resultData['BusBookingStatus'],
//             'amount': resultData['InvoiceAmount'],
//             'journey': '${widget.sourceCity} to ${widget.destinationCity}',
//             'travelDate': widget.journeyDate,
//             'bookingTime': FieldValue.serverTimestamp(),
//           });
//         }
//
//         setState(() {
//           _isLoading = false;
//         });
//
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) => AlertDialog(
//             title: const Text("Booking Successful"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Ticket No: ${responseData['Result']['TicketNo']}"),
//                 Text("PNR: ${responseData['Result']['TravelOperatorPNR']}"),
//                 Text("Status: ${responseData['Result']['BusBookingStatus']}"),
//                 const SizedBox(height: 10),
//                 const Text("Booking confirmation has been sent to your email."),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                 },
//                 child: const Text("ok"),
//               ),
//
//             ],
//
//             // actions: [
//             //   TextButton(
//             //     onPressed: () {
//             //       Navigator.pop(context); // Close current screen if needed
//             //       widget.onNavigateToHome(); // Switch tab to home
//             //     },
//             //     child: const Text("Go To Home Screen"),
//             //   ),
//
//             // ],
//
//             // actions: [
//             //   TextButton(
//             //     onPressed: () {
//             //       // Close the alert dialog
//             //       Navigator.pop(context);
//             //
//             //       // Then close all screens until reaching HomePage, and pass a result
//             //       Navigator.popUntil(context, (route) => route.isFirst); // or a custom check
//             //       Navigator.pushReplacement(
//             //         context,
//             //         MaterialPageRoute(
//             //           builder: (context) => HomePage(initialIndex: 1),
//             //         ),
//             //       );
//             //     },
//             //     child: const Text("Go To Bookings"),
//             //   ),
//             // ],
//
//           ),
//         );
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         _showDialog(
//           title: "Booking Failed",
//           message: "Server error: ${response.statusCode}",
//           isSuccess: false,
//         );
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showDialog(
//         title: "Error",
//         message: "An error occurred: $e",
//         isSuccess: false,
//       );
//     }
//   }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: const Text("Confirm Booking"),
//   //       backgroundColor: Colors.redAccent.shade700,
//   //     ),
//   //     body: Stack(
//   //       children: [
//   //         SingleChildScrollView(
//   //           padding: const EdgeInsets.all(16),
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.stretch,
//   //             children: [
//   //               Card(
//   //                 elevation: 4,
//   //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//   //                 child: Padding(
//   //                   padding: const EdgeInsets.all(16),
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       const Text(
//   //                         "Journey Details",
//   //                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //                       ),
//   //                       const SizedBox(height: 12),
//   //                       Row(
//   //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                         children: [
//   //                           Text(
//   //                             widget.sourceCity,
//   //                             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//   //                           ),
//   //                           const Icon(Icons.arrow_forward),
//   //                           Text(
//   //                             widget.destinationCity,
//   //                             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//   //                           ),
//   //                         ],
//   //                       ),
//   //                       const SizedBox(height: 10),
//   //                       Text("${widget.travelName} (${widget.busType})"),
//   //                       Text("Date: ${widget.journeyDate}"),
//   //                       Text("Departure: ${widget.departureTime}"),
//   //                       Text("Arrival: ${widget.arrivalTime}"),
//   //                       const Divider(height: 24),
//   //                       const Text(
//   //                         "Passenger & Seat Details",
//   //                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //                       ),
//   //                       const SizedBox(height: 10),
//   //                       ...widget.selectedSeats.asMap().entries.map((entry) {
//   //                         int index = entry.key;
//   //                         var seat = entry.value;
//   //                         return Padding(
//   //                           padding: const EdgeInsets.only(bottom: 8.0),
//   //                           child: Column(
//   //                             crossAxisAlignment: CrossAxisAlignment.start,
//   //                             children: [
//   //                               Text(
//   //                                 "Passenger ${index + 1}: ${index == 0 ? '${widget.title} ${widget.firstName} ${widget.lastName}' : 'Passenger${index + 1}'}",
//   //                                 style: const TextStyle(fontWeight: FontWeight.bold),
//   //                               ),
//   //                               Text("Seat: ${seat['SeatName']}"),
//   //                               Text("Type: ${seat['SeatType'] == 1 ? 'Sleeper' : 'Seater'}"),
//   //                               Text("Fare: ₹${seat['Price']['OfferedPrice']}"),
//   //                               if (index == 0) ...[
//   //                                 Text("Age: ${widget.age} | Gender: ${widget.gender}"),
//   //                                 Text("Phone: ${widget.phoneno}"),
//   //                                 Text("Email: ${widget.email}"),
//   //                               ],
//   //                             ],
//   //                           ),
//   //                         );
//   //                       }).toList(),
//   //                       const Divider(height: 24),
//   //                       const Text(
//   //                         "Boarding & Dropping",
//   //                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //                       ),
//   //                       const SizedBox(height: 10),
//   //                       Text("Boarding: ${widget.selectedBoardingPoint}"),
//   //                       Text("Dropping: ${widget.selectedDroppingPoint}"),
//   //                       const Divider(height: 24),
//   //                       Row(
//   //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                         children: [
//   //                           const Text(
//   //                             "Total Amount:",
//   //                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //                           ),
//   //                           Text(
//   //                             "₹${totalAmount.toStringAsFixed(2)}",
//   //                             style: const TextStyle(
//   //                               fontSize: 18,
//   //                               fontWeight: FontWeight.bold,
//   //                               color: Colors.redAccent,
//   //                             ),
//   //                           ),
//   //                         ],
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ),
//   //               const SizedBox(height: 24),
//   //               ElevatedButton(
//   //                 onPressed: _isLoading ? null : _openCheckout,
//   //                 style: ElevatedButton.styleFrom(
//   //                   backgroundColor: Colors.redAccent.shade700,
//   //                   padding: const EdgeInsets.symmetric(vertical: 16),
//   //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//   //                 ),
//   //                 child: _isLoading
//   //                     ? const SizedBox(
//   //                   height: 24,
//   //                   width: 24,
//   //                   child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//   //                 )
//   //                     : const Text(
//   //                   "PROCEED TO PAY",
//   //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//   //                 ),
//   //               ),
//   //               const SizedBox(height: 16),
//   //               Text(
//   //                 "By proceeding, you agree to our Terms and Conditions",
//   //                 textAlign: TextAlign.center,
//   //                 style: TextStyle(color: Colors.grey.shade600),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //         if (_isLoading)
//   //           const Center(child: CircularProgressIndicator()),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text("Confirm Booking"),
//       //   backgroundColor: Colors.redAccent.shade700,
//       //   actions: [
//       //     Container(
//       //
//       //       decoration: BoxDecoration(
//       //         color: Colors.white,
//       //         borderRadius: BorderRadius.circular(15),
//       //         boxShadow: [
//       //           BoxShadow(
//       //             color: Colors.grey.withOpacity(0.3),
//       //             spreadRadius: 1,
//       //             blurRadius: 5,
//       //           ),
//       //         ],
//       //       ),
//       //       child: TextButton(
//       //         onPressed: () {
//       //           // Close the alert dialog
//       //           Navigator.pop(context);
//       //
//       //           // Then close all screens until reaching HomePage, and pass a result
//       //           Navigator.popUntil(context, (route) => route.isFirst); // or a custom check
//       //           Navigator.pushReplacement(
//       //             context,
//       //             MaterialPageRoute(
//       //               builder: (context) => HomePage(initialIndex: 1),
//       //             ),
//       //           );
//       //         },
//       //         child: const Text("My Bookings",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),),
//       //       ),
//       //     ),
//       //   ],
//       //
//       // ),
//
//       appBar: AppBar(
//         title: const Text("Confirm Booking"),
//         backgroundColor: Colors.redAccent.shade700,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                   ),
//                 ],
//               ),
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                   minimumSize: Size.zero,
//                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.popUntil(context, (route) => route.isFirst);
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => HomePage(initialIndex: 1),
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   "Go To Home",
//                   style: TextStyle(
//                     color: Colors.redAccent,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 13,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Journey Details Card (same as before)
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Journey Details",
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               widget.sourceCity,
//                               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             const Icon(Icons.arrow_forward),
//                             Text(
//                               widget.destinationCity,
//                               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Text("${widget.travelName} (${widget.busType})"),
//                         Text("Date: ${widget.journeyDate}"),
//                         Text("Departure: ${widget.departureTime}"),
//                         Text("Arrival: ${widget.arrivalTime}"),
//                         // const Divider(height: 24),
//                         // const Text(
//                         //   "Passenger & Seat Details",
//                         //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         // ),
//                         // const SizedBox(height: 10),
//                         // ...widget.selectedSeats.asMap().entries.map((entry) {
//                         //   int index = entry.key;
//                         //   var seat = entry.value;
//                         //   return Padding(
//                         //     padding: const EdgeInsets.only(bottom: 8.0),
//                         //     child: Column(
//                         //       crossAxisAlignment: CrossAxisAlignment.start,
//                         //       children: [
//                         //         Text(
//                         //           "Passenger ${index + 1}: ${index == 0 ? '${widget.title} ${widget.firstName} ${widget.lastName}' : 'Passenger${index + 1}'}",
//                         //           style: const TextStyle(fontWeight: FontWeight.bold),
//                         //         ),
//                         //         Text("Seat: ${seat['SeatName']}"),
//                         //         Text("Type: ${seat['SeatType'] == 1 ? 'Sleeper' : 'Seater'}"),
//                         //         Text("Fare: ₹${seat['Price']['OfferedPrice']}"),
//                         //         if (index == 0) ...[
//                         //           Text("Age: ${widget.age} | Gender: ${widget.gender}"),
//                         //           Text("Phone: ${widget.phoneno}"),
//                         //           Text("Email: ${widget.email}"),
//                         //         ],
//                         //       ],
//                         //     ),
//                         //   );
//                         // }).toList(),
//                         const Divider(height: 24),
//                         const Text(
//                           "Boarding & Dropping",
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 10),
//                         Text("Boarding: ${widget.selectedBoardingPoint}"),
//                         Text("Dropping: ${widget.selectedDroppingPoint}"),
//                         const Divider(height: 24),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Total Amount:",
//                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               "₹${totalAmount.toStringAsFixed(2)}",
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.redAccent,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Passenger & Seat Details
//                 Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.only(top: 16),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Passenger & Seat Details",
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 12),
//
//                         // Display all passengers with their details
//                         ...widget.passengers.asMap().entries.map((entry) {
//                           final index = entry.key;
//                           final passenger = entry.value;
//                           final seat = passenger['Seat'];
//
//                           return Container(
//                             margin: const EdgeInsets.only(bottom: 16),
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey.shade300),
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Passenger ${index + 1}: ${passenger['Title']} ${passenger['FirstName']} ${passenger['LastName']}",
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text("Seat: ${seat['SeatName']}"),
//                                 Text("Type: ${seat['SeatType'] == 1 ? 'Sleeper' : 'Seater'}"),
//                                 Text("Fare: ₹${seat['Price']['OfferedPrice']}"),
//                                 const SizedBox(height: 8),
//                                 Text("Age: ${passenger['Age']} | Gender: ${passenger['Gender'] == "1" ? "Male" : "Female"}"),
//                                 Text("Phone: ${passenger['Phoneno']}"),
//                                 Text("Email: ${passenger['Email']}"),
//                                 if (passenger['LeadPassenger'] == true)
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8),
//                                     child: Text(
//                                       "Lead Passenger",
//                                       style: TextStyle(
//                                           color: Colors.green.shade700,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: _isLoading ? null : _openCheckout,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.redAccent.shade700,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   child: _isLoading
//                       ? const SizedBox(
//                     height: 24,
//                     width: 24,
//                     child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//                   )
//                       : const Text(
//                     "PROCEED TO PAY",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   "By proceeding, you agree to our Terms and Conditions",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.grey.shade600),
//                 ),
//                 // Rest of the UI (boarding points, total amount, payment button)
//                 // ... existing code
//               ],
//             ),
//           ),
//           if (_isLoading)
//             const Center(child: CircularProgressIndicator()),
//         ],
//       ),
//     );
//   }
// }



/// comission also adding finally





import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class BookSeat extends StatefulWidget {
  final String resultIndex;
  final String traceId;
  final String sourceCity;
  final String destinationCity;
  final String journeyDate;
  final String travelName;
  final String busType;
  final String arrivalTime;
  final String departureTime;
  final int? boardingPointIndex;
  final int? droppingPointIndex;
  final String selectedBoardingPoint;
  final String selectedDroppingPoint;
  // final List<Map<String, dynamic>> selectedSeats; // List of seats
  final bool leadPassenger;
  final int passengerId;
  final String title;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneno;
  final String gender;
  final String? idType;
  final String? idNumber;
  final String address;
  final String age;
  final List<Map<String, dynamic>> selectedSeats; // Changed to accept list of seats
  final List<Map<String, dynamic>> passengers; // All passengers data
  final VoidCallback onNavigateToHome;



  const BookSeat({
    super.key,
    required this.resultIndex,
    required this.traceId,
    required this.sourceCity,
    required this.destinationCity,
    required this.journeyDate,
    required this.travelName,
    required this.busType,
    required this.arrivalTime,
    required this.departureTime,
    required this.boardingPointIndex,
    required this.droppingPointIndex,
    required this.selectedBoardingPoint,
    required this.selectedDroppingPoint,
    required this.selectedSeats,
    required this.leadPassenger,
    required this.passengerId,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneno,
    required this.gender,
    this.idType,
    this.idNumber,
    required this.address,
    required this.age,
    required this.passengers,
    required this.onNavigateToHome
  });

  @override
  _BookSeatState createState() => _BookSeatState();
}

class _BookSeatState extends State<BookSeat> {
  late Razorpay _razorpay;
  bool _isLoading = false;
  double _commission = 0; // Add commission variable


  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _loadCommission(); // Load commission when widget initializes
  }

  // Calculate price with commission
  double _calculatePriceWithCommission(dynamic basePrice) {
    final price = double.tryParse(basePrice.toString()) ?? 0;
    return (price * (1 + _commission / 100)).roundToDouble();
  }

  // Calculate total amount for all seats with commission
  double get totalAmount => widget.selectedSeats.fold(
    0.0,
        (sum, seat) => sum + _calculatePriceWithCommission(seat['Price']['OfferedPrice']),
  );

  Future<void> _loadCommission() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('settings')
          .doc('commission')
          .get();
      setState(() {
        _commission = doc.data()?['percentage']?.toDouble() ?? 0;
      });
    } catch (e) {
      print('Error loading commission: $e');
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    setState(() {
      _isLoading = true;
    });

    String apiUrl = "https://api.razorpay.com/v1/payments/${response.paymentId}/capture";
    String key = "rzp_live_jRrlgHE9Hldmk5";
    String secret = "C1Cvhlrq3ZaqJXSEq7NFeEUm";

    var headers = {
      "Authorization": "Basic ${base64Encode(utf8.encode('$key:$secret'))}",
      "Content-Type": "application/json"
    };

    var body = jsonEncode({
      "amount": (totalAmount * 100).toInt(), // Total amount in paise
      "currency": "INR"
    });

    try {
      var captureResponse = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (captureResponse.statusCode == 200) {
        print("Payment Captured Successfully");
        bookSeat(context, response.paymentId!);
      } else {
        print("Failed to capture payment: ${captureResponse.body}");
        _showDialog(
          title: "Payment Capture Failed",
          message: "Payment was successful but could not be captured. Contact support.",
          isSuccess: false,
        );
      }
    } catch (e) {
      print("Error capturing payment: $e");
      _showDialog(
        title: "Error",
        message: "Failed to capture the payment. Please try again.",
        isSuccess: false,
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _isLoading = false;
    });
    _showDialog(
      title: "Payment Failed",
      message: "Error: ${response.message ?? 'Unknown error'}",
      isSuccess: false,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    _showDialog(
      title: "External Wallet Selected",
      message: "Wallet: ${response.walletName}",
      isSuccess: true,
    );
  }

  void _openCheckout() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var options = {
        'key': 'rzp_live_jRrlgHE9Hldmk5',
        'amount': (totalAmount * 100).toString(), // Total amount in paise
        'name': 'Namma Savaari',
        'description': 'Bus Ticket: ${widget.travelName}',
        'prefill': {
          'contact': widget.phoneno,
          'email': widget.email,
        },
        'theme': {'color': '#FF2291'},
      };

      _razorpay.open(options);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showDialog(
        title: "Error",
        message: "Failed to open payment gateway: $e",
        isSuccess: false,
      );
    }
  }

  void _showDialog({required String title, required String message, required bool isSuccess}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
  Future<void> bookSeat(BuildContext context, String paymentId) async {
    const String apiUrl = "http://65.0.115.185/bus-api/Book";

    // Construct passenger list from the passengers data
    List<Map<String, dynamic>> passengers = widget.passengers.map((passenger) {
      return {
        "LeadPassenger": passenger["LeadPassenger"],
        "PassengerId": passenger["PassengerId"],
        "Title": passenger["Title"],
        "FirstName": passenger["FirstName"],
        "LastName": passenger["LastName"],
        "Email": passenger["Email"],
        "Phoneno": passenger["Phoneno"],
        "Gender": passenger["Gender"],
        "IdType": passenger["IdType"],
        "IdNumber": passenger["IdNumber"],
        "Address": passenger["Address"],
        "Age": passenger["Age"],
        "Seat": passenger["Seat"],
      };
    }).toList();

    final Map<String, dynamic> requestBody = {
      "ClientId": "180187",
      "UserName": "Namma434",
      "Password": "Namma@4341",
      "ResultIndex": widget.resultIndex,
      "TraceId": widget.traceId,
      "BoardingPointId": widget.boardingPointIndex,
      "DroppingPointId": widget.droppingPointIndex,
      "RefID": paymentId,
      "Passenger": passengers,
    };

    const headers = {
      "Content-Type": "application/json",
      "Api-Token": "Namma@90434#34",
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['Error'] != null &&
            (responseData['Error']['ErrorCode'] != 0 || responseData['Error']['ErrorMessage'].isNotEmpty)) {
          setState(() {
            _isLoading = false;
          });
          _showDialog(
            title: "Booking Failed",
            message: responseData['Error']['ErrorMessage'] ?? 'Unknown error',
            isSuccess: false,
          );
          return;
        }

        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          final resultData = responseData['Result'];

          await FirebaseFirestore.instance
              .collection('customers')
              .doc(currentUser.uid)
              .collection('bookings')
              .add({
            'traceId': resultData['TraceId'],
            'bookingStatus': resultData['BusBookingStatus'],
            'invoiceAmount': resultData['InvoiceAmount'],
            'busId': resultData['BusId'],
            'ticketNumber': resultData['TicketNo'],
            'operatorPNR': resultData['TravelOperatorPNR'],
            'paymentId': paymentId,
            'paymentStatus': 'completed',
            'paymentAmount': totalAmount,
            'paymentCurrency': widget.selectedSeats[0]['Price']['CurrencyCode'],
            'paymentTime': FieldValue.serverTimestamp(),
            'journeyDetails': {
              'source': widget.sourceCity,
              'destination': widget.destinationCity,
              'date': widget.journeyDate,
              'travelName': widget.travelName,
              'busType': widget.busType,
              'seats': widget.selectedSeats.map((seat) => seat['SeatName']).toList(),
              'departureTime': widget.departureTime,
              'arrivalTime': widget.arrivalTime,
              'boardingPoint': widget.selectedBoardingPoint,
              'droppingPoint': widget.selectedDroppingPoint,
            },
            'passengerDetails': passengers.map((p) => {
              'name': '${p['Title']} ${p['FirstName']} ${p['LastName']}',
              'email': p['Email'],
              'phone': p['Phoneno'],
              'age': p['Age'],
              'gender': p['Gender'],
              'idType': p['IdType'],
              'idNumber': p['IdNumber'],
              'seat': p['Seat']['SeatName'],
            }).toList(),
            'createdAt': FieldValue.serverTimestamp(),
            'status': 'confirmed',
            'lastUpdated': FieldValue.serverTimestamp(),
          });

          await FirebaseFirestore.instance.collection('all_bookings').add({
            'userId': currentUser.uid,
            'ticketNumber': resultData['TicketNo'],
            'pnr': resultData['TravelOperatorPNR'],
            'bookingStatus': resultData['BusBookingStatus'],
            'amount': resultData['InvoiceAmount'],
            'journey': '${widget.sourceCity} to ${widget.destinationCity}',
            'travelDate': widget.journeyDate,
            'bookingTime': FieldValue.serverTimestamp(),
          });
        }

        setState(() {
          _isLoading = false;
        });

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("Booking Successful"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ticket No: ${responseData['Result']['TicketNo']}"),
                Text("PNR: ${responseData['Result']['TravelOperatorPNR']}"),
                Text("Status: ${responseData['Result']['BusBookingStatus']}"),
                const SizedBox(height: 10),
                const Text("Booking confirmation has been sent to your email."),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("ok"),
              ),

            ],
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        _showDialog(
          title: "Booking Failed",
          message: "Server error: ${response.statusCode}",
          isSuccess: false,
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showDialog(
        title: "Error",
        message: "An error occurred: $e",
        isSuccess: false,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Booking"),
        backgroundColor: Colors.redAccent.shade700,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 8.0),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(12),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.grey.withOpacity(0.3),
        //             spreadRadius: 1,
        //             blurRadius: 4,
        //           ),
        //         ],
        //       ),
        //       child: TextButton(
        //         style: TextButton.styleFrom(
        //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        //           minimumSize: Size.zero,
        //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //         ),
        //         onPressed: () {
        //           Navigator.pop(context);
        //           Navigator.popUntil(context, (route) => route.isFirst);
        //           Navigator.pushReplacement(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => HomePage(initialIndex: 1),
        //             ),
        //           );
        //         },
        //         child: const Text(
        //           "Go To Home",
        //           style: TextStyle(
        //             color: Colors.redAccent,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 13,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Journey Details Card (same as before)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Journey Details",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.sourceCity,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.arrow_forward),
                            Text(
                              widget.destinationCity,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text("${widget.travelName} (${widget.busType})"),
                        Text("Date: ${widget.journeyDate}"),
                        Text("Departure: ${widget.departureTime}"),
                        Text("Arrival: ${widget.arrivalTime}"),
                        const Divider(height: 24),
                        const Text(
                          "Boarding & Dropping",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text("Boarding: ${widget.selectedBoardingPoint}"),
                        Text("Dropping: ${widget.selectedDroppingPoint}"),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Amount:",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            // Text(
                            //   "₹${totalAmount.toStringAsFixed(2)}",
                            //   style: const TextStyle(
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.redAccent,
                            //   ),
                            // ),

                            Text(
                              "₹${totalAmount.toStringAsFixed(0)}", // Already uses the commission-included total
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Passenger & Seat Details
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(top: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Passenger & Seat Details",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),

                        // Display all passengers with their details
                        ...widget.passengers.asMap().entries.map((entry) {
                          final index = entry.key;
                          final passenger = entry.value;
                          final seat = passenger['Seat'];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Passenger ${index + 1}: ${passenger['Title']} ${passenger['FirstName']} ${passenger['LastName']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text("Seat: ${seat['SeatName']}"),
                                Text("Type: ${seat['SeatType'] == 1 ? 'Sleeper' : 'Seater'}"),
                                // Text("Fare: ₹${seat['Price']['OfferedPrice']}"),

                                Text("Fare: ₹${_calculatePriceWithCommission(seat['Price']['OfferedPrice'])}"),
                                const SizedBox(height: 8),
                                Text("Age: ${passenger['Age']} | Gender: ${passenger['Gender'] == "1" ? "Male" : "Female"}"),
                                Text("Phone: ${passenger['Phoneno']}"),
                                Text("Email: ${passenger['Email']}"),
                                if (passenger['LeadPassenger'] == true)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      "Lead Passenger",
                                      style: TextStyle(
                                          color: Colors.green.shade700,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _openCheckout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                      : const Text(
                    "PROCEED TO PAY",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "By proceeding, you agree to our Terms and Conditions",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                // Rest of the UI (boarding points, total amount, payment button)
                // ... existing code
              ],
            ),
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

class CommissionProvider extends ChangeNotifier {
  double _commission = 0;

  double get commission => _commission;

  Future<void> loadCommission() async {
    final doc = await FirebaseFirestore.instance
        .collection('settings')
        .doc('commission')
        .get();
    _commission = doc.data()?['percentage']?.toDouble() ?? 0;
    notifyListeners();
  }
}



//response is printing

// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class BookSeat extends StatefulWidget {
//   // Fields (same as in your provided code)
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
//   final dynamic boardingPointIndex;
//   final dynamic droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//
//   final bool leadPassenger;
//   final int passengerId;
//   final String title;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneno;
//   final String gender;
//   final String? idType;
//   final String? idNumber;
//   final String address;
//   final String age;
//
//   const BookSeat({
//     Key? key,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.columnNo,
//     required this.height,
//     required this.isMalesSeat,
//     required this.isLadiesSeat,
//     required this.isUpper,
//     required this.rowNo,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatName,
//     required this.seatStatus,
//     required this.width,
//     required this.seatType,
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
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.leadPassenger,
//     required this.passengerId,
//     required this.firstName,
//     required this.title,
//     required this.lastName,
//     required this.address,
//     required this.email,
//     required this.phoneno,
//     required this.age,
//     required this.gender,
//     required this.idNumber,
//     required this.idType,
//   }) : super(key: key);
//
//   @override
//   _BookSeatState createState() => _BookSeatState();
// }
//
// class _BookSeatState extends State<BookSeat> {
//   late Razorpay _razorpay;
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     print("Payment Successful: ${response.paymentId}");
//     bookSeat(context);
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     print("Payment Failed: ${response.message}");
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     print("External Wallet Selected: ${response.walletName}");
//   }
//
//   void _startPayment() {
//     var options = {
//       'key': 'rzp_test_0JqfNU3fC2HG7Z',
//       'amount': widget.publishedPriceRoundedOff * 100,
//       'name': 'Namma Savaari',
//       'description': 'Bus Seat Booking Payment',
//       'theme': {'color': '#ff2291'},
//       'prefill': {
//         'contact': widget.phoneno,
//         'email': widget.email,
//       },
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   Future<void> bookSeat(BuildContext context) async {
//     const String apiUrl = "http://3.7.121.234/bus-api/Book";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": widget.resultIndex,
//       "TraceId": widget.traceId,
//       "BoardingPointId": widget.boardingPointIndex,
//       "DroppingPointId": widget.droppingPointIndex,
//       "RefID": "",
//       "Passenger": [
//         {
//           "LeadPassenger": widget.leadPassenger,
//           "FirstName": widget.firstName,
//           "LastName": widget.lastName,
//           "Email": widget.email,
//           "Phoneno": widget.phoneno,
//         }
//       ]
//     };
//
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       print("Response Status Code: ${response.statusCode}");
//       print("Response Body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         print("Booking Successful: $responseData");
//
//         final currentUser = FirebaseAuth.instance.currentUser;
//         if (currentUser != null) {
//           await FirebaseFirestore.instance
//               .collection('customers')
//               .doc(currentUser.uid)
//               .collection('bookings')
//               .add(responseData);
//         }
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Booking Successful"), backgroundColor: Colors.green),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Booking Failed: ${response.body}"), backgroundColor: Colors.red),
//         );
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Book Seat")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _startPayment,
//           child: Text("Confirm Booking"),
//         ),
//       ),
//     );
//   }
// }






// dummy

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'cancel_ticket_screen.dart';
//
// class BookSeat extends StatelessWidget {
//   // Fields (same as in your provided code)
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
//   final dynamic boardingPointIndex;
//   final dynamic droppingPointIndex;
//   final String selectedBoardingPoint;
//   final String selectedDroppingPoint;
//
//   final bool leadPassenger;
//   final int passengerId;
//   final String title;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneno;
//   final String gender;
//   final String? idType;
//   final String? idNumber;
//   final String address;
//   final String age;
//
//   const BookSeat({
//     Key? key,
//     required this.resultIndex,
//     required this.traceId,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.journeyDate,
//     required this.travelName,
//     required this.busType,
//     required this.arrivalTime,
//     required this.departureTime,
//     required this.columnNo,
//     required this.height,
//     required this.isMalesSeat,
//     required this.isLadiesSeat,
//     required this.isUpper,
//     required this.rowNo,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatName,
//     required this.seatStatus,
//     required this.width,
//     required this.seatType,
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
//     required this.boardingPointIndex,
//     required this.droppingPointIndex,
//     required this.selectedBoardingPoint,
//     required this.selectedDroppingPoint,
//     required this.leadPassenger,
//     required this.passengerId,
//     required this.firstName,
//     required this.title,
//     required this.lastName,
//     required this.address,
//     required this.email,
//     required this.phoneno,
//     required this.age,
//     required this.gender,
//     required this.idNumber,
//     required this.idType,
//   }) : super(key: key);
//
//   // Future<void> bookSeat(BuildContext context) async {
//   //   const String apiUrl = "https://bus.srdvapi.com/v5/rest/Book";
//   //
//   //   final Map<String, dynamic> requestBody = {
//   //     "ClientId": "180187",
//   //     "UserName": "Namma434",
//   //     "Password": "Namma@4341",
//   //     "ResultIndex": resultIndex,
//   //     "TraceId": traceId,
//   //     "BoardingPointId": boardingPointIndex,
//   //     "DroppingPointId": droppingPointIndex,
//   //     "RefID": "",
//   //     "Passenger": [
//   //       {
//   //         "LeadPassenger": leadPassenger,
//   //         "PassengerId": passengerId,
//   //         "Title": title,
//   //         "FirstName": firstName,
//   //         "LastName": lastName,
//   //         "Email": email,
//   //         "Phoneno": phoneno,
//   //         "Gender": gender,
//   //         "IdType": idType,
//   //         "IdNumber": idNumber,
//   //         "Address": address,
//   //         "Age": age,
//   //         "Seat": {
//   //           "ColumnNo": columnNo,
//   //           "Height": height,
//   //           "IsLadiesSeat": isLadiesSeat,
//   //           "IsMalesSeat": isMalesSeat,
//   //           "IsUpper": isUpper,
//   //           "RowNo": rowNo,
//   //           "SeatFare": seatFare,
//   //           "SeatIndex": seatIndex,
//   //           "SeatName": seatName,
//   //           "SeatStatus": seatStatus,
//   //           "SeatType": seatType,
//   //           "Width": width,
//   //           "Price": {
//   //             "CurrencyCode": currencyCode,
//   //             "BasePrice": basePrice,
//   //             "Tax": tax,
//   //             "OtherCharges": otherCharges,
//   //             "Discount": discount,
//   //             "PublishedPrice": publishedPrice,
//   //             "PublishedPriceRoundedOff": publishedPriceRoundedOff,
//   //             "OfferedPrice": offeredPrice,
//   //             "OfferedPriceRoundedOff": offeredPriceRoundedOff,
//   //             "AgentCommission": agentCommission,
//   //             "AgentMarkUp": agentMarkUp,
//   //             "TDS": tds,
//   //             "GST": {
//   //               "CGSTAmount": cgstAmount,
//   //               "CGSTRate": cgstRate,
//   //               "CessAmount": cessAmount,
//   //               "CessRate": cessRate,
//   //               "IGSTAmount": igstAmount,
//   //               "IGSTRate": igstRate,
//   //               "SGSTAmount": sgstAmount,
//   //               "SGSTRate": sgstRate,
//   //               "TaxableAmount": taxableAmount,
//   //             },
//   //           },
//   //         },
//   //       }
//   //     ]
//   //   };
//   //
//   //   const headers = {
//   //     "Content-Type": "application/json",
//   //     "Api-Token": "Namma@90434#34",
//   //   };
//   //
//   //   try {
//   //     final response = await http.post(
//   //       Uri.parse(apiUrl),
//   //       headers: headers,
//   //       body: jsonEncode(requestBody),
//   //     );
//   //
//   //     if (response.statusCode == 200) {
//   //       // Booking successful
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text("Booking Successful!")),
//   //       );
//   //       print("Booking Successful: ${response.body}");
//   //     } else {
//   //       // Booking failed
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text("Booking Failed: ${response.statusCode}"),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //       print("Booking Failed: ${response.statusCode}");
//   //       print("Error: ${response.body}");
//   //     }
//   //   } catch (e) {
//   //     // Error occurred
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text("An error occurred: $e"),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );
//   //     print("An error occurred: $e");
//   //   }
//   // }
//
//   Future<void> bookSeat(BuildContext context) async {
//     const String apiUrl = "https://bus.srdvapi.com/v5/rest/Book";
//
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "ResultIndex": resultIndex,
//       "TraceId": traceId,
//       "BoardingPointId": boardingPointIndex,
//       "DroppingPointId": droppingPointIndex,
//       "RefID": "",
//       "Passenger": [
//         {
//           "LeadPassenger": leadPassenger,
//           "PassengerId": passengerId,
//           "Title": title,
//           "FirstName": firstName,
//           "LastName": lastName,
//           "Email": email,
//           "Phoneno": phoneno,
//           "Gender": gender,
//           "IdType": idType,
//           "IdNumber": idNumber,
//           "Address": address,
//           "Age": age,
//           "Seat": {
//             "ColumnNo": columnNo,
//             "Height": height,
//             "IsLadiesSeat": isLadiesSeat,
//             "IsMalesSeat": isMalesSeat,
//             "IsUpper": isUpper,
//             "RowNo": rowNo,
//             "SeatFare": seatFare,
//             "SeatIndex": seatIndex,
//             "SeatName": seatName,
//             "SeatStatus": seatStatus,
//             "SeatType": seatType,
//             "Width": width,
//             "Price": {
//               "CurrencyCode": currencyCode,
//               "BasePrice": basePrice,
//               "Tax": tax,
//               "OtherCharges": otherCharges,
//               "Discount": discount,
//               "PublishedPrice": publishedPrice,
//               "PublishedPriceRoundedOff": publishedPriceRoundedOff,
//               "OfferedPrice": offeredPrice,
//               "OfferedPriceRoundedOff": offeredPriceRoundedOff,
//               "AgentCommission": agentCommission,
//               "AgentMarkUp": agentMarkUp,
//               "TDS": tds,
//               "GST": {
//                 "CGSTAmount": cgstAmount,
//                 "CGSTRate": cgstRate,
//                 "CessAmount": cessAmount,
//                 "CessRate": cessRate,
//                 "IGSTAmount": igstAmount,
//                 "IGSTRate": igstRate,
//                 "SGSTAmount": sgstAmount,
//                 "SGSTRate": sgstRate,
//                 "TaxableAmount": taxableAmount,
//               },
//             },
//           },
//         }
//       ]
//     };
//
//     const headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         final String busId = responseData['BusId']; // Extract BusId
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Booking Successful!")),
//         );
//         print("Booking Successful: ${response.body}");
//
//         // Navigate to CancelTicketScreen with BusId and SeatIndex
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CancelTicketScreen(
//               busId: busId,
//               seatIndex: seatIndex,
//             ),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Booking Failed: ${response.statusCode}"),
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
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Booking Confirmation"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => bookSeat(context),
//           child: Text("Confirm Booking"),
//         ),
//       ),
//     );
//   }
// }
