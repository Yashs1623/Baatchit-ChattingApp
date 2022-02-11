import 'package:baatchit/components/rounded_button.dart';
import 'package:baatchit/constants.dart';
import 'package:baatchit/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool loading = false;
  late AnimationController controller;
  late Animation<Color?> colortweenanimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync:
          this, //ticker (this -> yehi same class k obj ko represent krta hai and wo ticker hai)
    );
    colortweenanimation =
        ColorTween(begin: Colors.black87, end: Colors.black38)
            .animate(controller);
    // controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/baatchit.jpg'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  autofocus: true,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                    labelText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                    labelText: 'Password',
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  color: Colors.lightBlueAccent,
                  title: 'Log In',
                  onPressed: () {
                    setState(() {
                      controller.repeat(period: Duration(seconds: 2));
                      controller.addListener(() {
                        setState(() {});
                        // print(controller.value);
                      });
                      loading = true;
                    });

                    final existingUser = _auth.signInWithEmailAndPassword(
                        email: email, password: password);

                    try {
                      if (existingUser != null) {
                        setState(() {
                          loading=false;
                        });
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    } catch (e) {
                      print(e);
                    }
                    print(email);
                    print(password);
                    // print("Testing");
                  },
                ),
              ],
            ),
            if (loading)
              Center(
                child: Container(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: colortweenanimation,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
