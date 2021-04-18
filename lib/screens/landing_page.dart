import 'package:fbk_clone/config/palette.dart';
import 'package:fbk_clone/screens/login_page.dart';
import 'package:fbk_clone/screens/nav_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child:
                    Text("Something went wrong" + snapshot.error.toString()));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, authsnapshot) {
                if (authsnapshot.hasError) {
                  return Center(
                    child: Text(authsnapshot.error.toString()),
                  );
                }

                if (authsnapshot.connectionState == ConnectionState.active) {
                  User _currUser = authsnapshot.data;

                  if (_currUser == null) {
                    return LoginPage();
                  } else {
                    return NavScreen();
                  }

                }

                return SplashScreenUI();
              },
            );
          }
          return SplashScreenUI();
        },
      ),
    );
  }
}

class SplashScreenUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/fblogo.png",
            color: Palette.facebookBlue,
            scale: 8.0,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 24.0),
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            "assets/fb_footer.jpg",
            scale: 2.0,
          ),
        )
      ],
    );
  }
}
