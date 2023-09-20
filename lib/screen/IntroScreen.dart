import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_vet_care/screen/doctor_screens/DoctorSignUpScreen.dart';
import 'package:smart_vet_care/screen/pet_owner_screens/PetOwnerSignUpScreen.dart';


class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Vet Care'),
      ),
      body: Center(
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 200,),
                  Container(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/images/doctorLogo1.jpg')),
                  SizedBox(height: 11,),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorSignup(),));
                      },
                      child: Text('Doctor', style: TextStyle(fontSize: 16,),), ),

                  SizedBox(height: 20,),

                  Container(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/images/petOwnerLogo.jpg')),

                  ElevatedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PetOwnerSignUp(),));
                  },
                      child: Text('Pet Owner', style: TextStyle(fontSize: 16,),),),
                ],
              ),
            ),
        ],),
      ),
    );
  }
}
