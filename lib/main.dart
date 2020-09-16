import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_order/Models/cart.dart';
import 'package:food_order/Models/user.dart';
import 'package:food_order/Screens/WelcomeScreen.dart';
import 'package:food_order/Screens/Wrapper.dart';
import 'package:food_order/Utils/FirebaseAuth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<CustomUser>.value(
          value: AuthService().user,
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        )
      ],
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
