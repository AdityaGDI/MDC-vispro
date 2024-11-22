import 'package:flutter/material.dart';
import 'barang1.dart';
import 'login.dart';

void main() {
  runApp(const ShrineApp());
}

class ShrineApp extends StatelessWidget {
  const ShrineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHRINE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All'; // Default kategori

  // Filter produk berdasarkan kategori dan pencarian
  List<Product> _filteredProducts() {
    List<Product> filteredProducts = products.where((product) {
      final matchesCategory = _selectedCategory == 'All' ||
          (product.name.contains('Figure') && _selectedCategory == 'Figures') ||
          (product.name.contains('Nendoroid') && _selectedCategory == 'Nendroid');
      final matchesSearch = product.name
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return filteredProducts;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 2; // Default untuk mobile
    if (screenWidth >= 1200) {
      crossAxisCount = 4; // Untuk desktop
    } else if (screenWidth >= 800) {
      crossAxisCount = 3; // Untuk tablet
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('SHRINE'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Navigation Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('All Products'),
              onTap: () {
                setState(() {
                  _selectedCategory = 'All';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Figures'),
              onTap: () {
                setState(() {
                  _selectedCategory = 'Figures';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.toys),
              title: const Text('Nendroid'),
              onTap: () {
                setState(() {
                  _selectedCategory = 'Nendroid';
                });
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2 / 3,
        ),
        itemCount: _filteredProducts().length,
        itemBuilder: (context, index) {
          return ProductCard(product: _filteredProducts()[index]);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedCategory == 'All'
            ? 0
            : _selectedCategory == 'Figures'
                ? 1
                : 2,
        onTap: (index) {
          setState(() {
            if (index == 0) _selectedCategory = 'All';
            if (index == 1) _selectedCategory = 'Figures';
            if (index == 2) _selectedCategory = 'Nendroid';
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Figures',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.toys),
            label: 'Nendroid',
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final String price;

  Product({required this.name, required this.imageUrl, required this.price});
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Image.asset(
              product.imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text(
                    'Image not found',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.price,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (product.name == 'Figure Tobiichi Origami Angel Mode') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Barang1()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coming soon')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Buy'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Dummy Product Data
final List<Product> products = [
  Product(
    name: 'Figure Tobiichi Origami Angel Mode',
    imageUrl: 'images/angel.jpg',
    price: '\$20',
  ),
  Product(
    name: 'Figure Tobiichi Origami AST',
    imageUrl: 'images/AST.jpg',
    price: '\$20',
  ),
  Product(
    name: 'Nendoroid Tobiichi Origami',
    imageUrl: 'images/nendo.jpg',
    price: '\$20',
  ),
  Product(
    name: 'Aldenoah Zero',
    imageUrl: 'images/2_MC_Kalah.jpg',
    price: '\$20',
  ),
  Product(
    name: 'Menhera',
    imageUrl: 'images/menhera.jpg',
    price: '\$20',
  ),
  Product(
    name: 'Hinata',
    imageUrl: 'images/hinata.jpg',
    price: '\$20',
  ),
  Product(
    name: 'Hinata',
    imageUrl: 'images/hinata2.jpg',
    price: '\$20',
  ),
  Product(
    name: 'Hinata',
    imageUrl: 'images/hinata3.jpg',
    price: '\$20',
  ),
];
