import 'package:bus_booking_app/web/customer/privacyPolicy_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../customer/customer_help_topics.dart';


class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.5),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child: InkWell(
                onTap: () {
                  context.go('/home'); // Navigate to Home
                },
                child: Image.asset(
                  'assets/Namma_Savaari.png',
                  height: 250,
                  width: 250,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 180),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    context.go('/help'); // Navigate using go_router
                  },
                  icon: Icon(Icons.help_outline, color: Colors.black),
                  label: Text(
                    'Help',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                SizedBox(width: 16),
                PopupMenuButton<String>(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.account_circle_outlined, color: Colors.black),
                    label: Text(
                      'Account',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(
                      value: 'Cancel Ticket',
                      child: ListTile(
                        leading: Icon(Icons.cancel_outlined, color: Colors.black),
                        title: Text('Cancel Ticket', style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/home'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Change Travel Date',
                      child: ListTile(
                        leading: Icon(Icons.calendar_month_outlined, color: Colors.black),
                        title: Text('Change Travel Date', style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/home'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Show My Ticket',
                      child: ListTile(
                        leading: Icon(Icons.confirmation_number_outlined, color: Colors.black),
                        title: Text('Show My Ticket', style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/myBookings'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Email/SMS',
                      child: ListTile(
                        leading: Icon(Icons.email_outlined, color: Colors.black),
                        title: Text('Email/SMS', style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/home'),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'Login/Sign Up',
                      child: ListTile(
                        leading: Icon(Icons.login, color: Colors.black),
                        title: Text('Login/Sign Up', style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () => context.go('/signin'),
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white,
                  elevation: 4,
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 250,right: 250,top: 50,bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Important Notice
                  Text(
                    "IMPORTANT : ADHERE TO STATE GUIDELINES",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Most states have released their own guidelines for inbound and outbound travellers vis-a-vis passes, permits, quarantine rules and other requirements. Please go through the guidelines of your source and destination state carefully before planning your travel, for a hassle-free experience.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "View Passenger Guidelines.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Terms of Service Title
                  Center(
                    child: Text(
                      "TERMS OF SERVICE",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Section 1: BUS
                  _buildSectionTitle("1. BUS"),

                  // Role of Namma Savaari
                  _buildSubSectionTitle("1.1. ROLE OF NAMMA SAVAARI"),
                  _buildSubPoint("1.1.1. Namma Savaari only provides a technology platform that connects intending travelers with bus operators. It doesn’t operate any bus or offer the service of transportation to the User. Namma Savaari also doesn’t act as an agent of any bus operator in the process of providing the above-mentioned technology platform services."),
                  _buildSubPoint("1.1.2. The bus ticket booking voucher which Namma Savaari issues to a User is solely based on the information provided or updated by the bus operator regarding the seat availability."),
                  _buildSubPoint("1.1.3. The amenities, services, routes, fares, schedule, bus type, seat availability and any other details pertaining to the bus service are provided by the respective bus operator and Namma Savaari has no control over such information provided by the bus operator."),

                  const SizedBox(height: 10),

                  // Limitation of Liability
                  _buildSubSectionTitle("1.2. LIMITATION OF LIABILITY OF Namma Savaari"),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "In its role as a technology platform to enable transactions between the bus operators and the Users, Namma Savaari shall not be responsible for the operations of the bus operator including, but not limited to the following:",
                      style: TextStyle(fontSize: 14, color: Colors.black87),textAlign: TextAlign.justify,
                    ),
                  ),
                  _buildSubPoint("1.2.1. Timely departure or arrival of the bus;"),
                  _buildSubPoint("1.2.2. The conduct of bus operator's employees, representatives or agents;"),
                  _buildSubPoint("1.2.3. The condition of the bus, seats etc. not being up to the customer's expectation or as per the description provided by the bus operator;"),
                  _buildSubPoint("1.2.4. Cancellation of the trip due to any reason;"),
                  _buildSubPoint("1.2.5. Loss or damage of the baggage of the customer;"),
                  _buildSubPoint("1.2.6. The bus operator changing a customer’s seat for any reason whatsoever."),
                  _buildSubPoint("1.2.7. Bus operator informing a wrong boarding point for the issuance of the booking confirmation voucher, or changing such boarding point eventually with or without any notification to Namma Savaari or the User;"),
                  _buildSubPoint("1.2.8. Bus operator using a separate pick-up vehicle to transport the User from the designated boarding point to the actual place of departure of the bus."),


                  // RESPONSIBILITIES OF THE USERS
                  _buildSubSectionTitle("1.3. RESPONSIBILITIES OF THE USERS"),

                  _buildSubPoint("1.3.1. Users are advised to call the bus operator to find out the exact boarding point, or any information which they may need for the purpose of boarding or travel in that trip."),
                  _buildSubPoint("1.3.2. At the time of boarding the bus, Users shall furnish a copy of the ticket, and any valid identity proof like aadhar card, passport, PAN card or voter identification card or any other identity proof issued by a government authority."),
                  _buildSubPoint("1.3.3. Users are required to reach the boarding place at least 30 minutes before the scheduled departure time."),
                  _buildSubPoint("1.3.4. All tickets issued shall be non-transferable."),


                  //CANCELLATION OF TICKET
                  _buildSubSectionTitle("1.4. CANCELLATION OF TICKET"),

                  _buildSubPoint("1.4.1. Cancellation of tickets can be done either through the User’s login in the Namma Savaari’s website or mobile application, or by calling on the customer care number;"),
                  _buildSubPoint("1.4.2. Any cancellation is subject to such cancellation charges as mentioned on the ticket."),


                  //RESCHEDULING OF TICKET
                  _buildSubSectionTitle("1.5. RESCHEDULING OF TICKET"),

                  _buildSubPoint("1.5.1. Rescheduling (i.e. change of date of travel) of the tickets can be done through the User’s login in the Namma Savaari’s website or mobile application, or by reaching out to the customer support team;"),
                  _buildSubPoint("1.5.2. Rescheduling is an option provided only by select bus operators. The policy for the same shall be available on the e-ticket."),
                  _buildSubPoint("1.5.2. Rescheduling a ticket is subject to charges as mentioned on the e-ticket. Fare difference, if applicable, shall be borne by the customer. However, if the fare of the rescheduled ticket is lower than the current fare, the fare difference shall not be refunded."),
                  _buildSubPoint("1.5.2. Rescheduling a ticket can be availed only once per booking, if applicable. Once the travel date change option is availed, the ticket cannot be further canceled."),
                  _buildSubPoint("1.5.2. Tickets are non-transferrable and the originally booked passengers are to travel upon such rescheduling."),


                  const SizedBox(height: 10),

                  _buildSectionTitle("2. RYDE"),

                  // 2.1. ROLE OF Namma Savaari
                  _buildSubSectionTitle("2.1. ROLE OF NAMMA SAVAARI"),
                  _buildSubPoint("2.1.1. Namma Savaari only provides a technology platform that connects intending travelers with vehicle operators to hire an entire vehicle. It doesn’t operate any vehicle or offer the service of transportation to the User. Instead fulfilment of these bookings is done by operators who are empanelled with Namma Savaari. Namma Savaari also does not act as an agent of any bus or cab operator in the process of providing the above-mentioned technology platform services."),
                  _buildSubPoint("2.1.2. The Vehicle booking details which Namma Savaari issues to a User is solely based on the information provided or updated by the vehicle operator."),
                  _buildSubPoint("2.1.3. The amenities, services, fares, routes, schedule, vehicle type and any other details pertaining to the transportation service are provided by the respective vehicle operator and Namma Savaari has no control over such information provided by the operator or fulfillment of the same."),

                  // 2.2. LIMITATION OF LIABILITY OF Namma Savaari
                  _buildSubSectionTitle("2.2. LIMITATION OF LIABILITY OF Namma Savaari"),

                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "In its role as a technology platform to enable transactions between the vehicle operators and the Users, under no circumstances can Namma Savaari be held liable for failure on part of a service provider to provide the User with a particular vehicle, the standard of service or any insufficiency in the services or any other service related issues including, but not limited to the following:",
                      style: TextStyle(fontSize: 14, color: Colors.black87),textAlign: TextAlign.justify,
                    ),
                  ),

                  _buildSubPoint("2.2.1. Timely departure or arrival of the vehicle;"),
                  _buildSubPoint("2.2.2. The conduct and uniform of operator's employees, representatives or agents;"),
                  _buildSubPoint("2.2.3. The condition of the vehicle, seats etc. not being up to the customer's expectation or as per the description provided by the operator;"),
                  _buildSubPoint("2.2.4. Absence of amenities/ a welcome kit as per the description provided at the time of booking;"),
                  _buildSubPoint("2.2.5. Cancellation of the trip by the vehicle operator due to any reasons ;"),
                  _buildSubPoint("2.2.6. Loss or damage of the baggage of the customer;"),
                  _buildSubPoint("2.2.7. Vehicle operator using a separate pick-up vehicle to transport the User from the designated boarding point to the actual place of departure."),
                  _buildSubPoint("2.2.8. If User chooses the name of the operator and the vehicle for booking, best effort shall be made to ensure that the same operator fulfils the booking and provides the matching vehicle as per User’s choice."),
                  _buildSubPoint("2.2.9. In cases of unavailability of the hired vehicle or where the vehicle breaks down during the journey, Namma Savaari may reach out to the concerned service provider to make arrangements for an alternate vehicle of a similar standard. User may reach out to ryde_complaints@Namma Savaari.in for any assistance."),
                  _buildSubPoint("2.2.10. It is the sole liability of the vehicle operator to obtain all the relevant licenses, permits etc. to undertake the travel booked. In case of any cancellation of booking owing to absence of necessary licenses or permits by the vehicle operator, Namma Savaari shall not be liable in any manner."),

                  // 2.3. RESPONSIBILITIES OF THE USERS
                  _buildSubSectionTitle("2.3. RESPONSIBILITIES OF THE USERS"),
                  _buildSubPoint("2.3.1. Users are advised to call the vehicle operator to find out the exact boarding point, or any information which they may need for the purpose of boarding or travel in that trip."),
                  _buildSubPoint("2.3.2. At the time of boarding the bus, Users shall furnish a copy of the confirmation booking voucher, and any valid identity proof issued by a government authority."),
                  _buildSubPoint("2.3.3. Users are advised to check the booking confirmation SMS or email and re-initiate a booking in case of incorrect details immediately. Any loss, consequences and damages for any delay that may be caused to the User due to this shall be borne by the User."),


                  // 2.4. CANCELLATION OF BOOKING
                  _buildSubSectionTitle("2.4. CANCELLATION OF BOOKING"),
                  _buildSubPoint("2.4.1. Cancellation of bookings can be done either through the User’s login in the Namma Savaari’s website or mobile application, or by calling on the customer care number;"),
                  _buildSubPoint("2.4.2. Any cancellation is subject to such cancellation charges as mentioned on the booking details."),


                  // 2.5. PAYMENT FOR BOOKING AND ANY ADDITIONAL CHARGES
                  _buildSubSectionTitle("2.5. PAYMENT FOR BOOKING AND ANY ADDITIONAL CHARGES"),
                  _buildSubPoint("2.5.1. FULL PAYMENT: Payment maybe made in full amount to Namma Savaari during the booking. Such total booking amount includes the base fare, applicable taxes including GST as may be applicable as per local laws, and any additional booking fee, service fee or convenience fee charged by Namma Savaari."),
                  _buildSubPoint("2.5.2. PARTIAL PAYMENT:Under this option User has to make payment of a partial amount as specified at the time of booking / in the booking voucher and pay the balance amount within a specified time period as informed the time of booking / in the booking voucher. Failure to pay such balance amount within the stipulated time will lead to cancellation of the booking and any refund will be subject to the booking/ cancellation policy. In some cases, the customer may be allowed to make the balance payment at the start of the trip."),
                  _buildSubPoint("2.5.3. PAY AT VEHICLE:Under this option the User has to pay certain part of the booking amount specified at the time of booking / in the booking confirmation voucher to Namma Savaari and the balance to the vehicle operator at the start or end of the trip."),
                  _buildSubPoint("2.5.3. Expenses like toll charges, permit charges, parking charges, entry fees, Service Tax & any other Government Tax as per Government guidelines are to be borne by the User and paid directly to the driver."),
                  _buildSubPoint("2.5.3. The excess Driver Bata wherever applicable has to be paid directly to the driver."),
                  _buildSubPoint("2.5.3. User may opt for Insurance while booking. Such Insurance will be provided entirely by third party and Namma Savaari in no way will be a party to any such claims or concerns on the matter."),

                  const SizedBox(height: 20),

                  // Section 4: CONTACT INFORMATION
                  _buildSectionTitle("4. MISCELLANEOUS"),

                  _buildSubPoint("4.1. The bus operator shall solely be liable for compliance of all laws including but not limited to the Motor Vehicle Act its Rules, applicable regulations, guidelines or directions enacted or issued by the Central Government or relevant State Governments. Any prosecution arising out of the contravention of such laws, rules, regulations, guidelines including directives on fare control from respective RTO’s or directions including but not limited to fines or penalties shall be borne by the bus operator. The User agrees to take up any grievance resulting from cancellation or any deficiency in services due to any action of the enforcement agencies arising with the bus operator."),
                  _buildSubPoint("4.2. User Agreement and Privacy Policy at Namma Savaari website shall apply. Namma Savaari will be entitled to reject any claim in case there is any abuse/misuse of the offer by the User or the cancellation/claim is not eligible under the offer."),
                  _buildSubPoint("4.3. The terms and conditions shall be governed by the laws of India. Any dispute arising out of or in relation to this offer shall be subject to the exclusive jurisdiction of competent courts in Bengaluru."),
                  _buildSubPoint("4.4. The maximum liability of Namma Savaari in the event of any claim arising out of this offer shall not exceed the amount under the underlying transaction paid by the User."),
                  _buildSubPoint("4.5. Namma Savaari shall not be liable to pay for any indirect, punitive, special, incidental or consequential damages arising out of or in connection with the offer."),

                  const SizedBox(height: 30),


                ],
              ),
            ),
            Container(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 100, right: 100),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,  // Align items to the top
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Even spacing
                          children: [
                            // Logo & Description
                            Flexible(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/Namma_Savaari_LOGO1.png",
                                    width: 200,
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: 300,  // Set a fixed width for text to avoid overflow
                                    child: Text(
                                      "Namma Savaari is India's largest online bus ticket booking service trusted by over 25 million happy customers globally. We offer bookings through our website and mobile apps.",
                                      style: TextStyle(color: Colors.black87, fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // About Namma Savaari
                            Flexible(
                              child: buildColumn_footer(
                                "About Namma Savaari",
                                [
                                  {"title": "About us", "destination": TermsAndConditionsScreen()},
                                  {"title": "Contact us", "destination": PrivacyPolicyScreen()},
                                  {"title": "Namma Savaari on mobile", "destination": HelpTopicsScreen()},
                                ],
                              ),
                            ),

                            // Info
                            Flexible(
                              child: buildColumn_footer(
                                "Info",
                                [
                                  {"title": "T&C", "destination": TermsAndConditionsScreen()},
                                  {"title": "Privacy policy", "destination": PrivacyPolicyScreen()},
                                  {"title": "FAQ", "destination": HelpTopicsScreen()},
                                ],
                              ),
                            ),

                            // Social Media
                            Flexible(
                              child: buildColumn_footer(
                                "Social Media",
                                [
                                  {"title": "Facebook", "destination": "https://www.facebook.com/people/Namma-Savaari/61573070618808/#"},
                                  {"title": "Instagram", "destination": "https://www.instagram.com/namma.savaari/?igsh=ODUxbm04ZmRucm13#"},
                                  {"title": "Twitter", "destination": "https://twitter.com"},  // Provide valid links
                                  {"title": "LinkedIn", "destination": "https://linkedin.com"},
                                ],
                              ),
                            ),
                          ],
                        ),


                        SizedBox(height: 20),

                        // Copyright & Social Media
                        Column(
                          children: [
                            Divider(color: Colors.grey.shade300),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "© 2025 Namma Savaari India Pvt Ltd. All rights reserved",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/facebook.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/instagram.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/linkedin.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/twitter.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildColumn_footer(String heading, List<Map<String, dynamic>> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading
        Text(
          heading,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        SizedBox(height: 10), // Spacing between heading and options

        // Options with navigation
        ...options.map((option) {
          return GestureDetector(
            onTap: () {
              // Navigate to the specified destination
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => option['destination'],
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Expanded(
                child: Text(
                  option['title'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }


  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }



  // Sub-Section Title Widget
  Widget _buildSubSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // Sub-Point Widget
  Widget _buildSubPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 5),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.black),
        textAlign: TextAlign.justify,
      ),
    );
  }
}