import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'bus_seat_layout_page.dart';

class BusListPage extends StatefulWidget {
  final String sourceCity;
  final String destinationCity;
  final String journeyDate;
  final String SourceCityId;
  final String destinationCityId;

  BusListPage({
    required this.sourceCity,
    required this.destinationCity,
    required this.journeyDate,
    required this.SourceCityId,
    required this.destinationCityId,
  });

  @override
  _BusListPageState createState() => _BusListPageState();
}

class _BusListPageState extends State<BusListPage> {
  List<dynamic> _busResults = [];
  bool _isLoading = true;
  String _errorMessage = "";
  String? _traceId;

  @override
  void initState() {
    super.initState();
    _fetchBusResults();
  }

  Future<void> _fetchBusResults() async {
    const String apiUrl =
        "https://namma-savaari-api-backend-9mpl.vercel.app/search";
    final Map<String, dynamic> requestBody = {
      "ClientId": "180187",
      "UserName": "Namma434",
      "Password": "Namma@4341",
      "source_city": widget.sourceCity,
      "source_code":
          widget.SourceCityId, // Replace with the correct source code
      "destination_city": widget.destinationCity,
      "destination_code":
          widget.destinationCityId, // Replace with the correct destination code
      "depart_date": widget.journeyDate,
    };
    final headers = {
      "Content-Type": "application/json",
      "Api-Token": "Namma@90434#34", // Replace with your API token
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      // if (response.statusCode == 200) {
      //   final data = jsonDecode(response.body);
      //   setState(() {
      //     _busResults = data['Result']?['BusResults'] ?? [];
      //     _traceId = data['Result']?['TraceId'].toString(); // Get TraceId from the Result
      //     _isLoading = false;
      //   });
      // } else {
      //   setState(() {
      //     _errorMessage = "Failed to fetch buses: ${response.body}";
      //     _isLoading = false;
      //   });
      // }
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(
            "Response Data: $data"); // Debugging output to check the structure
        setState(() {
          _busResults = data['Result']?['BusResults'] ?? [];
          // _busResults = data['Result'] ?? []; // Handle case where 'Result' might be null
          // _traceId = data['TraceId']?.toString(); // Safely convert TraceId to string
          _traceId = data['Result']?['TraceId']
              ?.toString(); // Correct location for TraceId
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Failed to fetch buses: ${response.body}";
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

  // Function to extract time (HH:mm) from the given datetime string
  String _formatTime(String? time) {
    if (time == null || time.isEmpty) {
      return "N/A";
    }
    try {
      // Attempt to parse the time using DateTime
      final DateTime parsedTime = DateTime.parse(time);
      return "${parsedTime.hour.toString().padLeft(2, '0')}:${parsedTime.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      print('Error parsing time: $e');
      return "Invalid Time";
    }
  }

  // Function to calculate time difference between Arrival and Departure
  String _calculateTimeDifference(String? arrivalTime, String? departureTime) {
    if (arrivalTime == null || departureTime == null) {
      return "N/A";
    }
    try {
      final DateTime arrival = DateTime.parse(arrivalTime);
      final DateTime departure = DateTime.parse(departureTime);

      final Duration difference = departure.difference(arrival);
      final int hours = difference.inHours;
      final int minutes = difference.inMinutes % 60;

      return "$hours hrs ${minutes.toString().padLeft(2, '0')} min";
    } catch (e) {
      print('Error calculating time difference: $e');
      return "Invalid Time";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.pink[300],
      //   title: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         "${widget.sourceCity} -> ${widget.destinationCity}",
      //         style: TextStyle(
      //           fontSize: 18,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.white,
      //         ),
      //       ),
      //       Text(
      //         "${_busResults.length} Buses",
      //         style: TextStyle(
      //           fontSize: 14,
      //           fontWeight: FontWeight.normal,
      //           color: Colors.white70, // Use a lighter white for the subtitle
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.redAccent.shade700,
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Space between the texts
          children: [
            // Column for Source, Destination, and Bus Results
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.sourceCity} -> ${widget.destinationCity}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${_busResults.length} Buses",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.white70, // Lighter white for the subtitle
                  ),
                ),
              ],
            ),
            // Column for Month, Date, and Day
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end, // Align text to the right
              children: [
                // Container for the Month and Date
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6), // Add padding inside the container
                  decoration: BoxDecoration(
                    color: Colors.white, // White background color
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  child: Text(
                    "${DateFormat('MMM dd').format(DateTime.parse(widget.journeyDate))}", // Format month and date
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Black text color
                    ),
                  ),
                ),
                // Text for the Day
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0,
                      right:
                          19), // Add some space between the container and the day text
                  child: Text(
                    "${DateFormat('EEE').format(DateTime.parse(widget.journeyDate))}", // Format day (e.g., "Mon", "Tue")
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white70, // Lighter white for the day text
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : ListView.builder(
                  itemCount: _busResults.length,
                  itemBuilder: (context, index) {
                    final bus = _busResults[index];
                    return InkWell(
                      onTap: () {
                        // Navigate to Seat Layout Page and pass the ResultIndex of the selected bus
                        print("$_traceId");
                        // print("TraceID: ${bus['TraceId']}");
                        print(
                            "Selected Bus ResultIndex: ${bus['ResultIndex']}");
                        print(
                            "${widget.sourceCity}"); // Use widget.sourceCity directly
                        print(
                            "${widget.destinationCity}"); // Use widget.sourceCity directly
                        print(
                            "${widget.journeyDate}"); // Use widget.sourceCity directly
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeatLayoutPage(
                              // resultIndex: bus['ResultIndex']?.toString() ?? '0', // Use the safe check for ResultIndex
                              resultIndex: bus['ResultIndex']
                                  .toString(), // Pass ResultIndex as a string
                              traceId: _traceId ??
                                  '', // Pass TraceId from the Result
                              // traceId: bus['TraceId'].toString(), // Pass TraceId from the Result
                              sourceCity:
                                  widget.sourceCity, // Use widget.sourceCity
                              destinationCity: widget
                                  .destinationCity, // Use widget.sourceCity
                              journeyDate: widget.journeyDate,
                              arrivalTime: bus['ArrivalTime'] ?? 'N/A',
                              departureTime: bus['DepartureTime'] ?? 'N/A',
                              travelName:
                                  bus['TravelName'] ?? 'Unknown Operator',
                              busType: bus['BusType'] ?? 'N/A',
                              cancelationPolicies:
                                  bus['CancellationPolicies'] ?? 'N/A',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 10.0), // Adjust margin as needed
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color
                          borderRadius:
                              BorderRadius.circular(8.0), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 5,
                              offset: Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _formatTime(bus['DepartureTime']),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Space between Arrival and divider
                                  Container(
                                    height: 2, // Height of the divider
                                    width: 15, // Width of the divider
                                    color: Colors.grey, // Divider color
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Space between divider and Departure Time
                                  Text(
                                    _formatTime(bus['ArrivalTime']),
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(), // Push the price text to the right
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 8.0,
                                          top:
                                              8.0), // Exact 8 pixels from the right
                                      child: Row(
                                        mainAxisSize: MainAxisSize
                                            .min, // Ensure the Row takes up only as much space as needed
                                        children: [
                                          Text(
                                            '₹${bus['Price']['PublishedPriceRoundedOff']} ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors
                                                  .grey, // Color to highlight the PublishedPrice
                                              decoration: TextDecoration
                                                  .lineThrough, // Strike-through effect
                                              decorationColor: Colors
                                                  .grey, // Color of the strike-through line
                                            ),
                                          ),
                                          SizedBox(
                                              width:
                                                  4), // Space between cross mark and OfferedPrice

                                          //Actual Price

                                          Text(
                                            '₹${bus['Price']['OfferedPriceRoundedOff']}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          //Actual price ofter added client commission
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${_calculateTimeDifference(bus['DepartureTime'], bus['ArrivalTime'])}",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Small space between the elements
                                  Container(
                                    height: 2, // Height of the divider
                                    width: 2, // Width of the divider
                                    color: Colors.black, // Divider color
                                  ),
                                  SizedBox(
                                      width:
                                          4), // Small space between the elements
                                  Text(
                                    "${bus['AvailableSeats'] ?? "N/A"} Seats",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Spacer(), // Push the price text to the right
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: 8.0,
                                      ), // Exact 8 pixels from the right
                                      child: Row(
                                        mainAxisSize: MainAxisSize
                                            .min, // Ensure the Row takes up only as much space as needed
                                        children: [
                                          Text(
                                            "Onwards",
                                            style: TextStyle(
                                              color: Colors
                                                  .grey, // Color to highlight the PublishedPrice
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Text(
                                bus['TravelName'] ?? "Unknown Operator",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  height:
                                      8), // Add space between TravelName and Time Difference
                              Text(
                                "${bus['BusType'] ?? "N/A"}",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ), // Add Bus Type field
                              // SizedBox(height: 8), // Add space between TravelName and Time Difference
                              // Text(
                              //   "${bus['CancellationPolicies'] ?? "N/A"}",
                              //   style: TextStyle(fontSize: 12, color: Colors.grey),
                              // ), // Add Bus Type field
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
