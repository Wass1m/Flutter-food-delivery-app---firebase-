import 'package:flutter/material.dart';
import 'package:food_order/Models/cart.dart';
import 'package:food_order/Models/food.dart';
import 'package:food_order/Models/profile.dart';
import 'package:food_order/Models/store.dart';
import 'package:food_order/Pages/CartPage.dart';
import 'package:food_order/Screens/ProfileScreen.dart';
import 'package:food_order/Utils/FirebaseAuth.dart';
import 'package:food_order/Utils/database.dart';
import 'package:food_order/styleGuide.dart';
import 'package:provider/provider.dart';

class DetailFood extends StatefulWidget {
  final Food food;

  const DetailFood({Key key, this.food}) : super(key: key);
  @override
  _DetailFoodState createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  String sizeSelected = 'M';
  int addSelected = 0;
  int itemCount = 1;

  final AuthService _auth = AuthService();
  final DatabaseService _database = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.food.name,
                  style: kSubHeadTextStyle,
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: Align(
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
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Salami, Chilli ppepers, tomatoes, oregano, basil',
              style: ktextStyle,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\$${widget.food.price.toString()}',
                          style: kheadTextStyle),
                      SizedBox(
                        height: 50,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(text: 'Calories', style: ktextStyle),
                          TextSpan(text: '\n'),
                          TextSpan(
                              text: widget.food.calories.toString(),
                              style: ktextStyle),
                        ]),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(text: 'Weight', style: ktextStyle),
                          TextSpan(text: '\n'),
                          TextSpan(
                              text: widget.food.weight.toString(),
                              style: ktextStyle),
                        ]),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(text: 'Delivery', style: ktextStyle),
                          TextSpan(text: '\n'),
                          TextSpan(text: '34 Min', style: ktextStyle),
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      height: 250,
                      width: 280,
                      child: Image.network(
                        widget.food.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60,
                        width: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.food.size.length,
                          itemBuilder: (context, index) {
                            String sizeV = widget.food.size[index];
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sizeSelected = widget.food.size[index];
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        sizeSelected == widget.food.size[index]
                                            ? kprimaryColor
                                            : Color(0xffF1F4F9),
                                  ),
                                  child: Align(
                                    child: Text(
                                      sizeV,
                                      style: ktextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
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
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffF1F4F9),
                          ),
                          child: Align(
                            child: Text(
                              itemCount.toString(),
                              style: ktextStyle,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              addSelected = 0;

                              itemCount++;
                            });
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
                color: kprimaryColor,
                borderRadius: BorderRadius.circular(10),
                child: MaterialButton(
                  height: 60,
                  minWidth: 200,
                  onPressed: () {
                    Item item = Item(
                      food: widget.food,
                      quantity: itemCount,
                      size: sizeSelected,
                      itemPrice: widget.food.price,
                    );
                    Provider.of<CartProvider>(context, listen: false)
                        .addCartItem(item);
                  },
                  child: Text(
                    'Add to cart',
                    style: ktextStyleWhite,
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
