import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'api_service.dart';
import 'user.dart';
import 'product_details_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ApiService apiService = ApiService('https://api.escuelajs.co/api/v1');
  List<dynamic> products = [];
  List<dynamic> filteredProducts = [];
  int offset = 0;
  final int limit = 5;
  bool isLoading = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
    searchController.addListener(_filterProducts);
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    try {
      final newProducts = await apiService.fetchProducts(offset: offset, limit: limit);
      setState(() {
        // Filtrar productos que tienen al menos una imagen
        products.addAll(newProducts.where((product) => product['images'] != null && product['images'].isNotEmpty));
        filteredProducts = products;
        offset += limit;
      });
    } catch (error) {
      print('Error fetching products: $error');
    }
    setState(() {
      isLoading = false;
    });
  }

  void _filterProducts() {
    setState(() {
      if (searchController.text.isEmpty) {
        filteredProducts = products;
      } else {
        filteredProducts = products
            .where((product) =>
                product['title'].toLowerCase().contains(searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<User>('userBox');
    User? user = box.get('user');
    String email = user?.email ?? '';
    String password = user?.password ?? '';

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome!', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 10),
          Text('Email: $email', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Text('Password: $password', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Item',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: filteredProducts.length + 1,
            itemBuilder: (context, index) {
              if (index == filteredProducts.length) {
                return isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: fetchProducts,
                        child: const Text('Load More'),
                      );
              }
              final product = filteredProducts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(product: product),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        product['images'][0],
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return const Icon(Icons.error, size: 50);  // Ícono de error si la imagen no carga
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'NEW',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              product['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${product['price']}€',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
