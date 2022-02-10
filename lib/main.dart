import 'package:flutter/material.dart';
import 'package:baatchit/screens/welcome_screen.dart';
import 'package:baatchit/screens/login_screen.dart';
import 'package:baatchit/screens/registration_screen.dart';
import 'package:baatchit/screens/chat_screen.dart';

void main() => runApp(BaatChit());

class BaatChit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
        ),
      ),
      // home: WelcomeScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/chat': (context) => ChatScreen()
      },
    );
  }
}
