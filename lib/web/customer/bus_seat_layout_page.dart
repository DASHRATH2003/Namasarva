// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BusSeatLayoutPage extends StatefulWidget {
//   final String traceId;
//   final String resultIndex;
//
//   const BusSeatLayoutPage({
//     required this.traceId,
//     required this.resultIndex,
//   });
//
//   @override
//   _BusSeatLayoutPageState createState() => _BusSeatLayoutPageState();
// }
//
// class _BusSeatLayoutPageState extends State<BusSeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = '';
//   Map<String, dynamic>? _seatLayoutData;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": widget.traceId,
//       "ResultIndex": widget.resultIndex,
//     };
//
//     final headers = {
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
//         final data = jsonDecode(response.body);
//         setState(() {
//           _seatLayoutData = data['Result'];
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _buildSeatLayout(),
//     );
//   }
//
//   Widget _buildSeatLayout() {
//     if (_seatLayoutData == null) {
//       return Center(child: Text("No seat layout available."));
//     }
//
//     final layout = _seatLayoutData!['SeatLayout'] ?? [];
//     // Assuming layout contains the required seat details
//
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 5, // Adjust based on the number of columns
//         childAspectRatio: 1.5, // Adjust as needed for seat dimensions
//       ),
//       itemCount: layout.length,
//       itemBuilder: (context, index) {
//         final seat = layout[index];
//         final isAvailable = seat['SeatStatus'] ?? false;
//         final isLadiesSeat = seat['IsLadiesSeat'] ?? false;
//
//         return GestureDetector(
//           onTap: isAvailable
//               ? () {
//             // Handle seat selection
//           }
//               : null,
//           child: Container(
//             margin: EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               color: isAvailable ? Colors.green : Colors.grey,
//               border: Border.all(color: Colors.black),
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Center(
//               child: Text(
//                 seat['SeatName'] ?? "",
//                 style: TextStyle(
//                   color: isLadiesSeat ? Colors.pink : Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }



// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class SeatLayoutPage extends StatefulWidget {
//   final int resultIndex;
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   List<dynamic> _seatLayout = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "traceId12345", // Generate a unique TraceId
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//         final data = jsonDecode(response.body);
//         if (data['Error'][0]['ErrorCode'] == 0) {
//           setState(() {
//             _seatLayout = data['Result'][0]['SeatLayout'] ?? [];
//             _isLoading = false;
//           });
//         } else {
//           setState(() {
//             _errorMessage = "Error: ${data['Error'][0]['ErrorMessage']}";
//             _isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Display seat layout here
//             Text("Seat Layout:", style: TextStyle(fontWeight: FontWeight.bold)),
//             // Here you would render the seat layout details (you can parse HTMLLayout or display seat data)
//           ],
//         ),
//       ),
//     );
//   }
// }


//main

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class BusSeatLayoutPage extends StatefulWidget {
//   final int resultIndex;
//   final String traceId;
//
//   BusSeatLayoutPage({
//     required this.resultIndex,
//     required this.traceId,
//   });
//
//   @override
//   _BusSeatLayoutPageState createState() => _BusSeatLayoutPageState();
// }
//
// class _BusSeatLayoutPageState extends State<BusSeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   SeatLayoutResponse? _seatLayout;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": widget.traceId,
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34", // Replace with your API token
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
//         final data = jsonDecode(response.body);
//         if (data['Error'] != null && data['Error'].length > 0) {
//           setState(() {
//             _errorMessage = data['Error'][0]['ErrorMessage'] ??
//                 "Unknown error occurred.";
//             _isLoading = false;
//           });
//           return;
//         }
//
//         setState(() {
//           _seatLayout = SeatLayoutResponse.fromJson(data);
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   // Function to build the seat layout grid
//   Widget _buildSeatGrid() {
//     // Inside _buildSeatGrid()
//     if (_seatLayout == null ||
//         _seatLayout!.result.isEmpty ||
//         _seatLayout!.result[0].seatLayout.isEmpty) {
//       return Center(child: Text("No seat layout available."));
//     }
//
//     final seatLayoutDetails = _seatLayout!.result[0].seatLayout[0];
//     final layout = seatLayoutDetails.layout[0];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Seat Layout",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         // Display HTMLLayout if needed
//         // Text(seatLayoutDetails.htmlLayout), // You can render HTML if necessary
//
//         // Display seat details in a grid
//         GridView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: layout.seatDetails.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: layout.noOfColumns,
//             childAspectRatio: 1.5,
//             crossAxisSpacing: 4,
//             mainAxisSpacing: 4,
//           ),
//           itemBuilder: (context, index) {
//             final seat = layout.seatDetails[index];
//             return SeatWidget(seat: seat);
//           },
//         ),
//
//         SizedBox(height: 20),
//         Text(
//           "Price Details",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         // Display price details
//         ..._seatLayout!.result[0].seatLayout[0].price.map((price) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Currency: ${price.currencyCode}"),
//               Text("Base Price: ₹${price.basePrice}"),
//               Text("Tax: ₹${price.tax}"),
//               Text("Other Charges: ₹${price.otherCharges}"),
//               Text("Discount: ₹${price.discount}"),
//               Text("Published Price: ₹${price.publishedPrice}"),
//               Text("Offered Price: ₹${price.offeredPrice}"),
//               SizedBox(height: 10),
//             ],
//           );
//         }).toList(),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Seat Layout"),
//         ),
//         body: _isLoading
//             ? Center(child: CircularProgressIndicator())
//             : _errorMessage.isNotEmpty
//             ? Center(child: Text(_errorMessage))
//             : SingleChildScrollView(
//           padding: EdgeInsets.all(16.0),
//           child: _buildSeatGrid(),
//         ));
//   }
// }
//
// // Widget to display individual seats
// class SeatWidget extends StatelessWidget {
//   final SeatDetail seat;
//
//   SeatWidget({required this.seat});
//
//   @override
//   Widget build(BuildContext context) {
//     Color seatColor;
//     if (!seat.seatStatus) {
//       seatColor = Colors.grey; // Unavailable
//     } else if (seat.isLadiesSeat) {
//       seatColor = Colors.pink;
//     } else if (seat.isMalesSeat) {
//       seatColor = Colors.blue;
//     } else {
//       seatColor = Colors.green;
//     }
//
//     return GestureDetector(
//       onTap: () {
//         if (seat.seatStatus) {
//           // Handle seat selection
//           // For example, show a dialog or update the state
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text("Seat Selected"),
//               content: Text("You selected seat ${seat.seatName}"),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text("OK"),
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: seatColor,
//           borderRadius: BorderRadius.circular(4.0),
//         ),
//         child: Center(
//           child: Text(
//             seat.seatName,
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Models to parse the Seat Layout Response
//
// class SeatLayoutResponse {
//   final List<ErrorModel> error;
//   final List<ResultModel> result;
//
//   SeatLayoutResponse({required this.error, required this.result});
//
//   factory SeatLayoutResponse.fromJson(Map<String, dynamic> json) {
//     return SeatLayoutResponse(
//       error: (json['Error'] as List)
//           .map((e) => ErrorModel.fromJson(e))
//           .toList(),
//       result: (json['Result'] as List)
//           .map((e) => ResultModel.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class ErrorModel {
//   final int errorCode;
//   final String errorMessage;
//
//   ErrorModel({required this.errorCode, required this.errorMessage});
//
//   factory ErrorModel.fromJson(Map<String, dynamic> json) {
//     return ErrorModel(
//       errorCode: json['ErrorCode'],
//       errorMessage: json['ErrorMessage'] ?? "",
//     );
//   }
// }
//
// class ResultModel {
//   final String traceId;
//   final List<SeatLayoutDetails> seatLayout;
//
//   ResultModel({required this.traceId, required this.seatLayout});
//
//   factory ResultModel.fromJson(Map<String, dynamic> json) {
//     return ResultModel(
//       traceId: json['TraceId'],
//       seatLayout: (json['SeatLayout'] as List)
//           .map((e) => SeatLayoutDetails.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class SeatLayoutDetails {
//   final int availableSeats;
//   final String htmlLayout;
//   final List<Layout> layout;
//   final List<PriceDetail> price;
//
//   SeatLayoutDetails({
//     required this.availableSeats,
//     required this.htmlLayout,
//     required this.layout,
//     required this.price,
//   });
//
//   factory SeatLayoutDetails.fromJson(Map<String, dynamic> json) {
//     return SeatLayoutDetails(
//       availableSeats: json['AvailableSeats'],
//       htmlLayout: json['HTMLLayout'],
//       layout: (json['Layout'] as List)
//           .map((e) => Layout.fromJson(e))
//           .toList(),
//       price: (json['Price'] as List)
//           .map((e) => PriceDetail.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class Layout {
//   final int noOfColumns;
//   final int noOfRows;
//   final List<SeatDetail> seatDetails;
//
//   Layout({
//     required this.noOfColumns,
//     required this.noOfRows,
//     required this.seatDetails,
//   });
//
//   factory Layout.fromJson(Map<String, dynamic> json) {
//     return Layout(
//       noOfColumns: json['NoOfColumns'],
//       noOfRows: json['NoOfRows'],
//       seatDetails: (json['seatDetails'] as List)
//           .map((e) => SeatDetail.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class SeatDetail {
//   final int columnNo;
//   final int height;
//   final bool isLadiesSeat;
//   final bool isMalesSeat;
//   final bool isUpper;
//   final int rowNo;
//   final double seatFare;
//   final int seatIndex;
//   final String seatName;
//   final bool seatStatus;
//   final int seatType;
//   final int width;
//   final List<Price> price;
//
//   SeatDetail({
//     required this.columnNo,
//     required this.height,
//     required this.isLadiesSeat,
//     required this.isMalesSeat,
//     required this.isUpper,
//     required this.rowNo,
//     required this.seatFare,
//     required this.seatIndex,
//     required this.seatName,
//     required this.seatStatus,
//     required this.seatType,
//     required this.width,
//     required this.price,
//   });
//
//   factory SeatDetail.fromJson(Map<String, dynamic> json) {
//     return SeatDetail(
//       columnNo: json['ColumnNo'],
//       height: json['Height'],
//       isLadiesSeat: json['IsLadiesSeat'],
//       isMalesSeat: json['IsMalesSeat'],
//       isUpper: json['IsUpper'],
//       rowNo: json['RowNo'],
//       seatFare: (json['SeatFare'] as num).toDouble(),
//       seatIndex: json['SeatIndex'],
//       seatName: json['SeatName'],
//       seatStatus: json['SeatStatus'],
//       seatType: json['SeatType'],
//       width: json['Width'],
//       price: (json['Price'] as List)
//           .map((e) => Price.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class Price {
//   final String currencyCode;
//   final double basePrice;
//   final double tax;
//   final double otherCharges;
//   final double discount;
//   final double publishedPrice;
//   final double offeredPrice;
//
//   Price({
//     required this.currencyCode,
//     required this.basePrice,
//     required this.tax,
//     required this.otherCharges,
//     required this.discount,
//     required this.publishedPrice,
//     required this.offeredPrice,
//   });
//
//   factory Price.fromJson(Map<String, dynamic> json) {
//     return Price(
//       currencyCode: json['CurrencyCode'],
//       basePrice: (json['BasePrice'] as num).toDouble(),
//       tax: (json['Tax'] as num).toDouble(),
//       otherCharges: (json['OtherCharges'] as num).toDouble(),
//       discount: (json['Discount'] as num).toDouble(),
//       publishedPrice: (json['PublishedPrice'] as num).toDouble(),
//       offeredPrice: (json['OfferedPrice'] as num).toDouble(),
//     );
//   }
// }
//
// class PriceDetail {
//   final String currencyCode;
//   final double basePrice;
//   final double tax;
//   final double otherCharges;
//   final double discount;
//   final double publishedPrice;
//   final double offeredPrice;
//   final double publishedPriceRoundedOff;
//   final double offeredPriceRoundedOff;
//   final double agentCommission;
//   final double agentMarkUp;
//   final double tds;
//   final List<GSTDetail> gst;
//
//   PriceDetail({
//     required this.currencyCode,
//     required this.basePrice,
//     required this.tax,
//     required this.otherCharges,
//     required this.discount,
//     required this.publishedPrice,
//     required this.offeredPrice,
//     required this.publishedPriceRoundedOff,
//     required this.offeredPriceRoundedOff,
//     required this.agentCommission,
//     required this.agentMarkUp,
//     required this.tds,
//     required this.gst,
//   });
//
//   factory PriceDetail.fromJson(Map<String, dynamic> json) {
//     return PriceDetail(
//       currencyCode: json['CurrencyCode'],
//       basePrice: (json['BasePrice'] as num).toDouble(),
//       tax: (json['Tax'] as num).toDouble(),
//       otherCharges: (json['OtherCharges'] as num).toDouble(),
//       discount: (json['Discount'] as num).toDouble(),
//       publishedPrice: (json['PublishedPrice'] as num).toDouble(),
//       offeredPrice: (json['OfferedPrice'] as num).toDouble(),
//       publishedPriceRoundedOff:
//       (json['PublishedPriceRoundedOff'] as num).toDouble(),
//       offeredPriceRoundedOff:
//       (json['OfferedPriceRoundedOff'] as num).toDouble(),
//       agentCommission: (json['AgentCommission'] as num).toDouble(),
//       agentMarkUp: (json['AgentMarkUp'] as num).toDouble(),
//       tds: (json['TDS'] as num).toDouble(),
//       gst: (json['GST'] as List)
//           .map((e) => GSTDetail.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class GSTDetail {
//   final double cgstAmount;
//   final double cgstRate;
//   final double cessAmount;
//   final double cessRate;
//   final double igstAmount;
//   final double igstRate;
//   final double sgstAmount;
//   final double sgstRate;
//   final double taxableAmount;
//
//   GSTDetail({
//     required this.cgstAmount,
//     required this.cgstRate,
//     required this.cessAmount,
//     required this.cessRate,
//     required this.igstAmount,
//     required this.igstRate,
//     required this.sgstAmount,
//     required this.sgstRate,
//     required this.taxableAmount,
//   });
//
//   factory GSTDetail.fromJson(Map<String, dynamic> json) {
//     return GSTDetail(
//       cgstAmount: (json['CGSTAmount'] as num).toDouble(),
//       cgstRate: (json['CGSTRate'] as num).toDouble(),
//       cessAmount: (json['CessAmount'] as num).toDouble(),
//       cessRate: (json['CessRate'] as num).toDouble(),
//       igstAmount: (json['IGSTAmount'] as num).toDouble(),
//       igstRate: (json['IGSTRate'] as num).toDouble(),
//       sgstAmount: (json['SGSTAmount'] as num).toDouble(),
//       sgstRate: (json['SGSTRate'] as num).toDouble(),
//       taxableAmount: (json['TaxableAmount'] as num).toDouble(),
//     );
//   }
// }



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SeatLayoutPage extends StatefulWidget {
//   final int resultIndex; // ResultIndex to fetch the seat layout data
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   List<dynamic> _seatLayout = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1", // You can generate a unique TraceId
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34", // Replace with your API token
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );
//
//       // Debugging: print the response body
//       print("Response body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         // Debugging: print the entire response to verify the structure
//         print("Decoded data: $data");
//         var seatDetails = data['Result']['SeatLayout']['SeatLayoutDetails']['Layout']['seatDetails'];
//         // Check if 'Result' key exists
//         if (data != null && data['Result'] != null) {
//           final result = data['Result'];
//           // Check if the 'SeatLayout' and 'seatDetails' are available
//           if (result['SeatLayout'] != null &&
//               result['SeatLayout']['SeatLayoutDetails'] != null &&
//               result['SeatLayout']['SeatLayoutDetails']['Layout'] != null) {
//             setState(() {
//               _seatLayout = result['SeatLayout']['Layout']['seatDetails']; // Update the path to seatDetails
//               _isLoading = false;
//             });
//           } else {
//             // If data is missing, print what was available
//             setState(() {
//               _errorMessage = "Seat layout data is missing in the response.";
//               _isLoading = false;
//             });
//           }
//         } else {
//           setState(() {
//             _errorMessage = "Invalid response structure: Missing 'Result'.";
//             _isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch data. Status code: ${response.statusCode}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   Widget _buildSeatLayout() {
//     if (_seatLayout.isEmpty) {
//       return Center(child: Text("No seat layout available."));
//     }
//
//     return ListView.builder(
//       itemCount: _seatLayout.length,
//       itemBuilder: (context, index) {
//         final seat = _seatLayout[index];
//
//         return Container(
//           margin: EdgeInsets.all(8.0),
//           padding: EdgeInsets.all(8.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.0),
//             boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Seat Name: ${seat['SeatName'] ?? 'N/A'}",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text("Row: ${seat['RowNo'] ?? 'N/A'}"),
//               Text("Column: ${seat['ColumnNo'] ?? 'N/A'}"),
//               Text("Seat Fare: ₹${seat['SeatFare'] ?? '0'}"),
//               Text("Seat Type: ${seat['SeatType'] ?? 'N/A'}"),
//               Text("Available: ${seat['SeatStatus'] != null && seat['SeatStatus'] ? 'Yes' : 'No'}"),
//               Text("Reserved for Ladies: ${seat['IsLadiesSeat'] != null && seat['IsLadiesSeat'] ? 'Yes' : 'No'}"),
//               Text("Reserved for Males: ${seat['IsMalesSeat'] != null && seat['IsMalesSeat'] ? 'Yes' : 'No'}"),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _buildSeatLayout(),
//     );
//   }
// }


//nyt


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SeatLayoutPage extends StatefulWidget {
//   final int resultIndex; // ResultIndex to fetch the seat layout data
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   List<dynamic> _seatLayout = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//       print("Response body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         print("Decoded data: $data");
//
//         final seatDetails =
//         data['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//         if (seatDetails != null) {
//           setState(() {
//             _seatLayout = seatDetails;
//             _isLoading = false;
//           });
//         } else {
//           setState(() {
//             _errorMessage = "Seat layout details are not available.";
//             _isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch data. Status code: ${response.statusCode}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//
//   Widget _buildSeatLayout() {
//     if (_seatLayout.isEmpty) {
//       return Center(child: Text("No seat layout available."));
//     }
//
//     return ListView.builder(
//       itemCount: _seatLayout.length,
//       itemBuilder: (context, index) {
//         final seat = _seatLayout[index];
//
//         return Container(
//           margin: EdgeInsets.all(8.0),
//           padding: EdgeInsets.all(8.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.0),
//             boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Seat Name: ${seat['SeatName'] ?? 'N/A'}",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text("Row: ${seat['RowNo'] ?? 'N/A'}"),
//               Text("Column: ${seat['ColumnNo'] ?? 'N/A'}"),
//               Text("Seat Fare: ₹${seat['SeatFare'] ?? '0'}"),
//               Text("Seat Type: ${seat['SeatType'] ?? 'N/A'}"),
//               Text("Available: ${seat['SeatStatus'] != null && seat['SeatStatus'] ? 'Yes' : 'No'}"),
//               Text("Reserved for Ladies: ${seat['IsLadiesSeat'] != null && seat['IsLadiesSeat'] ? 'Yes' : 'No'}"),
//               Text("Reserved for Males: ${seat['IsMalesSeat'] != null && seat['IsMalesSeat'] ? 'Yes' : 'No'}"),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _buildSeatLayout(),
//     );
//   }
// }



// import 'dart:convert'; // To use jsonEncode
// import 'package:http/http.dart' as http; // To use http.post
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SeatLayoutPage extends StatefulWidget {
//   final int resultIndex; // ResultIndex to fetch the seat layout data
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   List<dynamic> _seatLayout = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   // Future<void> _fetchSeatLayout() async {
//   //   final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//   //   final Map<String, dynamic> requestBody = {
//   //     "ClientId": "180131",
//   //     "UserName": "Namma434",
//   //     "Password": "Namma@4341",
//   //     "TraceId": "1",
//   //     "ResultIndex": widget.resultIndex,
//   //   };
//   //   final headers = {
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
//   //     print("Response body: ${response.body}");
//   //
//   //     if (response.statusCode == 200) {
//   //       final data = jsonDecode(response.body);
//   //
//   //       print("Decoded data: $data");
//   //
//   //       final seatDetails =
//   //       data['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//   //       if (seatDetails != null) {
//   //         setState(() {
//   //           _seatLayout = seatDetails;
//   //           _isLoading = false;
//   //         });
//   //       } else {
//   //         setState(() {
//   //           _errorMessage = "Seat layout details are not available.";
//   //           _isLoading = false;
//   //         });
//   //       }
//   //     } else {
//   //       setState(() {
//   //         _errorMessage = "Failed to fetch data. Status code: ${response.statusCode}";
//   //         _isLoading = false;
//   //       });
//   //     }
//   //   } catch (e) {
//   //     setState(() {
//   //       _errorMessage = "Error: ${e.toString()}";
//   //       _isLoading = false;
//   //     });
//   //   }
//   // }
//
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34",
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl), // Correctly parse the URL
//         headers: headers,
//         body: jsonEncode(requestBody), // Convert the body to JSON
//       );
//
//       if (response.statusCode == 200) {
//         // Handle successful response
//         final data = jsonDecode(response.body); // Decode the response JSON
//         print('Response data: $data');
//       } else {
//         // Handle error responses
//         print('Error: ${response.statusCode}, ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       // Handle network or other errors
//       print('An error occurred: $e');
//     }
//   }
//
//
//   Widget _buildSeatLayout() {
//     if (_seatLayout.isEmpty) {
//       return Center(child: Text("No seat layout available."));
//     }
//
//     return ListView.builder(
//       itemCount: _seatLayout.length,
//       itemBuilder: (context, index) {
//         final seat = _seatLayout[index];
//
//         return Container(
//           margin: EdgeInsets.all(8.0),
//           padding: EdgeInsets.all(8.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.0),
//             boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Seat Name: ${seat['SeatName'] ?? 'N/A'}",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               // Text("Row: ${seat['RowNo'] ?? 'N/A'}"),
//               // Text("Column: ${seat['ColumnNo'] ?? 'N/A'}"),
//               // Text("Seat Fare: ₹${seat['SeatFare'] ?? '0'}"),
//               // Text("Seat Type: ${seat['SeatType'] ?? 'N/A'}"),
//               // Text("Available: ${seat['SeatStatus'] != null && seat['SeatStatus'] ? 'Yes' : 'No'}"),
//               // Text("Reserved for Ladies: ${seat['IsLadiesSeat'] != null && seat['IsLadiesSeat'] ? 'Yes' : 'No'}"),
//               // Text("Reserved for Males: ${seat['IsMalesSeat'] != null && seat['IsMalesSeat'] ? 'Yes' : 'No'}"),
//             ],
//           ),
//         );
//       },
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _buildSeatLayout(),
//     );
//   }
// }


//main little data getting

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": widget.resultIndex, // Pass the ResultIndex of the selected bus
//     };
//     final headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34", // Your API token
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
//         // Print the response from the API in the console
//         print("API Response: ${response.body}");
//
//         // Optionally, handle the response data here if you want to display anything on the UI
//
//         setState(() {
//           _isLoading = false; // Finished loading
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator()) // Show loading indicator
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage)) // Show error message if something went wrong
//           : Center(
//         child: Text("Seat Layout Loaded, check console for details."),
//       ),
//     );
//   }
// }



//test display entire data in console



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1", // Replace with actual TraceId
//       "ResultIndex": widget.resultIndex, // Use the ResultIndex from the selected bus
//     };
//     final headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34", // Replace with your API token
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
//         final responseBody = response.body;
//
//         // Print the full response body to the console
//         debugPrint(responseBody, wrapWidth: 1024);
//
//         setState(() {
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : Center(
//         child: Text(
//           "Seat layout fetched successfully. Check console for details.",
//           style: TextStyle(fontSize: 16, color: Colors.green),
//         ),
//       ),
//     );
//   }
// }


//test display all details


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData; // To store the API response
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1", // Replace with actual TraceId
//       "ResultIndex": widget.resultIndex, // Use the ResultIndex from the selected bus
//     };
//     final headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34", // Replace with your API token
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
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody; // Store the parsed response
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Text(
//             jsonEncode(_seatLayoutData), // Display the data as a string
//             style: TextStyle(fontSize: 14),
//           ),
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//     );
//   }
// }



//ui


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData; // To store the API response
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1", // Replace with actual TraceId
//       "ResultIndex": widget.resultIndex, // Use the ResultIndex from the selected bus
//     };
//     final headers = {
//       "Content-Type": "application/json",
//       "Api-Token": "Namma@90434#34", // Replace with your API token
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
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody; // Store the parsed response
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: _buildSeatRows(), // Build rows dynamically
//           ),
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//     );
//   }
//
//   // Build rows based on RowNo and SeatName
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     Map<String, List<String>> rows = {}; // Map to group seats by RowNo
//
//     // Loop through seat details to group by RowNo
//     for (var row in seatDetails) {
//       for (var seat in row) {
//         String rowNo = seat['RowNo'];
//         String seatName = seat['SeatName'];
//
//         if (rows[rowNo] == null) {
//           rows[rowNo] = [];
//         }
//         rows[rowNo]?.add(seatName);
//       }
//     }
//
//     List<Widget> seatRowsWidgets = [];
//     rows.forEach((rowNo, seatNames) {
//       seatRowsWidgets.add(
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: seatNames.map((seatName) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                 child: Container(
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     seatName,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       );
//     });
//
//     return seatRowsWidgets;
//   }
// }


//test pass

//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<String> _selectedSeats = []; // To track selected seats
//   static const int maxSeatSelection = 6; // Maximum number of seats that can be selected
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _toggleSeatSelection(String seatName) {
//     setState(() {
//       if (_selectedSeats.contains(seatName)) {
//         _selectedSeats.remove(seatName); // Deselect seat
//       } else {
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add(seatName); // Select seat
//         } else {
//           _showMaxSelectionDialog(); // Show alert dialog if max limit is reached
//         }
//       }
//     });
//   }
//
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Icon(Icons.airline_seat_recline_extra,size: 80,color: Colors.indigo[300],),
//         content: Text("You can select a maximum of $maxSeatSelection seats.",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context), // Close the dialog
//             child: Text("Okay"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: _buildSeatRows(),
//           ),
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     Map<String, List<String>> rows = {};
//
//     for (var row in seatDetails) {
//       for (var seat in row) {
//         String rowNo = seat['RowNo'];
//         String seatName = seat['SeatName'];
//
//         if (rows[rowNo] == null) {
//           rows[rowNo] = [];
//         }
//         rows[rowNo]?.add(seatName);
//       }
//     }
//
//     List<Widget> seatRowsWidgets = [];
//     rows.forEach((rowNo, seatNames) {
//       seatRowsWidgets.add(
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: seatNames.map((seatName) {
//               return GestureDetector(
//                 onTap: () => _toggleSeatSelection(seatName),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                   child: Container(
//                     padding: EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       color: _selectedSeats.contains(seatName) ? Colors.pink : Colors.blue,
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Text(
//                       seatName,
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       );
//     });
//
//     return seatRowsWidgets;
//   }
// }

//testing pass




// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<String> _selectedSeats = []; // To track selected seats
//   static const int maxSeatSelection = 6; // Maximum number of seats that can be selected
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _toggleSeatSelection(String seatName) {
//     setState(() {
//       if (_selectedSeats.contains(seatName)) {
//         _selectedSeats.remove(seatName); // Deselect seat
//       } else {
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add(seatName); // Select seat
//         } else {
//           _showMaxSelectionDialog(); // Show alert dialog if max limit is reached
//         }
//       }
//     });
//   }
//
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Icon(Icons.airline_seat_recline_extra, size: 80,
//               color: Colors.indigo[300],),
//             content: Text(
//               "You can select a maximum of $maxSeatSelection seats.",
//               style: TextStyle(color: Colors.black,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context), // Close the dialog
//                 child: Text("Okay"),
//               ),
//             ],
//           ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Center(
//           child: Container(
//             height: 600, // Container height
//             width: 330,  // Container width
//             padding: const EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               color: Colors.pink[50], // Background color
//               borderRadius: BorderRadius.circular(16.0),
//               border: Border.all(color: Colors.pink, width: 2.0),
//             ),
//             child: Stack(
//               children: [
//                 // This is the main content (seats)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 140), // Adjust to avoid overlap with image
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: _buildSeatRows(),
//                     ),
//                   ),
//                 ),
//                 // The asset image positioned at the top right corner
//                 Positioned(
//                   top: 16, // Distance from the top edge
//                   right: 16, // Distance from the right edge
//                   child: Image.asset(
//                     'assets/steering-wheel.png', // Replace with your image path
//                     height: 100,  // Set the image size
//                     width: 100,   // Set the image size
//                   ),
//                 ),
//               ],
//             ),
//           )
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//     );
//   }
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     Map<String, List<String>> rows = {};
//
//     // Group seat names by row number
//     for (var row in seatDetails) {
//       for (var seat in row) {
//         String rowNo = seat['RowNo'];
//         String seatName = seat['SeatName'];
//
//         if (rows[rowNo] == null) {
//           rows[rowNo] = [];
//         }
//         rows[rowNo]?.add(seatName);
//       }
//     }
//
//     List<Widget> seatRowsWidgets = [];
//     rows.forEach((rowNo, seatNames) {
//       seatRowsWidgets.add(
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: seatNames.map((seatName) {
//               return GestureDetector(
//                 onTap: () => _toggleSeatSelection(seatName),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0), // Space between seats
//                   child: Container(
//                     height: 40, // Set seat height
//                     width: 40,  // Set seat width
//                     decoration: BoxDecoration(
//                       color: _selectedSeats.contains(seatName) ? Colors.green : Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Center(
//                       child: Text(
//                         seatName,
//                         style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       );
//     });
//
//     return seatRowsWidgets;
//   }
//
// }




//testing pass




// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<Map<String, dynamic>> _selectedSeats = []; // To track selected seats
//   static const int maxSeatSelection = 6;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _toggleSeatSelection(Map<String, dynamic> seat) {
//     setState(() {
//       if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])) {
//         _selectedSeats.removeWhere((s) => s['SeatName'] == seat['SeatName']);
//       } else {
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add(seat);
//         } else {
//           _showMaxSelectionDialog();
//         }
//       }
//     });
//
//     if (_selectedSeats.isEmpty) {
//       Navigator.pop(context); // Close dialog if all seats are deselected
//     } else {
//       _showSeatSummaryDialog(); // Update dialog if seats are selected
//     }
//   }
//
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Icon(Icons.airline_seat_recline_extra, size: 80, color: Colors.indigo[300]),
//         content: Text(
//           "You can select a maximum of $maxSeatSelection seats.",
//           style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("Okay"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showSeatSummaryDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         int totalSelectedSeats = _selectedSeats.length;
//         double totalPrice = _selectedSeats.fold(0.0, (sum, seat) => sum + seat['SeatFare']);
//
//         return AlertDialog(
//           contentPadding: EdgeInsets.all(16.0),
//           content: Container(
//             height: 150,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Seats: $totalSelectedSeats",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       "Total: ₹${totalPrice.toStringAsFixed(2)}",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 Spacer(),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Add boarding & dropping point selection logic here
//                   },
//                   child: Text("Boarding & Dropping Point Selection"),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: _buildSeatRows(),
//           ),
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     return seatDetails.map<Widget>((row) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: row.map<Widget>((seat) {
//           return GestureDetector(
//             onTap: () => _toggleSeatSelection(seat),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(4.0),
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                         ? Colors.pink
//                         : Colors.blue,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     seat['SeatName'],
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName']))
//                   Positioned(
//                     top: -20,
//                     child: AnimatedOpacity(
//                       opacity: 1.0,
//                       duration: Duration(seconds: 3),
//                       child: Text(
//                         "₹${seat['SeatFare']}",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           );
//         }).toList(),
//       );
//     }).toList();
//   }
// }

//testing pass



// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<Map<String, dynamic>> _selectedSeats = []; // To track selected seats
//   static const int maxSeatSelection = 6;
//   bool _isSeatSummaryVisible = false; // Flag to toggle the seat summary visibility
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _toggleSeatSelection(Map<String, dynamic> seat) {
//     setState(() {
//       if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])) {
//         _selectedSeats.removeWhere((s) => s['SeatName'] == seat['SeatName']);
//       } else {
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add(seat);
//         } else {
//           _showMaxSelectionDialog();
//         }
//       }
//
//       // Update the visibility of the seat summary
//       _isSeatSummaryVisible = _selectedSeats.isNotEmpty;
//     });
//   }
//
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Icon(Icons.airline_seat_recline_extra, size: 80, color: Colors.indigo[300]),
//         content: Text(
//           "You can select a maximum of $maxSeatSelection seats.",
//           style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("Okay"),
//           ),
//         ],
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink[400],
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: _buildSeatRows(),
//           ),
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//       bottomNavigationBar: _isSeatSummaryVisible
//           ? Container(
//         color: Colors.white,
//         padding: EdgeInsets.all(16.0),
//         height: 150,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start, // Align all children to the left
//           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the content
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the texts
//               children: [
//                 Text(
//                   "Seats: ${_selectedSeats.length}",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Text(
//                   "Total: ₹${_selectedSeats.fold(0.0, (sum, seat) => sum + seat['SeatFare']).toStringAsFixed(2)}",
//                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
//                 ),
//               ],
//             ),
//             Spacer(), // Push the button to the bottom
//             Center( // Center the button horizontally
//               child: Container(
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.pink
//                   ),
//                   onPressed: () {
//                     // Add boarding & dropping point selection logic here
//                   },
//                   child: Text("Boarding & Dropping Point Selection",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )
//           : null,
//     );
//   }
//
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     return seatDetails.map<Widget>((row) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: row.map<Widget>((seat) {
//           return GestureDetector(
//             onTap: () => _toggleSeatSelection(seat),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(4.0),
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                         ? Colors.pink
//                         : Colors.blue,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     seat['SeatName'],
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName']))
//                   Positioned(
//                     top: -20,
//                     child: AnimatedOpacity(
//                       opacity: 1.0,
//                       duration: Duration(seconds: 3),
//                       child: Text(
//                         "₹${seat['SeatFare']}",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           );
//         }).toList(),
//       );
//     }).toList();
//   }
// }



// Final Test Pass

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'bording_and_droping_point_selection_page.dart';
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<Map<String, dynamic>> _selectedSeats = []; // To track selected seats
//   static const int maxSeatSelection = 6;
//   bool _isSeatSummaryVisible = false; // Flag to toggle the seat summary visibility
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _toggleSeatSelection(Map<String, dynamic> seat) {
//     setState(() {
//       if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])) {
//         _selectedSeats.removeWhere((s) => s['SeatName'] == seat['SeatName']);
//       } else {
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add(seat);
//         } else {
//           _showMaxSelectionDialog();
//         }
//       }
//
//       // Update the visibility of the seat summary
//       _isSeatSummaryVisible = _selectedSeats.isNotEmpty;
//     });
//   }
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Icon(Icons.airline_seat_recline_extra, size: 50,
//               color: Colors.indigo[300],),
//             content: Text(
//               "You can select a maximum of $maxSeatSelection seats.",
//               style: TextStyle(color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),),
//             actions: [
//               Center(
//                 child: Container(
//                   height: 55,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.pop(context), // Close the dialog
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink, // Set the button color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
//                       ),
//                     ),
//                     child: Text(
//                       "Okay",
//                       style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold), // Optional: Customize text color
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//     );
//   }
//
//   void _showSeatSelectionDialog() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 20,),
//                 // Close Icon and Price Breakup text at the top
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "Price Breakup",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.of(context).pop(), // Close the dialog
//                       child: Icon(
//                         Icons.close,
//                         size: 24.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.0), // Spacing below the header row
//                 // Seat Details List
//                 ..._selectedSeats.map((seat) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0), // Add spacing between items
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           seat['SeatName'],
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                         Text(
//                           "₹${seat['SeatFare']}",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink[400],
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: _buildSeatRows(),
//           ),
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//       bottomNavigationBar: _isSeatSummaryVisible
//           ? GestureDetector(
//         onTap:_showSeatSelectionDialog,
//         child: Container(
//                     color: Colors.white,
//                     padding: EdgeInsets.all(16.0),
//                     height: 150,
//                     child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start, // Align all children to the left
//             mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the content
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the texts
//                 children: [
//                   Text(
//                     "Seats: ${_selectedSeats.length}",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Text(
//                     "Total: ₹${_selectedSeats.fold(0.0, (sum, seat) => sum + seat['SeatFare']).toStringAsFixed(2)}",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),
//               Spacer(), // Push the button to the bottom
//               Center( // Center the button horizontally
//                 child: Container(
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BoardingDroppingPage(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Boarding & Dropping Point Selection",
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//                     ),
//                   ),
//           )
//           : null,
//     );
//   }
//
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     return seatDetails.map<Widget>((row) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: row.map<Widget>((seat) {
//           return GestureDetector(
//             onTap: () => _toggleSeatSelection(seat),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(4.0),
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                         ? Colors.pink
//                         : Colors.blue,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     seat['SeatName'],
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName']))
//                   Positioned(
//                     top: -20,
//                     child: AnimatedOpacity(
//                       opacity: 1.0,
//                       duration: Duration(seconds: 3),
//                       child: Text(
//                         "₹${seat['SeatFare']}",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           );
//         }).toList(),
//       );
//     }).toList();
//   }
// }



// Testing pass


// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'bording_and_droping_point_selection_page.dart';
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<Map<String, dynamic>> _selectedSeats = []; // To track selected seats
//   static const int maxSeatSelection = 6;
//   bool _isSeatSummaryVisible = false; // Flag to toggle the seat summary visibility
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _toggleSeatSelection(Map<String, dynamic> seat) {
//     setState(() {
//       if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])) {
//         _selectedSeats.removeWhere((s) => s['SeatName'] == seat['SeatName']);
//       } else {
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add({
//             ...seat,
//             'OfferedPriceRoundedOff': seat['Price']?['OfferedPriceRoundedOff'] ?? 0
//           });
//         } else {
//           _showMaxSelectionDialog();
//         }
//       }
//
//       _isSeatSummaryVisible = _selectedSeats.isNotEmpty;
//     });
//   }
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Icon(Icons.airline_seat_recline_extra, size: 50,
//               color: Colors.indigo[300],),
//             content: Text(
//               "You can select a maximum of $maxSeatSelection seats.",
//               style: TextStyle(color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),),
//             actions: [
//               Center(
//                 child: Container(
//                   height: 55,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.pop(context), // Close the dialog
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink, // Set the button color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
//                       ),
//                     ),
//                     child: Text(
//                       "Okay",
//                       style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold), // Optional: Customize text color
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//     );
//   }
//
//   void _showSeatSelectionDialog() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 20,),
//                 // Close Icon and Price Breakup text at the top
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "Price Breakup",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.of(context).pop(), // Close the dialog
//                       child: Icon(
//                         Icons.close,
//                         size: 24.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.0), // Spacing below the header row
//                 // Seat Details List
//                 ..._selectedSeats.map((seat) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           seat['SeatName'],
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                         Text(
//                           "₹${seat['OfferedPriceRoundedOff']}",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink[400],
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: _buildSeatRows(),
//           ),
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//       bottomNavigationBar: _isSeatSummaryVisible
//           ? GestureDetector(
//         onTap:_showSeatSelectionDialog,
//         child: Container(
//           color: Colors.white,
//           padding: EdgeInsets.all(16.0),
//           height: 150,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start, // Align all children to the left
//             mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the content
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the texts
//                 children: [
//                   Text(
//                     "Seats: ${_selectedSeats.length}",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Text(
//                     "Total: ₹${_selectedSeats.fold(0.0, (sum, seat) => sum + (seat['OfferedPriceRoundedOff'] ?? 0)).toStringAsFixed(2)}",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),
//               Spacer(), // Push the button to the bottom
//               Center( // Center the button horizontally
//                 child: Container(
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BoardingDroppingPage(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Boarding & Dropping Point Selection",
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//           : null,
//     );
//   }
//
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     return seatDetails.map<Widget>((row) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: row.map<Widget>((seat) {
//           return GestureDetector(
//             onTap: () => _toggleSeatSelection(seat),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(4.0),
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                         ? Colors.pink
//                         : Colors.blue,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     seat['SeatName'],
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName']))
//                   Positioned(
//                     top: -20,
//                     child: AnimatedOpacity(
//                       opacity: 1.0,
//                       duration: Duration(seconds: 3),
//                       child: Text(
//                         "₹${seat['Price']?['OfferedPriceRoundedOff'] ?? 0}",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           );
//         }).toList(),
//       );
//     }).toList();
//   }
// }



// Testing dhee


// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// // Replace this with your actual `BoardingDroppingPage` implementation
// class BoardingDroppingPage extends StatelessWidget {
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
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Boarding & Dropping Points")),
//       body: Center(
//         child: Text(
//           "Boarding page for seat: $seatName",
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//
//   const SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<Map<String, dynamic>> _selectedSeats = [];
//   static const int maxSeatSelection = 6;
//   bool _isSeatSummaryVisible = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     const String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": widget.resultIndex,
//     };
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
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _toggleSeatSelection(Map<String, dynamic> seat) {
//     setState(() {
//       if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])) {
//         _selectedSeats.removeWhere((s) => s['SeatName'] == seat['SeatName']);
//       } else {
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add({
//             ...seat,
//             'OfferedPriceRoundedOff': seat['Price']?['OfferedPriceRoundedOff'] ?? 0
//           });
//         } else {
//           _showMaxSelectionDialog();
//         }
//       }
//
//       _isSeatSummaryVisible = _selectedSeats.isNotEmpty;
//     });
//   }
//
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Icon(Icons.airline_seat_recline_extra, size: 50, color: Colors.indigo[300]),
//         content: Text(
//           "You can select a maximum of $maxSeatSelection seats.",
//           style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           Center(
//             child: ElevatedButton(
//               onPressed: () => Navigator.pop(context),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.pink,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               child: Text(
//                 "Okay",
//                 style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   void _showSeatSelectionDialog() {
//     // Show selected seat summary
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Selected Seats"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: _selectedSeats.map((seat) {
//             return Text(seat['SeatName']);
//           }).toList(),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("Close"),
//           )
//         ],
//       ),
//     );
//   }
//   void navigateToBoardingDroppingPage(Map<String, dynamic> seat) {
//     // Print the seat details to the console
//     print("Result Index: ${widget.resultIndex}");
//     print("Column No: ${seat['ColumnNo']}");
//     print("Row No: ${seat['RowNo']}");
//     print("Seat Index: ${seat['SeatIndex']}");
//     print("Seat Name: ${seat['SeatName']}");
//     print("Base Price: ${seat['Price']['BasePrice'] ?? 0.0}");
//     print("Published Price: ${seat['Price']['PublishedPrice'] ?? 0.0}");
//     print("Published Price Rounded Off: ${seat['Price']['PublishedPriceRoundedOff'] ?? 0.0}");
//     print("Offered Price: ${seat['Price']['OfferedPrice'] ?? 0.0}");
//     print("Offered Price Rounded Off: ${seat['Price']['OfferedPriceRoundedOff'] ?? 0.0}");
//     print("Seat Fare: ${seat['SeatFare'] ?? 0.0}");
//
//     // Navigate to the BoardingDroppingPage with the selected seat details
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(
//     //     builder: (context) => BoardingDroppingPage(
//     //       resultIndex: widget.resultIndex,
//     //       columnNo: seat['ColumnNo'],
//     //       rowNo: seat['RowNo'],
//     //       seatFare: seat['SeatFare'] ?? 0.0,
//     //       seatIndex: seat['SeatIndex'],
//     //       seatName: seat['SeatName'],
//     //       basePrice: seat['Price']['BasePrice'] ?? 0.0,
//     //       publishedPrice: seat['Price']['PublishedPrice'] ?? 0.0,
//     //       publishedPriceRoundedOff: seat['Price']['PublishedPriceRoundedOff'] ?? 0.0,
//     //       offeredPrice: seat['Price']['OfferedPrice'] ?? 0.0,
//     //       offeredPriceRoundedOff: seat['Price']['OfferedPriceRoundedOff'] ?? 0.0,
//     //     ),
//     //   ),
//     // );
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BoardingDroppingPage(
//           resultIndex: widget.resultIndex,
//           columnNo: seat['ColumnNo'] ?? 0,
//           rowNo: seat['RowNo'] ?? 0,
//           seatFare: seat['SeatFare'] ?? 0.0,
//           seatIndex: seat['SeatIndex'] ?? '',
//           seatName: seat['SeatName'] ?? '',
//           basePrice: seat['Price']['BasePrice'] ?? 0.0,
//           publishedPrice: seat['Price']['PublishedPrice'] ?? 0.0,
//           publishedPriceRoundedOff: seat['Price']['PublishedPriceRoundedOff'] ?? 0.0,
//           offeredPrice: seat['Price']['OfferedPrice'] ?? 0.0,
//           offeredPriceRoundedOff: seat['Price']['OfferedPriceRoundedOff'] ?? 0.0,
//         ),
//       ),
//     );
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink[400],
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: _buildSeatRows(),
//           ),
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//       bottomNavigationBar: _isSeatSummaryVisible
//           ? GestureDetector(
//         onTap: _showSeatSelectionDialog,
//         child: Container(
//           color: Colors.white,
//           padding: EdgeInsets.all(16.0),
//           height: 150,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Seats: ${_selectedSeats.length}",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Text(
//                     "Total: ₹${_selectedSeats.fold(0.0, (sum, seat) => sum + (seat['OfferedPriceRoundedOff'] ?? 0)).toStringAsFixed(2)}",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),
//               Spacer(),
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//                   onPressed: () {
//                     if (_selectedSeats.isNotEmpty) {
//                       navigateToBoardingDroppingPage(_selectedSeats.first);
//                     }
//                   },
//                   child: Text(
//                     "Boarding & Dropping Point Selection",
//                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//           : null,
//     );
//   }
//
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     return (seatDetails as List<dynamic>).map<Widget>((row) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: (row as List<dynamic>).map<Widget>((seat) {
//           return GestureDetector(
//             onTap: () => _toggleSeatSelection(seat as Map<String, dynamic>),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(4.0),
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                         ? Colors.green
//                         : Colors.grey,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     seat['SeatName'],
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       );
//     }).toList();
//   }
// }



//Testing




// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'bording_and_droping_point_selection_page.dart';
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<Map<String, dynamic>> _selectedSeats = []; // To track selected seats
//   static const int maxSeatSelection = 6;
//   bool _isSeatSummaryVisible = false; // Flag to toggle the seat summary visibility
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvtest.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180131",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": "1",
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _toggleSeatSelection(Map<String, dynamic> seat) {
//     setState(() {
//       if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])) {
//         _selectedSeats.removeWhere((s) => s['SeatName'] == seat['SeatName']);
//       } else {
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add({
//             ...seat,
//             'OfferedPriceRoundedOff': seat['Price']?['OfferedPriceRoundedOff'] ?? 0
//           });
//           _printSeatDetails(seat);
//         } else {
//           _showMaxSelectionDialog();
//         }
//       }
//
//       _isSeatSummaryVisible = _selectedSeats.isNotEmpty;
//     });
//   }
//
//   void _printSeatDetails(Map<String, dynamic> seat) {
//     // Extract and print the desired fields
//     final String resultIndex = widget.resultIndex;
//     print('Seat Details:');
//     print('ResultIndex: $resultIndex');
//     print('SeatName: ${seat['SeatName']?.toString() ?? 'N/A'}');
//     print('OfferedPriceRoundedOff: ${seat['Price']?['OfferedPriceRoundedOff']?.toString() ?? 'N/A'}');
//   }
//
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Icon(Icons.airline_seat_recline_extra, size: 50, color: Colors.indigo[300]),
//         content: Text(
//           "You can select a maximum of $maxSeatSelection seats.",
//           style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           Center(
//             child: ElevatedButton(
//               onPressed: () => Navigator.pop(context),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.pink,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: Text(
//                 "Okay",
//                 style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink[400],
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: _buildSeatRows(),
//           ),
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//       bottomNavigationBar: _isSeatSummaryVisible
//           ? GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BoardingDroppingPage(
//                 selectedSeats: _selectedSeats
//                     .map((seat) => seat['SeatName'].toString())
//                     .toList(), // Pass only the seat names
//               ),
//             ),
//           );
//         },
//         child: Container(
//           color: Colors.white,
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Seats: ${_selectedSeats.length}", style: TextStyle(fontSize: 20)),
//                   Text(
//                     "Total: ₹${_selectedSeats.fold(0.0, (sum, seat) => sum + (seat['OfferedPriceRoundedOff'] ?? 0)).toStringAsFixed(2)}",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),
//               Spacer(),
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => BoardingDroppingPage(
//                           selectedSeats: _selectedSeats
//                               .map((seat) => seat['SeatName'].toString())
//                               .toList(),
//                         ),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     "Boarding & Dropping Point Selection",
//                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//           : null,
//     );
//   }
//
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     return seatDetails.map<Widget>((row) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: row.map<Widget>((seat) {
//           return GestureDetector(
//             onTap: () => _toggleSeatSelection(seat),
//             child: Container(
//               margin: EdgeInsets.all(4.0),
//               padding: EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                 color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                     ? Colors.pink
//                     : Colors.blue,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Text(
//                 seat['SeatName'],
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           );
//         }).toList(),
//       );
//     }).toList();
//   }
// }







// Testing


// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'bording_and_droping_point_selection_page.dart';
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//
//   SeatLayoutPage({required this.resultIndex});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<Map<String, dynamic>> _selectedSeats = []; // To track selected seats
//   static const int maxSeatSelection = 6;
//   bool _isSeatSummaryVisible = false; // Flag to toggle the seat summary visibility
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvapi.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": widget.resultIndex,
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _toggleSeatSelection(Map<String, dynamic> seat) {
//     setState(() {
//       if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])) {
//         _selectedSeats.removeWhere((s) => s['SeatName'] == seat['SeatName']);
//       } else {
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add({
//             ...seat,
//             'OfferedPriceRoundedOff': seat['Price']?['OfferedPriceRoundedOff'] ?? 0
//           });
//         } else {
//           _showMaxSelectionDialog();
//         }
//       }
//
//       _isSeatSummaryVisible = _selectedSeats.isNotEmpty;
//     });
//   }
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Icon(Icons.airline_seat_recline_extra, size: 50,
//               color: Colors.indigo[300],),
//             content: Text(
//               "You can select a maximum of $maxSeatSelection seats.",
//               style: TextStyle(color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),),
//             actions: [
//               Center(
//                 child: Container(
//                   height: 55,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.pop(context), // Close the dialog
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink, // Set the button color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
//                       ),
//                     ),
//                     child: Text(
//                       "Okay",
//                       style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold), // Optional: Customize text color
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//     );
//   }
//
//   void _showSeatSelectionDialog() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 20,),
//                 // Close Icon and Price Breakup text at the top
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "Price Breakup",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.of(context).pop(), // Close the dialog
//                       child: Icon(
//                         Icons.close,
//                         size: 24.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.0), // Spacing below the header row
//                 // Seat Details List
//                 ..._selectedSeats.map((seat) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           seat['SeatName'],
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                         Text(
//                           "₹${seat['OfferedPriceRoundedOff']}",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink[400],
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: _buildSeatRows(),
//           ),
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//       bottomNavigationBar: _isSeatSummaryVisible
//           ? GestureDetector(
//         onTap:_showSeatSelectionDialog,
//         child: Container(
//           color: Colors.white,
//           padding: EdgeInsets.all(16.0),
//           height: 150,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start, // Align all children to the left
//             mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the content
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the texts
//                 children: [
//                   Text(
//                     "Seats: ${_selectedSeats.length}",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Text(
//                     "Total: ₹${_selectedSeats.fold(0.0, (sum, seat) => sum + (seat['OfferedPriceRoundedOff'] ?? 0)).toStringAsFixed(2)}",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),
//               Spacer(), // Push the button to the bottom
//               Center( // Center the button horizontally
//                 child: Container(
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BoardingDroppingPage(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Boarding & Dropping Point Selection",
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//           : null,
//     );
//   }
//
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     return seatDetails.map<Widget>((row) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: row.map<Widget>((seat) {
//           return GestureDetector(
//             onTap: () => _toggleSeatSelection(seat),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(4.0),
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                         ? Colors.pink
//                         : Colors.blue,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     seat['SeatName'],
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName']))
//                   Positioned(
//                     top: -20,
//                     child: AnimatedOpacity(
//                       opacity: 1.0,
//                       duration: Duration(seconds: 3),
//                       child: Text(
//                         "₹${seat['Price']?['OfferedPriceRoundedOff'] ?? 0}",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           );
//         }).toList(),
//       );
//     }).toList();
//   }
// }





//Test_pass



// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'bording_and_droping_point_selection_page.dart';
//
// class SeatLayoutPage extends StatefulWidget {
//   final String resultIndex;
//   final String traceId;
//
//   SeatLayoutPage({required this.resultIndex, required this.traceId});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<Map<String, dynamic>> _selectedSeats = []; // To track selected seats
//   static const int maxSeatSelection = 6;
//   bool _isSeatSummaryVisible = false; // Flag to toggle the seat summary visibility
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvapi.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": widget.traceId,
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _toggleSeatSelection(Map<String, dynamic> seat) {
//     setState(() {
//       if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])) {
//         _selectedSeats.removeWhere((s) => s['SeatName'] == seat['SeatName']);
//       } else {
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add({
//             ...seat,
//             'OfferedPriceRoundedOff': seat['Price']?['OfferedPriceRoundedOff'] ?? 0
//           });
//         } else {
//           _showMaxSelectionDialog();
//         }
//       }
//
//       _isSeatSummaryVisible = _selectedSeats.isNotEmpty;
//     });
//   }
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Icon(Icons.airline_seat_recline_extra, size: 50,
//               color: Colors.indigo[300],),
//             content: Text(
//               "You can select a maximum of $maxSeatSelection seats.",
//               style: TextStyle(color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),),
//             actions: [
//               Center(
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.pop(context), // Close the dialog
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink, // Set the button color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
//                       ),
//                     ),
//                     child: Text(
//                       "Okay",
//                       style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold), // Optional: Customize text color
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//     );
//   }
//
//   void _showSeatSelectionDialog() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 20,),
//                 // Close Icon and Price Breakup text at the top
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "Price Breakup",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.of(context).pop(), // Close the dialog
//                       child: Icon(
//                         Icons.close,
//                         size: 24.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.0), // Spacing below the header row
//                 // Seat Details List
//                 ..._selectedSeats.map((seat) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           seat['SeatName'],
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                         Text(
//                           "₹${seat['OfferedPriceRoundedOff']}",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink[400],
//         title: Text("Seat Layout"),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: _buildSeatRows(),
//           ),
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//       bottomNavigationBar: _isSeatSummaryVisible
//           ? GestureDetector(
//         onTap:_showSeatSelectionDialog,
//         child: Container(
//           color: Colors.white,
//           padding: EdgeInsets.all(16.0),
//           height: 150,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start, // Align all children to the left
//             mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the content
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the texts
//                 children: [
//                   Text(
//                     "Seats: ${_selectedSeats.length}",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Text(
//                     "Total: ₹${_selectedSeats.fold(0.0, (sum, seat) => sum + (seat['OfferedPriceRoundedOff'] ?? 0)).toStringAsFixed(2)}",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),
//               Spacer(), // Push the button to the bottom
//               Center( // Center the button horizontally
//                 child: Container(
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BoardingDroppingPage(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Boarding & Dropping Point Selection",
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//           : null,
//     );
//   }
//
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     return seatDetails.map<Widget>((row) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: row.map<Widget>((seat) {
//           return GestureDetector(
//             onTap: () => _toggleSeatSelection(seat),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(4.0),
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                         ? Colors.pink
//                         : Colors.blue,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     seat['SeatName'],
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       );
//     }).toList();
//   }
// }




//Testing_pass_parameters_passing_successfully



// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'bording_and_droping_point_selection_page.dart';
//
// class SeatLayoutPage extends StatefulWidget {
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
//   SeatLayoutPage({required this.resultIndex, required this.traceId, required this.sourceCity, required this.destinationCity, required this.journeyDate, required this.travelName, required this.busType, required this.arrivalTime, required this.departureTime});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<Map<String, dynamic>> _selectedSeats = []; // To track selected seats
//   static const int maxSeatSelection = 6;
//   bool _isSeatSummaryVisible = false; // Flag to toggle the seat summary visibility
//   String? _temporaryPrice;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvapi.com/v8/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": widget.traceId,
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//   void _toggleSeatSelection(Map<String, dynamic> seat) {
//     setState(() {
//       if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])) {
//         // Deselect the seat and remove temporary price
//         _selectedSeats.removeWhere((s) => s['SeatName'] == seat['SeatName']);
//       } else {
//         // Select the seat and add temporary price
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add({
//             ...seat,
//             'OfferedPriceRoundedOff': seat['Price']?['OfferedPriceRoundedOff'] ?? 0,
//             'tempPrice': "₹${seat['Price']?['OfferedPriceRoundedOff'] ?? 0}",
//           });
//         } else {
//           _showMaxSelectionDialog();
//         }
//       }
//
//       _isSeatSummaryVisible = _selectedSeats.isNotEmpty;
//
//       // Set the temporary price for this seat, which will disappear after 3 seconds
//       Future.delayed(Duration(seconds: 3), () {
//         setState(() {
//           // Remove the temporary price from the seat after 3 seconds
//           _selectedSeats = _selectedSeats.map((s) {
//             if (s['SeatName'] == seat['SeatName']) {
//               s.remove('tempPrice');
//             }
//             return s;
//           }).toList();
//         });
//       });
//     });
//   }
//
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Icon(Icons.airline_seat_recline_extra, size: 50,
//               color: Colors.indigo[300],),
//             content: Text(
//               "You can select a maximum of $maxSeatSelection seats.",
//               style: TextStyle(color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),),
//             actions: [
//               Center(
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.pop(context), // Close the dialog
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink, // Set the button color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
//                       ),
//                     ),
//                     child: Text(
//                       "Okay",
//                       style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold), // Optional: Customize text color
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//     );
//   }
//
//   void _showSeatSelectionDialog() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 20,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "Price Breakup",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.of(context).pop(),
//                       child: Icon(
//                         Icons.close,
//                         size: 24.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.0),
//                 ..._selectedSeats.map((seat) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           seat['SeatName'],
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                         Text(
//                           "₹${seat['OfferedPriceRoundedOff']}",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink[400],
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Select Seats",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 4), // Add some space between the two lines
//             Text(
//               "${widget.sourceCity} -> ${widget.destinationCity}",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.white70, // Slightly lighter white for the subtitle
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             if (_temporaryPrice != null)
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 10.0),
//                 alignment: Alignment.center,
//                 color: Colors.pink,
//                 child: Text(
//                   _temporaryPrice!,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             Expanded(
//                  child: SingleChildScrollView(
//                 child: Column(
//                   children: _buildSeatRows(),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10), // Spacing before the journey date container
//             Container(
//               padding: EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.pink, width: 2),
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Journey Date: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.journeyDate,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                   Text(
//                     "Travels Name: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.travelName,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                   Text(
//                     "Bus Type: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.busType,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                   Text(
//                     "Arrival Time: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.arrivalTime,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                   Text(
//                     "Departure Time: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.departureTime,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//       bottomNavigationBar: _isSeatSummaryVisible
//           ? GestureDetector(
//         onTap:_showSeatSelectionDialog,
//         child: Container(
//           color: Colors.white,
//           padding: EdgeInsets.all(16.0),
//           height: 150,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Seats: ${_selectedSeats.length}",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Text(
//                     "Total: ₹${_selectedSeats.fold(0.0, (sum, seat) => sum + (seat['OfferedPriceRoundedOff'] ?? 0)).toStringAsFixed(2)}",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),
//               Spacer(),
//               Center(
//                 child: Container(
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => BoardingDroppingPage(),
//                       //   ),
//                       // );
//                     },
//                     child: Text(
//                       "Boarding & Dropping Point Selection",
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//           : null,
//     );
//   }
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     return seatDetails.map<Widget>((row) {
//       return SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: row.map<Widget>((seat) {
//             // Get the price for the seat
//             final seatPrice = seat['Price']?['OfferedPriceRoundedOff'] ?? 0;
//
//             return GestureDetector(
//               onTap: () => _toggleSeatSelection(seat),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.all(4.0),
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                               ? Colors.pink
//                               : Colors.blue,
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Text(
//                           seat['SeatName'],
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       // Display the price below the seat name
//                       Text(
//                         "₹$seatPrice",
//                         style: TextStyle(color: Colors.black,fontSize: 10),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       );
//     }).toList();
//   }
// }





// Testing





// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'bording_and_droping_point_selection_page.dart';
//
// class SeatLayoutPage extends StatefulWidget {
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
//   SeatLayoutPage({required this.resultIndex, required this.traceId, required this.sourceCity, required this.destinationCity, required this.journeyDate, required this.travelName, required this.busType, required this.arrivalTime, required this.departureTime});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<Map<String, dynamic>> _selectedSeats = []; // To track selected seats
//   static const int maxSeatSelection = 6;
//   bool _isSeatSummaryVisible = false; // Flag to toggle the seat summary visibility
//   String? _temporaryPrice;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvapi.com/v8/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": widget.traceId,
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//   void _toggleSeatSelection(Map<String, dynamic> seat) {
//     setState(() {
//       if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])) {
//         // Deselect the seat and remove temporary price
//         _selectedSeats.removeWhere((s) => s['SeatName'] == seat['SeatName']);
//       } else {
//         // Select the seat and add temporary price
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add({
//             ...seat,
//             'OfferedPriceRoundedOff': seat['Price']?['OfferedPriceRoundedOff'] ?? 0,
//             'tempPrice': "₹${seat['Price']?['OfferedPriceRoundedOff'] ?? 0}",
//           });
//         } else {
//           _showMaxSelectionDialog();
//         }
//       }
//
//       _isSeatSummaryVisible = _selectedSeats.isNotEmpty;
//
//       // Set the temporary price for this seat, which will disappear after 3 seconds
//       Future.delayed(Duration(seconds: 3), () {
//         setState(() {
//           // Remove the temporary price from the seat after 3 seconds
//           _selectedSeats = _selectedSeats.map((s) {
//             if (s['SeatName'] == seat['SeatName']) {
//               s.remove('tempPrice');
//             }
//             return s;
//           }).toList();
//         });
//       });
//     });
//   }
//
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Icon(Icons.airline_seat_recline_extra, size: 50,
//               color: Colors.indigo[300],),
//             content: Text(
//               "You can select a maximum of $maxSeatSelection seats.",
//               style: TextStyle(color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),),
//             actions: [
//               Center(
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.pop(context), // Close the dialog
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink, // Set the button color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
//                       ),
//                     ),
//                     child: Text(
//                       "Okay",
//                       style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold), // Optional: Customize text color
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//     );
//   }
//
//   void _showSeatSelectionDialog() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 20,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "Price Breakup",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.of(context).pop(),
//                       child: Icon(
//                         Icons.close,
//                         size: 24.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.0),
//                 ..._selectedSeats.map((seat) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           seat['SeatName'],
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                         Text(
//                           "₹${seat['OfferedPriceRoundedOff']}",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink[400],
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Select Seats",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 4), // Add some space between the two lines
//             Text(
//               "${widget.sourceCity} -> ${widget.destinationCity}",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.white70, // Slightly lighter white for the subtitle
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             if (_temporaryPrice != null)
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 10.0),
//                 alignment: Alignment.center,
//                 color: Colors.pink,
//                 child: Text(
//                   _temporaryPrice!,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: _buildSeatRows(),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10), // Spacing before the journey date container
//             Container(
//               padding: EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.pink, width: 2),
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Journey Date: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.journeyDate,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                   Text(
//                     "Travels Name: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.travelName,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                   Text(
//                     "Bus Type: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.busType,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                   Text(
//                     "Arrival Time: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.arrivalTime,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                   Text(
//                     "Departure Time: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.departureTime,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//       bottomNavigationBar: _isSeatSummaryVisible
//           ? GestureDetector(
//         onTap:_showSeatSelectionDialog,
//         child: Container(
//           color: Colors.white,
//           padding: EdgeInsets.all(16.0),
//           height: 150,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Seats: ${_selectedSeats.length}",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Text(
//                     "Total: ₹${_selectedSeats.fold(0.0, (sum, seat) => sum + (seat['OfferedPriceRoundedOff'] ?? 0)).toStringAsFixed(2)}",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),
//               Spacer(),
//               Center(
//                 child: Container(
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//                     onPressed: () {
//                       print("$_selectedSeats");
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BoardingDroppingPage(
//                             resultIndex: widget.resultIndex, // Pass ResultIndex as a string
//                             traceId: widget.traceId, // Pass TraceId from the Result
//                             sourceCity: widget.sourceCity, // Use widget.sourceCity
//                             destinationCity: widget.destinationCity, // Use widget.sourceCity
//                             journeyDate: widget.journeyDate,
//                             arrivalTime: widget.arrivalTime,
//                             departureTime: widget.departureTime,
//                             travelName: widget.travelName,
//                             busType: widget.busType,
//                             selectedSeats: _selectedSeats, // Pass the selected seats
//                           ),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Boarding & Dropping Point Selection",
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//           : null,
//     );
//   }
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     // final seatDetails = _seatLayoutData?['Result']?['0']['0'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     return seatDetails.map<Widget>((row) {
//       return SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: row.map<Widget>((seat) {
//             // Get the price for the seat
//             final seatPrice = seat['Price']?['OfferedPriceRoundedOff'] ?? 0;
//
//             return GestureDetector(
//               onTap: () => _toggleSeatSelection(seat),
//               child: Stack(
//                alignment: Alignment.center,
//                children: [
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//                      Container(
//                        margin: EdgeInsets.all(4.0),
//                        padding: EdgeInsets.all(8.0),
//                        decoration: BoxDecoration(
//                          color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                              ? Colors.pink
//                              : Colors.blue,
//                          borderRadius: BorderRadius.circular(8.0),
//                        ),
//                        child: Text(
//                          seat['SeatName'],
//                          style: TextStyle(color: Colors.white),
//                        ),
//                      ),
//                      // Display the price below the seat name
//                      Text(
//                        "₹$seatPrice",
//                        style: TextStyle(color: Colors.black,fontSize: 10),
//                      ),
//                    ],
//                  ),
//                ],
//               ),
//             );
//           }).toList(),
//         ),
//       );
//     }).toList();
//   }
// }



// success




// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'bording_and_droping_point_selection_page.dart';
//
// class SeatLayoutPage extends StatefulWidget {
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
//   SeatLayoutPage({required this.resultIndex, required this.traceId, required this.sourceCity, required this.destinationCity, required this.journeyDate, required this.travelName, required this.busType, required this.arrivalTime, required this.departureTime});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<Map<String, dynamic>> _selectedSeats = []; // To track selected seats
//   static const int maxSeatSelection = 6;
//   bool _isSeatSummaryVisible = false; // Flag to toggle the seat summary visibility
//   String? _temporaryPrice;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvapi.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": widget.traceId,
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//   void _toggleSeatSelection(Map<String, dynamic> seat) {
//     setState(() {
//       if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])) {
//         // Deselect the seat and remove temporary price
//         _selectedSeats.removeWhere((s) => s['SeatName'] == seat['SeatName']);
//       } else {
//         // Select the seat and add temporary price
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add({
//             ...seat,
//             'OfferedPriceRoundedOff': seat['Price']?['OfferedPriceRoundedOff'] ?? 0,
//             'tempPrice': "₹${seat['Price']?['OfferedPriceRoundedOff'] ?? 0}",
//           });
//         } else {
//           _showMaxSelectionDialog();
//         }
//       }
//
//       _isSeatSummaryVisible = _selectedSeats.isNotEmpty;
//
//       // Set the temporary price for this seat, which will disappear after 3 seconds
//       Future.delayed(Duration(seconds: 3), () {
//         setState(() {
//           // Remove the temporary price from the seat after 3 seconds
//           _selectedSeats = _selectedSeats.map((s) {
//             if (s['SeatName'] == seat['SeatName']) {
//               s.remove('tempPrice');
//             }
//             return s;
//           }).toList();
//         });
//       });
//     });
//   }
//
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Icon(Icons.airline_seat_recline_extra, size: 50,
//               color: Colors.indigo[300],),
//             content: Text(
//               "You can select a maximum of $maxSeatSelection seats.",
//               style: TextStyle(color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),),
//             actions: [
//               Center(
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.pop(context), // Close the dialog
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink, // Set the button color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
//                       ),
//                     ),
//                     child: Text(
//                       "Okay",
//                       style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold), // Optional: Customize text color
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//     );
//   }
//
//   void _showSeatSelectionDialog() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 20,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "Price Breakup",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.of(context).pop(),
//                       child: Icon(
//                         Icons.close,
//                         size: 24.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.0),
//                 ..._selectedSeats.map((seat) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           seat['SeatName'],
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                         Text(
//                           "₹${seat['OfferedPriceRoundedOff']}",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink[400],
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Select Seats",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 4), // Add some space between the two lines
//             Text(
//               "${widget.sourceCity} -> ${widget.destinationCity}",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.white70, // Slightly lighter white for the subtitle
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             if (_temporaryPrice != null)
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 10.0),
//                 alignment: Alignment.center,
//                 color: Colors.pink,
//                 child: Text(
//                   _temporaryPrice!,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: _buildSeatRows(),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10), // Spacing before the journey date container
//             Container(
//               padding: EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.pink, width: 2),
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Journey Date: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.journeyDate,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                   Text(
//                     "Travels Name: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.travelName,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                   Text(
//                     "Bus Type: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.busType,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                   Text(
//                     "Arrival Time: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.arrivalTime,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                   Text(
//                     "Departure Time: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     widget.departureTime,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink[400],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//       bottomNavigationBar: _isSeatSummaryVisible
//           ? GestureDetector(
//         onTap:_showSeatSelectionDialog,
//         child: Container(
//           color: Colors.white,
//           padding: EdgeInsets.all(16.0),
//           height: 150,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Seats: ${_selectedSeats.length}",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Text(
//                     "Total: ₹${_selectedSeats.fold(0.0, (sum, seat) => sum + (seat['OfferedPriceRoundedOff'] ?? 0)).toStringAsFixed(2)}",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),
//               Spacer(),
//               Center(
//                 child: Container(
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//                     onPressed: () {
//                       print("$_selectedSeats");
//                       var seatDetails = _selectedSeats[0];
//                       var priceDetails = seatDetails['Price'];
//                       var gstDetails = priceDetails['GST'];
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BoardingDroppingPage(
//                             resultIndex: widget.resultIndex, // Pass ResultIndex as a string
//                             traceId: widget.traceId, // Pass TraceId from the Result
//                             sourceCity: widget.sourceCity, // Use widget.sourceCity
//                             destinationCity: widget.destinationCity, // Use widget.sourceCity
//                             journeyDate: widget.journeyDate,
//                             arrivalTime: widget.arrivalTime,
//                             departureTime: widget.departureTime,
//                             travelName: widget.travelName,
//                             busType: widget.busType,
//                             // // selectedSeats: _selectedSeats, // Pass the selected seats
//                             // // Pass individual seat details
//                             columnNo: seatDetails['ColumnNo'],
//                             height: seatDetails['Height'],
//                             isLadiesSeat: seatDetails['IsLadiesSeat'],
//                             isMalesSeat: seatDetails['IsMalesSeat'],
//                             isUpper: seatDetails['IsUpper'],
//                             rowNo: seatDetails['RowNo'],
//                             seatFare: seatDetails['SeatFare'],
//                             seatIndex: seatDetails['SeatIndex'],
//                             seatName: seatDetails['SeatName'],
//                             seatStatus: seatDetails['SeatStatus'],
//                             seatType: seatDetails['SeatType'],
//                             width: seatDetails['Width'],
//                             // // priceDetails: seatDetails['Price'], // Pass price details as a map
//                             currencyCode: priceDetails['CurrencyCode'],
//                             basePrice: priceDetails['BasePrice'],
//                             tax: priceDetails['Tax'],
//                             otherCharges: priceDetails['OtherCharges'],
//                             discount: priceDetails['Discount'],
//                             publishedPrice: priceDetails['PublishedPrice'],
//                             publishedPriceRoundedOff: priceDetails['PublishedPriceRoundedOff'],
//                             offeredPrice: priceDetails['OfferedPrice'],
//                             offeredPriceRoundedOff: priceDetails['OfferedPriceRoundedOff'],
//                             agentCommission: priceDetails['AgentCommission'],
//                             agentMarkUp: priceDetails['AgentMarkUp'],
//                             tds: priceDetails['TDS'],
//                             cgstAmount: gstDetails['CGSTAmount'],
//                             cgstRate: gstDetails['CGSTRate'],
//                             cessAmount: gstDetails['CessAmount'],
//                             cessRate: gstDetails['CessRate'],
//                             igstAmount: gstDetails['IGSTAmount'],
//                             igstRate: gstDetails['IGSTRate'],
//                             sgstAmount: gstDetails['SGSTAmount'],
//                             sgstRate: gstDetails['SGSTRate'],
//                             taxableAmount: gstDetails['TaxableAmount'],
//                           ),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Boarding & Dropping Point Selection",
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//           : null,
//     );
//   }
//
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     return seatDetails.map<Widget>((row) {
//       return SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: row.map<Widget>((seat) {
//             // Get the price for the seat
//             final seatPrice = seat['Price']?['OfferedPriceRoundedOff'] ?? 0;
//
//             return GestureDetector(
//               onTap: () => _toggleSeatSelection(seat),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.all(4.0),
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                               ? Colors.pink
//                               : Colors.blue,
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Text(
//                           seat['SeatName'],
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       // Display the price below the seat name
//                       Text(
//                         "₹$seatPrice",
//                         style: TextStyle(color: Colors.black,fontSize: 10),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       );
//     }).toList();
//   }
// }




// Success good 21 jan



// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'bording_and_droping_point_selection_page.dart';
//
// class SeatLayoutPage extends StatefulWidget {
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
//   SeatLayoutPage({required this.resultIndex, required this.traceId, required this.sourceCity, required this.destinationCity, required this.journeyDate, required this.travelName, required this.busType, required this.arrivalTime, required this.departureTime});
//
//   @override
//   _SeatLayoutPageState createState() => _SeatLayoutPageState();
// }
//
// class _SeatLayoutPageState extends State<SeatLayoutPage> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   Map<String, dynamic>? _seatLayoutData;
//   List<Map<String, dynamic>> _selectedSeats = []; // To track selected seats
//   static const int maxSeatSelection = 6;
//   bool _isSeatSummaryVisible = false; // Flag to toggle the seat summary visibility
//   String? _temporaryPrice;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchSeatLayout();
//   }
//
//   Future<void> _fetchSeatLayout() async {
//     final String apiUrl = "https://bus.srdvapi.com/v5/rest/GetSeatLayOut";
//     final Map<String, dynamic> requestBody = {
//       "ClientId": "180187",
//       "UserName": "Namma434",
//       "Password": "Namma@4341",
//       "TraceId": widget.traceId,
//       "ResultIndex": widget.resultIndex,
//     };
//     final headers = {
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
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//
//         setState(() {
//           _seatLayoutData = responseBody;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = "Failed to fetch seat layout: ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error: ${e.toString()}";
//         _isLoading = false;
//       });
//     }
//   }
//   void _toggleSeatSelection(Map<String, dynamic> seat) {
//     if (seat['SeatStatus'] == false) {
//       // Optionally, show a message that the seat is unavailable
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("This seat is unavailable.")),
//       );
//       return;
//     }
//
//     setState(() {
//       if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])) {
//         // Deselect the seat and remove temporary price
//         _selectedSeats.removeWhere((s) => s['SeatName'] == seat['SeatName']);
//       } else {
//         // Select the seat and add temporary price
//         if (_selectedSeats.length < maxSeatSelection) {
//           _selectedSeats.add({
//             ...seat,
//             'OfferedPriceRoundedOff': seat['Price']?['OfferedPriceRoundedOff'] ?? 0,
//             'tempPrice': "₹${seat['Price']?['OfferedPriceRoundedOff'] ?? 0}",
//           });
//         } else {
//           _showMaxSelectionDialog();
//         }
//       }
//
//       _isSeatSummaryVisible = _selectedSeats.isNotEmpty;
//
//       // Set the temporary price for this seat, which will disappear after 3 seconds
//       Future.delayed(Duration(seconds: 3), () {
//         setState(() {
//           // Remove the temporary price from the seat after 3 seconds
//           _selectedSeats = _selectedSeats.map((s) {
//             if (s['SeatName'] == seat['SeatName']) {
//               s.remove('tempPrice');
//             }
//             return s;
//           }).toList();
//         });
//       });
//     });
//   }
//
//   void _showMaxSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Icon(Icons.airline_seat_recline_extra, size: 50,
//               color: Colors.indigo[300],),
//             content: Text(
//               "You can select a maximum of $maxSeatSelection seats.",
//               style: TextStyle(color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),),
//             actions: [
//               Center(
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.pop(context), // Close the dialog
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink, // Set the button color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
//                       ),
//                     ),
//                     child: Text(
//                       "Okay",
//                       style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold), // Optional: Customize text color
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//     );
//   }
//
//   void _showSeatSelectionDialog() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 20,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "Price Breakup",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.of(context).pop(),
//                       child: Icon(
//                         Icons.close,
//                         size: 24.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.0),
//                 ..._selectedSeats.map((seat) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           seat['SeatName'],
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                         Text(
//                           "₹${seat['OfferedPriceRoundedOff']}",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink[400],
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Select Seats",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 4), // Add some space between the two lines
//             Text(
//               "${widget.sourceCity} -> ${widget.destinationCity}",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.white70, // Slightly lighter white for the subtitle
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//           ? Center(child: Text(_errorMessage))
//           : _seatLayoutData != null
//           ? Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             if (_temporaryPrice != null)
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 10.0),
//                 alignment: Alignment.center,
//                 color: Colors.pink,
//                 child: Text(
//                   _temporaryPrice!,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: _buildSeatRows(),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10), // Spacing before the journey date container
//             // Container(
//             //   padding: EdgeInsets.all(16.0),
//             //   decoration: BoxDecoration(
//             //     color: Colors.white,
//             //     border: Border.all(color: Colors.pink, width: 2),
//             //     borderRadius: BorderRadius.circular(8.0),
//             //   ),
//             //   child: Column(
//             //     mainAxisAlignment: MainAxisAlignment.center,
//             //     children: [
//             //       Text(
//             //         "Journey Date: ",
//             //         style: TextStyle(
//             //           fontSize: 16,
//             //           fontWeight: FontWeight.bold,
//             //           color: Colors.black54,
//             //         ),
//             //       ),
//             //       Text(
//             //         widget.journeyDate,
//             //         style: TextStyle(
//             //           fontSize: 16,
//             //           fontWeight: FontWeight.bold,
//             //           color: Colors.pink[400],
//             //         ),
//             //       ),
//             //       Text(
//             //         "Travels Name: ",
//             //         style: TextStyle(
//             //           fontSize: 16,
//             //           fontWeight: FontWeight.bold,
//             //           color: Colors.black54,
//             //         ),
//             //       ),
//             //       Text(
//             //         widget.travelName,
//             //         style: TextStyle(
//             //           fontSize: 16,
//             //           fontWeight: FontWeight.bold,
//             //           color: Colors.pink[400],
//             //         ),
//             //       ),
//             //       Text(
//             //         "Bus Type: ",
//             //         style: TextStyle(
//             //           fontSize: 16,
//             //           fontWeight: FontWeight.bold,
//             //           color: Colors.black54,
//             //         ),
//             //       ),
//             //       Text(
//             //         widget.busType,
//             //         style: TextStyle(
//             //           fontSize: 16,
//             //           fontWeight: FontWeight.bold,
//             //           color: Colors.pink[400],
//             //         ),
//             //       ),
//             //       Text(
//             //         "Arrival Time: ",
//             //         style: TextStyle(
//             //           fontSize: 16,
//             //           fontWeight: FontWeight.bold,
//             //           color: Colors.black54,
//             //         ),
//             //       ),
//             //       Text(
//             //         widget.arrivalTime,
//             //         style: TextStyle(
//             //           fontSize: 16,
//             //           fontWeight: FontWeight.bold,
//             //           color: Colors.pink[400],
//             //         ),
//             //       ),
//             //       Text(
//             //         "Departure Time: ",
//             //         style: TextStyle(
//             //           fontSize: 16,
//             //           fontWeight: FontWeight.bold,
//             //           color: Colors.black54,
//             //         ),
//             //       ),
//             //       Text(
//             //         widget.departureTime,
//             //         style: TextStyle(
//             //           fontSize: 16,
//             //           fontWeight: FontWeight.bold,
//             //           color: Colors.pink[400],
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//           ],
//         ),
//       )
//           : Center(
//         child: Text(
//           "No data available.",
//           style: TextStyle(fontSize: 16, color: Colors.red),
//         ),
//       ),
//       bottomNavigationBar: _isSeatSummaryVisible
//           ? GestureDetector(
//         onTap:_showSeatSelectionDialog,
//         child: Container(
//           color: Colors.white,
//           padding: EdgeInsets.all(16.0),
//           height: 150,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Seats: ${_selectedSeats.length}",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Text(
//                     "Total: ₹${_selectedSeats.fold(0.0, (sum, seat) => sum + (seat['OfferedPriceRoundedOff'] ?? 0)).toStringAsFixed(2)}",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),
//               Spacer(),
//               Center(
//                 child: Container(
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//                     onPressed: () {
//                       print("$_selectedSeats");
//                       var seatDetails = _selectedSeats[0];
//                       var priceDetails = seatDetails['Price'];
//                       var gstDetails = priceDetails['GST'];
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BoardingDroppingPage(
//                             resultIndex: widget.resultIndex, // Pass ResultIndex as a string
//                             traceId: widget.traceId, // Pass TraceId from the Result
//                             sourceCity: widget.sourceCity, // Use widget.sourceCity
//                             destinationCity: widget.destinationCity, // Use widget.sourceCity
//                             journeyDate: widget.journeyDate,
//                             arrivalTime: widget.arrivalTime,
//                             departureTime: widget.departureTime,
//                             travelName: widget.travelName,
//                             busType: widget.busType,
//                             // // selectedSeats: _selectedSeats, // Pass the selected seats
//                             // // Pass individual seat details
//                             columnNo: seatDetails['ColumnNo'],
//                             height: seatDetails['Height'],
//                             isLadiesSeat: seatDetails['IsLadiesSeat'],
//                             isMalesSeat: seatDetails['IsMalesSeat'],
//                             isUpper: seatDetails['IsUpper'],
//                             rowNo: seatDetails['RowNo'],
//                             seatFare: seatDetails['SeatFare'],
//                             seatIndex: seatDetails['SeatIndex'],
//                             seatName: seatDetails['SeatName'],
//                             seatStatus: seatDetails['SeatStatus'],
//                             seatType: seatDetails['SeatType'],
//                             width: seatDetails['Width'],
//                             // // priceDetails: seatDetails['Price'], // Pass price details as a map
//                             currencyCode: priceDetails['CurrencyCode'],
//                             basePrice: priceDetails['BasePrice'],
//                             tax: priceDetails['Tax'],
//                             otherCharges: priceDetails['OtherCharges'],
//                             discount: priceDetails['Discount'],
//                             publishedPrice: priceDetails['PublishedPrice'],
//                             publishedPriceRoundedOff: priceDetails['PublishedPriceRoundedOff'],
//                             offeredPrice: priceDetails['OfferedPrice'],
//                             offeredPriceRoundedOff: priceDetails['OfferedPriceRoundedOff'],
//                             agentCommission: priceDetails['AgentCommission'],
//                             agentMarkUp: priceDetails['AgentMarkUp'],
//                             tds: priceDetails['TDS'],
//                             cgstAmount: gstDetails['CGSTAmount'],
//                             cgstRate: gstDetails['CGSTRate'],
//                             cessAmount: gstDetails['CessAmount'],
//                             cessRate: gstDetails['CessRate'],
//                             igstAmount: gstDetails['IGSTAmount'],
//                             igstRate: gstDetails['IGSTRate'],
//                             sgstAmount: gstDetails['SGSTAmount'],
//                             sgstRate: gstDetails['SGSTRate'],
//                             taxableAmount: gstDetails['TaxableAmount'],
//                           ),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Boarding & Dropping Point Selection",
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//           : null,
//     );
//   }
//
//   // List<Widget> _buildSeatRows() {
//   //   final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//   //   if (seatDetails == null) {
//   //     return [Text("No seat details available")];
//   //   }
//   //
//   //   // Separate upper and lower seats
//   //   List<List<dynamic>> lowerSeatRows = [];
//   //   List<List<dynamic>> upperSeatRows = [];
//   //
//   //   for (var row in seatDetails) {
//   //     List<dynamic> lowerRow = [];
//   //     List<dynamic> upperRow = [];
//   //     for (var seat in row) {
//   //       if (seat['IsUpper'] == true) {
//   //         upperRow.add(seat);
//   //       } else {
//   //         lowerRow.add(seat);
//   //       }
//   //     }
//   //     if (lowerRow.isNotEmpty) lowerSeatRows.add(lowerRow);
//   //     if (upperRow.isNotEmpty) upperSeatRows.add(upperRow);
//   //   }
//   //
//   //   return [
//   //     // Lower Deck Seats
//   //     Text(
//   //       "Lower Deck",
//   //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //     ),
//   //     SizedBox(height: 10),
//   //     ...lowerSeatRows.map<Widget>((row) {
//   //       return SingleChildScrollView(
//   //         scrollDirection: Axis.horizontal,
//   //         child: Row(
//   //           mainAxisAlignment: MainAxisAlignment.center,
//   //           children: row.map<Widget>((seat) {
//   //             bool isSelectable = seat['SeatStatus'] ?? true;
//   //             bool isMaleSeat = seat['IsMalesSeat'] ?? false;
//   //             bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
//   //             double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
//   //
//   //             Color seatColor;
//   //             if (!isSelectable) {
//   //               seatColor = Colors.grey;
//   //             } else if (isMaleSeat) {
//   //               seatColor = Colors.green;
//   //             } else if (isLadiesSeat) {
//   //               seatColor = Colors.blue;
//   //             } else {
//   //               seatColor = Colors.blue; // Default color if needed
//   //             }
//   //
//   //             return Tooltip(
//   //               message: isSelectable ? "Select Seat" : "Seat Unavailable",
//   //               child: GestureDetector(
//   //                 onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
//   //                 child: Stack(
//   //                   alignment: Alignment.center,
//   //                   children: [
//   //                     Column(
//   //                       mainAxisAlignment: MainAxisAlignment.center,
//   //                       children: [
//   //                         Container(
//   //                           margin: EdgeInsets.all(4.0),
//   //                           padding: EdgeInsets.all(8.0),
//   //                           decoration: BoxDecoration(
//   //                             color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//   //                                 ? Colors.pink
//   //                                 : seatColor,
//   //                             borderRadius: BorderRadius.circular(8.0),
//   //                           ),
//   //                           child: Text(
//   //                             seat['SeatName'],
//   //                             style: TextStyle(color: Colors.white),
//   //                           ),
//   //                         ),
//   //                         // Display the price below the seat name
//   //                         Text(
//   //                           "₹$seatPrice",
//   //                           style: TextStyle(color: Colors.black, fontSize: 10),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ),
//   //             );
//   //           }).toList(),
//   //         ),
//   //       );
//   //     }).toList(),
//   //
//   //     SizedBox(height: 20),
//   //
//   //     // Upper Deck Seats
//   //     if (upperSeatRows.isNotEmpty) ...[
//   //       Text(
//   //         "Upper Deck",
//   //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //       ),
//   //       SizedBox(height: 10),
//   //       ...upperSeatRows.map<Widget>((row) {
//   //         return SingleChildScrollView(
//   //           scrollDirection: Axis.horizontal,
//   //           child: Row(
//   //             mainAxisAlignment: MainAxisAlignment.center,
//   //             children: row.map<Widget>((seat) {
//   //               bool isSelectable = seat['SeatStatus'] ?? true;
//   //               bool isMaleSeat = seat['IsMalesSeat'] ?? false;
//   //               bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
//   //               double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
//   //
//   //               Color seatColor;
//   //               if (!isSelectable) {
//   //                 seatColor = Colors.grey;
//   //               } else if (isMaleSeat) {
//   //                 seatColor = Colors.green;
//   //               } else if (isLadiesSeat) {
//   //                 seatColor = Colors.blue;
//   //               } else {
//   //                 seatColor = Colors.blue; // Default color if needed
//   //               }
//   //
//   //               return GestureDetector(
//   //                 onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
//   //                 child: Stack(
//   //                   alignment: Alignment.center,
//   //                   children: [
//   //                     Column(
//   //                       mainAxisAlignment: MainAxisAlignment.center,
//   //                       children: [
//   //                         Container(
//   //                           margin: EdgeInsets.all(4.0),
//   //                           padding: EdgeInsets.all(8.0),
//   //                           decoration: BoxDecoration(
//   //                             color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//   //                                 ? Colors.pink
//   //                                 : seatColor,
//   //                             borderRadius: BorderRadius.circular(8.0),
//   //                           ),
//   //                           child: Text(
//   //                             seat['SeatName'],
//   //                             style: TextStyle(color: Colors.white),
//   //                           ),
//   //                         ),
//   //                         // Display the price below the seat name
//   //                         Text(
//   //                           "₹$seatPrice",
//   //                           style: TextStyle(color: Colors.black, fontSize: 10),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ],
//   //                 ),
//   //               );
//   //             }).toList(),
//   //           ),
//   //         );
//   //       }).toList(),
//   //     ],
//   //   ];
//   // }
//
// // seats categorised
// //   List<Widget> _buildSeatRows() {
// //     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
// //     if (seatDetails == null) {
// //       return [Text("No seat details available")];
// //     }
// //
// //     // Separate upper and lower seats
// //     List<List<dynamic>> lowerSeatRows = [];
// //     List<List<dynamic>> upperSeatRows = [];
// //
// //     for (var row in seatDetails) {
// //       List<dynamic> lowerRow = [];
// //       List<dynamic> upperRow = [];
// //       for (var seat in row) {
// //         if (seat['IsUpper'] == true) {
// //           upperRow.add(seat);
// //         } else {
// //           lowerRow.add(seat);
// //         }
// //       }
// //       if (lowerRow.isNotEmpty) lowerSeatRows.add(lowerRow);
// //       if (upperRow.isNotEmpty) upperSeatRows.add(upperRow);
// //     }
// //
// //     return [
// //       // Lower Deck Seats
// //       Text(
// //         "Lower Deck",
// //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //       ),
// //       SizedBox(height: 10),
// //       ...lowerSeatRows.map<Widget>((row) {
// //         return SingleChildScrollView(
// //           scrollDirection: Axis.horizontal,
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: row.map<Widget>((seat) {
// //               bool isSelectable = seat['SeatStatus'] ?? true;
// //               bool isMaleSeat = seat['IsMalesSeat'] ?? false;
// //               bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
// //               double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
// //
// //               Color seatColor;
// //               if (!isSelectable) {
// //                 seatColor = Colors.grey;
// //               } else if (isMaleSeat) {
// //                 seatColor = Colors.indigo;
// //               } else if (isLadiesSeat) {
// //                 seatColor = Colors.pink;
// //               } else {
// //                 seatColor = Colors.white; // White color for seats that are neither male nor female
// //               }
// //
// //               return Tooltip(
// //                 message: isSelectable ? "Select Seat" : "Seat Unavailable",
// //                 child: GestureDetector(
// //                   onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
// //                   child: Stack(
// //                     alignment: Alignment.center,
// //                     children: [
// //                       Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Container(
// //                             margin: EdgeInsets.all(4.0),
// //                             padding: EdgeInsets.all(8.0),
// //                             decoration: BoxDecoration(
// //                               color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
// //                                   ? Colors.green
// //                                   : seatColor,
// //                               borderRadius: BorderRadius.circular(8.0),
// //                             ),
// //                             child: Text(
// //                               seat['SeatName'],
// //                               style: TextStyle(color: Colors.black), // Adjusted for white background
// //                             ),
// //                           ),
// //                           // Display the price below the seat name
// //                           Text(
// //                             "₹$seatPrice",
// //                             style: TextStyle(color: Colors.black, fontSize: 10),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             }).toList(),
// //           ),
// //         );
// //       }).toList(),
// //
// //       SizedBox(height: 20),
// //
// //       // Upper Deck Seats
// //       if (upperSeatRows.isNotEmpty) ...[
// //         Text(
// //           "Upper Deck",
// //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //         ),
// //         SizedBox(height: 10),
// //         ...upperSeatRows.map<Widget>((row) {
// //           return SingleChildScrollView(
// //             scrollDirection: Axis.horizontal,
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: row.map<Widget>((seat) {
// //                 bool isSelectable = seat['SeatStatus'] ?? true;
// //                 bool isMaleSeat = seat['IsMalesSeat'] ?? false;
// //                 bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
// //                 double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
// //
// //                 Color seatColor;
// //                 if (!isSelectable) {
// //                   seatColor = Colors.grey;
// //                 } else if (isMaleSeat) {
// //                   seatColor = Colors.green;
// //                 } else if (isLadiesSeat) {
// //                   seatColor = Colors.blue;
// //                 } else {
// //                   seatColor = Colors.white; // White color for seats that are neither male nor female
// //                 }
// //
// //                 return GestureDetector(
// //                   onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
// //                   child: Stack(
// //                     alignment: Alignment.center,
// //                     children: [
// //                       Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Container(
// //                             margin: EdgeInsets.all(4.0),
// //                             padding: EdgeInsets.all(8.0),
// //                             decoration: BoxDecoration(
// //                               color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
// //                                   ? Colors.pink
// //                                   : seatColor,
// //                               borderRadius: BorderRadius.circular(8.0),
// //                             ),
// //                             child: Text(
// //                               seat['SeatName'],
// //                               style: TextStyle(color: Colors.black), // Adjusted for white background
// //                             ),
// //                           ),
// //                           // Display the price below the seat name
// //                           Text(
// //                             "₹$seatPrice",
// //                             style: TextStyle(color: Colors.black, fontSize: 10),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               }).toList(),
// //             ),
// //           );
// //         }).toList(),
// //       ],
// //     ];
// //   }
//
//
// // good
//
//
//   // List<Widget> _buildSeatRows() {
//   //   final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//   //   if (seatDetails == null) {
//   //     return [Text("No seat details available")];
//   //   }
//   //
//   //   // Separate upper and lower seats
//   //   List<List<dynamic>> lowerSeatRows = [];
//   //   List<List<dynamic>> upperSeatRows = [];
//   //
//   //   for (var row in seatDetails) {
//   //     List<dynamic> lowerRow = [];
//   //     List<dynamic> upperRow = [];
//   //     for (var seat in row) {
//   //       if (seat['IsUpper'] == true) {
//   //         upperRow.add(seat);
//   //       } else {
//   //         lowerRow.add(seat);
//   //       }
//   //     }
//   //     if (lowerRow.isNotEmpty) lowerSeatRows.add(lowerRow);
//   //     if (upperRow.isNotEmpty) upperSeatRows.add(upperRow);
//   //   }
//   //
//   //   return [
//   //     // Lower Deck Seats
//   //     Text(
//   //       "Lower Deck",
//   //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //     ),
//   //     SizedBox(height: 10),
//   //     Row(
//   //       mainAxisAlignment: MainAxisAlignment.center,
//   //       crossAxisAlignment: CrossAxisAlignment.end,
//   //       children: lowerSeatRows.map<Widget>((row) {
//   //         return Column(
//   //           children: row.map<Widget>((seat) {
//   //             bool isSelectable = seat['SeatStatus'] ?? true;
//   //             bool isMaleSeat = seat['IsMalesSeat'] ?? false;
//   //             bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
//   //             double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
//   //
//   //             Color seatColor;
//   //             if (!isSelectable) {
//   //               seatColor = Colors.grey;
//   //             } else if (isMaleSeat) {
//   //               seatColor = Colors.indigo;
//   //             } else if (isLadiesSeat) {
//   //               seatColor = Colors.pink;
//   //             } else {
//   //               seatColor = Colors.white; // White color for seats that are neither male nor female
//   //             }
//   //
//   //             return Tooltip(
//   //               message: isSelectable ? "Select Seat" : "Seat Unavailable",
//   //               child: GestureDetector(
//   //                 onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
//   //                 child: Column(
//   //                   mainAxisAlignment: MainAxisAlignment.center,
//   //                   children: [
//   //                     Container(
//   //                       margin: EdgeInsets.all(4.0),
//   //                       padding: EdgeInsets.all(8.0),
//   //                       decoration: BoxDecoration(
//   //                         color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//   //                             ? Colors.green
//   //                             : seatColor,
//   //                         borderRadius: BorderRadius.circular(8.0),
//   //                       ),
//   //                       child: Text(
//   //                         seat['SeatName'],
//   //                         style: TextStyle(color: Colors.black), // Adjusted for white background
//   //                       ),
//   //                     ),
//   //                     Text(
//   //                       "₹$seatPrice",
//   //                       style: TextStyle(color: Colors.black, fontSize: 10),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ),
//   //             );
//   //           }).toList(),
//   //         );
//   //       }).toList(),
//   //     ),
//   //
//   //     SizedBox(height: 20),
//   //
//   //     // Upper Deck Seats
//   //     if (upperSeatRows.isNotEmpty) ...[
//   //       Text(
//   //         "Upper Deck",
//   //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //       ),
//   //       SizedBox(height: 10),
//   //       Row(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         crossAxisAlignment: CrossAxisAlignment.end,
//   //         children: upperSeatRows.map<Widget>((row) {
//   //           return Column(
//   //             children: row.map<Widget>((seat) {
//   //               bool isSelectable = seat['SeatStatus'] ?? true;
//   //               bool isMaleSeat = seat['IsMalesSeat'] ?? false;
//   //               bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
//   //               double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
//   //
//   //               Color seatColor;
//   //               if (!isSelectable) {
//   //                 seatColor = Colors.grey;
//   //               } else if (isMaleSeat) {
//   //                 seatColor = Colors.indigo;
//   //               } else if (isLadiesSeat) {
//   //                 seatColor = Colors.pink;
//   //               } else {
//   //                 seatColor = Colors.white; // White color for seats that are neither male nor female
//   //               }
//   //
//   //               return GestureDetector(
//   //                 onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
//   //                 child: Column(
//   //                   mainAxisAlignment: MainAxisAlignment.center,
//   //                   children: [
//   //                     Container(
//   //                       margin: EdgeInsets.all(4.0),
//   //                       padding: EdgeInsets.all(8.0),
//   //                       decoration: BoxDecoration(
//   //                         color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//   //                             ? Colors.green
//   //                             : seatColor,
//   //                         borderRadius: BorderRadius.circular(8.0),
//   //                       ),
//   //                       child: Text(
//   //                         seat['SeatName'],
//   //                         style: TextStyle(color: Colors.black), // Adjusted for white background
//   //                       ),
//   //                     ),
//   //                     Text(
//   //                       "₹$seatPrice",
//   //                       style: TextStyle(color: Colors.black, fontSize: 10),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               );
//   //             }).toList(),
//   //           );
//   //         }).toList(),
//   //       ),
//   //     ],
//   //   ];
//   // }
//
//
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     // Separate upper and lower seats
//     List<List<dynamic>> lowerSeatRows = [];
//     List<List<dynamic>> upperSeatRows = [];
//
//     for (var row in seatDetails) {
//       List<dynamic> lowerRow = [];
//       List<dynamic> upperRow = [];
//       for (var seat in row) {
//         if (seat['IsUpper'] == true) {
//           upperRow.add(seat);
//         } else {
//           lowerRow.add(seat);
//         }
//       }
//       if (lowerRow.isNotEmpty) lowerSeatRows.add(lowerRow);
//       if (upperRow.isNotEmpty) upperSeatRows.add(upperRow);
//     }
//
//     Widget buildSeatDeck(String title, List<List<dynamic>> seatRows) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: seatRows.map<Widget>((row) {
//               return Column(
//                 children: row.map<Widget>((seat) {
//                   bool isSelectable = seat['SeatStatus'] ?? true;
//                   bool isMaleSeat = seat['IsMalesSeat'] ?? false;
//                   bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
//                   double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
//
//                   Color seatColor;
//                   if (!isSelectable) {
//                     seatColor = Colors.grey;
//                   } else if (isMaleSeat) {
//                     seatColor = Colors.indigo;
//                   } else if (isLadiesSeat) {
//                     seatColor = Colors.pink;
//                   } else {
//                     seatColor = Colors.white; // White color for seats that are neither male nor female
//                   }
//
//                   return Tooltip(
//                     message: isSelectable ? "Select Seat" : "Seat Unavailable",
//                     child: GestureDetector(
//                       onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.all(4.0),
//                             padding: EdgeInsets.all(8.0),
//                             decoration: BoxDecoration(
//                               color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                                   ? Colors.green
//                                   : seatColor,
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: Text(
//                               seat['SeatName'],
//                               style: TextStyle(color: Colors.black), // Adjusted for white background
//                             ),
//                           ),
//                           Text(
//                             "₹$seatPrice",
//                             style: TextStyle(color: Colors.black, fontSize: 10),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               );
//             }).toList(),
//           ),
//         ],
//       );
//     }
//
//     return [
//       Center(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (lowerSeatRows.isNotEmpty) ...[
//                 buildSeatDeck("Lower Deck", lowerSeatRows),
//                 SizedBox(width: 20), // Space between columns
//               ],
//               if (upperSeatRows.isNotEmpty) ...[
//                 buildSeatDeck("Upper Deck", upperSeatRows),
//               ],
//             ],
//           ),
//         ),
//       ),
//     ];
//   }
// }




//success updating jan 21



import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'bording_and_droping_point_selection_page.dart';

class SeatLayoutPage extends StatefulWidget {
  final String resultIndex;
  final String traceId;
  final String sourceCity;
  final String destinationCity;
  final String journeyDate;
  final String travelName;
  final String busType;
  final String arrivalTime;
  final String departureTime;

  SeatLayoutPage({required this.resultIndex, required this.traceId, required this.sourceCity, required this.destinationCity, required this.journeyDate, required this.travelName, required this.busType, required this.arrivalTime, required this.departureTime});

  @override
  _SeatLayoutPageState createState() => _SeatLayoutPageState();
}

class _SeatLayoutPageState extends State<SeatLayoutPage> {
  bool _isLoading = true;
  String _errorMessage = "";
  Map<String, dynamic>? _seatLayoutData;
  List<Map<String, dynamic>> _selectedSeats = []; // To track selected seats
  static const int maxSeatSelection = 6;
  bool _isSeatSummaryVisible = false; // Flag to toggle the seat summary visibility
  String? _temporaryPrice;


  @override
  void initState() {
    super.initState();
    _fetchSeatLayout();
  }

  Future<void> _fetchSeatLayout() async {
    // final String apiUrl = "https://bus.srdvapi.com/v5/rest/GetSeatLayOut";
    final String apiUrl = "http://3.7.121.234/bus-api/GetSeatLayOut";

    final Map<String, dynamic> requestBody = {
      "ClientId": "180187",
      "UserName": "Namma434",
      "Password": "Namma@4341",
      "TraceId": widget.traceId,
      "ResultIndex": widget.resultIndex,
    };
    final headers = {
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
        final responseBody = jsonDecode(response.body);

        setState(() {
          _seatLayoutData = responseBody;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Failed to fetch seat layout: ${response.body}";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Error: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  void _toggleSeatSelection(Map<String, dynamic> seat) {
    if (seat['SeatStatus'] == false) {
      // Optionally, show a message that the seat is unavailable
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("This seat is unavailable.")),
      );
      return;
    }

    setState(() {
      if (_selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])) {
        // Deselect the seat and remove temporary price
        _selectedSeats.removeWhere((s) => s['SeatName'] == seat['SeatName']);
      } else {
        // Select the seat and add temporary price
        if (_selectedSeats.length < maxSeatSelection) {
          _selectedSeats.add({
            ...seat,
            'OfferedPriceRoundedOff': seat['Price']?['OfferedPriceRoundedOff'] ??
                0,
            'tempPrice': "₹${seat['Price']?['OfferedPriceRoundedOff'] ?? 0}",
          });
        } else {
          _showMaxSelectionDialog();
        }
      }

      _isSeatSummaryVisible = _selectedSeats.isNotEmpty;

      // Set the temporary price for this seat, which will disappear after 3 seconds
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          // Remove the temporary price from the seat after 3 seconds
          _selectedSeats = _selectedSeats.map((s) {
            if (s['SeatName'] == seat['SeatName']) {
              s.remove('tempPrice');
            }
            return s;
          }).toList();
        });
      });
    });
  }

  void _showMaxSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Icon(Icons.airline_seat_recline_extra, size: 50,
              color: Colors.indigo[300],),
            content: Text(
              "You can select a maximum of $maxSeatSelection seats.",
              style: TextStyle(color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),),
            actions: [
              Center(
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context), // Close the dialog
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.shade700,
                      // Set the button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Optional: Rounded corners
                      ),
                    ),
                    child: Text(
                      "Okay",
                      style: TextStyle(color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight
                              .bold), // Optional: Customize text color
                    ),
                  ),
                ),
              )
            ],
          ),
    );
  }

  void _showSeatSelectionDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Price Breakup",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.close,
                        size: 24.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                ..._selectedSeats.map((seat) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          seat['SeatName'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "₹${seat['OfferedPriceRoundedOff']}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.redAccent.shade700,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Seats",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4), // Add some space between the two lines
            Text(
              "${widget.sourceCity} -> ${widget.destinationCity}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors
                    .white70, // Slightly lighter white for the subtitle
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : _seatLayoutData != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_temporaryPrice != null)
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                alignment: Alignment.center,
                color: Colors.redAccent.shade700,
                child: Text(
                  _temporaryPrice!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _buildSeatRows(),
                ),
              ),
            ),
            SizedBox(height: 10), // Spacing before the journey date container
            // Container(
            //   padding: EdgeInsets.all(16.0),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     border: Border.all(color: Colors.pink, width: 2),
            //     borderRadius: BorderRadius.circular(8.0),
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         "Journey Date: ",
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black54,
            //         ),
            //       ),
            //       Text(
            //         widget.journeyDate,
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.pink[400],
            //         ),
            //       ),
            //       Text(
            //         "Travels Name: ",
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black54,
            //         ),
            //       ),
            //       Text(
            //         widget.travelName,
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.pink[400],
            //         ),
            //       ),
            //       Text(
            //         "Bus Type: ",
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black54,
            //         ),
            //       ),
            //       Text(
            //         widget.busType,
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.pink[400],
            //         ),
            //       ),
            //       Text(
            //         "Arrival Time: ",
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black54,
            //         ),
            //       ),
            //       Text(
            //         widget.arrivalTime,
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.pink[400],
            //         ),
            //       ),
            //       Text(
            //         "Departure Time: ",
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black54,
            //         ),
            //       ),
            //       Text(
            //         widget.departureTime,
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.pink[400],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      )
          : Center(
        child: Text(
          "No data available.",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      ),
      bottomNavigationBar: _isSeatSummaryVisible
          ? GestureDetector(
        onTap: _showSeatSelectionDialog,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Seats: ${_selectedSeats.length}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Total: ₹${_selectedSeats.fold(0.0, (sum, seat) => sum +
                        (seat['OfferedPriceRoundedOff'] ?? 0))
                        .toStringAsFixed(2)}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              Spacer(),
              Center(
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent.shade700),
                    onPressed: () {
                      print("$_selectedSeats");
                      var seatDetails = _selectedSeats[0];
                      var priceDetails = seatDetails['Price'];
                      var gstDetails = priceDetails['GST'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BoardingDroppingPage(
                                resultIndex: widget.resultIndex,
                                // Pass ResultIndex as a string
                                traceId: widget.traceId,
                                // Pass TraceId from the Result
                                sourceCity: widget.sourceCity,
                                // Use widget.sourceCity
                                destinationCity: widget.destinationCity,
                                // Use widget.sourceCity
                                journeyDate: widget.journeyDate,
                                arrivalTime: widget.arrivalTime,
                                departureTime: widget.departureTime,
                                travelName: widget.travelName,
                                busType: widget.busType,
                                // // selectedSeats: _selectedSeats, // Pass the selected seats
                                // // Pass individual seat details
                                columnNo: seatDetails['ColumnNo'],
                                height: seatDetails['Height'],
                                isLadiesSeat: seatDetails['IsLadiesSeat'],
                                isMalesSeat: seatDetails['IsMalesSeat'],
                                isUpper: seatDetails['IsUpper'],
                                rowNo: seatDetails['RowNo'],
                                seatFare: seatDetails['SeatFare'],
                                seatIndex: seatDetails['SeatIndex'],
                                seatName: seatDetails['SeatName'],
                                seatStatus: seatDetails['SeatStatus'],
                                seatType: seatDetails['SeatType'],
                                width: seatDetails['Width'],
                                // // priceDetails: seatDetails['Price'], // Pass price details as a map
                                currencyCode: priceDetails['CurrencyCode'],
                                basePrice: priceDetails['BasePrice'],
                                tax: priceDetails['Tax'],
                                otherCharges: priceDetails['OtherCharges'],
                                discount: priceDetails['Discount'],
                                publishedPrice: priceDetails['PublishedPrice'],
                                publishedPriceRoundedOff: priceDetails['PublishedPriceRoundedOff'],
                                offeredPrice: priceDetails['OfferedPrice'],
                                offeredPriceRoundedOff: priceDetails['OfferedPriceRoundedOff'],
                                agentCommission: priceDetails['AgentCommission'],
                                agentMarkUp: priceDetails['AgentMarkUp'],
                                tds: priceDetails['TDS'],
                                cgstAmount: gstDetails['CGSTAmount'],
                                cgstRate: gstDetails['CGSTRate'],
                                cessAmount: gstDetails['CessAmount'],
                                cessRate: gstDetails['CessRate'],
                                igstAmount: gstDetails['IGSTAmount'],
                                igstRate: gstDetails['IGSTRate'],
                                sgstAmount: gstDetails['SGSTAmount'],
                                sgstRate: gstDetails['SGSTRate'],
                                taxableAmount: gstDetails['TaxableAmount'],
                              ),
                        ),
                      );
                    },
                    child: Text(
                      "Boarding & Dropping Point Selection",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          : null,
    );
  }

  // List<Widget> _buildSeatRows() {
  //   final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
  //   if (seatDetails == null) {
  //     return [Text("No seat details available")];
  //   }
  //
  //   // Separate upper and lower seats
  //   List<List<dynamic>> lowerSeatRows = [];
  //   List<List<dynamic>> upperSeatRows = [];
  //
  //   for (var row in seatDetails) {
  //     List<dynamic> lowerRow = [];
  //     List<dynamic> upperRow = [];
  //     for (var seat in row) {
  //       if (seat['IsUpper'] == true) {
  //         upperRow.add(seat);
  //       } else {
  //         lowerRow.add(seat);
  //       }
  //     }
  //     if (lowerRow.isNotEmpty) lowerSeatRows.add(lowerRow);
  //     if (upperRow.isNotEmpty) upperSeatRows.add(upperRow);
  //   }
  //
  //   return [
  //     // Lower Deck Seats
  //     Text(
  //       "Lower Deck",
  //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //     ),
  //     SizedBox(height: 10),
  //     ...lowerSeatRows.map<Widget>((row) {
  //       return SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: row.map<Widget>((seat) {
  //             bool isSelectable = seat['SeatStatus'] ?? true;
  //             bool isMaleSeat = seat['IsMalesSeat'] ?? false;
  //             bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
  //             double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
  //
  //             Color seatColor;
  //             if (!isSelectable) {
  //               seatColor = Colors.grey;
  //             } else if (isMaleSeat) {
  //               seatColor = Colors.green;
  //             } else if (isLadiesSeat) {
  //               seatColor = Colors.blue;
  //             } else {
  //               seatColor = Colors.blue; // Default color if needed
  //             }
  //
  //             return Tooltip(
  //               message: isSelectable ? "Select Seat" : "Seat Unavailable",
  //               child: GestureDetector(
  //                 onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
  //                 child: Stack(
  //                   alignment: Alignment.center,
  //                   children: [
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Container(
  //                           margin: EdgeInsets.all(4.0),
  //                           padding: EdgeInsets.all(8.0),
  //                           decoration: BoxDecoration(
  //                             color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                                 ? Colors.pink
  //                                 : seatColor,
  //                             borderRadius: BorderRadius.circular(8.0),
  //                           ),
  //                           child: Text(
  //                             seat['SeatName'],
  //                             style: TextStyle(color: Colors.white),
  //                           ),
  //                         ),
  //                         // Display the price below the seat name
  //                         Text(
  //                           "₹$seatPrice",
  //                           style: TextStyle(color: Colors.black, fontSize: 10),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //       );
  //     }).toList(),
  //
  //     SizedBox(height: 20),
  //
  //     // Upper Deck Seats
  //     if (upperSeatRows.isNotEmpty) ...[
  //       Text(
  //         "Upper Deck",
  //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //       ),
  //       SizedBox(height: 10),
  //       ...upperSeatRows.map<Widget>((row) {
  //         return SingleChildScrollView(
  //           scrollDirection: Axis.horizontal,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: row.map<Widget>((seat) {
  //               bool isSelectable = seat['SeatStatus'] ?? true;
  //               bool isMaleSeat = seat['IsMalesSeat'] ?? false;
  //               bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
  //               double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
  //
  //               Color seatColor;
  //               if (!isSelectable) {
  //                 seatColor = Colors.grey;
  //               } else if (isMaleSeat) {
  //                 seatColor = Colors.green;
  //               } else if (isLadiesSeat) {
  //                 seatColor = Colors.blue;
  //               } else {
  //                 seatColor = Colors.blue; // Default color if needed
  //               }
  //
  //               return GestureDetector(
  //                 onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
  //                 child: Stack(
  //                   alignment: Alignment.center,
  //                   children: [
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Container(
  //                           margin: EdgeInsets.all(4.0),
  //                           padding: EdgeInsets.all(8.0),
  //                           decoration: BoxDecoration(
  //                             color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                                 ? Colors.pink
  //                                 : seatColor,
  //                             borderRadius: BorderRadius.circular(8.0),
  //                           ),
  //                           child: Text(
  //                             seat['SeatName'],
  //                             style: TextStyle(color: Colors.white),
  //                           ),
  //                         ),
  //                         // Display the price below the seat name
  //                         Text(
  //                           "₹$seatPrice",
  //                           style: TextStyle(color: Colors.black, fontSize: 10),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         );
  //       }).toList(),
  //     ],
  //   ];
  // }

// seats categorised
//   List<Widget> _buildSeatRows() {
//     final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
//     if (seatDetails == null) {
//       return [Text("No seat details available")];
//     }
//
//     // Separate upper and lower seats
//     List<List<dynamic>> lowerSeatRows = [];
//     List<List<dynamic>> upperSeatRows = [];
//
//     for (var row in seatDetails) {
//       List<dynamic> lowerRow = [];
//       List<dynamic> upperRow = [];
//       for (var seat in row) {
//         if (seat['IsUpper'] == true) {
//           upperRow.add(seat);
//         } else {
//           lowerRow.add(seat);
//         }
//       }
//       if (lowerRow.isNotEmpty) lowerSeatRows.add(lowerRow);
//       if (upperRow.isNotEmpty) upperSeatRows.add(upperRow);
//     }
//
//     return [
//       // Lower Deck Seats
//       Text(
//         "Lower Deck",
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//       SizedBox(height: 10),
//       ...lowerSeatRows.map<Widget>((row) {
//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: row.map<Widget>((seat) {
//               bool isSelectable = seat['SeatStatus'] ?? true;
//               bool isMaleSeat = seat['IsMalesSeat'] ?? false;
//               bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
//               double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
//
//               Color seatColor;
//               if (!isSelectable) {
//                 seatColor = Colors.grey;
//               } else if (isMaleSeat) {
//                 seatColor = Colors.indigo;
//               } else if (isLadiesSeat) {
//                 seatColor = Colors.pink;
//               } else {
//                 seatColor = Colors.white; // White color for seats that are neither male nor female
//               }
//
//               return Tooltip(
//                 message: isSelectable ? "Select Seat" : "Seat Unavailable",
//                 child: GestureDetector(
//                   onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.all(4.0),
//                             padding: EdgeInsets.all(8.0),
//                             decoration: BoxDecoration(
//                               color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                                   ? Colors.green
//                                   : seatColor,
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: Text(
//                               seat['SeatName'],
//                               style: TextStyle(color: Colors.black), // Adjusted for white background
//                             ),
//                           ),
//                           // Display the price below the seat name
//                           Text(
//                             "₹$seatPrice",
//                             style: TextStyle(color: Colors.black, fontSize: 10),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         );
//       }).toList(),
//
//       SizedBox(height: 20),
//
//       // Upper Deck Seats
//       if (upperSeatRows.isNotEmpty) ...[
//         Text(
//           "Upper Deck",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         ...upperSeatRows.map<Widget>((row) {
//           return SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: row.map<Widget>((seat) {
//                 bool isSelectable = seat['SeatStatus'] ?? true;
//                 bool isMaleSeat = seat['IsMalesSeat'] ?? false;
//                 bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
//                 double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
//
//                 Color seatColor;
//                 if (!isSelectable) {
//                   seatColor = Colors.grey;
//                 } else if (isMaleSeat) {
//                   seatColor = Colors.green;
//                 } else if (isLadiesSeat) {
//                   seatColor = Colors.blue;
//                 } else {
//                   seatColor = Colors.white; // White color for seats that are neither male nor female
//                 }
//
//                 return GestureDetector(
//                   onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.all(4.0),
//                             padding: EdgeInsets.all(8.0),
//                             decoration: BoxDecoration(
//                               color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                                   ? Colors.pink
//                                   : seatColor,
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: Text(
//                               seat['SeatName'],
//                               style: TextStyle(color: Colors.black), // Adjusted for white background
//                             ),
//                           ),
//                           // Display the price below the seat name
//                           Text(
//                             "₹$seatPrice",
//                             style: TextStyle(color: Colors.black, fontSize: 10),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//           );
//         }).toList(),
//       ],
//     ];
//   }


// good


  // List<Widget> _buildSeatRows() {
  //   final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
  //   if (seatDetails == null) {
  //     return [Text("No seat details available")];
  //   }
  //
  //   // Separate upper and lower seats
  //   List<List<dynamic>> lowerSeatRows = [];
  //   List<List<dynamic>> upperSeatRows = [];
  //
  //   for (var row in seatDetails) {
  //     List<dynamic> lowerRow = [];
  //     List<dynamic> upperRow = [];
  //     for (var seat in row) {
  //       if (seat['IsUpper'] == true) {
  //         upperRow.add(seat);
  //       } else {
  //         lowerRow.add(seat);
  //       }
  //     }
  //     if (lowerRow.isNotEmpty) lowerSeatRows.add(lowerRow);
  //     if (upperRow.isNotEmpty) upperSeatRows.add(upperRow);
  //   }
  //
  //   return [
  //     // Lower Deck Seats
  //     Text(
  //       "Lower Deck",
  //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //     ),
  //     SizedBox(height: 10),
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       children: lowerSeatRows.map<Widget>((row) {
  //         return Column(
  //           children: row.map<Widget>((seat) {
  //             bool isSelectable = seat['SeatStatus'] ?? true;
  //             bool isMaleSeat = seat['IsMalesSeat'] ?? false;
  //             bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
  //             double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
  //
  //             Color seatColor;
  //             if (!isSelectable) {
  //               seatColor = Colors.grey;
  //             } else if (isMaleSeat) {
  //               seatColor = Colors.indigo;
  //             } else if (isLadiesSeat) {
  //               seatColor = Colors.pink;
  //             } else {
  //               seatColor = Colors.white; // White color for seats that are neither male nor female
  //             }
  //
  //             return Tooltip(
  //               message: isSelectable ? "Select Seat" : "Seat Unavailable",
  //               child: GestureDetector(
  //                 onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Container(
  //                       margin: EdgeInsets.all(4.0),
  //                       padding: EdgeInsets.all(8.0),
  //                       decoration: BoxDecoration(
  //                         color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                             ? Colors.green
  //                             : seatColor,
  //                         borderRadius: BorderRadius.circular(8.0),
  //                       ),
  //                       child: Text(
  //                         seat['SeatName'],
  //                         style: TextStyle(color: Colors.black), // Adjusted for white background
  //                       ),
  //                     ),
  //                     Text(
  //                       "₹$seatPrice",
  //                       style: TextStyle(color: Colors.black, fontSize: 10),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //         );
  //       }).toList(),
  //     ),
  //
  //     SizedBox(height: 20),
  //
  //     // Upper Deck Seats
  //     if (upperSeatRows.isNotEmpty) ...[
  //       Text(
  //         "Upper Deck",
  //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //       ),
  //       SizedBox(height: 10),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.end,
  //         children: upperSeatRows.map<Widget>((row) {
  //           return Column(
  //             children: row.map<Widget>((seat) {
  //               bool isSelectable = seat['SeatStatus'] ?? true;
  //               bool isMaleSeat = seat['IsMalesSeat'] ?? false;
  //               bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
  //               double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
  //
  //               Color seatColor;
  //               if (!isSelectable) {
  //                 seatColor = Colors.grey;
  //               } else if (isMaleSeat) {
  //                 seatColor = Colors.indigo;
  //               } else if (isLadiesSeat) {
  //                 seatColor = Colors.pink;
  //               } else {
  //                 seatColor = Colors.white; // White color for seats that are neither male nor female
  //               }
  //
  //               return GestureDetector(
  //                 onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Container(
  //                       margin: EdgeInsets.all(4.0),
  //                       padding: EdgeInsets.all(8.0),
  //                       decoration: BoxDecoration(
  //                         color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                             ? Colors.green
  //                             : seatColor,
  //                         borderRadius: BorderRadius.circular(8.0),
  //                       ),
  //                       child: Text(
  //                         seat['SeatName'],
  //                         style: TextStyle(color: Colors.black), // Adjusted for white background
  //                       ),
  //                     ),
  //                     Text(
  //                       "₹$seatPrice",
  //                       style: TextStyle(color: Colors.black, fontSize: 10),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             }).toList(),
  //           );
  //         }).toList(),
  //       ),
  //     ],
  //   ];
  // }


  //
  // List<Widget> _buildSeatRows() {
  //   final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
  //   if (seatDetails == null) {
  //     return [Text("No seat details available")];
  //   }
  //
  //   // Separate upper and lower seats
  //   List<List<dynamic>> lowerSeatRows = [];
  //   List<List<dynamic>> upperSeatRows = [];
  //
  //   for (var row in seatDetails) {
  //     List<dynamic> lowerRow = [];
  //     List<dynamic> upperRow = [];
  //     for (var seat in row) {
  //       if (seat['IsUpper'] == true) {
  //         upperRow.add(seat);
  //       } else {
  //         lowerRow.add(seat);
  //       }
  //     }
  //     if (lowerRow.isNotEmpty) lowerSeatRows.add(lowerRow);
  //     if (upperRow.isNotEmpty) upperSeatRows.add(upperRow);
  //   }
  //
  //   Widget buildSeatDeck(String title, List<List<dynamic>> seatRows) {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           title,
  //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 10),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: seatRows.map<Widget>((row) {
  //             return Column(
  //               children: row.map<Widget>((seat) {
  //                 bool isSelectable = seat['SeatStatus'] ?? true;
  //                 bool isMaleSeat = seat['IsMalesSeat'] ?? false;
  //                 bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
  //                 double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
  //
  //                 Color seatColor;
  //                 if (!isSelectable) {
  //                   seatColor = Colors.grey;
  //                 } else if (isMaleSeat) {
  //                   seatColor = Colors.indigo;
  //                 } else if (isLadiesSeat) {
  //                   seatColor = Colors.pink;
  //                 } else {
  //                   seatColor = Colors.white; // Default seat color
  //                 }
  //
  //                 Widget seatWidget;
  //                 if (seat['SeatType'] == 1) {
  //                   // Custom stacked layout for SeatType 1
  //                   seatWidget = Container(
  //                     width: 40,
  //                     height: 40,
  //                     child: Stack(
  //                       children: [
  //                         Positioned(
  //                           top: 5,
  //                           bottom: 5,
  //                           left: 5,
  //                           right: 5,
  //                           child: SizedBox(
  //                             child: DecoratedBox(
  //                               decoration: BoxDecoration(
  //                                 border: Border.all(color: Colors.black, width: 1),
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                                     ? Colors.green
  //                                     : seatColor,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Positioned(
  //                           top: 29,
  //                           bottom: 5,
  //                           left: 5,
  //                           right: 5,
  //                           child: SizedBox(
  //                             child: DecoratedBox(
  //                               decoration: BoxDecoration(
  //                                 border: Border.all(color: Colors.black, width: 1),
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                                     ? Colors.green
  //                                     : seatColor,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Positioned(
  //                           top: 15,
  //                           bottom: 5,
  //                           left: 4,
  //                           right: 30,
  //                           child: SizedBox(
  //                             child: DecoratedBox(
  //                               decoration: BoxDecoration(
  //                                 border: Border.all(color: Colors.black, width: 1),
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                                     ? Colors.green
  //                                     : seatColor,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Positioned(
  //                           top: 15,
  //                           bottom: 5,
  //                           left: 30,
  //                           right: 4,
  //                           child: SizedBox(
  //                             child: DecoratedBox(
  //                               decoration: BoxDecoration(
  //                                 border: Border.all(color: Colors.black, width: 1),
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                                     ? Colors.green
  //                                     : seatColor,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //                 } else if (seat['SeatType'] == 2) {
  //                   // Adjust height for SeatType 2
  //                   seatWidget = Container(
  //                     width: 40,
  //                     height: 94,
  //                     decoration: BoxDecoration(
  //                       color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                           ? Colors.green
  //                           : seatColor,
  //                       border: Border.all(color: Colors.black, width: 1),
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         seat['SeatName'],
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                     ),
  //                   );
  //                 } else {
  //                   // Default seat layout
  //                   seatWidget = Container(
  //                     width: 40,
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                       color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                           ? Colors.green
  //                           : seatColor,
  //                       border: Border.all(color: Colors.black, width: 1),
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         seat['SeatName'],
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                     ),
  //                   );
  //                 }
  //
  //                 return GestureDetector(
  //                   onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
  //                   child: Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 4.0), // Space between seats
  //                     child: Column(
  //                       children: [
  //                         seatWidget,
  //                         Text(
  //                           "₹$seatPrice",
  //                           style: TextStyle(color: Colors.black, fontSize: 10),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               }).toList(),
  //             );
  //           }).toList(),
  //         ),
  //       ],
  //     );
  //   }
  //
  //   return [
  //     Center(
  //       child: SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             if (lowerSeatRows.isNotEmpty) ...[
  //               buildSeatDeck("Lower Deck", lowerSeatRows),
  //               SizedBox(width: 20),
  //             ],
  //             if (upperSeatRows.isNotEmpty) ...[
  //               buildSeatDeck("Upper Deck", upperSeatRows),
  //             ],
  //           ],
  //         ),
  //       ),
  //     ),
  //   ];
  // }


// layout should working but align ment is not good

  // List<Widget> _buildSeatRows() {
  //   final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
  //   if (seatDetails == null) {
  //     return [Text("No seat details available")];
  //   }
  //
  //   // Separate upper and lower seats
  //   List<List<dynamic>> lowerSeatRows = [];
  //   List<List<dynamic>> upperSeatRows = [];
  //
  //   for (var row in seatDetails) {
  //     List<dynamic> lowerRow = [];
  //     List<dynamic> upperRow = [];
  //     for (var seat in row) {
  //       if (seat['IsUpper'] == true) {
  //         upperRow.add(seat);
  //       } else {
  //         lowerRow.add(seat);
  //       }
  //     }
  //     if (lowerRow.isNotEmpty) lowerSeatRows.add(lowerRow);
  //     if (upperRow.isNotEmpty) upperSeatRows.add(upperRow);
  //   }
  //   Widget buildSeatDeck(String title, List<List<dynamic>> seatRows) {
  //     // Reverse the order of the seat rows
  //     List<List<dynamic>> reversedRows = seatRows.reversed.toList();
  //
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           title,
  //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 10),
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: reversedRows.map<Widget>((row) {
  //             return Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: row.map<Widget>((seat) {
  //                 bool isSelectable = seat['SeatStatus'] ?? true;
  //                 bool isMaleSeat = seat['IsMalesSeat'] ?? false;
  //                 bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
  //                 double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
  //
  //                 Color seatColor;
  //                 if (!isSelectable) {
  //                   seatColor = Colors.grey;
  //                 } else if (isMaleSeat) {
  //                   seatColor = Colors.indigo.shade200;
  //                 } else if (isLadiesSeat) {
  //                   seatColor = Colors.pink.shade200;
  //                 } else {
  //                   seatColor = Colors.white; // Default seat color
  //                 }
  //
  //                 Widget seatWidget;
  //
  //                 // before space
  //                 if (seat['SeatType'] == 1) {
  //                   // Custom stacked layout for SeatType 1
  //                   seatWidget = Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0), // Space between seats (top, bottom, left, right)
  //                     child: Container(
  //                       width: 40,
  //                       height: 40,
  //                       child: Stack(
  //                         children: [
  //                           Positioned(
  //                             top: 5,
  //                             bottom: 5,
  //                             left: 5,
  //                             right: 5,
  //                             child: SizedBox(
  //                               child: DecoratedBox(
  //                                 decoration: BoxDecoration(
  //                                   border: Border.all(
  //                                     color: Colors.black,
  //                                     width: 1,
  //                                   ),
  //                                   borderRadius: BorderRadius.circular(5),
  //                                   color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                                       ? Colors.green
  //                                       : seatColor,
  //                                   // color: seatColor,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Positioned(
  //                             top: 29,
  //                             bottom: 5,
  //                             left: 5,
  //                             right: 5,
  //                             child: SizedBox(
  //                               child: DecoratedBox(
  //                                 decoration: BoxDecoration(
  //                                   border: Border.all(
  //                                     color: Colors.black,
  //                                     width: 1,
  //                                   ),
  //                                   borderRadius: BorderRadius.circular(5),
  //                                   color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                                       ? Colors.green
  //                                       : seatColor,
  //                                   // color: seatColor,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Positioned(
  //                             top: 15,
  //                             bottom: 5,
  //                             left: 4,
  //                             right: 30,
  //                             child: SizedBox(
  //                               child: DecoratedBox(
  //                                 decoration: BoxDecoration(
  //                                   border: Border.all(
  //                                     color: Colors.black,
  //                                     width: 1,
  //                                   ),
  //                                   borderRadius: BorderRadius.circular(5),
  //                                   color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                                       ? Colors.green
  //                                       : seatColor,
  //                                   // color: seatColor,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Positioned(
  //                             top: 15,
  //                             bottom: 5,
  //                             left: 30,
  //                             right: 4,
  //                             child: SizedBox(
  //                               child: DecoratedBox(
  //                                 decoration: BoxDecoration(
  //                                   border: Border.all(
  //                                     color: Colors.black,
  //                                     width: 1,
  //                                   ),
  //                                   borderRadius: BorderRadius.circular(5),
  //                                   color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                                       ? Colors.green
  //                                       : seatColor,
  //                                   // color: seatColor,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 } else if (seat['SeatType'] == 2) {
  //                   // Custom layout for SeatType 2
  //                   seatWidget = Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0), // Space between seats (top, bottom, left, right)
  //                     child: Container(
  //                       width: 40,
  //                       height: 102,
  //                       decoration: BoxDecoration(
  //                           color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                             ? Colors.green
  //                             : seatColor,
  //                         // color: seatColor,
  //                         border: Border.all(color: Colors.black, width: 1),
  //                         borderRadius: BorderRadius.circular(8.0),
  //                       ),
  //                       child: Center(
  //                         child: Text(
  //                           seat['SeatName'],
  //                           style: TextStyle(color: Colors.black),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 } else {
  //                   // Default seat layout
  //                   seatWidget = Container(
  //                     width: 40,
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                         color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
  //                           ? Colors.green
  //                           : seatColor,
  //                       // color: seatColor,
  //                       border: Border.all(color: Colors.black, width: 1),
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         seat['SeatName'],
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                     ),
  //                   );
  //                 }
  //
  //                 return GestureDetector(
  //                   onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
  //                   child: Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 4.0), // Space between seats
  //                     child: Column(
  //                       children: [
  //                         seatWidget,
  //                         Text(
  //                           // "₹${seatPrice+10}",
  //                           "₹${seatPrice}",
  //
  //                           style: TextStyle(color: Colors.black, fontSize: 10),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               }).toList(),
  //             );
  //           }).toList(),
  //         ),
  //       ],
  //     );
  //   }
  //   return [
  //     Center(
  //       child: SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             if (lowerSeatRows.isNotEmpty) ...[
  //               buildSeatDeck("Lower Deck", lowerSeatRows),
  //               SizedBox(width: 20),
  //             ],
  //             if (upperSeatRows.isNotEmpty) ...[
  //               buildSeatDeck("Upper Deck", upperSeatRows),
  //             ],
  //           ],
  //         ),
  //       ),
  //     ),
  //   ];
  // }

// with Space
  List<Widget> _buildSeatRows() {
    final seatDetails = _seatLayoutData?['Result']?['SeatLayout']?['SeatLayoutDetails']?['Layout']?['seatDetails'];
    if (seatDetails == null) {
      return [Text("No seat details available")];
    }

    // Separate upper and lower seats
    List<List<dynamic>> lowerSeatRows = [];
    List<List<dynamic>> upperSeatRows = [];

    for (var row in seatDetails) {
      List<dynamic> lowerRow = [];
      List<dynamic> upperRow = [];
      for (var seat in row) {
        if (seat['IsUpper'] == true) {
          upperRow.add(seat);
        } else {
          lowerRow.add(seat);
        }
      }
      if (lowerRow.isNotEmpty) lowerSeatRows.add(lowerRow);
      if (upperRow.isNotEmpty) upperSeatRows.add(upperRow);
    }

    return [
      Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (lowerSeatRows.isNotEmpty) ...[
                _buildLowerDeck(lowerSeatRows),
                SizedBox(width: 20),
              ],
              if (upperSeatRows.isNotEmpty) ...[
                _buildUpperDeck(upperSeatRows),
              ],
            ],
          ),
        ),
      ),
      SizedBox(height: 20), // Space below the decks
      Center(
        child: Text(
          "About Seat Types",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 20), // Space below the text
      Center(
        child: Container(
          height: 350, // Set container height to 350
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              // BoxShadow(
              //   color: Colors.grey.withOpacity(0.5),
              //   spreadRadius: 2,
              //   blurRadius: 5,
              //   offset: Offset(0, 3),
              // ),
            ],
          ),
          child: Column(
            children: [
              // First row with "Type", "Seater", "Sleeper"
              Container(
                height: 50, // Height for the first row
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Type",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    VerticalDivider(color: Colors.grey, thickness: 1), // Vertical divider
                    Expanded(
                      child: Center(
                        child: Text(
                          "Seater",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    VerticalDivider(color: Colors.grey, thickness: 1), // Vertical divider
                    Expanded(
                      child: Center(
                        child: Text(
                          "Sleeper",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey, thickness: 1), // Horizontal divider below the first row

              // Second row with "Available" and custom containers
              Container(
                height: 50, // Height for the second row
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Available",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    VerticalDivider(color: Colors.grey, thickness: 1), // Vertical divider
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 5,
                                bottom: 5,
                                left: 5,
                                right: 5,
                                child: SizedBox(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black, // Border color for available seats
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white, // Background color
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 29,
                                bottom: 5,
                                left: 5,
                                right: 5,
                                child: SizedBox(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black, // Border color for available seats
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white, // Background color
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 15,
                                bottom: 5,
                                left: 4,
                                right: 30,
                                child: SizedBox(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black, // Border color for available seats
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white, // Background color
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 15,
                                bottom: 5,
                                left: 30,
                                right: 4,
                                child: SizedBox(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black, // Border color for available seats
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white, // Background color
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(color: Colors.grey, thickness: 1), // Vertical divider
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 102,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // Border color for available seats
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white, // Background color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey, thickness: 1), // Horizontal divider below the second row

              // Rows 3 to 5 with specific labels and custom containers
              Expanded(
                child: Column(
                  children: [
                    for (int i = 0; i < 3; i++) ...[
                      Container(
                        height: 50, // Fixed height for each row
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  ["Already Booked", "Only for Female", "Only for Male"][i], // Dynamic text for each row
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            VerticalDivider(color: Colors.grey, thickness: 1), // Vertical divider
                            Expanded(
                              child: Center(
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 5,
                                        bottom: 5,
                                        left: 5,
                                        right: 5,
                                        child: SizedBox(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: i == 0
                                                    ? Colors.grey.shade300 // Already Booked
                                                    : i == 1
                                                    ? Colors.pink.shade400 // Only for Female
                                                    : Color(0xFF4A90E2), // Only for Male
                                                width: 2, // Border width
                                              ),
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.white, // Background color
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 29,
                                        bottom: 5,
                                        left: 5,
                                        right: 5,
                                        child: SizedBox(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: i == 0
                                                    ? Colors.grey.shade300 // Already Booked
                                                    : i == 1
                                                    ? Colors.pink.shade400 // Only for Female
                                                    : Color(0xFF4A90E2), // Only for Male
                                                width: 2, // Border width
                                              ),
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.white, // Background color
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 15,
                                        bottom: 5,
                                        left: 4,
                                        right: 30,
                                        child: SizedBox(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: i == 0
                                                    ? Colors.grey.shade300 // Already Booked
                                                    : i == 1
                                                    ? Colors.pink.shade400 // Only for Female
                                                    : Color(0xFF4A90E2), // Only for Male
                                                width: 2, // Border width
                                              ),
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.white, // Background color
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 15,
                                        bottom: 5,
                                        left: 30,
                                        right: 4,
                                        child: SizedBox(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: i == 0
                                                    ? Colors.grey.shade300 // Already Booked
                                                    : i == 1
                                                    ? Colors.pink.shade400 // Only for Female
                                                    : Color(0xFF4A90E2), // Only for Male
                                                width: 2, // Border width
                                              ),
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.white, // Background color
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(color: Colors.grey, thickness: 1), // Vertical divider
                            Expanded(
                              child: Center(
                                child: Container(
                                  width: 40,
                                  height: 102,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: i == 0
                                          ? Colors.grey.shade300 // Already Booked
                                          : i == 1
                                          ? Colors.pink.shade400 // Only for Female
                                          : Color(0xFF4A90E2), // Only for Male
                                      width: 2, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white, // Background color
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (i < 2) Divider(color: Colors.grey, thickness: 1), // Horizontal divider except for the last row
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }



  Widget _buildLowerDeck(List<List<dynamic>> lowerSeatRows) {
    return _buildSeatDeck("Lower Deck", lowerSeatRows);
  }

  Widget _buildUpperDeck(List<List<dynamic>> upperSeatRows) {
    return _buildSeatDeck("Upper Deck", upperSeatRows);
  }

  // for seat clumsy
  //
  // Widget _buildSeatDeck(String title, List<List<dynamic>> seatRows) {
  //   // Reverse the order of the seat rows
  //   List<List<dynamic>> reversedRows = seatRows.reversed.toList();
  //
  //   // Check if all seats in the deck are of SeatType == 2
  //   bool isAllSeatType2 = true;
  //   for (var row in seatRows) {
  //     for (var seat in row) {
  //       if (seat['SeatType'] != 2) {
  //         isAllSeatType2 = false;
  //         break;
  //       }
  //     }
  //     if (!isAllSeatType2) break;
  //   }
  //
  //   // Check if there are both SeatType == 1 and SeatType == 2 in the same column
  //   bool hasMixedSeatTypes = false;
  //   for (var row in seatRows) {
  //     bool hasSeatType1 = false;
  //     bool hasSeatType2 = false;
  //     for (var seat in row) {
  //       if (seat['SeatType'] == 1) hasSeatType1 = true;
  //       if (seat['SeatType'] == 2) hasSeatType2 = true;
  //       if (hasSeatType1 && hasSeatType2) {
  //         hasMixedSeatTypes = true;
  //         break;
  //       }
  //     }
  //     if (hasMixedSeatTypes) break;
  //   }
  //
  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       // borderRadius: BorderRadius.circular(12),
  //   borderRadius: BorderRadius.vertical(
  //   top: Radius.circular(12), // Top border radius
  //   bottom: Radius.circular(12),
  //   ),
  //       boxShadow: [
  //         // BoxShadow(
  //         //   color: Colors.grey.withOpacity(0.5),
  //         //   spreadRadius: 2,
  //         //   blurRadius: 5,
  //         //   offset: Offset(0, 3),
  //         // ),
  //       ],
  //     ),

  // for seats clumsy

      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       title,
      //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //     ),
      //     SizedBox(height: 10),
      //     Row(
      //       crossAxisAlignment: CrossAxisAlignment.end,
      //       children: [
      //         for (int i = 0; i < reversedRows.length; i++) ...[
      //           Column(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: reversedRows[i].map<Widget>((seat) {
      //               bool isSelectable = seat['SeatStatus'] ?? true;
      //               bool isMaleSeat = seat['IsMalesSeat'] ?? false;
      //               bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
      //               double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
      //
      //               Color seatColor;
      //               if (!isSelectable) {
      //                 seatColor = Colors.grey;
      //               } else if (isMaleSeat) {
      //                 seatColor = Colors.indigo.shade400;
      //               } else if (isLadiesSeat) {
      //                 seatColor = Colors.pink.shade400;
      //               } else {
      //                 seatColor = Colors.white; // Default seat color
      //               }
      //
      //               Widget seatWidget;
      //
      //               // before space
      //               if (seat['SeatType'] == 1) {
      //                 // Custom stacked layout for SeatType 1
      //                 seatWidget = Padding(
      //                   padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0), // Space between seats (top, bottom, left, right)
      //                   child: Container(
      //                     width: 40,
      //                     height: 40,
      //                     child: Stack(
      //                       children: [
      //                         Positioned(
      //                           top: 5,
      //                           bottom: 5,
      //                           left: 5,
      //                           right: 5,
      //                           child: SizedBox(
      //                             child: DecoratedBox(
      //                               decoration: BoxDecoration(
      //                                 border: Border.all(
      //                                   color: Colors.black,
      //                                   width: 0.5,
      //                                 ),
      //                                 borderRadius: BorderRadius.circular(5),
      //                                 color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
      //                                     ? Colors.green
      //                                     : seatColor,
      //                                 // color: seatColor,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                         Positioned(
      //                           top: 29,
      //                           bottom: 5,
      //                           left: 5,
      //                           right: 5,
      //                           child: SizedBox(
      //                             child: DecoratedBox(
      //                               decoration: BoxDecoration(
      //                                 border: Border.all(
      //                                   color: Colors.black,
      //                                   width: 0.5,
      //                                 ),
      //                                 borderRadius: BorderRadius.circular(5),
      //                                 color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
      //                                     ? Colors.green
      //                                     : seatColor,
      //                                 // color: seatColor,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                         Positioned(
      //                           top: 15,
      //                           bottom: 5,
      //                           left: 4,
      //                           right: 30,
      //                           child: SizedBox(
      //                             child: DecoratedBox(
      //                               decoration: BoxDecoration(
      //                                 border: Border.all(
      //                                   color: Colors.black,
      //                                   width: 0.5,
      //                                 ),
      //                                 borderRadius: BorderRadius.circular(5),
      //                                 color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
      //                                     ? Colors.green
      //                                     : seatColor,
      //                                 // color: seatColor,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                         Positioned(
      //                           top: 15,
      //                           bottom: 5,
      //                           left: 30,
      //                           right: 4,
      //                           child: SizedBox(
      //                             child: DecoratedBox(
      //                               decoration: BoxDecoration(
      //                                 border: Border.all(
      //                                   color: Colors.black,
      //                                   width: 0.5,
      //                                 ),
      //                                 borderRadius: BorderRadius.circular(5),
      //                                 color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
      //                                     ? Colors.green
      //                                     : seatColor,
      //                                 // color: seatColor,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 );
      //               } else if (seat['SeatType'] == 2) {
      //                 // Custom layout for SeatType 2
      //                 seatWidget = Padding(
      //                   padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0), // Space between seats (top, bottom, left, right)
      //                   child: Container(
      //                     width: 40,
      //                     height: 102,
      //                     decoration: BoxDecoration(
      //                       color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
      //                           ? Colors.green
      //                           : seatColor,
      //                       // color: seatColor,
      //                       border: Border.all(color: Colors.black, width: 0.5),
      //                       borderRadius: BorderRadius.circular(8.0),
      //                     ),
      //                     child: Center(
      //                       child: Text(
      //                         seat['SeatName'],
      //                         style: TextStyle(color: Colors.black),
      //                       ),
      //                     ),
      //                   ),
      //                 );
      //               } else {
      //                 // Default seat layout
      //                 seatWidget = Container(
      //                   width: 40,
      //                   height: 40,
      //                   decoration: BoxDecoration(
      //                     color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
      //                         ? Colors.green
      //                         : seatColor,
      //                     // color: seatColor,
      //                     border: Border.all(color: Colors.black, width: 1),
      //                     borderRadius: BorderRadius.circular(8.0),
      //                   ),
      //                   child: Center(
      //                     child: Text(
      //                       seat['SeatName'],
      //                       style: TextStyle(color: Colors.black),
      //                     ),
      //                   ),
      //                 );
      //               }
      //
      //               return GestureDetector(
      //                 onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
      //                 child: Padding(
      //                   padding: const EdgeInsets.symmetric(vertical: 4.0), // Space between seats
      //                   child: Column(
      //                     children: [
      //                       seatWidget,
      //                       Text(
      //                         // Display "Sold" if the seat is not selectable, otherwise display the price without decimal places
      //                         !isSelectable ? "Sold" : "₹${seatPrice.toStringAsFixed(0)}",
      //                         style: TextStyle(
      //                           color: !isSelectable ? Colors.green : Colors.black,
      //                           fontSize: 10,
      //                           fontWeight: !isSelectable ? FontWeight.bold : FontWeight.normal,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             }).toList(),
      //           ),
      //           // Add a SizedBox(width: 50) after the first column if all seats are of SeatType == 2 or if there are mixed seat types
      //           if ((isAllSeatType2 || hasMixedSeatTypes) && i == 0) SizedBox(width: 50),
      //         ],
      //       ],
      //     ),
      //   ],
      // ),

      // 2/7/2025 seat shape not there remaining is good

//             child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 10),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               for (int i = 0; i < reversedRows.length; i++) ...[
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: reversedRows[i].map<Widget>((seat) {
//                     bool isSelectable = seat['SeatStatus'] ?? true;
//                     bool isMaleSeat = seat['IsMalesSeat'] ?? false;
//                     bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
//                     double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
//
//                     Color seatColor;
//                     if (!isSelectable) {
//                       seatColor = Colors.grey;
//                     } else if (isMaleSeat) {
//                       seatColor = Colors.indigo.shade400;
//                     } else if (isLadiesSeat) {
//                       seatColor = Colors.pink.shade400;
//                     } else {
//                       seatColor = Colors.white; // Default seat color
//                     }
//
//                     Widget seatWidget;
//
// // before space
//                     if (seat['SeatType'] == 1) {
//                       // Custom stacked layout for SeatType 1
//                       seatWidget = Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0), // Space between seats (top, bottom, left, right)
//                         child: Container(
//                           width: 40,
//                           height: 40,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 top: 5,
//                                 bottom: 5,
//                                 left: 5,
//                                 right: 5,
//                                 child: SizedBox(
//                                   child: DecoratedBox(
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: isMaleSeat
//                                             ? Colors.indigo.shade400 // Border color for male seats
//                                             : isLadiesSeat
//                                             ? Colors.pink.shade400 // Border color for ladies seats
//                                             : Colors.black, // Default border color
//                                         width: 0.5,
//                                       ),
//                                       borderRadius: BorderRadius.circular(5),
//                                       color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                                           ? Colors.green
//                                           : Colors.white, // Default seat color
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               // Other Positioned widgets for SeatType 1...
//                             ],
//                           ),
//                         ),
//                       );
//                     } else if (seat['SeatType'] == 2) {
//                       // Custom layout for SeatType 2
//                       seatWidget = Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0), // Space between seats (top, bottom, left, right)
//                         child: Container(
//                           width: 40,
//                           height: 102,
//                           decoration: BoxDecoration(
//                             color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                                 ? Colors.green
//                                 : Colors.white, // Default seat color
//                             border: Border.all(
//                               color: isMaleSeat
//                                   ? Colors.indigo.shade400 // Border color for male seats
//                                   : isLadiesSeat
//                                   ? Colors.pink.shade400 // Border color for ladies seats
//                                   : Colors.black, // Default border color
//                               width: 0.5,
//                             ),
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           child: Center(
//                             child: Text(
//                               seat['SeatName'],
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       );
//                     } else {
//                       // Default seat layout
//                       seatWidget = Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
//                               ? Colors.green
//                               : Colors.white, // Default seat color
//                           border: Border.all(
//                             color: isMaleSeat
//                                 ? Colors.indigo.shade400 // Border color for male seats
//                                 : isLadiesSeat
//                                 ? Colors.pink.shade400 // Border color for ladies seats
//                                 : Colors.black, // Default border color
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Center(
//                           child: Text(
//                             seat['SeatName'],
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       );
//                     }
//                     return GestureDetector(
//                       onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 4.0), // Space between seats
//                         child: Column(
//                           children: [
//                             seatWidget,
//                             Text(
//                               // Display "Sold" if the seat is not selectable, otherwise display the price without decimal places
//                               !isSelectable ? "Sold" : "₹${seatPrice.toStringAsFixed(0)}",
//                               style: TextStyle(
//                                 color: !isSelectable ? Colors.green : Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: !isSelectable ? FontWeight.bold : FontWeight.normal,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//                 // Add a SizedBox(width: 50) after the first column if all seats are of SeatType == 2 or if there are mixed seat types
//                 if ((isAllSeatType2 || hasMixedSeatTypes) && i == 0) SizedBox(width: 50),
//               ],
//             ],
//           ),
//         ],
//       ),


// good

    //       child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //     Text(
    //     title,
    //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //   ),
    //   SizedBox(height: 10),
    //   Row(
    //       crossAxisAlignment: CrossAxisAlignment.end,
    //       children: [
    //   for (int i = 0; i < reversedRows.length; i++) ...[
    //   Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: reversedRows[i].map<Widget>((seat) {
    //     bool isSelectable = seat['SeatStatus'] ?? true;
    //     bool isMaleSeat = seat['IsMalesSeat'] ?? false;
    //     bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
    //     double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;
    //
    //     Color borderColor = Colors.black; // Default border color
    //     if (isMaleSeat) {
    //       borderColor = Colors.indigo.shade400;
    //     } else if (isLadiesSeat) {
    //       borderColor = Colors.pink.shade400;
    //     }
    //
    //     Color seatColor = !isSelectable ? Colors.grey : Colors.white; // Default seat color
    //
    //     Widget seatWidget;
    //
    //     // before space
    //     if (seat['SeatType'] == 1) {
    //       // Custom stacked layout for SeatType 1
    //       seatWidget = Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0), // Space between seats (top, bottom, left, right)
    //         child: Container(
    //           width: 40,
    //           height: 40,
    //           child: Stack(
    //             children: [
    //               Positioned(
    //                 top: 5,
    //                 bottom: 5,
    //                 left: 5,
    //                 right: 5,
    //                 child: SizedBox(
    //                   child: DecoratedBox(
    //                     decoration: BoxDecoration(
    //                       border: Border.all(
    //                         color: borderColor,
    //                         width: 1.5,
    //                       ),
    //                       borderRadius: BorderRadius.circular(5),
    //                       color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
    //                           ? Colors.green
    //                           : seatColor,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 top: 29,
    //                 bottom: 5,
    //                 left: 5,
    //                 right: 5,
    //                 child: SizedBox(
    //                   child: DecoratedBox(
    //                     decoration: BoxDecoration(
    //                       border: Border.all(
    //                         color: borderColor,
    //                         width: 1.5,
    //                       ),
    //                       borderRadius: BorderRadius.circular(5),
    //                       color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
    //                           ? Colors.green
    //                           : seatColor,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 top: 15,
    //                 bottom: 5,
    //                 left: 4,
    //                 right: 30,
    //                 child: SizedBox(
    //                   child: DecoratedBox(
    //                     decoration: BoxDecoration(
    //                       border: Border.all(
    //                         color: borderColor,
    //                         width: 1.5,
    //                       ),
    //                       borderRadius: BorderRadius.circular(5),
    //                       color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
    //                           ? Colors.green
    //                           : seatColor,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 top: 15,
    //                 bottom: 5,
    //                 left: 30,
    //                 right: 4,
    //                 child: SizedBox(
    //                   child: DecoratedBox(
    //                     decoration: BoxDecoration(
    //                       border: Border.all(
    //                         color: borderColor,
    //                         width: 1.5,
    //                       ),
    //                       borderRadius: BorderRadius.circular(5),
    //                       color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
    //                           ? Colors.green
    //                           : seatColor,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     } else if (seat['SeatType'] == 2) {
    //       // Custom layout for SeatType 2
    //       seatWidget = Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0), // Space between seats (top, bottom, left, right)
    //         child: Container(
    //           width: 40,
    //           height: 102,
    //           decoration: BoxDecoration(
    //             color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
    //                 ? Colors.green
    //                 : seatColor,
    //             border: Border.all(color: borderColor, width: 1.5),
    //             borderRadius: BorderRadius.circular(8.0),
    //           ),
    //           child: Center(
    //             child: Text(
    //               seat['SeatName'],
    //               style: TextStyle(color: Colors.black),
    //             ),
    //           ),
    //         ),
    //       );
    //     } else {
    //       // Default seat layout
    //       seatWidget = Container(
    //         width: 40,
    //         height: 40,
    //         decoration: BoxDecoration(
    //           color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
    //               ? Colors.green
    //               : seatColor,
    //           border: Border.all(color: borderColor, width: 1),
    //           borderRadius: BorderRadius.circular(8.0),
    //         ),
    //         child: Center(
    //           child: Text(
    //             seat['SeatName'],
    //             style: TextStyle(color: Colors.black),
    //           ),
    //         ),
    //       );
    //     }
    //
    //     return GestureDetector(
    //       onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 4.0), // Space between seats
    //         child: Column(
    //           children: [
    //             seatWidget,
    //             Text(
    //               // Display "Sold" if the seat is not selectable, otherwise display the price without decimal places
    //               !isSelectable ? "Sold" : "₹${seatPrice.toStringAsFixed(0)}",
    //               style: TextStyle(
    //                 color: !isSelectable ? Colors.green : Colors.black,
    //                 fontSize: 10,
    //                 fontWeight: !isSelectable ? FontWeight.bold : FontWeight.normal,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   }).toList(),
    // ),
    // // Add a SizedBox(width: 50) after the first column if all seats are of SeatType == 2 or if there are mixed seat types
    // if ((isAllSeatType2 || hasMixedSeatTypes) && i == 0) SizedBox(width: 50),
    //   ],
    //       ],
    //   ),
    //     ],
    //       ),
  Widget _buildSeatDeck(String title, List<List<dynamic>> seatRows) {
    // Reverse the order of the seat rows
    List<List<dynamic>> reversedRows = seatRows.reversed.toList();

    // Check if all seats in the deck are of SeatType == 2
    bool isAllSeatType2 = true;
    for (var row in seatRows) {
      for (var seat in row) {
        if (seat['SeatType'] != 2) {
          isAllSeatType2 = false;
          break;
        }
      }
      if (!isAllSeatType2) break;
    }

    // Check if there are both SeatType == 1 and SeatType == 2 in the same column
    bool hasMixedSeatTypes = false;
    for (var row in seatRows) {
      bool hasSeatType1 = false;
      bool hasSeatType2 = false;
      for (var seat in row) {
        if (seat['SeatType'] == 1) hasSeatType1 = true;
        if (seat['SeatType'] == 2) hasSeatType2 = true;
        if (hasSeatType1 && hasSeatType2) {
          hasMixedSeatTypes = true;
          break;
        }
      }
      if (hasMixedSeatTypes) break;
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(12),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12), // Top border radius
          bottom: Radius.circular(12),
        ),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.grey.withOpacity(0.5),
          //   spreadRadius: 2,
          //   blurRadius: 5,
          //   offset: Offset(0, 3),
          // ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
      for (int i = 0; i < reversedRows.length; i++) ...[
      Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: reversedRows[i].map<Widget>((seat) {
        bool isSelectable = seat['SeatStatus'] ?? true;
        bool isMaleSeat = seat['IsMalesSeat'] ?? false;
        bool isLadiesSeat = seat['IsLadiesSeat'] ?? false;
        double seatPrice = seat['Price']?['OfferedPriceRoundedOff']?.toDouble() ?? 0.0;

        Color borderColor = isMaleSeat
            ? Color(0xFF4A90E2) // Border color for male seats
            : isLadiesSeat
            ? Colors.pink.shade400 // Border color for ladies seats
            : Colors.black; // Default border color

        Color seatColor = !isSelectable ? Colors.grey.shade300 : Colors.white; // Default seat color

        Widget seatWidget;

        // before space
        if (seat['SeatType'] == 1) {
          // Custom stacked layout for SeatType 1 (medium size)
          seatWidget = Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0), // Space between seats (top, bottom, left, right)
            child: Container(
              width: 30, // Reduced width for medium size
              height: 30, // Reduced height for medium size
              child: Stack(
                children: [
                  Positioned(
                    top: 3, // Adjusted top position
                    bottom: 3, // Adjusted bottom position
                    left: 3, // Adjusted left position
                    right: 3, // Adjusted right position
                    child: SizedBox(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 0.8,
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
                              ? Colors.green
                              : seatColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20, // Adjusted top position
                    bottom: 3, // Adjusted bottom position
                    left: 3, // Adjusted left position
                    right: 3, // Adjusted right position
                    child: SizedBox(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 0.8,
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
                              ? Colors.green
                              : seatColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10, // Adjusted top position
                    bottom: 3, // Adjusted bottom position
                    left: 2, // Adjusted left position
                    right: 20, // Adjusted right position
                    child: SizedBox(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 0.8,
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
                              ? Colors.green
                              : seatColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10, // Adjusted top position
                    bottom: 3, // Adjusted bottom position
                    left: 20, // Adjusted left position
                    right: 2, // Adjusted right position
                    child: SizedBox(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 0.8,
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
                              ? Colors.green
                              : seatColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (seat['SeatType'] == 2) {
          // Custom layout for SeatType 2
          seatWidget = Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0), // Space between seats (top, bottom, left, right)
            child: Container(
              width: 30,
              height: 82,
              decoration: BoxDecoration(
                color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
                    ? Colors.green
                    : seatColor,
                border: Border.all(
                  color: borderColor,
                  width: 0.8,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  seat['SeatName'],
                  style: TextStyle(color: Colors.black,fontSize: 8),
                ),
              ),
            ),
          );
        } else {
          // Default seat layout
          seatWidget = Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _selectedSeats.any((s) => s['SeatName'] == seat['SeatName'])
                  ? Colors.green
                  : seatColor,
              border: Border.all(
                color: borderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                seat['SeatName'],
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: isSelectable ? () => _toggleSeatSelection(seat) : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0), // Space between seats
            child: Column(
              children: [
                seatWidget,
                Text(
                  // Display "Sold" if the seat is not selectable, otherwise display the price without decimal places
                  !isSelectable ? "Sold" : "₹${seatPrice.toStringAsFixed(0)}",
                  style: TextStyle(
                    color: !isSelectable ? Colors.green : Colors.black,
                    fontSize: 10,
                    fontWeight: !isSelectable ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ),
    // Add a SizedBox(width: 50) after the first column if all seats are of SeatType == 2 or if there are mixed seat types
    if ((isAllSeatType2 || hasMixedSeatTypes) && i == 0) SizedBox(width: 50),
      ],
          ],
      ),
        ],
      ),
    );
  }
}


