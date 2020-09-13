class Food {
  final FoodType type;
  final String name;
  final int price;
  final String size;
  final int weight;
  final int calories;
  final bool outOfStock = false;

  Food({
    this.type,
    this.name,
    this.price,
    this.size,
    this.weight,
    this.calories,
  });
}

class FoodType {
  final String name;
  final String image;

  FoodType(
    this.name,
    this.image,
  );
}

List<FoodType> foodTypes = [
  FoodType('All', ''),
  FoodType('Pizza', 'assets/images/foodTypes/pizza.png'),
  FoodType('Burger', 'assets/images/foodTypes/burger.png'),
  FoodType('Pasta', 'assets/images/foodTypes/pasta.png'),
];