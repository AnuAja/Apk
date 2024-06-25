import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = _products;
  }

  void _addProduct(String name, double price, String kategori, int quantity) {
    setState(() {
      _products.add({
        'name': name,
        'price': price,
        'kategori': kategori,
        'quantity': quantity
      });
      _filteredProducts = _products;
    });
  }

  void _editProduct(
      int index, String name, double price, String kategori, int quantity) {
    setState(() {
      _products[index] = {
        'name': name,
        'price': price,
        'kategori': kategori,
        'quantity': quantity
      };
      _filteredProducts = _products;
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
      _filteredProducts = _products;
    });
  }

  void _searchProduct(String query) {
    final filteredProducts = _products.where((product) {
      final nameLower = product['name'].toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      _filteredProducts = filteredProducts;
    });
  }

  void _showAddProductDialog() {
    String name = '';
    double price = 0.0;
    String kategori = '';
    int quantity = 0;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Barang'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nama Barang'),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Harga'),
              keyboardType: TextInputType.number,
              onChanged: (value) => price = double.parse(value),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Kategori'),
              keyboardType: TextInputType.number,
              onChanged: (value) => kategori = value,
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
              _addProduct(name, price, kategori, quantity);
              Navigator.of(context).pop();
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  void _showEditProductDialog(int index) {
    String name = _products[index]['name'];
    double price = _products[index]['price'];
    String kategori = _products[index]['kategori'];
    int quantity = _products[index]['quantity'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Barang'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nama Barang'),
              controller: TextEditingController(text: name),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Harga'),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: price.toString()),
              onChanged: (value) => price = double.parse(value),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Kategori'),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: kategori.toString()),
              onChanged: (value) => kategori = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Jumlah'),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: quantity.toString()),
              onChanged: (value) => quantity = int.parse(value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _editProduct(index, name, price, kategori, quantity);
              Navigator.of(context).pop();
            },
            child: const Text('Simpan'),
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
        leading: IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: _showAddProductDialog,
        ),
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
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredProducts[index]['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Harga: ${_filteredProducts[index]['price']}'),
                      Text('Kategori: ${_filteredProducts[index]['kategori']}'),
                      Text('Stok: ${_filteredProducts[index]['quantity']}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showEditProductDialog(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteProduct(index),
                      ),
                    ],
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
