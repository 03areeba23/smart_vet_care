import 'package:flutter/material.dart';

import 'doctor_screens/DoctorSignUpScreen.dart';
import 'pet_owner_screens/PetOwnerSignUpScreen.dart';

class SignupIntro extends StatelessWidget {
  const SignupIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              height: 430,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                image: const DecorationImage(
                  image: NetworkImage('https://www.sgu.edu/blog/veterinary/wp-content/uploads/sites/3/2018/06/258728_8-Things-You-Should-Know-Before-Becoming-a-Veterinarian_horiz.gif',),
                  fit: BoxFit.cover,
                )
              ),
              child: Container(
                height: 430,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white24,
              ),
                child: Container(
                  alignment: Alignment.center,
                  height: 70,
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorSignup(),));
                  },
                      child: const Text('Doctor', style: TextStyle(fontSize: 24),),
                  ),
                ),
              ),
            ),
            Container(
              height: 430,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  image: const DecorationImage(
                    image: NetworkImage('https://th.bing.com/th/id/R.3f19e320440db97d422d4b8dc54a958b?rik=Kzzsar5MQrj12A&pid=ImgRaw&r=0',),
                    fit: BoxFit.cover,
                  )
              ),
              child: Container(
                height: 430,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white10,
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 70,
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PetOwnerSignUp(),));
                  },
                    child: const Text('Pet Owner', style: TextStyle(fontSize: 24),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
