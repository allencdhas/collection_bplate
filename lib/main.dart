import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './API/data_fetcher.dart';
import './Models/dish_model.dart';
import './dish_detail.dart';
import 'finalcart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataFetcher.initializeSupabase();
  runApp(const MyApp());
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
      home: const LandingPage(),
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: const Color.fromARGB(0, 158, 158, 158),
            height: 1.0,
          ),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 16),
          Container(
            width: 137,
            decoration: BoxDecoration(
              color: const Color.fromARGB(0, 255, 255, 255),
            ),
            child: ListView.builder(
              itemCount: filters.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    color: selectedFilter == filters[index]
                        ? Colors.orange.withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: selectedFilter == filters[index]
                          ? Colors.orange
                          : Colors.transparent,
                    ),
                  ),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        filters[index],
                        style: TextStyle(
                            color: selectedFilter == filters[index]
                                ? Colors.orange
                                : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () => filterDishes(filters[index]),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(0, 255, 255, 255),
                border: Border.all(color: Color.fromARGB(255, 193, 149, 122)),
              ),
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10.0),
                                  ),
                                  child: Image.network(
                                    filteredDishes[index].imageUrl,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
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
                                const SizedBox(height: 8),
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
          ),
        ],
      ),
    );
  }
}
