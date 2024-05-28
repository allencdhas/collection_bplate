// data_fetcher.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Models/dish_model.dart';

class DataFetcher {
  static const supabaseUrl = 'https://hamsxoqqbswiataxemfo.supabase.co';
  static const supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhhbXN4b3FxYnN3aWF0YXhlbWZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY4NDc1OTQsImV4cCI6MjAzMjQyMzU5NH0.y6cPwoLu4Q80v4ov-7l08WZjKgC2OREAq8JtI2c4Xq8';

  static Future<void> initializeSupabase() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );
  }

  static Future<List<Dish>> fetchDishesFromSupabase() async {
    final response = await Supabase.instance.client
        .from('dishes')
        .select('*')
        .order('category');

    return response.map((item) => Dish.fromJson(item)).toList();
  }
}
