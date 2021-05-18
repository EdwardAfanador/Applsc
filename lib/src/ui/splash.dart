import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: new BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple[300], Colors.purple[900]],
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter)),
              child: Image.asset("assets/images/Logo.png"),
            )
          ],
        ),
      ),
    );
  }
}
