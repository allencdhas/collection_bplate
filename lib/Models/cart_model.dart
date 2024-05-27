import './dish_model.dart';

class Cart {
  static final List<Dish> _items = [];

  static List<Dish> get items => List.unmodifiable(_items);

  static void addItem(Dish dish) {
    _items.add(dish);
  }

  static void removeItem(Dish dish) {
    _items.remove(dish);
  }

  static void clearCart() {
    _items.clear();
  }
}
