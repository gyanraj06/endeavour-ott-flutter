// ignore_for_file: use_build_context_synchronously

import 'package:endeavour/constants/style.dart';
import 'package:endeavour/screens/homescreen.dart';
import 'package:endeavour/screens/login.dart';
import 'package:endeavour/widgets/common_widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    //loading circle
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userNameController.text,
          password: passwordController.text,
        );

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog.adaptive(
              
              title: Text(
                "Account Created, Log In Again!",
                style: GoogleFonts.montserrat(fontSize: 14),
                textAlign: TextAlign.center,

              ),
              icon: const Icon(Icons.done),
              alignment: Alignment.bottomCenter,
            );
          },
        );
      } else {
        //pass dont match
        showErrorMessage("Password don't match");
      }

      //Navigator.pop(context);
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      if (e.code == 'invalid-email') {
        showErrorMessage("Check your email/password");
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        showErrorMessage("Check your email/password");
      }
    }
  }

//wrong credential details........

  void showErrorMessage(message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(
            message,
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
                          "Sign Up.",
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
                          child: TextField(
                            textAlignVertical: TextAlignVertical.top,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            cursorColor: Style.textColor,
                            controller: userNameController,
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

                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "PASSWORD",
                            style: GoogleFonts.montserrat(
                              color: Style.textColor,
                            ),
                          ),
                        ),

                        Container(
                          height: screenWidth * 0.1,
                          child: TextField(
                            cursorColor: Style.textColor,
                            textAlignVertical: TextAlignVertical.top,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            controller: passwordController,
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

                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "CONFIRM PASSWORD",
                            style: GoogleFonts.montserrat(
                              color: Style.textColor,
                            ),
                          ),
                        ),

                        Container(
                          height: screenWidth * 0.1,
                          child: TextField(
                            cursorColor: Style.textColor,
                            textAlignVertical: TextAlignVertical.top,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            controller: confirmPasswordController,
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

                        //*button
                        Center(
                          child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              //button here
                              child: MyButton(
                                onTap: signUserUp,
                                text: "SIGN UP",
                              )),
                        ),
                        SizedBox(
                          height: screenWidth * 0.02,
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  textAlign: TextAlign.end,
                                  "ALREADY A USER? LOG IN",
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
