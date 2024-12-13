import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'confirm_payment_page.dart';

class PaymentScreen extends StatefulWidget {
  final int selectedSeatsCount;
  final double pricePerSeat;

  const PaymentScreen({
    super.key,
    required this.selectedSeatsCount,
    this.pricePerSeat = 55000.0,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMethod;
  bool _isLoading = false;

  // Lista metode pembayaran dengan ikon
  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'QRIS', 'icon': Icons.qr_code},
    {'name': 'Bank Transfer', 'icon': Icons.account_balance},
    {'name': 'Credit Card', 'icon': Icons.credit_card},
    {'name': 'E-Wallet', 'icon': Icons.account_balance_wallet},
    {'name': 'Gopay', 'icon': Icons.payment},
    {'name': 'Dana', 'icon': Icons.payments},
  ];

  // Hitung total pembayaran
  double get _totalPayment => widget.selectedSeatsCount * widget.pricePerSeat;

  void _processPayment() {
    if (_selectedPaymentMethod == null) {
      _showErrorDialog('Pilih metode pembayaran terlebih dahulu');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulasi proses pembayaran
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      // Navigasi ke halaman konfirmasi pembayaran
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentConfirmationScreen(
            ticketPrice: _totalPayment,
            paymentMethod: _selectedPaymentMethod!,
            paymentStatus: 'success', // Simulasi pembayaran berhasil
            paymentTime: DateTime.now(),
          ),
        ),
      );
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildPaymentSummaryCard(),
          const SizedBox(height: 20),
          _buildPaymentMethodSelection(),
          const SizedBox(height: 30),
          _buildPaymentButton(),
        ],
      ),
    );
  }

  Widget _buildPaymentSummaryCard() {
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
            Text(
              'Detail Pembayaran',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 10),
            _buildSummaryRow(
              'Jumlah Kursi',
              '${widget.selectedSeatsCount} Kursi',
            ),
            _buildSummaryRow(
              'Harga per Kursi',
              NumberFormat.currency(
                  locale: 'id_ID',
                  symbol: 'Rp ',
                  decimalDigits: 0
              ).format(widget.pricePerSeat),
            ),
            const Divider(),
            _buildSummaryRow(
              'Total Pembayaran',
              NumberFormat.currency(
                  locale: 'id_ID',
                  symbol: 'Rp ',
                  decimalDigits: 0
              ).format(_totalPayment),
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Metode Pembayaran',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: _paymentMethods.length,
          itemBuilder: (context, index) {
            final method = _paymentMethods[index];
            return _buildPaymentMethodItem(method);
          },
        ),
      ],
    );
  }

  Widget _buildPaymentMethodItem(Map<String, dynamic> method) {
    final isSelected = _selectedPaymentMethod == method['name'];
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method['name'];
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              method['icon'],
              color: isSelected ? Colors.blue : Colors.grey,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              method['name'],
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentButton() {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ElevatedButton(
      onPressed: _processPayment,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Bayar Sekarang',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isTotal ? Colors.black : Colors.grey.shade700,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: isTotal ? Colors.blue.shade700 : Colors.black,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}