import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seba_admin/widgets/home_screen/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late BuildContext _context;
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), (() {
      Navigator.pushReplacement(
        _context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 300,
          height: 200,
          child: Image.asset('assets/welcome.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
