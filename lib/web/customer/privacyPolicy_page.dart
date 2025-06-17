import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';


class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
              padding: const EdgeInsets.only(
                  left: 250, right: 250, top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Terms of Service Title
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // A. INTRODUCTION:
                  _buildSectionTitle("A. INTRODUCTION:"),

                  // Role of Namma Savaari
                  _buildSubPoint("Namma Savaari India Private Limited (hereinafter “Namma Savaari”) recognizes the importance of privacy of its users and also of maintaining confidentiality of the information provided by its users as a responsible data controller and data processor."),
                  _buildSubPoint("This Privacy Policy provides for the practices for handling and securing user's Personal Information (defined hereunder) by Namma Savaari and its subsidiaries and affiliates."),
                  _buildSubPoint("This Privacy Policy is applicable to any person (‘User’) who purchases, intends to purchase, or inquire about any product(s) or service(s) made available by Namma Savaari through any of Namma Savaari’s customer interface channels including its website, mobile site, mobile app & offline channels including call centers and offices (collectively referred herein as 'Sales Channels')."),
                  _buildSubPoint("For the purpose of this Privacy Policy, wherever the context so requires 'you' or 'your' shall mean User and the term 'we', 'us', 'our' shall mean Namma Savaari. For the purpose of this Privacy Policy, Website means the website(s), mobile site(s) and mobile app(s)."),
                  _buildSubPoint("By using or accessing the Website or other Sales Channels, the User hereby agrees with the terms of this Privacy Policy and the contents herein. If you disagree with this Privacy Policy please do not use or access our Website or other Sales Channels."),
                  _buildSubPoint("This Privacy Policy does not apply to any website(s), mobile sites and mobile apps of third parties, even if their websites/products are linked to our Website. User should take note that information and privacy practices of Namma Savaari’s business partners, advertisers, sponsors or other sites to which Namma Savaari provides hyperlink(s), may be materially different from this Privacy Policy. Accordingly, it is recommended that you review the privacy statements and policies of any such third parties with whom they interact."),
                  _buildSubPoint("This Privacy Policy is an integral part of your User Agreement with Namma Savaari and all capitalized terms used, but not otherwise defined herein, shall have the respective meanings as ascribed to them in the User Agreement."),

                  const SizedBox(height: 10),

                  // B. USERS OUTSIDE THE GEOGRAPHICAL LIMITS OF INDIA
                  _buildSectionTitle("B. USERS OUTSIDE THE GEOGRAPHICAL LIMITS OF INDIA"),

                  _buildSubPoint("Please note that the data shared with Namma Savaari shall be primarily processed in India and such other jurisdictions where a third party engaged by Namma Savaari may process the data on Namma Savaari’s behalf. By agreeing to this policy, you are providing Namma Savaari with your explicit consent to process your personal information for the purpose(s) defined in this policy. The data protection regulations in India or such other jurisdictions mentioned above may differ from those of your country of residence."),
                  _buildSubPoint("If you have any concerns in the processing your data and wish to withdraw your consent, you may do so by writing to the following email id: privacy@nammasavaari.com. However, if such processing of data is essential for us to be able to provide service to you, then we may not be able to serve or confirm your bookings after your withdrawal of consent. For instance, if you want to book a bus journey, then certain personal information of yours like contact details, gender, location details etc. may have to be shared by us with our bus operator and they may further process this information for making suitable arrangements for your journey."),
                  _buildSubPoint("A withdrawal of consent by you for us to process your information may:"),

                  _buildSubSubSectionPoint("1. severely inhibit our ability to serve you properly and in such case, we may have to refuse the booking altogether, or"),
                  _buildSubSubSectionPoint("2. unreasonably restrict us to service your booking (if a booking is already made) which may further affect your trip or may compel us to cancel your booking."),

                  const SizedBox(height: 10),

                  //C. TYPE OF INFORMATION WE COLLECT AND ITS LEGAL BASIS
                  _buildSectionTitle("C. TYPE OF INFORMATION WE COLLECT AND ITS LEGAL BASIS"),

                  _buildSubPoint("The information as detailed below is collected for us to be able to provide the services chosen by you and also to fulfill our legal obligations as well as our obligations towards third parties as per our User Agreement."),
                  _buildSubPoint("'Personal Information' of User shall include the information shared by the User and collected by us for the following purposes:"),
                  _buildSubPoint("1. Registration on the Website: Information which you provide while subscribing to or registering on the Website, including but not limited to information about your personal identity such as name, gender, age etc., your contact details such as your email address, postal addresses, telephone (mobile or otherwise) and/or fax numbers. The information may also include information such as your banking details (including credit/debit card) and any other information relating to your income and/or lifestyle; billing information payment history etc. (as shared by you)."),
                  _buildSubPoint("2. Other information: We many also collect some other information and documents including but not limited to:"),

                  _buildSubSubSectionPoint("1. Transactional history (other than banking details) about your e-commerce activities, buying behavior."),
                  _buildSubSubSectionPoint("2. Your usernames, passwords, email addresses and other security-related information used by you in relation to our Services."),
                  _buildSubSubSectionPoint("3. Data either created by you or by a third party and which you wish to store on our servers such as image files, documents etc."),
                  _buildSubSubSectionPoint("4. Data available in public domain or received from any third party including social media channels, including but not limited to personal or non-personal information from your linked social media channels (like name, email address, friend list, profile pictures or any other information that is permitted to be received as per your account settings) as a part of your account information."),
                  _buildSubSubSectionPoint("5. Information pertaining any other traveler(s) for who you make a booking through your registered Namma Savaari account. In such case, you must confirm and represent that each of the other traveler(s) for whom a booking has been made, has agreed to have the information shared by you disclosed to us and further be shared by us with the concerned service provider(s)."),

                  const SizedBox(height: 10),

                  // D. HOW WE USE YOUR PERSONAL INFORMATION
                  _buildSectionTitle("D. HOW WE USE YOUR PERSONAL INFORMATION"),

                  _buildSubPoint("The Personal Information collected maybe used in the following manner:"),

                  _buildSectionTitle("1. While making a booking:"),
                  _buildSubPoint("While making a booking, we may use Personal Information including, payment details which include cardholder name, credit/debit card number (in encrypted form) with expiration date, banking details, wallet details etc. as shared and allowed to be stored by you. We may also use the information of travelers list as available in or linked with your account. This information is presented to the User at the time of making a booking to enable you to complete your bookings expeditiously."),

                  _buildSectionTitle("2. We may also use your Personal Information for several reasons including but not limited to:"),
                  _buildSubSubSectionPoint("1.keep you informed of the transaction status;"),
                  _buildSubSubSectionPoint("2.Your usernames, passwords, email addresses and other security-related information used by you in relation to our Services."),
                  _buildSubSubSectionPoint("3.send booking confirmations either via SMS or Whatsapp or any other messaging service;"),
                  _buildSubSubSectionPoint("4.send any updates or changes to your booking(s);"),
                  _buildSubSubSectionPoint("5.allow our customer service to contact you, if necessary;"),
                  _buildSubSubSectionPoint("6.customize the content of our website, mobile site and mobile app;"),
                  _buildSubSubSectionPoint("7.request for reviews of products or services or any other improvements;"),
                  _buildSubSubSectionPoint("8.send verification message(s) or email(s);"),
                  _buildSubSubSectionPoint("9.Validate/authenticate your account and to prevent any misuse or abuse."),

                  _buildSectionTitle("3. SURVEYS:"),

                  _buildSubPoint("We value opinions and comments from our Users and frequently conduct surveys, both online and offline. Participation in these surveys is entirely optional. Typically, the information received is aggregated, and used to make improvements to Website, other Sales Channels, services and to develop appealing content, features and promotions for members based on the results of the surveys. Identity of the survey participants is anonymous unless otherwise stated in the survey."),

                  _buildSectionTitle("USER GENERATED CONTENT (UGC)"),
                  _buildSubPoint("Namma Savaari provides an option to its users to post their experiences by way of review, ratings and general poll questions. The customers also have an option of posting questions w.r.t a service offered by Namma Savaari or post answers to questions raised by other users. Namma Savaari may also hire a third party to contact you and gather feedback about your recent booking with Namma Savaari. Though the participation in the feedback process is purely optional, you may still receive emails, notifications (SMS, Whatsapp or any other messaging service) for you to share your feedback. The reviews may be written or in a video format. The reviews written or posted may also be visible on other travel or travel related platforms."),

                  SizedBox(height: 10),
                  _buildSubPoint("The UGC that Namma Savaari collect may be of the following kinds:"),
                  _buildSubSubSectionPoint("1. Review and Ratings"),
                  _buildSubSubSectionPoint("2. Question and Answers"),
                  _buildSubSubSectionPoint("3. Crowd Source Data Collection (poll questions)."),


                  _buildSectionTitle("4. MARKETING PROMOTIONS, RESEARCH AND PROGRAMS:"),

                  _buildSubPoint("Marketing promotions, research and programs help us to identify your preferences, develop programs and improve user experience. Namma Savaari frequently sponsors promotions to give its Users the opportunity to win great travel and travel related prizes. Personal Information collected by us for such activities may include contact information and survey questions. We use such Personal Information to notify contest winners and survey information to develop promotions and product improvements. As a registered User, you will also occasionally receive updates from us about fare sales in your area, special offers, new Namma Savaari services, other noteworthy items (like savings and benefits on bus tickets, hotel reservations, pilgrimage packages, car rentals and other travel services) and marketing programs."),
                  _buildSubPoint("In addition, you may look forward to receiving periodic marketing emails, newsletters and exclusive promotions offering special deals."),
                  _buildSubPoint("From time to time we may add or enhance services available on the Website. To the extent these services are provided, and used by you, we will use the Personal Information you provide to facilitate the service(s) requested. For example, if you email us with a question, we will use your email address, name, nature of the question, etc. to respond to your question. We may also store such Personal Information to assist us in making the Website the better and easier to use for our Users."),
                  _buildSubPoint("Namma Savaari may from time to time launch reward programs by way of which users may stand to win travel related rewards or other rewards. We may use your Personal Information to enroll you in the rewards program and status of the same will be visible each time you log in to the Website. Depending on the reward program, each time you win a reward, Namma Savaari may share your Personal Information with a third party that will be responsible for fulfilling the reward to you. You may however choose to opt out of such reward programs by writing to us. For various purposes such as fraud detection, offering bookings on credit etc., we at times may verify information of customers on selective basis, including their credit information."),


                  const SizedBox(height: 10),
                  // E. HOW LONG DO WE KEEP YOUR PERSONAL INFORMATION?
                  _buildSectionTitle("E. HOW LONG DO WE KEEP YOUR PERSONAL INFORMATION?"),
                  _buildSubPoint("Namma Savaari will retain your Personal Information on its servers for as long as is reasonably necessary for the purposes listed in this policy. In some circumstances we may retain your Personal Information for longer periods of time, for instance where we are required to do so in accordance with any legal, regulatory, tax or accounting requirements."),
                  _buildSubPoint("Namma Savaari will retain your Personal Information on its servers for as long as is reasonably necessary for the purposes listed in this policy. In some circumstances we may retain your Personal Information for longer periods of time, for instance where we are required to do so in accordance with any legal, regulatory, tax or accounting requirements."),


                  const SizedBox(height: 10),

                  // F. COOKIES AND SESSION DATA
                  _buildSectionTitle("F. COOKIES AND SESSION DATA"),
                  _buildSectionTitle("1. Cookies"),

                  _buildSubPoint("Namma Savaari uses cookies to personalize your experience on the Website and the advertisements that maybe displayed. Namma Savaari’s use of cookies is similar to that of any other reputable online companies."),
                  _buildSubPoint("Cookies are small pieces of information that are stored by your browser on your device's hard drive. Cookies allow us to serve you better and more efficiently. Cookies also allow ease of access, by logging you in without having to type your login name each time (only your password is needed); we may also use such cookies to display any advertisement(s) to you while you are on the Website or to send you offers (or similar emails – provided you have not opted out of receiving such emails) focusing on destinations which may be of your interest."),
                  _buildSubPoint("A cookie may also be placed by our advertising servers, or third party advertising companies. Such cookies are used for purposes of tracking the effectiveness of advertising served by us on any website, and also to use aggregated statistics about your visits to the Website in order to provide advertisements in the Website or any other website about services that may be of potential interest to you. The third party advertising companies or advertisement providers may also employ technology that is used to measure the effectiveness of the advertisements. All such information is anonymous. This anonymous information is collected through the use of a pixel tag, which is an industry standard technology and is used by all major websites. They may use this anonymous information about your visits to the Website in order to provide advertisements about goods and services of potential interest to you. No Personal Information is collected during this process. The information so collected during this process, is anonymous, and does not link online actions to a User."),
                  _buildSubPoint("Most web browsers automatically accept cookies. Of course, by changing the options on your web browser or using certain software programs, you can control how and whether cookies will be accepted by your browser. Namma Savaari supports your right to block any unwanted Internet activity, especially that of unscrupulous websites. However, blocking Namma Savaari cookies may disable certain features on the Website, and may hinder an otherwise seamless experience to purchase or use certain services available on the Website. Please note that it is possible to block cookie activity from certain websites while permitting cookies from websites you trust."),

                  _buildSectionTitle("2. Automatic Logging of Session Data:"),
                  _buildSubPoint("Each time you access the Website your session data gets logged. Session data may consist of various aspects like the IP address, operating system and type of browser software being used and the activities conducted by the User while on the Website. We collect session data because it helps us analyze User’s choices, browsing pattern including the frequency of visits and duration for which a User is logged on. It also helps us diagnose problems with our servers and lets us better administer our systems. The aforesaid information cannot identify any User personally. However, it may be possible to determine a User's Internet Service Provider (ISP), and the approximate geographic location of User's point of connectivity through the above session data"),

                  const SizedBox(height: 10),

                  // G. WITH WHOM YOUR PERSONAL INFORMATION IS SHARED
                  _buildSectionTitle("G. WITH WHOM YOUR PERSONAL INFORMATION IS SHARED"),
                  _buildSectionTitle("1. Service Providers and suppliers:"),

                  _buildSubPoint("Your information shall be shared with the end service providers like hotels, bus service providers, cab rental or any other suppliers who are responsible for fulfilling your booking. You may note that while making a booking with Namma Savaari you authorize us to share your information with the said service providers and suppliers. It is pertinent to note that Namma Savaari does not authorize the end service provider to use your information for any other purpose(s) except as may be for fulfilling their part of service. However, how the said service providers/suppliers use the information shared with them is beyond the purview and control of Namma Savaari as they process Personal Information as independent data controllers, and hence we cannot be made accountable for the same. You are therefore advised to review the privacy policies of the respective service provider or supplier whose services you choose to avail."),
                  _buildSubPoint("Namma Savaari does not sell or rent individual customer names or other Personal Information of Users to third parties except sharing of such information with our business / alliance partners or vendors who are engaged by us for providing various referral services and for sharing promotional and other benefits to our customers from time to time basis their booking history with us."),

                  _buildSectionTitle("2. COMPANIES IN THE SAME GROUP:"),
                  _buildSubPoint("In the interests of improving personalization and service efficiency, we may, under controlled and secure circumstances, share your Personal Information with our affiliate or associate entities."),
                  _buildSubPoint("If the assets of Namma Savaari are acquired, our customer information may also be transferred to the acquirer depending upon the nature of such acquisition. In addition, as part of business expansion/development/restructuring or for any other reason whatsoever, if we decide to sell/transfer/assign our business, any part thereof, any of our subsidiaries or any business units, then as part of such restructuring exercise customer information including the Personal Information collected herein shall be transferred accordingly."),

                  _buildSectionTitle("3. BUSINESS PARTNERS AND THIRD-PARTY VENDORS:"),
                  _buildSubPoint("We may also share certain filtered Personal Information to our corporate affiliates or business partners who may contact the customers to offer certain products or services, which may include free or paid products / services, which will enable the customer to have better travel experience or to avail certain benefits specially made for Namma Savaari customers. Examples of such partners are entities offering co-branded credit cards, travel insurance, insurance cover against loss of wallet, banking cards or similar sensitive information etc. If you choose to avail any such services offered by our business partners, the services so availed will be governed by the privacy policy of the respective service provider."),
                  _buildSubPoint("Namma Savaari may share your Personal Information to third party that Namma Savaari may engage to perform certain tasks on its behalf, including but not limited to payment processing, data hosting, and data processing platforms."),
                  _buildSubPoint("We use non-identifiable Personal Information of Users in aggregate or anonymized form to build higher quality, more useful online services by performing statistical analysis of the collective characteristics and behavior of our customers and visitors, and by measuring demographics and interests regarding specific areas of the Website. We may provide anonymous statistical information based on this data to suppliers, advertisers, affiliates and other current and potential business partners. We may also use such aggregate data to inform these third parties as to the number of people who have seen and clicked on links to their websites. Any Personal Information which we collect and which we may use in an aggregated format is our property. We may use it, in our sole discretion and without any compensation to you, for any legitimate purpose including without limitation the commercial sale thereof to third parties."),
                  _buildSubPoint("Occasionally, Namma Savaari will hire a third party for market research, surveys etc. and will provide information to these third parties specifically for use in connection with these projects. The information (including aggregate cookie and tracking information) we provide to such third parties, alliance partners, or vendors are protected by confidentiality agreements and such information is to be used solely for completing the specific project, and in compliance with the applicable regulations."),

                  _buildSectionTitle("4. DISCLOSURE OF INFORMATION"),
                  _buildSubPoint("In addition to the circumstances described above, Namma Savaari may disclose User's Personal Information if required to do so:"),
                  _buildSubSubSectionPoint("1. by law, required by any enforcement authority for investigation, by court order or in reference to any legal process;"),
                  _buildSubSubSectionPoint("2. to conduct our business;"),
                  _buildSubSubSectionPoint("3. for regulatory, internal compliance and audit exercise(s)"),
                  _buildSubSubSectionPoint("4. to secure our systems; or"),
                  _buildSubSubSectionPoint("5. to enforce or protect our rights or properties of Namma Savaari or any or all of its affiliates, associates, employees, directors or officers or when we have reason to believe that disclosing Personal Information of User(s) is necessary to identify, contact or bring legal action against someone who may be causing interference with our rights or properties, whether intentionally or otherwise, or when anyone else could be harmed by such activities."),
                  _buildSubPoint("Such disclosure and storage may take place without your knowledge. In that case, we shall not be liable to you or any third party for any damages howsoever arising from such disclosure and storage."),

                  const SizedBox(height: 10),

                  // H. HOW CAN YOU OPT-OUT OF RECEIVING OUR PROMOTIONAL E-MAILS?
                  _buildSectionTitle("H. HOW CAN YOU OPT-OUT OF RECEIVING OUR PROMOTIONAL E-MAILS?"),

                  _buildSubPoint("You will occasionally receive e-mail updates from us about fare sales in your area, special offers, new Namma Savaari services, and other noteworthy items. We hope you will find these updates interesting and informative. If you wish not to receive them, please click on the 'unsubscribe' link or follow the instructions in each e-mail message."),

                  _buildSectionTitle("1. PERMISSIONS REQUIRED FOR USING OUR MOBILE APPLICATIONS"),
                  _buildSubPoint("When the Namma Savaari app is installed on your phone or tablet, a list of permissions appear and are needed for the app to function effectively. There is no option to customize the list. The permissions that Namma Savaari requires and the data that shall be accessed and its use is as below:"),

                  _buildSectionTitle("1. Android permissions:"),
                  _buildSubSubSectionPoint("1. Device and App history:We need your device permission to get information about your device, like OS (operating system) name, OS version, mobile network, hardware model, unique device identifier, preferred language, etc. Basis these inputs, we intend to optimize your travel booking experience."),
                  _buildSubSubSectionPoint("2. Identity:This permission enables us to know about details of your account(s) on your mobile device. We use this info to auto-fill your email ID’s and provide a typing free experience. It also helps us map email ID’s to a particular user to give you the benefit of exclusive travel offers, wallet cash-backs, etc. It also allows facilitating your Facebook and Google+ login."),
                  _buildSubSubSectionPoint("3. Location:This permission enables us to give you the benefit of location specific deals and provide you a personalized experience. When you launch Namma Savaari app to make a travel booking, we auto-detect your location so that your nearest city is auto-filled. We also require this permission to be able to help you track your bus with respect to your location. Namma Savaari collects and uses location data to find boarding points near you and provide real-time travel updates."),
                  _buildSubSubSectionPoint("4. SMS:If you allow us to access your SMS, we read your SMS to autofill or prepopulate ‘OTP’ while making a transaction and to validate your mobile number. This provides you a seamless purchase experience while making a booking and you don’t need to move out of the app to read the SMS and then enter it in the app."),
                  _buildSubSubSectionPoint("5. Phone:The app requires access to make phone calls so that you can make phone calls to bus operators, hotels and our customer contact centers directly through the app."),
                  _buildSubSubSectionPoint("6. Contacts:If you allow us to access your contacts, it enables us to provide a lot of social features to you such as sharing tickets or location with your friends. This permission also allows you to select numbers from your contacts for mobile recharges done on the app."),
                  _buildSubSubSectionPoint("7. Photo/ Media/ Files:The libraries in the app use these permissions to allow users to to save and upload multimedia reviews."),
                  _buildSubSubSectionPoint("8. Wi-Fi connection information:When you allow us the permission to detect your Wi-Fi connection, we optimize your bandwidth usage for multimedia uploads."),
                  _buildSubSubSectionPoint("9. Device ID and Call information:This permission is used to detect your Android ID through which we can uniquely identify users. It also lets us know your contact details using which we pre-populate specific fields to ensure a seamless booking experience."),
                  _buildSubSubSectionPoint("10. Camera:This permission is used to capture pictures of the boarding point or bus before the journey. This images can then uploaded as part of multimedia reviews."),
                  _buildSubSubSectionPoint("11. Calendar:This permission enables us to put your travel plans on your calendar."),
                  
                  _buildSectionTitle("2. IOS permissions:"),
                  _buildSubSubSectionPoint("1. Notifications:If you opt in for notifications, it enables us to send across exclusive deals, promotional offers, travel related updates, etc. on your device. If you do not opt for this, updates for your travel like booking confirmation, refund (in case of cancellation), etc. will be sent through SMS."),
                  _buildSubSubSectionPoint("2. Contacts:This permission enables us to know about details of your account(s) on your mobile device. We use this info to auto-fill your email ID’s and provide a typing free experience. It also helps us map email ID’s to a particular user to give you the benefit of exclusive travel offers, wallet cash-backs, etc. It also allows facilitating your Facebook and Google+ login."),
                  _buildSubSubSectionPoint("3. Location:This permission enables us to give you the benefit of location specific deals and provide you a personalized experience. When you launch Namma Savaari app to make a travel booking, we auto-detect your location so that your nearest city is auto-filled. We also require this permission to be able to help you track your bus with respect to your location. Namma Savaari collects and uses location data to find boarding points near you and provide real-time travel updates"),
                  _buildSubSubSectionPoint("4. Photo/ Media/ Files:The libraries in the app use these permissions to allow users to to save and upload multimedia reviews."),
                  _buildSubSubSectionPoint("5. Camera:This permission is used to capture pictures of the boarding point or bus before the journey. This images can then uploaded as part of multimedia reviews."),
                  _buildSubSubSectionPoint("6. Calendar:This permission enables us to put your travel plans on your calendar."),

                  const SizedBox(height: 10),

                  // I. HOW WE PROTECT YOUR PERSONAL INFORMATION?
                  _buildSectionTitle("I. HOW WE PROTECT YOUR PERSONAL INFORMATION?"),
                  _buildSubPoint("All payments on the Website are secured. This means all Personal Information you provide is transmitted using TLS (Transport Layer Security) encryption. TLS is a proven coding system that lets your browser automatically encrypt, or scramble, data before you send it to us. Website has stringent security measures in place to protect the loss, misuse, and alteration of the information under our control. Whenever you change or access your account information, we offer the use of a secure server. Once your information is in our possession we adhere to strict security guidelines, protecting it against unauthorized access."),


                  const SizedBox(height: 10),

                  // J. WITHDRAWAL OF CONSENT AND PERMISSION
                  _buildSectionTitle("J. WITHDRAWAL OF CONSENT AND PERMISSION"),
                  _buildSubPoint("You may withdraw your consent to submit any or all Personal Information or decline to provide any permissions on its Website as covered above at any time. In case, you choose to do so then your access to the Website may be limited, or we might not be able to provide the services to you. You may withdraw your consent by sending an email to privacy@nammasavaari.com"),


                  const SizedBox(height: 10),

                  // K. YOUR RIGHTS QUA PERSONAL INFORMATION
                  _buildSectionTitle("K. YOUR RIGHTS QUA PERSONAL INFORMATION"),
                  _buildSubPoint("You may access your Personal Information from your user account with Namma Savaari. You may also correct your personal information or delete such information (except some mandatory fields) from your user account directly. If you don’t have such a user account, then you write to privacy@nammasavaari.com"),


                  const SizedBox(height: 10),

                  // L. ELIGIBILITY TO TRANSACT WITH Namma Savaari
                  _buildSectionTitle("L. ELIGIBILITY TO TRANSACT WITH Namma Savaari"),
                  _buildSubPoint("We reserve the rights to revise the Privacy Policy from time to time to suit various legal, business and customer requirement. We will duly notify the users as may be necessary."),

                  const SizedBox(height: 10),

                  // M. CHANGES TO THE PRIVACY POLICY
                  _buildSectionTitle("M. CHANGES TO THE PRIVACY POLICY"),
                  _buildSubPoint("You must atleast 18 years of age to transact directly with Namma Savaari and also to consent to the processing of your personal data."),
                  _buildSectionTitle("You may always submit concerns regarding this Privacy Policy via email to us at privacy@nammasavaari.com. Namma Savaari shall endeavor to respond to all reasonable concerns and inquiries."),

                  const SizedBox(height: 10),

                  // N. DELETION OF ACCOUNT OR PERSONAL INFORMATION
                  _buildSectionTitle("N. DELETION OF ACCOUNT OR PERSONAL INFORMATION"),
                  _buildSubPoint("In case you want to delete your account or your personal information, you may write to us at privacy@nammasavaari.com, requesting for deletion of your account. Please note that the DPO may require you to verify your identity before proceeding with your request of deleting your account. Any identity proof that you may provide shall be stored for a period of 21 days from the date of deletion of the account."),
                  _buildSubPoint("If you do delete the account or personal information, please note that Namma Savaari may keep your transactional information, if required as per applicable local laws. Further, you may not be able to use the same credentials (email ID/mobile number) to create another account with Namma Savaari for a period of 12 months from the date of deletion of the account."),

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
                                  {"title": "About us", "destination": "/aboutus"},
                                  {"title": "Contact us", "destination": "/contactus"},
                                  {"title": "Namma Savaari on mobile", "destination": "https://play.google.com/store/apps/details?id=com.app.nammasavari.android"},
                                ],
                              ),
                            ),

                            // Info
                            Flexible(
                              child: buildColumn_footer(
                                "Info",
                                [
                                  {"title": "T&C", "destination": "/termsandcondition"},
                                  {"title": "Privacy policy", "destination": "/privacypolicy"},
                                  {"title": "FAQ", "destination": "/faq"},
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
        Text(
          heading,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        SizedBox(height: 10),
        ...options.map((option) {
          return GestureDetector(
            onTap: () async {
              final destination = option['destination'];

              if (destination is String && Uri.tryParse(destination)?.hasScheme == true) {
                // Launch external URLs (Facebook, Instagram)
                if (await canLaunchUrl(Uri.parse(destination))) {
                  await launchUrl(Uri.parse(destination), mode: LaunchMode.externalApplication);
                } else {
                  print('Could not launch $destination');
                }
              } else if (destination is String) {
                // Navigate to internal routes (GoRouter)
                print("Navigating to $destination"); // Debugging Log
                GoRouter.of(context).go(destination);
              } else {
                print("Invalid destination: $destination");
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                option['title'],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
//Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

// Sub-Section Title Widget
  Widget _buildSubSubSectionPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 5),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.black),
        textAlign: TextAlign.justify,
      ),
    );
  }

// Sub-Point Widget
  Widget _buildSubPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.black),
        textAlign: TextAlign.justify,
      ),
    );
  }

}