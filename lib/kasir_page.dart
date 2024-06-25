import 'package:flutter/material.dart';

class KasirPage extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  const KasirPage({super.key, required this.products});

  @override
  _KasirPageState createState() => _KasirPageState();
}

class _KasirPageState extends State<KasirPage> {
  List<Map<String, dynamic>> _cartItems = [];
  List<Map<String, dynamic>> _filteredProducts = [];
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _filteredProducts = widget.products;
  }

  void _addItemToCart(String name, double price, int quantity) {
    setState(() {
      _cartItems.add({'name': name, 'price': price, 'quantity': quantity});
      _totalPrice += price * quantity;
    });
  }

  void _removeItemFromCart(int index) {
    setState(() {
      _totalPrice -= _cartItems[index]['price'] * _cartItems[index]['quantity'];
      _cartItems.removeAt(index);
    });
  }

  void _searchProduct(String query) {
    final filteredProducts = widget.products.where((product) {
      final nameLower = product['name'].toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      _filteredProducts = filteredProducts;
    });
  }

  void _showAddItemDialog() {
    String selectedProduct = '';
    int quantity = 1;
    double price = 0.0;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Barang ke Keranjang'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Pilih Barang'),
              items: _filteredProducts.map((product) {
                return DropdownMenuItem(
                  value: product['name'],
                  child: Text(product['name']),
                );
              }).toList(),
              onChanged: (value) {
                selectedProduct = value as String;
                price = _filteredProducts.firstWhere(
                    (product) => product['name'] == selectedProduct)['price'];
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Jumlah'),
              keyboardType: TextInputType.number,
              onChanged: (value) => quantity = int.parse(value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _addItemToCart(selectedProduct, price, quantity);
              Navigator.of(context).pop();
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('KASHIRO'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _cartItems.clear();
                _totalPrice = 0.0;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Cari Produk',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _searchProduct,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: const Text('Total Harga'),
                subtitle: Text(_totalPrice.toStringAsFixed(2)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_cartItems[index]['name']),
                  subtitle: Text('Jumlah: ${_cartItems[index]['quantity']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          'Harga: ${(_cartItems[index]['price'] * _cartItems[index]['quantity']).toStringAsFixed(2)}'),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeItemFromCart(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
