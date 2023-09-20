import 'package:flutter/material.dart';
class ForgotPassword extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 160,),
            Container(
              height: 150,
              width: 150,
              child: Image.asset('assets/images/forgotPassword.png'),
            ),
            SizedBox(height: 11,),
            Container(
              child: Text(
                'Forgot Password?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: "PTSans"),
              ),
            ),
            SizedBox(height: 20,),
            Form(child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(
                        color: Colors.deepPurple.shade400,
                        width: 2,
                      ),
                    ),
                    label: Text('E-Mail'), hintText: 'E-Mail',
                    prefixIcon: Icon(Icons.mail_outline_rounded)
                  ),
                ),
                SizedBox(height: 20.0,),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){},
                    child: Text('Next')),)
              ],
            ))
          ],
        ),
      ),
    );
  }

}