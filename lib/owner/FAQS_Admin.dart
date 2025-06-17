// bus_booking_application

import 'package:flutter/material.dart';
import 'admin_bus_cancelation_faqs/admn_bus_cancl_faqs.dart';
import 'admin_offers_faqs/admn_ofers_faqs.dart';
import 'admin_other_queries_faqs/admn_other_queries_faqs.dart';
import 'admin_process_payments_and_refund_faqs/admin_payment_and_refund_faqs.dart';
import 'admin_refund_guarantee_program_faqs/admin_refund_guarantee_faqs.dart';
import 'admin_trip_rewards_faqs/admn_trip_rewards_faqs.dart';
import 'admin_wallet_transaction_faqs/admin_wallet_faqs.dart';
import 'admn_tik_resche_cancl_faqs/admin_ticket_resche_cancelation.dart';
import 'admin_tick_bok_faqs/admin_tickets_booking_screen.dart';


class AdminHelpTopicsScreen extends StatelessWidget {
  const AdminHelpTopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Help Topics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20), // Spacing below the header text
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 items in each row
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildAdminHelpBox(context, Icons.confirmation_number, 'Ticket Bookings', const TicketBookingsScreen()),
                  _buildAdminHelpBox(context, Icons.sync, 'Reschedule / Cancel Tickets', const AdmTikRescheCanclFaqs()),
                  _buildAdminHelpBox(context, Icons.cancel, 'Handle Bus Cancellations', const AdmnBusCanclFaqs()),
                  _buildAdminHelpBox(context, Icons.local_offer, 'Manage Offers', const AdmnOfersFaqs()),
                  _buildAdminHelpBox(context, Icons.attach_money, 'Process Payments & Refunds', const AdminPaymentAndRefundFaqs()),
                  _buildAdminHelpBox(context, Icons.account_balance_wallet, 'Manage Wallet Transactions', const AdminWalletFaqs()),
                  _buildAdminHelpBox(context, Icons.security, 'Manage Refund Guarantee Program', const AdminRefundGuaranteeFaqs()),
                  _buildAdminHelpBox(context, Icons.help_outline, 'Other Admin Queries', const AdminOtherQueriesFaqs()),
                  _buildAdminHelpBox(context, Icons.card_giftcard, 'Admin Trip Rewards', const AdminTripRewardsFaqs()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build each admin help option as a box
  Widget _buildAdminHelpBox(BuildContext context, IconData icon, String title, Widget targetScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => targetScreen,
          ),
        );
      },
      child: Container(
        height: 200, // Set height
        width: 200, // Set width
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.redAccent.shade700, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
