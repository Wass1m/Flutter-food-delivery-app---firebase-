import 'package:flutter/material.dart';
import 'package:food_order/Models/cart.dart';
import 'package:food_order/Models/food.dart';
import 'package:food_order/Models/profile.dart';
import 'package:food_order/Models/store.dart';
import 'package:food_order/Pages/CheckoutPage.dart';
import 'package:food_order/Pages/DetailFood.dart';
import 'package:food_order/Screens/ProfileScreen.dart';
import 'package:food_order/Utils/FirebaseAuth.dart';
import 'package:food_order/Utils/database.dart';
import 'package:food_order/styleGuide.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  final Store store;

  const CartPage({Key key, this.store}) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final AuthService _auth = AuthService();

  final DatabaseService _database = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<CartProvider>(context).cart;

    return Scaffold(
      key: _scaffoldKey,
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
                          Icons.arrow_back,
                          size: 40,
                          color: Colors.white,
                        )),
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(text: 'Your', style: kheadTextStyleLight),
                      TextSpan(text: '\n'),
                      TextSpan(text: 'Cart', style: kheadTextStyle),
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
              CartList(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                    color: kprimaryColor,
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      height: 60,
                      minWidth: 200,
                      onPressed: () {
                        // Item item = Item(
                        //   food: widget.food,
                        //   quantity: itemCount,
                        //   size: sizeSelected,
                        //   itemPrice: widget.food.price,
                        // );
                        // Provider.of<CartProvider>(context, listen: false)
                        //     .addCartItem(item);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutPage()));
                      },
                      child: Text(
                        'Checkout',
                        style: ktextStyleWhite,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CartList extends StatefulWidget {
  const CartList({
    Key key,
  }) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  int addSelected = 0;
  int itemCount = 1;
  @override
  Widget build(BuildContext context) {
    final cartList = Provider.of<CartProvider>(context).cart;
    print(cartList.items[0].size);
    return cartList == null
        ? CircularProgressIndicator(
            backgroundColor: kprimaryColor,
            strokeWidth: 2,
          )
        : cartList.items.length == 0
            ? Container(
                child: Text('Empty Cart'),
              )
            : Expanded(
                child: Container(
                  child: ListView.builder(
                      itemCount: cartList.items.length,
                      itemBuilder: (context, index) {
                        return cartList.items[index].food == null
                            ? Text('Loading cart item')
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 10),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(
                                            cartList.items[index].food.image,
                                            fit: BoxFit.cover,
                                          )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                              '${cartList.items[index].itemPrice} \$'),
                                          Text(
                                            cartList.items[index].food.name,
                                            style: ktextStyle,
                                          ),
                                          Text(cartList.items[index].size),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      addSelected = 1;
                                                      if (itemCount > 1) {
                                                        setState(() {
                                                          itemCount--;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: addSelected == 1
                                                          ? kprimaryColor
                                                          : Color(0xffF1F4F9),
                                                    ),
                                                    child: Align(
                                                      child: Text(
                                                        '-',
                                                        style: ktextStyle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Color(0xffF1F4F9),
                                                  ),
                                                  child: Align(
                                                    child: Text(
                                                      cartList
                                                          .items[index].quantity
                                                          .toString(),
                                                      style: ktextStyle,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      addSelected = 0;

                                                      itemCount++;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: addSelected == 0
                                                          ? kprimaryColor
                                                          : Color(0xffF1F4F9),
                                                    ),
                                                    child: Align(
                                                      child: Text(
                                                        '+',
                                                        style: ktextStyle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                      }),
                ),
              );
  }
}
