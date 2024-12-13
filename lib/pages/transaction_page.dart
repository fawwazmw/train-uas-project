import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk pemformatan tanggal
import '../models/transaction.dart';

class TransactionScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionScreen({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Transaction Details",
          style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTransactionDetailsCard(context),
            const SizedBox(height: 20),
            _buildTicketIconSection(),
            const SizedBox(height: 20),
            _buildPrintTicketButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionDetailsCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
                'Transaction Code',
                transaction.ticketCode
            ),
            const SizedBox(height: 10),
            _buildDetailRow(
                'Ticket Price',
                NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: 'Rp '
                ).format(transaction.ticketPrice)
            ),
            const SizedBox(height: 10),
            _buildDetailRow(
                'Payment Method',
                transaction.paymentMethod
            ),
            const SizedBox(height: 10),
            _buildDetailRow(
                'Transaction Date',
                DateFormat('dd MMMM yyyy').format(transaction.transactionDate)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTicketIconSection() {
    return Center(
      child: Column(
        children: [
          const Text(
            'Your Ticket Confirmation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Icon(
            Icons.confirmation_number_outlined,
            size: 100.0,
            color: Colors.blue.shade700,
          ),
        ],
      ),
    );
  }

  Widget _buildPrintTicketButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => _showPrintDialog(context),
        icon: const Icon(Icons.print),
        label: const Text('Print Ticket'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  void _showPrintDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Print Ticket'),
        content: const Text('Do you want to print your ticket?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implementasikan logika pencetakan tiket
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Printing ticket...')),
              );
            },
            child: const Text('Print'),
          ),
        ],
      ),
    );
  }
}