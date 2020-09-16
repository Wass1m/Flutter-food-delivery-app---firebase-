import 'package:flutter/material.dart';
import 'package:food_order/Models/cart.dart';
import 'package:food_order/Models/food.dart';
import 'package:food_order/Models/payment.dart';
import 'package:food_order/Models/profile.dart';
import 'package:food_order/Models/store.dart';
import 'package:food_order/Models/user.dart';
import 'package:food_order/Pages/ChangeAddress.dart';
import 'package:food_order/Pages/DetailFood.dart';
import 'package:food_order/Screens/ProfileScreen.dart';
import 'package:food_order/Utils/FirebaseAuth.dart';
import 'package:food_order/Utils/database.dart';
import 'package:food_order/styleGuide.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key key}) : super(key: key);
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final AuthService _auth = AuthService();

  final DatabaseService _database = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    return StreamProvider<Profile>.value(
      value: DatabaseService(uid: user.uid).currentProfile,
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            text: 'Payment Methods',
                            style: kheadTextStyleLight),
                      ]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                PaymentList(),
                SizedBox(
                  height: 50,
                ),
                Address(),
                SizedBox(
                  height: 50,
                ),
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
                        },
                        child: Text(
                          'Place Order',
                          style: ktextStyleWhite,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Address extends StatelessWidget {
  const Address({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.local_shipping,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delivery address', style: ktextStyle),
                    Text(profile == null ? '' : profile.address),
                  ],
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeAddress(
                                profile: profile,
                              )));
                },
                child: Icon(
                  Icons.edit,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentList extends StatefulWidget {
  const PaymentList({
    Key key,
  }) : super(key: key);

  @override
  _PaymentListState createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  int paymentSelected = 0;

  @override
  Widget build(BuildContext context) {
    final paymentList = paymentmethods;
    return paymentList == null
        ? CircularProgressIndicator(
            backgroundColor: kprimaryColor,
            strokeWidth: 2,
          )
        : Container(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: paymentList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        paymentSelected = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: paymentSelected == index
                              ? kprimaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 0.2))
                          ],
                        ),
                        height: 200,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Image.network(
                                paymentList[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              paymentList[index].paymentMethod,
                              style: paymentSelected == index
                                  ? kSubHeadTextStyleWhite
                                  : kSubHeadTextStyle,
                              maxLines: 1,
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
