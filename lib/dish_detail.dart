// dish_detail_page.dart
import 'package:flutter/material.dart';
import './Models/dish_model.dart';
import './Models/cart_model.dart';

class DishDetailPage extends StatefulWidget {
  final Dish dish;

  const DishDetailPage({Key? key, required this.dish}) : super(key: key);

  @override
  _DishDetailPageState createState() => _DishDetailPageState();
}

class _DishDetailPageState extends State<DishDetailPage> {
  String? selectedVariation;

  void _addToCart() {
    final selectedDish = widget.dish;
    final extraPrice = selectedVariation != null
        ? widget.dish.variations
            .firstWhere((v) => v.name == selectedVariation!)
            .extraPrice
        : 0.0;

    final dishToAdd = Dish(
      id: selectedDish.id,
      name: selectedDish.name,
      category: selectedDish.category,
      price: selectedDish.price + extraPrice,
      imageUrl: selectedDish.imageUrl,
      variations: selectedDish.variations,
    );

    Cart.addItem(dishToAdd);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              '${selectedDish.name} with ${selectedVariation ?? ''} added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dish = widget.dish;
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
            if (dish.variations.isNotEmpty) ...[
              Text(
                'Variations:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              for (var variation in dish.variations) ...[
                ListTile(
                  title: Text(variation.name),
                  trailing:
                      Text('\$${variation.extraPrice.toStringAsFixed(2)}'),
                  leading: Radio<String>(
                    value: variation.name,
                    groupValue: selectedVariation,
                    onChanged: (value) {
                      setState(() {
                        selectedVariation = value;
                      });
                    },
                  ),
                ),
              ],
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addToCart,
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
