import 'dart:convert';
import 'dart:async';
import 'package:bus_booking_app/customer/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Bookings_screen.dart';
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
    required this.selectedSeats,
  }) : super(key: key);

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
  String _commonPhone = '';
  String _commonEmail = '';
  String _commonState = '';

  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _stateController;

  @override
  void initState() {
    super.initState();
    _initializePassengerForms();
    _fetchSavedPassengers();
    _fetchSavedContacts(); // Add this line
    _phoneController = TextEditingController(text: _commonPhone);
    _emailController = TextEditingController(text: _commonEmail);
    _stateController = TextEditingController(text: _commonState);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  // con

  List<Map<String, dynamic>> _savedContacts = [];
  String? _selectedContactId;

  void _fetchSavedContacts() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('customers')
        .doc(currentUser.uid)
        .collection('contacts')
        .orderBy('lastUsed', descending: true)
        .get();

    setState(() {
      _savedContacts = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          ...data,
          'id': doc.id,
        };
      }).toList();

      // Set the latest contact as default if available
      if (_savedContacts.isNotEmpty) {
        _selectedContactId = _savedContacts.first['id'];
        _commonPhone = _savedContacts.first['phone'] ?? '';
        _commonEmail = _savedContacts.first['email'] ?? '';
        _commonState = _savedContacts.first['state'] ?? '';
      }
    });
  }

  void _onContactSelected(String contactId) {
    final contact = _savedContacts.firstWhere((c) => c['id'] == contactId);
    setState(() {
      _selectedContactId = contactId;
      _commonPhone = contact['phone'] ?? '';
      _commonEmail = contact['email'] ?? '';
      _commonState = contact['state'] ?? '';

      // Update controllers without losing cursor position
      _phoneController.text = _commonPhone;
      _emailController.text = _commonEmail;
      _stateController.text = _commonState;
    });
  }

  Future<void> _saveContactInfo() async {
    _phoneController.text = _commonPhone;
    _emailController.text = _commonEmail;
    _stateController.text = _commonState;
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final contactsRef = FirebaseFirestore.instance
        .collection('customers')
        .doc(currentUser.uid)
        .collection('contacts');

    // Check if this contact already exists
    final existingContact = _savedContacts.firstWhere(
      (c) => c['phone'] == _commonPhone && c['email'] == _commonEmail,
      orElse: () => {},
    );

    if (existingContact.isNotEmpty) {
      // Update last used timestamp
      await contactsRef.doc(existingContact['id']).update({
        'lastUsed': FieldValue.serverTimestamp(),
      });
    } else {
      // Add new contact
      await contactsRef.add({
        'phone': _commonPhone,
        'email': _commonEmail,
        'state': _commonState,
        'lastUsed': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  void _initializePassengerForms() {
    _passengerForms = widget.selectedSeats.map((seat) {
      return {
        'seat': seat,
        'fullName': '',
        'age': '',
        'gender': null,
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

  void _onSavedPassengerSelected(
      int passengerIndex, Map<String, dynamic> passenger) {
    setState(() {
      _passengerForms[passengerIndex] = {
        ..._passengerForms[passengerIndex],
        'fullName':
            '${passenger['FirstName'] ?? ''} ${passenger['LastName'] ?? ''}',
        'age': passenger['Age'] ?? '',
        'gender': passenger['Gender'] == "1" ? "Male" : "Female",
        'isUsingSavedPassenger': true,
        'savedPassengerId': passenger['id'],
      };
    });
  }

  void _clearPassengerForm(int index) {
    setState(() {
      _passengerForms[index] = {
        'seat': _passengerForms[index]['seat'],
        'fullName': '',
        'age': '',
        'gender': null,
        'isUsingSavedPassenger': false,
        'savedPassengerId': null,
      };
    });
  }

  bool _validateForms() {
    // Validate passenger-specific fields
    for (var form in _passengerForms) {
      if (form['fullName'].isEmpty ||
          form['age'].isEmpty ||
          form['gender'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please fill all details for all passengers"),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }

    // Validate common fields
    if (_commonPhone.isEmpty || _commonEmail.isEmpty || _commonState.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all common details (Phone, Email, State)"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Validate email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_commonEmail.trim().toLowerCase())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email address"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Validate phone number format
    final phone = _commonPhone.trim();
    if (phone.length < 10 || !RegExp(r'^[0-9]+$').hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Please enter a valid phone number (minimum 10 digits)"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }

  Map<String, String> _splitFullName(String fullName) {
    final names = fullName.trim().split(' ');
    if (names.isEmpty) return {'firstName': '', 'lastName': ''};
    if (names.length == 1) return {'firstName': names[0], 'lastName': ''};

    final firstName = names.first;
    final lastName = names.sublist(1).join(' ');
    return {'firstName': firstName, 'lastName': lastName};
  }

  Future<void> _blockSeat() async {
    if (!_validateForms()) {
      return;
    }

    await _saveContactInfo();

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
      final nameParts = _splitFullName(form['fullName']);

      return {
        "LeadPassenger":
            _passengerForms.indexOf(form) == 0, // First passenger is lead
        "PassengerId": DateTime.now().millisecondsSinceEpoch +
            _passengerForms.indexOf(form),
        "Title": "Mr",
        "FirstName": nameParts['firstName'],
        "LastName": nameParts['lastName'],
        "Email": _commonEmail,
        "Phoneno": _commonPhone,
        "Gender": form['gender'] == "Male" ? "1" : "2",
        "IdType": null,
        "IdNumber": null,
        "Address": _commonState,
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
          "Price": form['seat']['Price'] ??
              {
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

      final currentPassengers = await passengersRef.get();
      final currentCount = currentPassengers.size;
      const maxPassengers = 6;

      final newPassengersCount = passengersData
          .asMap()
          .entries
          .where(
              (entry) => !_passengerForms[entry.key]['isUsingSavedPassenger'])
          .length;

      final totalPassengersAfterAdd = currentCount + newPassengersCount;

      final batch = FirebaseFirestore.instance.batch();

      if (totalPassengersAfterAdd > maxPassengers) {
        final passengersToDelete = totalPassengersAfterAdd - maxPassengers;
        final oldestPassengers = await passengersRef
            .orderBy('createdAt')
            .limit(passengersToDelete)
            .get();

        for (final doc in oldestPassengers.docs) {
          batch.delete(doc.reference);
        }
      }

      final remainingCapacity = maxPassengers -
          (currentCount -
              (totalPassengersAfterAdd > maxPassengers
                  ? (totalPassengersAfterAdd - maxPassengers)
                  : 0));

      if (remainingCapacity > 0) {
        int addedCount = 0;
        for (var i = 0;
            i < passengersData.length && addedCount < remainingCapacity;
            i++) {
          if (!_passengerForms[i]['isUsingSavedPassenger']) {
            final nameParts = _splitFullName(_passengerForms[i]['fullName']);
            batch.set(passengersRef.doc(), {
              "FirstName": nameParts['firstName'],
              "LastName": nameParts['lastName'],
              "Email": _commonEmail,
              "Phoneno": _commonPhone,
              "Gender": passengersData[i]["Gender"],
              "Address": _commonState,
              "Age": passengersData[i]["Age"],
              "createdAt": FieldValue.serverTimestamp(),
            });
            addedCount++;
          }
        }
      }

      await batch.commit();
      print(
          "Passengers saved to Firestore (strict 6-passenger limit enforced)");
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to save passengers: $e";
      });
      print("Firestore Error: $e");
      return;
    }

    // API Call to Block Seats
    const String apiUrl =
        "https://namma-savaari-api-backend-9mpl.vercel.app/bus-api/Block";
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
                  Navigator.popUntil(context, (route) => route.isFirst);
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
          final errorMessage = responseData['Error']?['ErrorMessage'] ??
              "Failed to block seats. Please try again.";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
          );
        }
      } else {
        final errorMessage = responseData['Error']?['ErrorMessage'] ??
            "Failed to block seats. Status code: ${response.statusCode}";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("An error occurred: $e"),
            backgroundColor: Colors.red),
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
        actions: [
          IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomePage()));
              },
              icon: const Icon(Icons.person, color: Colors.white)),
          const SizedBox(
            width: 20,
          ),
        ],
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Passenger Information",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  "${widget.sourceCity} -> ${widget.destinationCity}",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
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
              // Common fields section (Phone, Email, State)
              // Replace the existing contact information Card widget with this:
              // Card(
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              //   elevation: 5,
              //   margin: EdgeInsets.only(bottom: 20),
              //   child: Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               "Contact Information",
              //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //             ),
              //             if (_savedContacts.isNotEmpty)
              //               DropdownButton<String>(
              //                 value: _selectedContactId,
              //                 hint: Text("Select Contact"),
              //                 items: _savedContacts.map((contact) {
              //                   return DropdownMenuItem<String>(
              //                     value: contact['id'],
              //                     child: Text(
              //                       "${contact['phone']} - ${contact['email']}",
              //                       overflow: TextOverflow.ellipsis,
              //                     ),
              //                   );
              //                 }).toList(),
              //                 onChanged: (value) => _onContactSelected(value!),
              //               ),
              //           ],
              //         ),
              //         SizedBox(height: 16),
              //         TextFormField(
              //           controller: _phoneController,
              //           keyboardType: TextInputType.phone,
              //           decoration: InputDecoration(
              //             labelText: "Phone Number",
              //             prefixIcon: Icon(Icons.phone, color: Colors.redAccent),
              //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              //             filled: true,
              //             fillColor: Colors.grey[200],
              //           ),
              //           onChanged: (value) => setState(() => _commonPhone = value),
              //           validator: (value) => value!.isEmpty ? "Phone number is required" : null,
              //         ),
              //         SizedBox(height: 12),
              //         TextFormField(
              //           controller: _emailController,
              //           keyboardType: TextInputType.emailAddress,
              //           decoration: InputDecoration(
              //             labelText: "Email",
              //             prefixIcon: Icon(Icons.email, color: Colors.redAccent),
              //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              //             filled: true,
              //             fillColor: Colors.grey[200],
              //           ),
              //           onChanged: (value) => setState(() => _commonEmail = value),
              //           validator: (value) => value!.isEmpty ? "Email is required" : null,
              //         ),
              //         SizedBox(height: 12),
              //         TextFormField(
              //           controller: _stateController,
              //           decoration: InputDecoration(
              //             labelText: "State",
              //             prefixIcon: Icon(Icons.home, color: Colors.redAccent),
              //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              //             filled: true,
              //             fillColor: Colors.grey[200],
              //           ),
              //           onChanged: (value) => setState(() => _commonState = value),
              //           validator: (value) => value!.isEmpty ? "State is required" : null,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
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
                          const Text(
                            "Contact Information",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          if (_savedContacts.isNotEmpty)
                            DropdownButton<String>(
                              value: _selectedContactId,
                              icon: const Icon(Icons.bookmark,
                                  color: Colors.redAccent),
                              underline:
                                  const SizedBox(), // Remove default underline
                              items: _savedContacts.map((contact) {
                                return DropdownMenuItem<String>(
                                  value: contact['id'],
                                  child: Text(
                                    "Contact ${_savedContacts.indexOf(contact) + 1}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) => _onContactSelected(value!),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          prefixIcon:
                              const Icon(Icons.phone, color: Colors.redAccent),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        onChanged: (value) =>
                            setState(() => _commonPhone = value),
                        validator: (value) =>
                            value!.isEmpty ? "Phone number is required" : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.redAccent),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        onChanged: (value) =>
                            setState(() => _commonEmail = value),
                        validator: (value) =>
                            value!.isEmpty ? "Email is required" : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _stateController,
                        decoration: InputDecoration(
                          labelText: "State",
                          prefixIcon:
                              const Icon(Icons.home, color: Colors.redAccent),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        onChanged: (value) =>
                            setState(() => _commonState = value),
                        validator: (value) =>
                            value!.isEmpty ? "State is required" : null,
                      ),
                    ],
                  ),
                ),
              ),
              // Passenger Forms for each seat (without phone, email, state)
              ..._passengerForms.asMap().entries.map((entry) {
                final index = entry.key;
                final form = entry.value;
                final seat = form['seat'];

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
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
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            if (form['isUsingSavedPassenger'])
                              Chip(
                                label: const Text("Saved Passenger"),
                                backgroundColor: Colors.green[100],
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (!form['isUsingSavedPassenger'] &&
                            _savedPassengers.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Select from saved passengers:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _savedPassengers.map((passenger) {
                                  return ChoiceChip(
                                    label: Text(
                                        "${passenger['FirstName']} ${passenger['LastName']}"),
                                    selected: false,
                                    onSelected: (_) =>
                                        _onSavedPassengerSelected(
                                            index, passenger),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 16),
                              const Divider(),
                            ],
                          ),
                        _buildTextField(
                          index,
                          'fullName',
                          form['fullName'],
                          "Firstname Lastname",
                          Icons.person,
                          (value) => setState(
                              () => _passengerForms[index]['fullName'] = value),
                        ),
                        _buildTextField(
                          index,
                          'age',
                          form['age'],
                          "Age",
                          Icons.cake,
                          (value) => setState(
                              () => _passengerForms[index]['age'] = value),
                          TextInputType.number,
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: form['gender'],
                          decoration: InputDecoration(
                            labelText: "Gender",
                            prefixIcon:
                                const Icon(Icons.wc, color: Colors.redAccent),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          items: ["Male", "Female"]
                              .map((gender) => DropdownMenuItem(
                                  value: gender, child: Text(gender)))
                              .toList(),
                          onChanged: (value) => setState(
                              () => _passengerForms[index]['gender'] = value),
                          validator: (value) =>
                              value == null ? "Gender is required" : null,
                        ),
                        if (form['isUsingSavedPassenger'])
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => _clearPassengerForm(index),
                              child: const Text("Clear Saved Passenger",
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _isLoading || _isSeatBlocked ? null : _blockSeat,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isSeatBlocked ? Colors.green : Colors.redAccent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        _isSeatBlocked
                            ? "Seats Booked"
                            : "Book ${widget.selectedSeats.length} Seats",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(_errorMessage,
                      style: const TextStyle(color: Colors.red)),
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
