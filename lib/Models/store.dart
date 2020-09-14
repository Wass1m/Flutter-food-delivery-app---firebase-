import 'package:food_order/Models/Brand.dart';
import 'package:food_order/Models/food.dart';

class Store {
  final String name;
  final List<dynamic> menu;
  final String image;
  final int rating;
  final String location;
  final String brand;

  Store(
      {this.name,
      this.menu,
      this.image,
      this.rating,
      this.location,
      this.brand});
}
