import 'package:flutter/material.dart';
import 'package:food_order/Utils/FirebaseAuth.dart';
import 'package:food_order/styleGuide.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _globalkey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();
  bool loading = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Form(
                  key: _globalkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 10),
                    child: Column(
                      children: [
                        Hero(
                          tag: 'LOGO',
                          child: Image.asset(
                            'assets/images/livreur.png',
                            height: 250,
                            width: 300,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildEmailField(),
                        SizedBox(
                          height: 20,
                        ),
                        buildPasswordField(),
                        SizedBox(
                          height: 20,
                        ),
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
                                  if (_globalkey.currentState.validate()) {
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
                                    dynamic result =
                                        await _auth.signInWithEmailandPassword(
                                            _emailController.text,
                                            _passwordController.text);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                      });
                                      print('login failed');
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                      print('login success');
                                      print(result);
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: loading
                                    ? CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        strokeWidth: 3,
                                      )
                                    : Text(
                                        'Login',
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

  Padding buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        onChanged: (value) {},
        controller: _passwordController,
        validator: (value) {
          if (value.isEmpty) return 'Password';
          if (value.length < 6) return 'Should be superior to 6 car';
          return null;
        },
        decoration: InputDecoration(
          errorText: '',
          hintText: 'Enter your password',
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

  Padding buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        onChanged: (value) {},
        controller: _emailController,
        validator: (value) {
          if (value.isEmpty) return 'Email cannot be empty';
          if (!value.contains('@')) return 'Email is invalid';
          return null;
        },
        decoration: InputDecoration(
          errorText: '',
          hintText: 'Enter your email',
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
