import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uas_project_lumiride/pages/home_page.dart';
import 'package:uas_project_lumiride/pages/transaction_page.dart';
import '../models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccountScreen(),
    );
  }
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedIndex = 2; // Indeks tab BottomNavigationBar

  // Fungsi aksi untuk tombol Profile
  void _onProfilePressed() {
    if (kDebugMode) {
      print("Tombol Profile ditekan");
    }
  }

  // Fungsi aksi untuk ganti kata sandi
  void _onChangePasswordPressed() {
    if (kDebugMode) {
      print("Tombol Ganti Kata Sandi ditekan");
    }
  }

  // Fungsi aksi untuk kebijakan privasi
  void _onPrivacyPolicyPressed() {
    if (kDebugMode) {
      print("Tombol Kebijakan Privasi ditekan");
    }
  }

  // Fungsi aksi untuk pusat bantuan
  void _onHelpCenterPressed() {
    if (kDebugMode) {
      print("Tombol Pusat Bantuan ditekan");
    }
  }

  // Fungsi aksi untuk keluar
  void _onLogoutPressed() {
    if (kDebugMode) {
      print("Tombol Keluar ditekan");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Menambahkan logika navigasi berdasarkan tab yang dipilih
    switch (index) {
      case 0:
      // Jika tab Beranda dipilih, kita tidak perlu melakukan apapun
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
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
          MaterialPageRoute(builder: (context) => const AccountScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            // Aksi kembali
          },
        ),
        title: const Text(
          "Akun Saya",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 30,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Lexa',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _onProfilePressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Profile'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.blue),
              title: const Text('Ganti Kata Sandi'),
              onTap: _onChangePasswordPressed,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.privacy_tip, color: Colors.blue),
              title: const Text('Kebijakan Privasi'),
              onTap: _onPrivacyPolicyPressed,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help, color: Colors.blue),
              title: const Text('Pusat Bantuan'),
              onTap: _onHelpCenterPressed,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.blue),
              title: const Text('Keluar'),
              onTap: _onLogoutPressed,
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
}
