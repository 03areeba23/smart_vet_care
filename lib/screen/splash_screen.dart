import 'dart:async';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_vet_care/screen/LoginScreen.dart';

import 'doctor_screens/DocBottomNav.dart';
import 'pet_owner_screens/BottomNav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), checkUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Container(
            color: Colors.deepPurple.shade400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Center(
                    child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Image.asset('assets/images/logo1.png')),
                  ),
                ),
                const SizedBox(
                  height: 11,
                ),
                Center(
                  child: Center(
                    child: Container(
                      child: const Center(
                        child: Text(
                          'Smart Vet Care',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void checkUser() async {
  SharedPreferences pre = await SharedPreferences.getInstance();
  String user = pre.getString("user") ?? "";
  String doctor = pre.getString("doctor") ?? "";
  if (user != '') {
    Get.offAll(() => BottomNav());
  } else if (doctor != '') {
    Get.offAll(() => const DoctorNavBar());
  } else {
    Get.offAll(() => Login());
  }
}
