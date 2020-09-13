import 'package:flutter/material.dart';
import 'package:food_order/Models/food.dart';
import 'package:food_order/Models/profile.dart';
import 'package:food_order/Screens/ProfileScreen.dart';
import 'package:food_order/Utils/FirebaseAuth.dart';
import 'package:food_order/Utils/database.dart';
import 'package:food_order/styleGuide.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: kprimaryColor,
                        child: CircleAvatar(
                          radius: 48,
                          backgroundImage:
                              AssetImage('assets/images/wassim.jpg'),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${profile.firstName} ${profile.lastName}',
                    style: ktextStyle,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlatButton(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    child: Text('Order History'),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    child: Text('Enter Promo Code'),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    child: Text('Settings'),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    child: Text('FAQS'),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    child: Text('LOGOUT'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hello, ${profile.firstName}',
                    style: kheadTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: kprimaryColor,
                      child: CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage('assets/images/wassim.jpg'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(text: 'Find your', style: kheadTextStyleLight),
                      TextSpan(text: '\n'),
                      TextSpan(text: 'Favorite Food', style: kheadTextStyle),
                    ]),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 1,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: foodTypes.length,
                    itemBuilder: (context, index) {
                      final type = foodTypes[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            print(index);
                            setState(() {
                              isSelected = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: isSelected == index
                                  ? Color(0xffE31C1B).withOpacity(0.7)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    offset: Offset(0, 0.2),
                                    color: Colors.black),
                              ],
                            ),
                            height: 60,
                            width: 130,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: type.image == ''
                                      ? null
                                      : Image(
                                          image: AssetImage(type.image),
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        ),
                                ),
                                Text(
                                  type.name,
                                  style: isSelected == index
                                      ? ktextStyleWhite
                                      : ktextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
