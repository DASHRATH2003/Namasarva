import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool showError = false;

  void bookSeat() {
    setState(() {
      showError = true; // Trigger the error message
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Booking'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 55,
              width: 325,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink
                ),
                onPressed: bookSeat,
                child: const Text('Book',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
            const SizedBox(height: 20),
            if (showError)
              // Container(
              //   width: 40,
              //   height: 40,
              //   child: Stack(
              //     children: [
              //       Positioned(
              //         top: 5,
              //         bottom: 5,
              //         left: 5,
              //         right: 5,
              //         child:SizedBox(
              //           child: DecoratedBox(
              //             decoration: BoxDecoration(
              //                 border: Border.all(
              //                   color: Colors.black,
              //                   width: 1,
              //                 ),
              //                 borderRadius: BorderRadius.circular(5),
              //                 color: Colors.white
              //             ),
              //           ),
              //         ),),
              //       Positioned(
              //         top: 29,
              //         bottom: 5,
              //         left: 5,
              //         right: 5,
              //         child:SizedBox(
              //           child: DecoratedBox(
              //             decoration: BoxDecoration(
              //                 border: Border.all(
              //                   color: Colors.black,
              //                   width: 1,
              //                 ),
              //                 borderRadius: BorderRadius.circular(5),
              //                 color: Colors.white
              //             ),
              //           ),
              //         ),),
              //       Positioned(
              //         top: 15,
              //         bottom: 5,
              //         left: 4,
              //         right: 30,
              //         child:SizedBox(
              //           child: DecoratedBox(
              //             decoration: BoxDecoration(
              //                 border: Border.all(
              //                   color: Colors.black,
              //                   width: 1,
              //                 ),
              //                 borderRadius: BorderRadius.circular(5),
              //                 color: Colors.white
              //             ),
              //           ),
              //         ),),
              //       Positioned(
              //         top: 15,
              //         bottom: 5,
              //         left: 30,
              //         right: 4,
              //         child:SizedBox(
              //           child: DecoratedBox(
              //             decoration: BoxDecoration(
              //                 border: Border.all(
              //                   color: Colors.black,
              //                   width: 1,
              //                 ),
              //                 borderRadius: BorderRadius.circular(5),
              //                 color: Colors.white
              //             ),
              //           ),
              //         ),)
              //
              //     ],
              //   ),
              // ),
              Container(
                width: 40,
                height: 40,
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      bottom: 5,
                      left: 5,
                      right: 5,
                      child:SizedBox(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white
                          ),
                        ),
                      ),),
                    Positioned(
                      top: 29,
                      bottom: 5,
                      left: 5,
                      right: 5,
                      child:SizedBox(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white
                          ),
                        ),
                      ),),
                    Positioned(
                      top: 15,
                      bottom: 5,
                      left: 4,
                      right: 30,
                      child:SizedBox(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white
                          ),
                        ),
                      ),),
                    Positioned(
                      top: 15,
                      bottom: 5,
                      left: 30,
                      right: 4,
                      child:SizedBox(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white
                          ),
                        ),
                      ),)

                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}