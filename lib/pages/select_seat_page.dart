import 'package:flutter/material.dart';
import 'package:uas_project_lumiride/pages/payment_page.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({super.key});

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  // Matriks status kursi: available, selected, reserved
  final List<List<String>> seats = List.generate(
    12, // 12 baris
        (index) => List.generate(6, (index) => 'available'),
  );

  // Method untuk mengatur status kursi
  void _toggleSeatSelection(int row, int col) {
    setState(() {
      if (seats[row][col] == 'available') {
        seats[row][col] = 'selected';
      } else if (seats[row][col] == 'selected') {
        seats[row][col] = 'available';
      }
    });
  }

  // Hitung jumlah kursi yang dipilih
  int _getSelectedSeatsCount() {
    return seats.expand((row) => row)
        .where((seat) => seat == 'selected')
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Kursi'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildLegendSection(),
          _buildSeatLayout(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  // Legenda status kursi
  Widget _buildLegendSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLegendItem(Colors.white, 'Available', Colors.black),
          const SizedBox(width: 10),
          _buildLegendItem(Colors.blue, 'Selected', Colors.white),
          const SizedBox(width: 10),
          _buildLegendItem(Colors.black26, 'Reserved', Colors.white),
        ],
      ),
    );
  }

  // Widget legenda
  Widget _buildLegendItem(Color color, String label, Color textColor) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black54),
          ),
        ),
        const SizedBox(width: 5),
        Text(label, style: TextStyle(color: textColor)),
      ],
    );
  }

  // Layout kursi
  Widget _buildSeatLayout() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Kolom Kiri
            _buildSeatColumn(0),
            const SizedBox(width: 16),
            // Kolom Kanan
            _buildSeatColumn(3),
          ],
        ),
      ),
    );
  }

  // Membangun kolom kursi
  Widget _buildSeatColumn(int colStart) {
    return Column(
      children: List.generate(
          6,
              (row) => _buildSeatRow(row, colStart)
      ),
    );
  }

  // Membangun baris kursi
  Widget _buildSeatRow(int row, int colStart) {
    return Row(
      children: List.generate(3, (col) {
        final seatStatus = seats[row][colStart + col];
        final seatNumber = row * 6 + colStart + col + 1;

        return _buildSeatWidget(row, colStart + col, seatNumber, seatStatus);
      }),
    );
  }

  // Widget kursi individual
  Widget _buildSeatWidget(int row, int col, int seatNumber, String seatStatus) {
    return GestureDetector(
      onTap: seatStatus == 'available'
          ? () => _toggleSeatSelection(row, col)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getSeatColor(seatStatus),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black54),
        ),
        child: Center(
          child: Text(
            '$seatNumber',
            style: TextStyle(
              color: _getSeatTextColor(seatStatus),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Mendapatkan warna kursi berdasarkan status
  Color _getSeatColor(String status) {
    switch (status) {
      case 'available':
        return Colors.white;
      case 'selected':
        return Colors.blue;
      case 'reserved':
        return Colors.black26;
      default:
        return Colors.white;
    }
  }

  // Mendapatkan warna teks kursi berdasarkan status
  Color _getSeatTextColor(String status) {
    return status == 'available' ? Colors.black : Colors.white;
  }

  // Tombol aksi
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Tombol Batal
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
            ),
            child: const Text('Batal'),
          ),

          // Tombol Lanjutkan
          ElevatedButton(
            onPressed: () {
              final selectedSeats = _getSelectedSeatsCount();
              if (selectedSeats > 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      selectedSeatsCount: selectedSeats,
                    ),
                  ),
                );
              } else {
                // Tampilkan pesan jika belum memilih kursi
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pilih minimal satu kursi'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text('Lanjutkan'),
          ),
        ],
      ),
    );
  }
}