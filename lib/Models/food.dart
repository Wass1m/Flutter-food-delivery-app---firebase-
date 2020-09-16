class Food {
  final String foodID;
  final String type;
  final String name;
  final String image;
  final int price;
  final int weight;
  final int calories;
  final List<dynamic> size;
  final bool outOfStock;

  Food(
      {this.foodID,
      this.type,
      this.name,
      this.image,
      this.price,
      this.size,
      this.weight,
      this.calories,
      this.outOfStock = false});

  Map toJson() => {
        'foodID': foodID,
        'type': type,
        'size': size,
        'name': name,
        'image': image,
        'price': price,
        'weight': weight,
        'calories': calories,
        'outOfStock': outOfStock,
      };

  Food.fromJson(Map json)
      : foodID = json['foodID'],
        type = json['type'],
        size = json['size'],
        image = json['image'],
        price = json['price'],
        weight = json['weight'],
        calories = json['calories'],
        outOfStock = json['outOfStock'],
        name = json['name'];
}

class FoodType {
  final String name;
  final String image;

  FoodType({
    this.name,
    this.image,
  });
}

// List<FoodType> foodTypes = [
//   FoodType('All', ''),
//   FoodType('Pizza', 'assets/images/foodTypes/pizza.png'),
//   FoodType('Burger', 'assets/images/foodTypes/burger.png'),
//   FoodType('Pasta', 'assets/images/foodTypes/pasta.png'),
// ];
