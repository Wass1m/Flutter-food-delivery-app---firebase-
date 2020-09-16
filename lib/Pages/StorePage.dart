import 'package:flutter/material.dart';
import 'package:food_order/Models/cart.dart';
import 'package:food_order/Models/food.dart';
import 'package:food_order/Models/profile.dart';
import 'package:food_order/Models/store.dart';
import 'package:food_order/Pages/CartPage.dart';
import 'package:food_order/Pages/DetailFood.dart';
import 'package:food_order/Screens/ProfileScreen.dart';
import 'package:food_order/Utils/FirebaseAuth.dart';
import 'package:food_order/Utils/database.dart';
import 'package:food_order/styleGuide.dart';
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  final Store store;

  const StorePage({Key key, this.store}) : super(key: key);
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final AuthService _auth = AuthService();
  final DatabaseService _database = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Food>>.value(
          value: DatabaseService()
              .getfoodList(widget.store.menu.cast<String>().toList()),
        ),
        // StreamProvider<List<FoodType>>.value(
        //   value: DatabaseService().allTypes,
        // )
      ],
      child: Scaffold(
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
                    // Text(
                    //   '${profile.firstName} ${profile.lastName}',
                    //   style: ktextStyle,
                    // )
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
                        Provider.of<CartProvider>(context, listen: false)
                            .reset();
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
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: kprimaryColor,
                          child: Icon(
                            Icons.home,
                            size: 40,
                            color: Colors.white,
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPage()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 10,
                            child: Text(
                                '${Provider.of<CartProvider>(context).itemsNumber()}'),
                          )
                        ],
                      ),
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
                          backgroundImage:
                              AssetImage('assets/images/wassim.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Choose what', style: kheadTextStyleLight),
                        TextSpan(text: '\n'),
                        TextSpan(
                            text: 'You want to eat', style: kheadTextStyle),
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
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          offset: Offset(0, 0.2),
                          color: Colors.black),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.network(
                        widget.store.image,
                        height: 50,
                        width: 50,
                      ),
                      Text(
                        widget.store.name,
                        style: kSubHeadTextStyle,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FoodList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FoodTypesList extends StatefulWidget {
  const FoodTypesList({
    Key key,
    @required this.setF,
  }) : super(key: key);

  final Function setF;

  @override
  _FoodTypesListState createState() => _FoodTypesListState();
}

class _FoodTypesListState extends State<FoodTypesList> {
  int isFoodSelected = 0;
  @override
  Widget build(BuildContext context) {
    final types = Provider.of<List<FoodType>>(context);
    return types == null
        ? CircularProgressIndicator(
            backgroundColor: Colors.blue,
            strokeWidth: 2,
          )
        : Container(
            height: 80,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: types.length,
                itemBuilder: (context, index) {
                  final type = types[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        widget.setF(type.name);

                        setState(() {
                          isFoodSelected = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: isFoodSelected == index
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
                              style: isFoodSelected == index
                                  ? ktextStyleWhite
                                  : ktextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
  }
}

class FoodList extends StatelessWidget {
  const FoodList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foodList = Provider.of<List<Food>>(context);

    print(foodList);
    return foodList == null
        ? CircularProgressIndicator(
            backgroundColor: kprimaryColor,
            strokeWidth: 2,
          )
        : Container(
            height: 300,
            child: ListView.builder(
                itemCount: foodList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailFood(
                              food: foodList[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 3,
                                color: Colors.black,
                                offset: Offset(0, 0.2))
                          ],
                        ),
                        height: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  foodList[index].image,
                                  fit: BoxFit.cover,
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('${foodList[index].price.toString()} \$'),
                                Text(
                                  foodList[index].name,
                                  style: ktextStyle,
                                ),
                                Row(
                                  children: foodList[index]
                                      .size
                                      .map((element) => Text('$element '))
                                      .toList(),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: kprimaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
  }
}
