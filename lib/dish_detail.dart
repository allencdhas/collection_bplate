// dish_detail_page.dart
import 'package:flutter/material.dart';
import './Models/dish_model.dart';
import './Models/cart_model.dart';

class DishDetailPage extends StatelessWidget {
  final Dish dish;

  const DishDetailPage({Key? key, required this.dish}) : super(key: key);

  void _addToCart(BuildContext context) {
    Cart.addItem(dish);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${dish.name} added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dish.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              dish.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              dish.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Category: ${dish.category}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${dish.price}',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              'Description of the dish can go here.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _addToCart(context),
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
