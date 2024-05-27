// cart_page.dart
import 'package:flutter/material.dart';
import './Models/cart_model.dart';
import 'Models/dish_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeItem(Dish dish) {
    setState(() {
      Cart.removeItem(dish);
    });
  }

  void _checkout() {
    // Implement checkout logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order taken successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = Cart.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: items.isNotEmpty
                ? ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(
                          items[index].imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(items[index].name),
                        subtitle: Text('\$${items[index].price}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () => _removeItem(items[index]),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('No items in the cart'),
                  ),
          ),
          if (items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _checkout,
                child: const Text('Checkout'),
              ),
            ),
        ],
      ),
    );
  }
}
