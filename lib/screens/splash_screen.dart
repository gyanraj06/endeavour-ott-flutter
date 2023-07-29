import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:endeavour/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "ENDEAVOUR",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                textStyle:
                    const TextStyle(color: Color.fromARGB(255, 254, 201, 25), fontSize: 45),
              ),
            ),
            Text(
              'WATCH THE BEST',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color(0xFFDBEDED),
                  letterSpacing: 2.5,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
