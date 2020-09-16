import 'package:flutter/material.dart';
import 'package:food_order/Models/profile.dart';
import 'package:food_order/Models/user.dart';
import 'package:food_order/Utils/FirebaseAuth.dart';
import 'package:food_order/Utils/database.dart';
import 'package:food_order/styleGuide.dart';
import 'package:provider/provider.dart';

class ChangeAddress extends StatefulWidget {
  final Profile profile;

  const ChangeAddress({Key key, this.profile}) : super(key: key);
  @override
  _ChangeAddressState createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  final _globalProfileKet = GlobalKey<FormState>();

  final AuthService _auth = AuthService();
  bool loading = false;
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    final DatabaseService _database = DatabaseService(uid: user.uid);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _globalProfileKet,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        Text(
                          'Would you like to change your address ? ',
                          style: kheadTextStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildAddress(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Material(
                              elevation: 2,
                              color: kprimaryColor,
                              borderRadius: BorderRadius.circular(15),
                              child: MaterialButton(
                                height: 70,
                                onPressed: () async {
                                  if (_globalProfileKet.currentState
                                      .validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    // dynamic result = await _auth.signInAnonym();
                                    // if (result == null) {
                                    //   print('login failed');
                                    // } else {
                                    //   print('login success');
                                    //   print(result.uid);
                                    //   Navigator.pop(context);
                                    // }

                                    await _database
                                        .updateProfile(_addressController.text);

                                    // if (result == null) {
                                    //   setState(() {
                                    //     loading = false;
                                    //   });
                                    //   print('profile failed');
                                    // } else {
                                    //   setState(() {
                                    //     loading = false;
                                    //   });
                                    //   print('profile success');
                                    //   print(result);
                                    // }
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                                child: loading
                                    ? CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        strokeWidth: 3,
                                      )
                                    : Text(
                                        'Change',
                                        style: kbuttonText,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        onChanged: (value) {},
        controller: _addressController,
        validator: (value) {
          if (value.isEmpty) return 'Should not be empty';

          return null;
        },
        decoration: InputDecoration(
          errorText: '',
          hintText: widget.profile.address,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }
}
