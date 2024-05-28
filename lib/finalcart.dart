import 'package:flutter/material.dart';
import './Models/cart_model.dart';
import 'Models/dish_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            items[index].imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(items[index].name),
                        subtitle: Text('\$${items[index].price}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () => _removeItem(items[index]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (items.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: _checkout,
                  child: const Text('Checkout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    minimumSize: Size(double.infinity, 0),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
