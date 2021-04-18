import 'package:fbk_clone/config/palette.dart';
import 'package:fbk_clone/utils/other_utils.dart';
import 'package:fbk_clone/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("www.facebook.com",
            style: TextStyle(color: Palette.facebookBlue, fontSize: 18.0)),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
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
                            email = value;
                          },
                          onSubmitted: (value) {
                            email = value;

                            //    OtherUtils().passwordFocusNode.requestFocus();
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        CustomInput(
                          hintText: "Password",
                          onChanged: (value) {
                            password = value;
                          },
                         // focusNode: OtherUtils().passwordFocusNode,
                          isPasswordField: true,
                          onSubmitted: (value) {
                            password = value;

                            OtherUtils()
                                .submitCreateAccForm(context, email, password);
                          },
                        ),
                        InkWell(
                          onTap: () {
                            OtherUtils()
                                .submitCreateAccForm(context, email, password);
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
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.62,
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
