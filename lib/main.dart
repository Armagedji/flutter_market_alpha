import 'package:flutter/material.dart';
import 'models/product.dart';
import 'data/data_loader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Список семян',
      theme: ThemeData(
        primaryColor: const Color(0xFF2D4059),
        scaffoldBackgroundColor: const Color(0xFFFFD151),
        cardColor: const Color(0xFFEDB230),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE77728),
            foregroundColor: const Color(0xFF1B262C),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Color(0xFF1B262C), fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Color(0xFF1B262C), fontSize: 16.0),
          bodyMedium: TextStyle(color: Color(0xFF4E4E50), fontSize: 14.0),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE77728),
        ),
      ),
      home: FutureBuilder<List<Product>>(
        future: loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ошибка при загрузке информации'));
          } else {
            return ProductListScreen(products: snapshot.data!);
          }
        },
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  final List<Product> products;

  const ProductListScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Перечень семян'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Card.filled(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      child: Image.asset(
                        products[index].image,
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[index].title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            products[index].shortDescription,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(product: products[index]),
                                  ),
                                );
                              },
                              child: const Text('Прочитать подробнее'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(product.image),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
