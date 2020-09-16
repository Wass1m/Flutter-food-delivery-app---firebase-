import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_order/Models/food.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Item {
  final Food food;
  int quantity;
  String size;
  final int itemPrice;

  Item({this.food, this.quantity, this.size, this.itemPrice});

  Map toJson() => {
        'food': food,
        'quantity': quantity,
        'size': size,
        'itemPrice': itemPrice,
      };

  Item.fromJson(Map json)
      : food = Food.fromJson(json['food']),
        quantity = json['quantity'],
        size = json['size'],
        itemPrice = json['itemPrice'];
}

class Cart {
  List<Item> items;
  int totalPrice;

  Cart({this.items, this.totalPrice});
}

class CartProvider extends ChangeNotifier {
  Cart cart = Cart(items: [], totalPrice: 0);

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  saveList(String key, list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, list);
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  readList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  void addCartItem(Item item) {
    cart.items.add(item);
    print(cart.items);
    List<String> listProducts =
        cart.items.map((elm) => json.encode(elm)).toList();
    print(listProducts);
    saveList('cart', listProducts);
    notifyListeners();
  }

  void loadSharedPrefs() async {
    List<String> productsItem = await readList("cart");
    List<Item> productsTemp =
        productsItem.map((item) => Item.fromJson(json.decode(item))).toList();

    setProducts(productsTemp);
    print('yaw');
    print(cart.items[0].toJson());
    print(itemsNumber());
    print('yaw');
  }

  Item getProduct(id) {
    return cart.items[id];
  }

  void reset() {
    cart.items = [];
    List<String> empty = List<String>();
    saveList('cart', empty);
    notifyListeners();
  }

  int itemsNumber() {
    return cart.items.length;
  }

  int totalPrice() {
    return cart.items
        .fold(0, (previousValue, element) => previousValue + element.itemPrice);
  }

  void removeProduct(id) {
    setProducts(cart.items.where((item) => item.food.foodID != id).toList());
  }

  void setItemQuantity(id, qty) {
    cart.items
        .map((item) => item.food.foodID != id ? item.quantity = qty : item);
    notifyListeners();
  }

  void setProducts(value) {
    cart.items = value;
    notifyListeners();
  }
}
