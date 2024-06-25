import 'package:flutter/material.dart';

class PurchasePage extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  const PurchasePage({super.key, required this.products});

  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final List<Map<String, dynamic>> _orderedProducts = [];

  void _addProductToOrder(String name, int quantity) {
    setState(() {
      _orderedProducts.add({'name': name, 'quantity': quantity});
    });
  }

  void _showAddOrderDialog() {
    String selectedProduct =
        widget.products.isNotEmpty ? widget.products[0]['name'] : '';
    int quantity = 0;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pesan Barang'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Pilih Barang'),
              value: selectedProduct.isNotEmpty ? selectedProduct : null,
              items: widget.products.map((product) {
                return DropdownMenuItem<String>(
                  value: product['name'],
                  child: Text(product['name']),
                );
              }).toList(),
              onChanged: (value) => selectedProduct = value ?? '',
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
              _addProductToOrder(selectedProduct, quantity);
              Navigator.of(context).pop();
            },
            child: const Text('Pesan'),
          ),
        ],
      ),
    );
  }

  void _deleteOrder(int index) {
    setState(() {
      _orderedProducts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Pembelian Barang'),
        leading: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: _showAddOrderDialog,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _orderedProducts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_orderedProducts[index]['name']),
                  subtitle:
                      Text('Jumlah: ${_orderedProducts[index]['quantity']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteOrder(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
