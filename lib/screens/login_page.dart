import 'package:fbk_clone/config/palette.dart';
import 'package:fbk_clone/screens/create_account_screen.dart';
import 'package:fbk_clone/utils/firebaseutils.dart';
import 'package:fbk_clone/utils/other_utils.dart';
import 'package:fbk_clone/widgets/custom_input.dart';
import 'package:fbk_clone/widgets/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Responsive(
        mobile: LoginPageMobile(deviceHeight: deviceHeight),
        desktop: LoginPageDesktop());
  }
}

class LoginPageMobile extends StatefulWidget {
  final deviceHeight;

  const LoginPageMobile({Key key, this.deviceHeight}) : super(key: key);

  @override
  _LoginPageMobileState createState() => _LoginPageMobileState();
}

class _LoginPageMobileState extends State<LoginPageMobile>
    with SingleTickerProviderStateMixin {
  Animation logoAnimation, inputBoxAnimation;
  AnimationController animationController;
  String email, password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    logoAnimation = Tween(
            begin: widget.deviceHeight * 0.45, end: widget.deviceHeight * 0.62)
        .animate(CurvedAnimation(
            parent: animationController,
            curve: Interval(0.2, 1.0, curve: Curves.easeInOutExpo)))
          ..addListener(() {
            setState(() {});
          });
    inputBoxAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.easeInOut)))
      ..addListener(() {
        setState(() {});
      });

    animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: RichText(
            text: TextSpan(
                text: "मराठी · हिंदी · ",
                style: TextStyle(color: Colors.black54, fontSize: 18.0),
                children: <TextSpan>[
              TextSpan(
                  text: "More...",
                  style: TextStyle(color: Palette.facebookBlue, fontSize: 18.0))
            ])),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: inputBoxAnimation.value,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CustomInput(
                            hintText: "Phone number or email address",
                            onChanged: (value) {
                              setState(() {
                                // OtherUtils().registerEmail = value;
                                setState(() {
                                  email = value;
                                });
                              });
                            },
                            onSubmitted: (value) {
                              OtherUtils().passwordFocusNode.requestFocus();
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          CustomInput(
                            hintText: "Password",
                            onChanged: (value) {
                              password = value;
//                                OtherUtils().registerPassword = value;
                            },
                            focusNode: OtherUtils().passwordFocusNode,
                            isPasswordField: true,
                            onSubmitted: (value) {
                              setState(() {
                                password = value;
                              });
                              OtherUtils()
                                  .submitLoginForm(context, email, password);
                            },
                          ),
                          InkWell(
                            onTap: () {
                              OtherUtils()
                                  .submitLoginForm(context, email, password);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.blueAccent,
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Forgotten Password?",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.facebookBlue),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
                                height: 3.0,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 0.4,
                                )),
                            Text(
                              "OR",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12.0),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
                                height: 3.0,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 0.4,
                                )),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateAccountScreen(),
                              ));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 18.0),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Create New Facebook Account",
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0),
                            ),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: logoAnimation.value,
            left: MediaQuery.of(context).size.width * 0.4,
            // duration: Duration(milliseconds: 500),
            // curve: Curves.easeInOut,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/fblogo.png",
                color: Palette.facebookBlue,
                scale: 8.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoginPageDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.only(left: 100.0),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            "facebook",
                            style: const TextStyle(
                                color: Palette.facebookBlue,
                                fontSize: 68.0,
                                letterSpacing: -1.2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            'Facebook helps you connect and share with the people in your life.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 500.0),
                  padding: EdgeInsets.all(16.0),
                  height: MediaQuery.of(context).size.height * 0.6,
                  alignment: Alignment.center,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              CustomInputWeb(
                                hintText: "Email address or phone number",
                                onChanged: (value) {},
                                onSubmitted: (value) {
                                  OtherUtils().passwordFocusNode.requestFocus();
                                },
                                textInputAction: TextInputAction.next,
                              ),
                              CustomInputWeb(
                                hintText: "Password",
                                isPasswordField: true,
                                onChanged: (value) {
                                  // OtherUtils().registerPassword = value;
                                },
                                focusNode: OtherUtils().passwordFocusNode,
                                onSubmitted: (value) {
                                  // OtherUtils().submitLoginForm(context);
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  //OtherUtils().submitLoginForm(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Palette.facebookBlue,
                                  ),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Forgotten Password?",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.facebookBlue),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 3.0),
                              height: 2.0,
                              width: MediaQuery.of(context).size.width * 0.34,
                              child: Divider(
                                color: Colors.grey,
                                thickness: 0.4,
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateAccountScreen(),
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 18.0),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Create New  Account",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0),
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: "Create a Page ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                          children: <TextSpan>[
                            TextSpan(
                                text: "for a celebrity, band or business.",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w200))
                          ])),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*
Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Positioned.fill(
                  top: 40.0,
                  //left: MediaQuery.of(context).size.width*0.4,
                  child: Container(
                    child: Image.asset(
                      "assets/fblogo.png",
                      color: Palette.facebookBlue,
                      scale: 8.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomInput(
                      hintText: "Phone number or email address",
                      onChanged: (value) {
                        OtherUtils.registerEmail = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: "Password",
                      onChanged: (value) {
                        OtherUtils().registerPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value) {
                        _submitForm();
                      },
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.blueAccent,
                      ),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Forgotten Password?",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Palette.facebookBlue),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          height: 3.0,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.4,
                          )),
                      Text(
                        "OR",
                        style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          height: 3.0,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.4,
                          )),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Create New Facebook Account",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                    ),
                  )),
                )
              ],
            ),
          )
        ],
      )
 */
