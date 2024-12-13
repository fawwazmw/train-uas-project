import 'package:flutter/material.dart';
import 'package:uas_project_lumiride/pages/profil_page.dart';
import 'package:uas_project_lumiride/pages/select_train_page.dart';
import 'package:uas_project_lumiride/pages/transaction_page.dart';

import '../models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers untuk kolom input
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController departureController = TextEditingController();
  final TextEditingController returnController = TextEditingController();
  final TextEditingController travellerController = TextEditingController();
  final TextEditingController quotaController = TextEditingController();

  int _selectedIndex = 0; // Indeks tab BottomNavigationBar

  // Fungsi untuk memilih tanggal
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      controller.text = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
    }
  }

  // Fungsi untuk mencari kereta dan berpindah ke halaman detail tiket
  void _searchTrains() {
    if (fromController.text.isEmpty ||
        toController.text.isEmpty ||
        departureController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Harap isi semua kolom yang diperlukan'))
      );
      return;
    }

    // Jika validasi sukses, pindah ke halaman tiket
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TicketDetailsScreen())
    );
  }

  // Fungsi untuk menangani perubahan tab di BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Menambahkan logika navigasi berdasarkan tab yang dipilih
    switch (index) {
      case 0:
      // Jika tab Beranda dipilih, kita tidak perlu melakukan apapun
        break;
      case 1:
      // Jika tab Transaksi dipilih, navigasi ke halaman transaksi (misalnya)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionScreen(
              transaction: TransactionModel(
                ticketCode: 'ABC123',
                ticketPrice: 150.00,
                paymentMethod: 'Credit Card',
                transactionDate: DateTime.now(),
                fromStation: 'Station A',
                toStation: 'Station B',
                trainName: 'Train X',
              ),
            ),
          ),
        );
        break;
      case 2:
      // Jika tab Akun dipilih, navigasi ke halaman akun
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AccountScreen())
        );
        break;
    }
  }

  @override
  void dispose() {
    // Pastikan untuk melepaskan kontroler agar tidak menyebabkan kebocoran memori
    fromController.dispose();
    toController.dispose();
    departureController.dispose();
    returnController.dispose();
    travellerController.dispose();
    quotaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/profile.png'), // Gambar profil
          ),
        ),
        title: const Text('Lexa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Tampilkan notifikasi
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Belum ada notifikasi'))
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildInputRow(
                      icon: Icons.train,
                      label: 'From',
                      controller: fromController,
                      hintText: 'Enter departure station'
                  ),
                  const Divider(color: Colors.white),

                  _buildInputRow(
                      icon: Icons.train,
                      label: 'To',
                      controller: toController,
                      hintText: 'Enter destination station'
                  ),
                  const Divider(color: Colors.white),

                  _buildDateRow(
                      icon: Icons.calendar_today,
                      label: 'Departure',
                      controller: departureController,
                      onTap: () => _selectDate(context, departureController)
                  ),
                  const Divider(color: Colors.white),

                  _buildDateRow(
                      icon: Icons.calendar_today,
                      label: 'Return',
                      controller: returnController,
                      onTap: () => _selectDate(context, returnController)
                  ),
                  const Divider(color: Colors.white),

                  _buildInputRow(
                      icon: Icons.person,
                      label: 'Traveller',
                      controller: travellerController,
                      hintText: 'Enter number of travellers',
                      keyboardType: TextInputType.number
                  ),
                  const Divider(color: Colors.white),

                  _buildInputRow(
                      icon: Icons.label,
                      label: 'Quota',
                      controller: quotaController,
                      hintText: 'Enter quota'
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchTrains,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Colors.blue.shade800,
              ),
              child: const Text(
                'SEARCH TRAIN',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Akun',
          ),
        ],
      ),
    );
  }

  Widget _buildInputRow({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: label,
              labelStyle: const TextStyle(color: Colors.white),
              hintStyle: const TextStyle(color: Colors.white),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            style: const TextStyle(color: Colors.white),
            keyboardType: keyboardType,
          ),
        ),
      ],
    );
  }

  Widget _buildDateRow({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: AbsorbPointer(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: const TextStyle(color: Colors.white),
                  hintText: 'Select Date',
                  hintStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
