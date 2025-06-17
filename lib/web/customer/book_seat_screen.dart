import 'dart:convert';
import 'package:bus_booking_app/customer/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'home_screen.dart';

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
  final List<Map<String, dynamic>> selectedSeats;
  final List<Map<String, dynamic>> passengers;
  final VoidCallback onNavigateToHome;

  const BookSeat(
      {Key? key,
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
      required this.onNavigateToHome})
      : super(key: key);

  @override
  _BookSeatState createState() => _BookSeatState();
}

class _BookSeatState extends State<BookSeat> {
  late Razorpay _razorpay;
  bool _isLoading = false;
  double _commission = 0;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _loadCommission();
  }

  // Calculate base price without commission (without decimal)

  // double _calculateBasePrice(dynamic basePrice) {
  //   return double.tryParse(basePrice.toString()) ?? 0;
  // }

  // Calculate base price without commission and round it (with decimal)

  double _calculateBasePrice(dynamic basePrice) {
    final price = double.tryParse(basePrice.toString()) ?? 0;
    return price.roundToDouble(); // This will round to the nearest integer
  }

  // Calculate commission amount for a single seat
  double _calculateCommission(dynamic basePrice) {
    return (_calculateBasePrice(basePrice) * (_commission / 100))
        .roundToDouble();
  }

  // Calculate total base amount without commission
  double get totalBaseAmount => widget.selectedSeats.fold(
        0.0,
        (sum, seat) => sum + _calculateBasePrice(seat['Price']['OfferedPrice']),
      );

  // Calculate total commission amount
  double get totalCommission => widget.selectedSeats.fold(
        0.0,
        (sum, seat) =>
            sum + _calculateCommission(seat['Price']['OfferedPrice']),
      );

  // Calculate total amount (base + commission)
  double get totalAmount => totalBaseAmount + totalCommission;

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

    String apiUrl =
        "https://api.razorpay.com/v1/payments/${response.paymentId}/capture";
    String key = "rzp_live_jRrlgHE9Hldmk5";
    String secret = "C1Cvhlrq3ZaqJXSEq7NFeEUm";

    var headers = {
      "Authorization": "Basic ${base64Encode(utf8.encode('$key:$secret'))}",
      "Content-Type": "application/json"
    };

    var body =
        jsonEncode({"amount": (totalAmount * 100).toInt(), "currency": "INR"});

    try {
      var captureResponse =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (captureResponse.statusCode == 200) {
        print("Payment Captured Successfully");
        bookSeat(context, response.paymentId!);
      } else {
        print("Failed to capture payment: ${captureResponse.body}");
        _showDialog(
          title: "Payment Capture Failed",
          message:
              "Payment was successful but could not be captured. Contact support.",
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

  // ... (keep other payment handler methods the same)
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

  void _showDialog(
      {required String title,
      required String message,
      required bool isSuccess}) {
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
    const String apiUrl = "https://namma-savaari-api-backend-9mpl.vercel.app/bus-api/BookSeat";

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
            (responseData['Error']['ErrorCode'] != 0 ||
                responseData['Error']['ErrorMessage'].isNotEmpty)) {
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
              'seats':
                  widget.selectedSeats.map((seat) => seat['SeatName']).toList(),
              'departureTime': widget.departureTime,
              'arrivalTime': widget.arrivalTime,
              'boardingPoint': widget.selectedBoardingPoint,
              'droppingPoint': widget.selectedDroppingPoint,
            },
            'passengerDetails': passengers
                .map((p) => {
                      'name':
                          '${p['Title']} ${p['FirstName']} ${p['LastName']}',
                      'email': p['Email'],
                      'phone': p['Phoneno'],
                      'age': p['Age'],
                      'gender': p['Gender'],
                      'idType': p['IdType'],
                      'idNumber': p['IdNumber'],
                      'seat': p['Seat']['SeatName'],
                    })
                .toList(),
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

        // showDialog(
        //   context: context,
        //   barrierDismissible: false,
        //   builder: (context) => AlertDialog(
        //     title: const Text("Booking Successful"),
        //     content: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text("Ticket No: ${responseData['Result']['TicketNo']}"),
        //         Text("PNR: ${responseData['Result']['TravelOperatorPNR']}"),
        //         Text("Status: ${responseData['Result']['BusBookingStatus']}"),
        //         const SizedBox(height: 10),
        //         const Text("Booking confirmation has been sent to your email."),
        //       ],
        //     ),
        //     actions: [
        //       TextButton(
        //         onPressed: () {
        //           Navigator.pop(context);
        //           Navigator.pop(context);
        //         },
        //         child: const Text("ok"),
        //       ),
        //
        //     ],
        //   ),
        // );

        // In the bookSeat method, update the success dialog actions:
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
                  // Close all dialogs and pop to root
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  // Navigate to bookings screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                          initialIndex: 1), // Index 1 is BookingsScreen
                    ),
                  );
                },
                child: const Text("VIEW BOOKING"),
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
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Journey Details",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.sourceCity,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.arrow_forward),
                            Text(
                              widget.destinationCity,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text("Boarding: ${widget.selectedBoardingPoint}"),
                        Text("Dropping: ${widget.selectedDroppingPoint}"),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Base Fare:",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "₹${totalBaseAmount.toStringAsFixed(0)}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Convenience Fee:",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "₹${totalCommission.toStringAsFixed(0)}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Amount:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "₹${totalAmount.toStringAsFixed(0)}",
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
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
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
                                Text(
                                    "Type: ${seat['SeatType'] == 1 ? 'Sleeper' : 'Seater'}"),
                                // Text("Fare: ₹${_calculateBasePrice(seat['Price']['OfferedPrice'])}"), (with decimal)

                                // (without decimal)
                                Text(
                                    "Fare: ₹${_calculateBasePrice(seat['Price']['OfferedPrice']).toStringAsFixed(0)}"),

                                const SizedBox(height: 8),
                                Text(
                                    "Age: ${passenger['Age']} | Gender: ${passenger['Gender'] == "1" ? "Male" : "Female"}"),
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
                        }).toList(),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      : const Text(
                          "PROCEED TO PAY",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                ),
                const SizedBox(height: 16),
                Text(
                  "By proceeding, you agree to our Terms and Conditions",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
