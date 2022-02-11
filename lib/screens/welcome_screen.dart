import 'package:baatchit/components/RoundedButton.dart';
import 'package:baatchit/screens/login_screen.dart';
import 'package:baatchit/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation, colortweenanimation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync:
          this, //ticker (this -> yehi same class k obj ko represent krta hai and wo ticker hai)
      upperBound: 1,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    // colortweenanimation = ColorTween(begin: Colors.black, end: Colors.white).animate(controller);   --> another type of animation to change colors
    controller.forward();

    controller.addStatusListener((status) {
      print(status);
      //below code is of : if we want to loop animation
      // if(status == AnimationStatus.completed)
      // {
      //   controller.reverse(from: 1.0);
      // }
      // else if(status==AnimationStatus.dismissed){
      //   controller.forward();
      // }
    });

    controller.addListener(() {
      setState(() {});
      // print(controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/baatchit.jpg'),
                    height: 100.0 * animation.value,
                  ),
                ),
                AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TypewriterAnimatedText('BaatChit',
                        speed: Duration(milliseconds: 100),
                        textStyle: TextStyle(
                            fontSize: 50.0, fontWeight: FontWeight.w900)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              title: 'Log In',
              onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
                print("Test");
              },
            ),
            RoundedButton(
              color: Colors.blueAccent,
              title: 'Register',
              onPressed: () {
                //Go to registration screen.
                print("Test2");
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
