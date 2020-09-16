import 'package:flutter/material.dart';
import 'package:food_order/Models/cart.dart';
import 'package:food_order/Models/food.dart';
import 'package:food_order/Models/profile.dart';
import 'package:food_order/Models/store.dart';
import 'package:food_order/Pages/CartPage.dart';
import 'package:food_order/Pages/StorePage.dart';
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
  final DatabaseService _database = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String filter = 'All';
  bool loading = false;
  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  void setFilter(String newFilter) {
    this.setState(() {
      filter = newFilter;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CartProvider>(context, listen: false).loadSharedPrefs();
    });
  }

  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<Store>>.value(
          value: DatabaseService().getFilteredStores(filter: filter),
        ),
        StreamProvider<List<FoodType>>.value(
          value: DatabaseService().allTypes,
        )
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
                          backgroundImage:
                              AssetImage('assets/images/wassim.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: InkWell(
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
                  ),
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
                FoodTypesList(
                  setF: setFilter,
                  setLoading: setLoading,
                  loading: loading,
                ),
                SizedBox(
                  height: 20,
                ),
                StoreList(
                  loading: loading,
                ),
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
    this.loading,
    this.setLoading,
  }) : super(key: key);

  final Function setF;
  final bool loading;
  final Function setLoading;

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

class StoreList extends StatelessWidget {
  final bool loading;

  const StoreList({
    Key key,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stores = Provider.of<List<Store>>(context);

    print('store provider');
    print(stores);
    return stores == null
        ? CircularProgressIndicator(
            backgroundColor: kprimaryColor,
            strokeWidth: 2,
          )
        : Container(
            height: 300,
            child: ListView.builder(
                itemCount: stores.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StorePage(
                                      store: stores[index],
                                    )));
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                child: Image.network(stores[index].image)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('${stores[index].rating.toString()} ⭐'),
                                Text(
                                  stores[index].name,
                                  style: ktextStyle,
                                ),
                                Text(stores[index].foodTypes[0]),
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
