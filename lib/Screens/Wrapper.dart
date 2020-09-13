import 'package:flutter/material.dart';
import 'package:food_order/Models/profile.dart';
import 'package:food_order/Models/user.dart';
import 'package:food_order/Screens/HomeScreen.dart';
import 'package:food_order/Screens/LoadingScreen.dart';
import 'package:food_order/Screens/WelcomeScreen.dart';
import 'package:food_order/Screens/WrapperProfile.dart';
import 'package:food_order/Utils/database.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DatabaseService database;
    final user = Provider.of<CustomUser>(context);
    // if (user != null) {
    //   database = DatabaseService(uid: user.uid);
    // }
    print(user);

    return user == null
        ? WelcomeScreen()
        : StreamProvider<Profile>.value(
            value: DatabaseService(uid: user.uid).currentProfile,
            child: WrapperProfile(),
          );
  }
}
