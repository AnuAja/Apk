import 'package:flutter/material.dart';
import 'product_page.dart';
import 'kasir_page.dart';
import 'purchase_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _products = [];

  final List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions.addAll([
      const ProductPage(),
      KasirPage(products: _products),
      const Center(child: Text('Laporan Page')),
      PurchasePage(products: _products),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 165, 226, 221),
            icon: Icon(Icons.store),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 165, 226, 221),
            icon: Icon(Icons.receipt_long),
            label: 'Kasir',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 165, 226, 221),
            icon: Icon(Icons.analytics_outlined),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 165, 226, 221),
            icon: Icon(Icons.shopping_cart),
            label: 'Pembelian',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        onTap: _onItemTapped,
      ),
    );
  }
}
