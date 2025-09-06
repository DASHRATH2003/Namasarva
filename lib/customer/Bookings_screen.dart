// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
//
// class BookingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final currentUser = FirebaseAuth.instance.currentUser;
//
//     if (currentUser == null) {
//       return const Center(
//         child: Text('Please login to view your bookings'),
//       );
//     }
//
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('customers')
//             .doc(currentUser.uid)
//             .collection('bookings')
//             .orderBy('createdAt', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return const Center(child: Text('Error loading bookings'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.receipt_long, size: 60, color: Colors.grey),
//                   SizedBox(height: 16),
//                   Text(
//                     'No bookings yet',
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Your upcoming trips will appear here',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final booking = snapshot.data!.docs[index];
//               final journey = booking['journeyDetails'];
//               final passenger = booking['passengerDetails'];
//               final date = (booking['createdAt'] as Timestamp).toDate();
//               final formattedDate = DateFormat('MMM dd, yyyy').format(date);
//               final formattedTime = DateFormat('hh:mm a').format(date);
//
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 6,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     // Header with status
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: _getStatusColor(booking['bookingStatus']),
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(12),
//                           topRight: Radius.circular(12),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             booking['ticketNumber'],
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             booking['bookingStatus'].toString().toUpperCase(),
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     // Journey details
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Route
//                           // Route
//                           SizedBox(
//                             width: double.infinity, // Take full width
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8),
//                                     child: Text(
//                                       journey['source'],
//                                       style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   const Icon(Icons.arrow_forward,
//                                       color: Colors.grey),
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8),
//                                     child: Text(
//                                       journey['destination'],
//                                       style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//
//                           const SizedBox(height: 12),
//
//                           // Travel details
//                           SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               children: [
//                                 const Icon(Icons.directions_bus,
//                                     size: 16, color: Colors.grey),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   '${journey['travelName']} • ${journey['busType']}',
//                                   style: const TextStyle(color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//
//                           // Date and seat
//                           Row(
//                             children: [
//                               const Icon(Icons.calendar_today,
//                                   size: 16, color: Colors.grey),
//                               const SizedBox(width: 8),
//                               Text(
//                                 '${_formatDate(journey['date'])} • Seat ${journey['seatNumber']}',
//                                 style: const TextStyle(color: Colors.grey),
//                               ),
//                             ],
//                           ),
//
//                           const SizedBox(height: 8),
//
//                           // Boarding point
//                           Row(
//                             children: [
//                               const Icon(Icons.location_on,
//                                   size: 16, color: Colors.grey),
//                               const SizedBox(width: 8),
//                               Text(
//                                 'Boarding: ${journey['boardingPoint']}',
//                                 style: const TextStyle(color: Colors.grey),
//                               ),
//                             ],
//                           ),
//
//                           const SizedBox(height: 16),
//                           const Divider(height: 1),
//                           const SizedBox(height: 16),
//
//                           // Passenger details
//                           const Text(
//                             'Passenger Details',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//
//                           const SizedBox(height: 8),
//
//                           Text(
//                             passenger['name'],
//                             style: const TextStyle(fontSize: 15),
//                           ),
//
//                           const SizedBox(height: 4),
//
//                           Text(
//                             '${passenger['age']} yrs • ${passenger['gender']}',
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//
//                           const SizedBox(height: 16),
//                           const Divider(height: 1),
//                           const SizedBox(height: 16),
//
//                           // Booking and payment info
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Booked on',
//                                     style: TextStyle(color: Colors.grey),
//                                   ),
//                                   Text('$formattedDate at $formattedTime'),
//                                 ],
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   const Text(
//                                     'Amount paid',
//                                     style: TextStyle(color: Colors.grey),
//                                   ),
//                                   Text(
//                                     '₹${booking['invoiceAmount']}',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                       color: Colors.green.shade700,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     /// Final change
//
//                     // Container(
//                     //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                     //   decoration: BoxDecoration(
//                     //     border: Border(top: BorderSide(color: Colors.grey.shade200)),
//                     //   ),
//                     //   child: Row(
//                     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //     children: [
//                     //       TextButton(
//                     //         onPressed: () {
//                     //           // View ticket details
//                     //           _showBookingDetails(context, booking);
//                     //         },
//                     //         child: Text(
//                     //           'VIEW TICKET',
//                     //           style: TextStyle(color: Colors.redAccent.shade700),
//                     //         ),
//                     //       ),
//                     //
//                     //       if (booking['bookingStatus'] == 'Confirmed')
//                     //         TextButton(
//                     //           onPressed: () {
//                     //             // Cancel booking - pass the full document snapshot
//                     //             _showCancelDialog(context, booking);
//                     //           },
//                     //           child: Text(
//                     //             'CANCEL',
//                     //             style: TextStyle(color: Colors.red),
//                     //           ),
//                     //         ),
//                     //     ],
//                     //   ),
//                     // ),
//
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 12),
//                       decoration: BoxDecoration(
//                         border: Border(
//                             top: BorderSide(color: Colors.grey.shade200)),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           TextButton(
//                             onPressed: () {
//                               // View ticket details
//                               _showBookingDetails(context, booking);
//                             },
//                             child: Text(
//                               'VIEW TICKET',
//                               style:
//                                   TextStyle(color: Colors.redAccent.shade700),
//                             ),
//                           ),
//                           if (booking['bookingStatus'] == 'Confirmed')
//                             TextButton(
//                               onPressed: () {
//                                 _showCancelDialog(context, booking);
//                               },
//                               child: const Text(
//                                 'CANCEL',
//                                 style: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'confirmed':
//         return Colors.green.shade600;
//       case 'cancelled':
//         return Colors.red.shade600;
//       case 'pending':
//         return Colors.orange.shade600;
//       default:
//         return Colors.blue.shade600;
//     }
//   }
//
//   String _formatDate(String dateString) {
//     try {
//       final date = DateTime.parse(dateString);
//       return DateFormat('MMM dd, yyyy').format(date);
//     } catch (e) {
//       return dateString;
//     }
//   }
//
//   void _showBookingDetails(BuildContext context, DocumentSnapshot booking) {
//     final journey = booking['journeyDetails'];
//     final passenger = booking['passengerDetails'];
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Ticket Details'),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Ticket No: ${booking['ticketNumber']}',
//                   style: const TextStyle(fontWeight: FontWeight.bold)),
//               Text('PNR: ${booking['operatorPNR']}'),
//               const SizedBox(height: 16),
//               const Text('Journey Details',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               Text('${journey['source']} to ${journey['destination']}'),
//               Text(_formatDate(journey['date'])),
//               Text('${journey['travelName']} (${journey['busType']})'),
//               Text('Seat: ${journey['seatNumber']}'),
//               const SizedBox(height: 16),
//               const Text('Timings',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               Text('Departure: ${journey['departureTime']}'),
//               Text('Arrival: ${journey['arrivalTime']}'),
//               const SizedBox(height: 16),
//               const Text('Boarding Point',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               Text(journey['boardingPoint']),
//               const SizedBox(height: 16),
//               const Text('Passenger Details',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               Text(passenger['name']),
//               Text('${passenger['age']} yrs • ${passenger['gender']}'),
//               Text(passenger['phone']),
//               const SizedBox(height: 16),
//               const Text('Payment Details',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               Text('Amount: ₹${booking['invoiceAmount']}'),
//               Text('Status: ${booking['bookingStatus']}'),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('CLOSE'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // void _showCancelDialog(BuildContext context, DocumentSnapshot booking) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) => AlertDialog(
//   //       title: Text('Cancel Booking'),
//   //       content: Text('Are you sure you want to cancel this booking?'),
//   //       actions: [
//   //         TextButton(
//   //           onPressed: () => Navigator.pop(context),
//   //           child: Text('NO'),
//   //         ),
//   //         TextButton(
//   //           onPressed: () async {
//   //             Navigator.pop(context); // Close the dialog
//   //             await _cancelBooking(context, booking);
//   //           },
//   //           child: Text('YES, CANCEL', style: TextStyle(color: Colors.red)),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   //
//   // Future<void> _cancelBooking(BuildContext context, DocumentSnapshot booking) async {
//   //   final currentUser = FirebaseAuth.instance.currentUser;
//   //   if (currentUser == null) return;
//   //
//   //   // Show loading indicator
//   //   showDialog(
//   //     context: context,
//   //     barrierDismissible: false,
//   //     builder: (context) => Center(child: CircularProgressIndicator()),
//   //   );
//   //
//   //   try {
//   //     // First call the cancellation API
//   //     const String apiUrl = "http://3.7.121.234/bus-api/cancelbusbooking";
//   //
//   //     final Map<String, dynamic> requestBody = {
//   //       "EndUserIp": "122.171.16.249", // You might want to get the actual user IP
//   //       "ClientId": "180187",
//   //       "UserName": "Namma434",
//   //       "Password": "Namma@4341",
//   //       "BusId": booking['busId'].toString(), // From the booking document
//   //       "SeatId": booking['journeyDetails']['seatNumber'], // From journey details
//   //       "Remarks": "Cancelled by user through app"
//   //     };
//   //
//   //     const headers = {
//   //       "Content-Type": "application/json",
//   //       "Api-Token": "Namma@90434#34",
//   //     };
//   //
//   //     final response = await http.post(
//   //       Uri.parse(apiUrl),
//   //       headers: headers,
//   //       body: jsonEncode(requestBody),
//   //     );
//   //
//   //     // Hide loading indicator
//   //     Navigator.pop(context);
//   //
//   //     if (response.statusCode == 200) {
//   //       final responseData = jsonDecode(response.body);
//   //
//   //       // Check if API cancellation was successful
//   //       if (responseData['Error'] != null &&
//   //           (responseData['Error']['ErrorCode'] != 0 ||
//   //               responseData['Error']['ErrorMessage'].isNotEmpty)) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(content: Text('Cancellation failed: ${responseData['Error']['ErrorMessage']}')),
//   //         );
//   //         return;
//   //       }
//   //
//   //       // API cancellation successful - now update Firestore
//   //       await FirebaseFirestore.instance
//   //           .collection('customers')
//   //           .doc(currentUser.uid)
//   //           .collection('bookings')
//   //           .doc(booking.id)
//   //           .update({
//   //         'bookingStatus': 'Cancelled',
//   //         'lastUpdated': FieldValue.serverTimestamp(),
//   //         'cancellationTime': FieldValue.serverTimestamp(),
//   //         'cancellationDetails': {
//   //           'apiResponse': responseData,
//   //           'cancelledAt': DateTime.now().toIso8601String(),
//   //         }
//   //       });
//   //
//   //       // Also update the global bookings collection if you have one
//   //       // You might need to query the global collection first to find the matching booking
//   //       // This part depends on your database structure
//   //
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Booking cancelled successfully')),
//   //       );
//   //     } else {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Cancellation failed: Server error ${response.statusCode}')),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     // Hide loading indicator in case of error
//   //     Navigator.pop(context);
//   //
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Cancellation failed: $e')),
//   //     );
//   //   }
//   // }
//
// // First, add this list of cancellation reasons at the class level
//   final List<String> cancellationReasons = [
//     'Change of travel plans',
//     'Found better alternative',
//     'Bus timing not suitable',
//     'Personal emergency',
//     'Other reason'
//   ];
//
//   BookingsScreen({super.key});
//
// // Update the _showCancelDialog method to include remarks selection
//
//   void _showCancelDialog(BuildContext context, DocumentSnapshot booking) {
//     String selectedReason = cancellationReasons[0]; // Default reason
//
//     showDialog(
//       context: context,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: const Text('Cancel Booking'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text('Are you sure you want to cancel this booking?'),
//                 const SizedBox(height: 16),
//                 DropdownButtonFormField<String>(
//                   value: selectedReason,
//                   items: cancellationReasons.map((String reason) {
//                     return DropdownMenuItem<String>(
//                       value: reason,
//                       child: Text(reason),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedReason = value!;
//                     });
//                   },
//                   decoration: const InputDecoration(
//                     labelText: 'Reason for cancellation',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('NO'),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   Navigator.pop(context); // Close the dialog
//                   await _cancelBooking(context, booking, selectedReason);
//                 },
//                 child: const Text('YES, CANCEL',
//                     style: TextStyle(color: Colors.red)),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
// // Update the _cancelBooking method to accept remarks parameter
// //   Future<void> _cancelBooking(BuildContext context, DocumentSnapshot booking, String remarks) async {
// //     final currentUser = FirebaseAuth.instance.currentUser;
// //     if (currentUser == null) return;
// //
// //     // Show loading indicator
// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (context) => Center(child: CircularProgressIndicator()),
// //     );
// //
// //     try {
// //       // Prepare the cancellation API request
// //       const String apiUrl = "http://3.7.121.234/bus-api/cancelbusbooking";
// //
// //       // Get BusId from the booking document (top level field)
// //       final busId = booking['busId'] as int;
// //
// //       // Get SeatId from journeyDetails
// //       final seatId = int.parse(booking['journeyDetails']['seatNumber'].toString());
// //
// //       final Map<String, dynamic> requestBody = {
// //         "EndUserIp": "122.171.16.249", // You might want to get the actual user IP
// //         "ClientId": "180187",
// //         "UserName": "Namma434",
// //         "Password": "Namma@4341",
// //         "BusId": busId,
// //         "SeatId": seatId,
// //         "Remarks": remarks // Use the selected reason
// //       };
// //
// //       const headers = {
// //         "Content-Type": "application/json",
// //         "Api-Token": "Namma@90434#34",
// //       };
// //
// //       final response = await http.post(
// //         Uri.parse(apiUrl),
// //         headers: headers,
// //         body: jsonEncode(requestBody),
// //       );
// //
// //       // Hide loading indicator
// //       Navigator.pop(context);
// //
// //       if (response.statusCode == 200) {
// //         final responseData = jsonDecode(response.body);
// //
// //         // Show API response in dialog
// //         await showDialog(
// //           context: context,
// //           builder: (context) => AlertDialog(
// //             title: Text('Cancellation Response'),
// //             content: SingleChildScrollView(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   if (responseData['Error'] != null)
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text('Error Code: ${responseData['Error']['ErrorCode']}'),
// //                         Text('Message: ${responseData['Error']['ErrorMessage']}'),
// //                       ],
// //                     ),
// //                   if (responseData['Response'] != null)
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text('Status: ${responseData['Response']['Status']}'),
// //                         Text('CancellationId: ${responseData['Response']['CancellationId']}'),
// //                         Text('RefundAmount: ${responseData['Response']['RefundAmount']}'),
// //                       ],
// //                     ),
// //                 ],
// //               ),
// //             ),
// //             actions: [
// //               TextButton(
// //                 onPressed: () => Navigator.pop(context),
// //                 child: Text('OK'),
// //               ),
// //             ],
// //           ),
// //         );
// //
// //         // Check if API cancellation was successful
// //         if (responseData['Error'] == null ||
// //             (responseData['Error']['ErrorCode'] == 0 &&
// //                 responseData['Error']['ErrorMessage'].isEmpty)) {
// //
// //           // Update Firestore document
// //           await FirebaseFirestore.instance
// //               .collection('customers')
// //               .doc(currentUser.uid)
// //               .collection('bookings')
// //               .doc(booking.id)
// //               .update({
// //             'bookingStatus': 'Cancelled',
// //             'lastUpdated': FieldValue.serverTimestamp(),
// //             'cancellationTime': FieldValue.serverTimestamp(),
// //             'cancellationDetails': {
// //               'apiResponse': responseData,
// //               'cancelledAt': DateTime.now().toIso8601String(),
// //               'refundAmount': responseData['Response']?['RefundAmount'],
// //               'cancellationReason': remarks, // Store the selected reason
// //             }
// //           });
// //
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(content: Text('Booking status updated to Cancelled')),
// //           );
// //         }
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Cancellation failed: Server error ${response.statusCode}')),
// //         );
// //       }
// //     } catch (e) {
// //       // Hide loading indicator in case of error
// //       Navigator.pop(context);
// //
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Cancellation failed: $e')),
// //       );
// //     }
// //   }
//
//   /// Final Change
//
//   // Future<void> _cancelBooking(BuildContext context, DocumentSnapshot booking, String remarks) async {
//   //   final currentUser = FirebaseAuth.instance.currentUser;
//   //   if (currentUser == null) return;
//   //
//   //   // Show loading indicator
//   //   showDialog(
//   //     context: context,
//   //     barrierDismissible: false,
//   //     builder: (context) => Center(child: CircularProgressIndicator()),
//   //   );
//   //
//   //   try {
//   //     const String apiUrl = "http://3.7.121.234/bus-api/cancelbusbooking";
//   //
//   //     final busId = booking['busId'] is int
//   //         ? booking['busId'] as int
//   //         : int.parse(booking['busId'].toString());
//   //
//   //     final seatId = booking['journeyDetails']['seatNumber'] is int
//   //         ? booking['journeyDetails']['seatNumber'] as int
//   //         : int.parse(booking['journeyDetails']['seatNumber'].toString());
//   //
//   //     final Map<String, dynamic> requestBody = {
//   //       "EndUserIp": "122.171.16.249",
//   //       "ClientId": "180187",
//   //       "UserName": "Namma434",
//   //       "Password": "Namma@4341",
//   //       "BusId": busId,
//   //       "SeatId": seatId,
//   //       "Remarks": remarks
//   //     };
//   //
//   //     const headers = {
//   //       "Content-Type": "application/json",
//   //       "Api-Token": "Namma@90434#34",
//   //     };
//   //
//   //     final response = await http.post(
//   //       Uri.parse(apiUrl),
//   //       headers: headers,
//   //       body: jsonEncode(requestBody),
//   //     );
//   //
//   //     // Hide loading indicator
//   //     Navigator.pop(context);
//   //
//   //     if (response.statusCode == 200) {
//   //       final responseData = jsonDecode(response.body);
//   //
//   //       if (responseData['Error'] == null ||
//   //           (responseData['Error']['ErrorCode'] == 0 &&
//   //               responseData['Error']['ErrorMessage'].isEmpty)) {
//   //
//   //         // Update Firestore booking status
//   //         await FirebaseFirestore.instance
//   //             .collection('customers')
//   //             .doc(currentUser.uid)
//   //             .collection('bookings')
//   //             .doc(booking.id)
//   //             .update({
//   //           'bookingStatus': 'Cancelled',
//   //           'lastUpdated': FieldValue.serverTimestamp(),
//   //           'cancellationTime': FieldValue.serverTimestamp(),
//   //           'cancellationDetails': {
//   //             'apiResponse': responseData,
//   //             'cancelledAt': DateTime.now().toIso8601String(),
//   //             'refundAmount': responseData['Response']?['RefundAmount'],
//   //             'cancellationReason': remarks,
//   //           }
//   //         });
//   //
//   //         // Show success snackbar message
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(
//   //             content: Text('Ticket canceled successfully'),
//   //             backgroundColor: Colors.green,
//   //             duration: Duration(seconds: 3),
//   //           ),
//   //         );
//   //
//   //       } else {
//   //         // Show API error message
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(
//   //             content: Text(responseData['Error']['ErrorMessage'] ?? 'Cancellation failed'),
//   //             backgroundColor: Colors.red,
//   //           ),
//   //         );
//   //       }
//   //     } else {
//   //       // Show HTTP error message
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text('Server returned status code ${response.statusCode}'),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     // Hide loading indicator in case of error
//   //     Navigator.pop(context);
//   //
//   //     // Show exception error message
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text('Cancellation failed: ${e.toString()}'),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );
//   //   }
//   // }
//
//   Future<void> _cancelBooking(
//       BuildContext context, DocumentSnapshot booking, String remarks) async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;
//
//     // Show loading indicator
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => const Center(child: CircularProgressIndicator()),
//     );
//
//     try {
//       const String apiUrl =
//           "https://namma-savaari-api-backend-9mpl.vercel.app/cancel-booking";
//
//       final busId = booking['busId'] is int
//           ? booking['busId'] as int
//           : int.parse(booking['busId'].toString());
//
//       final seatId = booking['journeyDetails']['seatNumber'] is int
//           ? booking['journeyDetails']['seatNumber'] as int
//           : int.parse(booking['journeyDetails']['seatNumber'].toString());
//
//       final Map<String, dynamic> requestBody = {
//         "EndUserIp": "122.171.16.249",
//         "ClientId": "180187",
//         "UserName": "Namma434",
//         "Password": "Namma@4341",
//         "BusId": busId,
//         "SeatId": seatId,
//         "Remarks": remarks
//       };
//
//       const headers = {
//         "Content-Type": "application/json",
//         "Api-Token": "Namma@90434#34",
//       };
//
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       // Hide loading indicator
//       Navigator.pop(context);
//
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//
//         if (responseData['Error'] == null ||
//             (responseData['Error']['ErrorCode'] == 0 &&
//                 responseData['Error']['ErrorMessage'].isEmpty)) {
//           // Update Firestore booking status
//           await FirebaseFirestore.instance
//               .collection('customers')
//               .doc(currentUser.uid)
//               .collection('bookings')
//               .doc(booking.id)
//               .update({
//             'bookingStatus': 'Cancelled',
//             'lastUpdated': FieldValue.serverTimestamp(),
//             'cancellationTime': FieldValue.serverTimestamp(),
//             'cancellationDetails': {
//               'apiResponse': responseData,
//               'cancelledAt': DateTime.now().toIso8601String(),
//               'refundAmount': responseData['Response']?['RefundAmount'],
//               'cancellationReason': remarks,
//             }
//           });
//
//           // Show success snackbar message with refund info
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text(
//                   'Your booking is canceled. Refund will be processed within 25 hours based on cancellation charges.'),
//               backgroundColor: Colors.green,
//               duration: Duration(seconds: 4),
//             ),
//           );
//
//           // Refresh the UI to disable the cancel button
//           (context as Element).markNeedsBuild();
//         } else {
//           // Show API error message
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(responseData['Error']['ErrorMessage'] ??
//                   'Cancellation failed'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       } else {
//         // Show HTTP error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Server returned status code ${response.statusCode}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       // Hide loading indicator in case of error
//       Navigator.pop(context);
//
//       // Show exception error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Cancellation failed: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
// }



//




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BookingsScreen extends StatefulWidget {
  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return Center(
        child: Text('Please login to view your bookings'),
      );
    }

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('customers')
            .doc(currentUser.uid)
            .collection('bookings')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading bookings'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No bookings yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your upcoming trips will appear here',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: EdgeInsets.all(16),
            children: snapshot.data!.docs.map((booking) {
              final journey = booking['journeyDetails'] as Map<String, dynamic>;
              final passengers = List<Map<String, dynamic>>.from(booking['passengerDetails']);
              final date = (booking['createdAt'] as Timestamp).toDate();
              final formattedDate = DateFormat('MMM dd, yyyy').format(date);
              final formattedTime = DateFormat('hh:mm a').format(date);

              return Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header with status
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _getStatusColor(booking['bookingStatus']),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            booking['ticketNumber'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            booking['bookingStatus'].toString().toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Journey details
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Route
                          Container(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      journey['source'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward, color: Colors.grey),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      journey['destination'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 12),

                          // Travel details
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Icon(Icons.directions_bus, size: 16, color: Colors.grey),
                                SizedBox(width: 8),
                                Text(
                                  '${journey['travelName']} • ${journey['busType']}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),

                          // Date and seat
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                '${_formatDate(journey['date'])} • Seat ${journey['seats'].join(', ')}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),

                          SizedBox(height: 8),

                          // Boarding point
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                'Boarding: ${journey['boardingPoint']}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          // Dropping point
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                'Dropping: ${journey['droppingPoint']}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),

                          SizedBox(height: 16),
                          Divider(height: 1),
                          SizedBox(height: 16),

                          // Passenger details
                          Text(
                            'Passenger Details',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          SizedBox(height: 8),

                          // Display all passengers
                          Column(
                            children: passengers.map((passenger) => Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    passenger['name'] ?? 'Name not available',
                                    style: TextStyle(fontSize: 15, color: Colors.green),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${passenger['age'] ?? 'N/A'} yrs • ${_getGenderText(passenger['gender'])}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    'Seat: ${passenger['seat'] ?? 'N/A'}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            )).toList(),
                          ),

                          SizedBox(height: 16),
                          Divider(height: 1),
                          SizedBox(height: 16),

                          // Booking and payment info
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Booked on',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text('$formattedDate at $formattedTime'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Amount paid',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    '₹${booking['invoiceAmount']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Cancel button
                    if (booking['bookingStatus'] == 'Confirmed')
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.grey.shade200)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            _showCancelDialog(context, booking);
                          },
                          child: Text(
                            'CANCEL',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  String _getGenderText(dynamic genderCode) {
    if (genderCode == null) return 'N/A';
    if (genderCode == '1') return 'Male';
    if (genderCode == '2') return 'Female';
    if (genderCode == '3') return 'Other';
    return genderCode.toString();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green.shade600;
      case 'cancelled':
        return Colors.red.shade600;
      case 'pending':
        return Colors.orange.shade600;
      default:
        return Colors.blue.shade600;
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  final List<String> cancellationReasons = [
    'Change of travel plans',
    'Found better alternative',
    'Bus timing not suitable',
    'Personal emergency',
    'Other reason'
  ];

  void _showCancelDialog(BuildContext context, DocumentSnapshot booking) {
    String selectedReason = cancellationReasons[0];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Cancel Booking'),
            content: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Are you sure you want to cancel this booking?'),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedReason,
                      isExpanded: true,
                      items: cancellationReasons.map((String reason) {
                        return DropdownMenuItem<String>(
                          value: reason,
                          child: Text(
                            reason,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Reason for cancellation',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('NO'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _cancelBooking(context, booking, selectedReason);
                },
                child: Text('YES, CANCEL', style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        },
      ),
    );
  }

  // Future<void> _cancelBooking(BuildContext context, DocumentSnapshot booking, String remarks) async {
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser == null) return;
  //
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => Center(child: CircularProgressIndicator()),
  //   );
  //
  //   try {
  //     const String apiUrl = "http://65.0.115.185:8081/cancel-booking";
  //
  //     final busId = booking['busId'] is int
  //         ? booking['busId'] as int
  //         : int.parse(booking['busId'].toString());
  //
  //     final seatIds = (booking['journeyDetails']['seats'] as List).map((seat) {
  //       return seat is int ? seat : int.parse(seat.toString());
  //     }).toList();
  //
  //     final Map<String, dynamic> requestBody = {
  //       "EndUserIp": "122.171.16.249",
  //       "ClientId": "180187",
  //       "UserName": "Namma434",
  //       "Password": "Namma@4341",
  //       "BusId": busId,
  //       "SeatId": seatIds,
  //       "Remarks": remarks
  //     };
  //
  //     const headers = {
  //       "Content-Type": "application/json",
  //       "Api-Token": "Namma@90434#34",
  //     };
  //
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: headers,
  //       body: jsonEncode(requestBody),
  //     );
  //
  //     Navigator.pop(context);
  //
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //
  //       if (responseData['Error'] == null ||
  //           (responseData['Error']['ErrorCode'] == 0 &&
  //               responseData['Error']['ErrorMessage'].isEmpty)) {
  //
  //         await FirebaseFirestore.instance
  //             .collection('customers')
  //             .doc(currentUser.uid)
  //             .collection('bookings')
  //             .doc(booking.id)
  //             .update({
  //           'bookingStatus': 'Cancelled',
  //           'lastUpdated': FieldValue.serverTimestamp(),
  //           'cancellationTime': FieldValue.serverTimestamp(),
  //           'cancellationDetails': {
  //             'apiResponse': responseData,
  //             'cancelledAt': DateTime.now().toIso8601String(),
  //             'refundAmount': responseData['Response']?['RefundAmount'],
  //             'cancellationReason': remarks,
  //           }
  //         });
  //
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Your booking is canceled. Refund will be processed within 25 hours based on cancellation charges.'),
  //             backgroundColor: Colors.green,
  //             duration: Duration(seconds: 4),
  //           ),
  //         );
  //
  //         setState(() {}); // Refresh the UI
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(responseData['Error']['ErrorMessage'] ?? 'Cancellation failed'),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Server returned status code ${response.statusCode}'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Cancellation failed: ${e.toString()}'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  Future<void> _cancelBooking(BuildContext context, DocumentSnapshot booking, String remarks) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      const String apiUrl = "https://namma-savaari-api-backend.vercel.app/cancel-booking";

      final busId = booking['busId'] is int
          ? booking['busId'] as int
          : int.parse(booking['busId'].toString());

      final seatId = booking['journeyDetails']['seatNumber'] is int
          ? booking['journeyDetails']['seatNumber'] as int
          : int.parse(booking['journeyDetails']['seatNumber'].toString());

      final Map<String, dynamic> requestBody = {
        "EndUserIp": "122.171.16.249",
        "ClientId": "180187",
        "UserName": "Namma434",
        "Password": "Namma@4341",
        "BusId": busId,
        "SeatId": seatId,
        "Remarks": remarks
      };

      const headers = {
        "Content-Type": "application/json",
        "Api-Token": "Namma@90434#34",
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      // Hide loading indicator
      Navigator.pop(context);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['Error'] == null ||
            (responseData['Error']['ErrorCode'] == 0 &&
                responseData['Error']['ErrorMessage'].isEmpty)) {

          // Update Firestore booking status
          await FirebaseFirestore.instance
              .collection('customers')
              .doc(currentUser.uid)
              .collection('bookings')
              .doc(booking.id)
              .update({
            'bookingStatus': 'Cancelled',
            'lastUpdated': FieldValue.serverTimestamp(),
            'cancellationTime': FieldValue.serverTimestamp(),
            'cancellationDetails': {
              'apiResponse': responseData,
              'cancelledAt': DateTime.now().toIso8601String(),
              'refundAmount': responseData['Response']?['RefundAmount'],
              'cancellationReason': remarks,
            }
          });

          // Show success snackbar message with refund info
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Your booking is canceled. Refund will be processed within 25 hours based on cancellation charges.'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 4),
            ),
          );

          // Refresh the UI to disable the cancel button
          (context as Element).markNeedsBuild();

        } else {
          // Show API error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['Error']['ErrorMessage'] ?? 'Cancellation failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // Show HTTP error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Server returned status code ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Hide loading indicator in case of error
      Navigator.pop(context);

      // Show exception error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cancellation failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
