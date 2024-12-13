import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'transaction_page.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final double ticketPrice;
  final String paymentMethod;
  final String paymentStatus;
  final DateTime paymentTime;
  final String fromStation;
  final String toStation;
  final String trainName;

  const PaymentConfirmationScreen({
    super.key,
    required this.ticketPrice,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.paymentTime,
    this.fromStation = '',
    this.toStation = '',
    this.trainName = '',
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
          "Payment Confirmation",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPaymentStatusWidget(),
              const SizedBox(height: 20),
              _buildPaymentDetailsCard(),
              const SizedBox(height: 40),
              _buildActionButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentStatusWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paymentStatus == 'success'
            ? Colors.green.shade50
            : Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: paymentStatus == 'success'
              ? Colors.green
              : Colors.red,
        ),
      ),
      child: Row(
        children: [
          Icon(
            paymentStatus == 'success'
                ? Icons.check_circle
                : Icons.error,
            color: paymentStatus == 'success'
                ? Colors.green
                : Colors.red,
          ),
          const SizedBox(width: 10),
          Text(
            'Payment ${paymentStatus == 'success' ? 'Successful' : 'Failed'}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: paymentStatus == 'success'
                  ? Colors.green
                  : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetailsCard() {
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
            _buildDetailRow('Ticket Price',
                NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(ticketPrice)
            ),
            const SizedBox(height: 10),
            _buildDetailRow('Payment Method', paymentMethod),
            const SizedBox(height: 10),
            _buildDetailRow('Payment Time',
                DateFormat('dd MMMM yyyy HH:mm').format(paymentTime)
            ),
            if (fromStation.isNotEmpty && toStation.isNotEmpty) ...[
              const SizedBox(height: 10),
              _buildDetailRow('Route', '$fromStation - $toStation'),
            ],
            if (trainName.isNotEmpty) ...[
              const SizedBox(height: 10),
              _buildDetailRow('Train', trainName),
            ],
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
            color: Colors.black87,
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

  Widget _buildActionButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: paymentStatus == 'success'
            ? () => _navigateToTransaction(context)
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'View Transaction Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _navigateToTransaction(BuildContext context) {
    final transaction = TransactionModel(
      ticketCode: 'TX${DateTime.now().millisecondsSinceEpoch}',
      ticketPrice: ticketPrice,
      paymentMethod: paymentMethod,
      transactionDate: paymentTime,
      fromStation: fromStation,
      toStation: toStation,
      trainName: trainName,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionScreen(transaction: transaction),
      ),
    );
  }
}