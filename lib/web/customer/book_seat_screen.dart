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

// response not printing ofter integrated razorpay


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

  final dynamic boardingPointIndex;
  final dynamic droppingPointIndex;
  final String selectedBoardingPoint;
  final String selectedDroppingPoint;

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

  const BookSeat({
    Key? key,
    required this.resultIndex,
    required this.traceId,
    required this.sourceCity,
    required this.destinationCity,
    required this.journeyDate,
    required this.travelName,
    required this.busType,
    required this.arrivalTime,
    required this.departureTime,
    required this.columnNo,
    required this.height,
    required this.isMalesSeat,
    required this.isLadiesSeat,
    required this.isUpper,
    required this.rowNo,
    required this.seatFare,
    required this.seatIndex,
    required this.seatName,
    required this.seatStatus,
    required this.width,
    required this.seatType,
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
    required this.boardingPointIndex,
    required this.droppingPointIndex,
    required this.selectedBoardingPoint,
    required this.selectedDroppingPoint,
    required this.leadPassenger,
    required this.passengerId,
    required this.firstName,
    required this.title,
    required this.lastName,
    required this.address,
    required this.email,
    required this.phoneno,
    required this.age,
    required this.gender,
    required this.idNumber,
    required this.idType,
  }) : super(key: key);

  @override
  _BookSeatState createState() => _BookSeatState();
}

class _BookSeatState extends State<BookSeat> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Successful! ID: ${response.paymentId}"),
        backgroundColor: Colors.green,
      ),
    );
    bookSeat(context); // Call bookSeat after successful payment
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Failed: ${response.message}"),
        backgroundColor: Colors.redAccent.shade700,
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("External Wallet Selected: ${response.walletName}"),
      ),
    );
  }

  void _startPayment() {
    var options = {
      'key': 'rzp_test_0JqfNU3fC2HG7Z', // Replace with your Razorpay API Key
      'amount': (widget.publishedPriceRoundedOff * 100), // Amount in paise
      'name': 'Namma Savaari',
      'description': 'Bus Ticket Booking',
      'prefill': {
        'contact': widget.phoneno,
        'email': widget.email,
      },
      'theme': {'color': '#ff2291'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> bookSeat(BuildContext context) async {
    const String apiUrl = "http://3.7.121.234/bus-api/Book";

    final Map<String, dynamic> requestBody = {
      "ClientId": "180187",
      "UserName": "Namma434",
      "Password": "Namma@4341",
      "ResultIndex": widget.resultIndex,
      "TraceId": widget.traceId,
      "BoardingPointId": widget.boardingPointIndex,
      "DroppingPointId": widget.droppingPointIndex,
      "Passenger": [
        {
          "FirstName": widget.firstName,
          "LastName": widget.lastName,
          "Email": widget.email,
          "Phoneno": widget.phoneno,
          "Seat": {"SeatName": widget.seatName}
        }
      ]
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );
      print("Booking Failed: ${response.statusCode}");
      print("Error: ${response.body}");
      print("Booking Successful:1");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Booking Successful!"), backgroundColor: Colors.green),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Booking Failed: ${response.body}"), backgroundColor: Colors.redAccent.shade700),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e"), backgroundColor: Colors.redAccent.shade700),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking Confirmation")),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent.shade700,
          ),
          onPressed: _startPayment, // Start payment before booking
          child: Text("Confirm Booking",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
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
