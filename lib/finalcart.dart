// cart_page.dart
import 'package:flutter/material.dart';
import './Models/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = Cart.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: items.isNotEmpty
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
                );
              },
            )
          : Center(
              child: Text('No items in the cart'),
            ),
    );
  }
}
