import 'package:flutter/material.dart';
import './Models/dish_model.dart';
import './Models/cart_model.dart';

class DishDetailPage extends StatefulWidget {
  final Dish dish;

  const DishDetailPage({Key? key, required this.dish});

  @override
  _DishDetailPageState createState() => _DishDetailPageState();
}

class _DishDetailPageState extends State<DishDetailPage> {
  String? selectedVariation;
  double totalPrice = 0.0;

  void _updateTotalPrice() {
    setState(() {
      totalPrice = widget.dish.price +
          (selectedVariation != null
              ? widget.dish.variations
                  .firstWhere((v) => v.name == selectedVariation!)
                  .extraPrice
              : 0.0);
    });
  }

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
      description: selectedDish.description,
    );

    Cart.addItem(dishToAdd);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${selectedDish.name} with ${selectedVariation ?? ''} added to cart',
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _updateTotalPrice();
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    dish.imageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                dish.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dish.category,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                '\$$totalPrice', // Display total price
                style: const TextStyle(fontSize: 18, color: Colors.green),
              ),
              const SizedBox(height: 16),
              Text(
                dish.description,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              if (dish.variations.isNotEmpty) ...[
                const Text(
                  'Choose Type',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: dish.variations.map((variation) {
                    final isSelected = selectedVariation == variation.name;
                    return ChoiceChip(
                      label: Text(
                        '${variation.name} \$${variation.extraPrice.toStringAsFixed(2)}', // Display name and price
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedVariation = selected ? variation.name : null;
                          _updateTotalPrice(); // Update total price when variation changes
                        });
                      },
                      selectedColor: Colors.orange,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: 150, // Make button full-width
                child: ElevatedButton(
                  onPressed: _addToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.orange, // Set the button color to orange
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
