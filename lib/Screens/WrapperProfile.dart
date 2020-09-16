import 'package:flutter/material.dart';
import 'package:food_order/Models/cart.dart';
import 'package:food_order/Models/profile.dart';
import 'package:food_order/Screens/HomeScreen.dart';
import 'package:food_order/Screens/ProfileScreen.dart';
import 'package:food_order/Utils/database.dart';
import 'package:provider/provider.dart';

class WrapperProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    return profile == null ? ProfileScreen() : HomeScreen();
  }
}
