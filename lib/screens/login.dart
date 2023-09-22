import 'package:endeavour/constants/style.dart';
import 'package:endeavour/screens/homescreen.dart';
import 'package:endeavour/screens/signup.dart';
import 'package:endeavour/widgets/common_widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  var code = "";

  void signUserIn() async {
    //loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      Navigator.pop(context);
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      print(e.code);
      if (e.code == 'invalid-email') {
        showErrorMessage();
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        showErrorMessage();
      }
    }
  }

//wrong credential details........

  void showErrorMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(
            "Check your email/password",
            style: GoogleFonts.montserrat(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          icon: Icon(Icons.dangerous),
          alignment: Alignment.bottomCenter,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),

                //*Login Text and logo
                Column(
                  children: [
                    Image.asset("assets/logo.png"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Endeavour",
                          style: GoogleFonts.montserrat(
                              color: Style.tempColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 40),
                        ),
                        Text(
                          ".",
                          style: GoogleFonts.montserrat(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        ),
                      ],
                    ),
                    Text(
                      "ALL TOGETHER",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          letterSpacing: 10),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenWidth * 0.1,
                ),
                Container(
                  height: screenHeight * 0.55,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    border: Border.all(color: Style.tempColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Get Ready To Experience",
                          style: GoogleFonts.montserrat(
                            color: Style.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "A New Era Of Entertaintment",
                          style: GoogleFonts.montserrat(
                            color: Style.textColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: screenWidth * 0.01,
                        ),
                        Text(
                          "Log In.",
                          style: GoogleFonts.montserrat(
                            color: Style.tempColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),

                        //*Login Text Field
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "USERNAME",
                            style: GoogleFonts.montserrat(
                              color: Style.textColor,
                            ),
                          ),
                        ),
                        Container(
                          height: screenWidth * 0.1,
                          child: Center(
                            child: TextField(
                              textAlignVertical: TextAlignVertical.top,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              controller: email,
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(
                                    color: Style.tempColor,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(
                                    color: Style.tempColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "PASSWORD",
                            style: GoogleFonts.montserrat(
                              color: Style.textColor,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: screenWidth * 0.1,
                            child: TextField(
                              textAlignVertical: TextAlignVertical.top,
                              controller: password,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(
                                    color: Style.tempColor,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(
                                    color: Style.tempColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        //* sub text forget password and new user
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                textAlign: TextAlign.end,
                                "FORGET PASSWORD?",
                                style: GoogleFonts.montserrat(
                                  color: Style.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                        //*button
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20),
                            //button here
                            child: MyButton(
                              onTap: signUserIn,
                              text: "LOG IN",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenWidth * 0.1,
                        ),

                        //*sign up
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  textAlign: TextAlign.end,
                                  "NEW USER? SIGN IN",
                                  style: GoogleFonts.montserrat(
                                      color: Style.textColor, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
