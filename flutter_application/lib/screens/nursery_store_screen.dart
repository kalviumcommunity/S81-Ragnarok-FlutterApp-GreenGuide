import 'package:flutter/material.dart';

import '../data/green_guide_repository.dart';
import '../models/product.dart';

class NurseryStoreScreen extends StatelessWidget {
  const NurseryStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = GreenGuideRepository.sampleProducts;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nursery Store'),
        backgroundColor: Colors.green[700],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.green[50],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Loyalty Points', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('Earn 10 points when you purchase a product through the nursery store. Redeem for free potting mix or service calls.'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...products.map((product) => _ProductCard(product: product)),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(product.imageUrl, width: 56, fit: BoxFit.cover),
        ),
        title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(product.description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('\$${product.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700], minimumSize: const Size(80, 32)),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
