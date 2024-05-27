import 'package:flutter/material.dart';
import './API/data_fetcher.dart';
import './Models/dish_model.dart';
import './dish_detail.dart';
import 'finalcart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataFetcher.initializeSupabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<String> filters = [];
  List<Dish> dishes = [];
  String selectedFilter = 'Rice Bowls';
  List<Dish> filteredDishes = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Dish> fetchedDishes = await DataFetcher.fetchDishesFromSupabase();
    print("Fetched dishes: $fetchedDishes");
    setState(() {
      dishes = fetchedDishes;
      filters = dishes.map((dish) => dish.category).toSet().toList();
      print("Filters: $filters");
      filterDishes(selectedFilter);
    });
  }

  void filterDishes(String filterValue) {
    print("Filtering dishes with category: $filterValue");
    setState(() {
      selectedFilter = filterValue;
      filteredDishes =
          dishes.where((dish) => dish.category == filterValue).toList();
      print("Filtered dishes: $filteredDishes");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Welcome, Allen'),
            Spacer(),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 16),
          Container(
            width: 137,
            child: ListView.builder(
              itemCount: filters.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filters[index]),
                  onTap: () => filterDishes(filters[index]),
                );
              },
            ),
          ),
          Expanded(
            child: filteredDishes.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredDishes.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DishDetailPage(dish: filteredDishes[index]),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            children: [
                              Image.network(
                                filteredDishes[index].imageUrl,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                filteredDishes[index].name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('\$${filteredDishes[index].price}'),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text('No dishes found for this category'),
                  ),
          ),
        ],
      ),
    );
  }
}
