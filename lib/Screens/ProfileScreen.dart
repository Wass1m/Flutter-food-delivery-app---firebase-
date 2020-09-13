import 'package:flutter/material.dart';
import 'package:food_order/Models/user.dart';
import 'package:food_order/Utils/FirebaseAuth.dart';
import 'package:food_order/Utils/database.dart';
import 'package:food_order/styleGuide.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _globalProfileKet = GlobalKey<FormState>();

  final AuthService _auth = AuthService();
  bool loading = false;
  TextEditingController _addressController = TextEditingController();
  TextEditingController _firstController = TextEditingController();
  TextEditingController _lastController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    final DatabaseService _database = DatabaseService(uid: user.uid);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Form(
                  key: _globalProfileKet,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          'It seems that we don\'t know you yet',
                          style: kheadTextStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildFirstName(),
                        SizedBox(
                          height: 20,
                        ),
                        buildLastName(),
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

                                    await _database.createProfile(
                                        _firstController.text,
                                        _lastController.text,
                                        _addressController.text);

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
                                  }
                                },
                                child: loading
                                    ? CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        strokeWidth: 3,
                                      )
                                    : Text(
                                        'Create Profile',
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
          hintText: 'Enter your Address',
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

  Padding buildFirstName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        onChanged: (value) {},
        controller: _firstController,
        validator: (value) {
          if (value.isEmpty) return 'Should not be empty';

          return null;
        },
        decoration: InputDecoration(
          errorText: '',
          hintText: 'Enter your First Name',
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

  Padding buildLastName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        onChanged: (value) {},
        controller: _lastController,
        validator: (value) {
          if (value.isEmpty) return 'Should not be empty';

          return null;
        },
        decoration: InputDecoration(
          errorText: '',
          hintText: 'Enter your Last Name',
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
