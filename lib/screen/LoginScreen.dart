import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_vet_care/controllers/auth_controller.dart';
import 'package:smart_vet_care/screen/ForgotPassword.dart';
import 'package:smart_vet_care/screen/SignupIntroScreen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:smart_vet_care/screen/doctor_screens/DoctorSignUpScreen.dart';
import 'package:smart_vet_care/screen/pet_owner_screens/PetOwnerSignUpScreen.dart';

import '../Widget/custom_message.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController docusernameController = TextEditingController();
  TextEditingController docpasswordController = TextEditingController();

  final controller = Get.put(AuthController());

  get padding => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
              title: const Center(child: Text('Log In')),
              bottom: const TabBar(
                indicatorColor: Colors.deepPurple,
                tabs: [
                  Tab(icon: Icon(Icons.person), text: "Pet Owner"),
                  Tab(
                      icon: Icon(Icons.contact_emergency_rounded),
                      text: "Docotor")
                ],
              )),
          body: TabBarView(
            children: [
              Center(
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: Text(
                          'Smart Vet Care',
                          style: TextStyle(
                            color: Colors.deepPurple.shade400,
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                          ),
                        )),
                    /*Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Log In Pet Owner',
                          style: TextStyle(fontSize: 20),
                        )),*/
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple.shade400,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: Colors.deepPurple),
                              hintText:
                                  'Enter valid email ID as abc@gmail.com'),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "* Required"),
                            EmailValidator(errorText: "Enter valid email ID"),
                          ])),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: BorderSide(
                                color: Colors.deepPurple.shade400,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.deepPurple),
                            hintText: 'Enter secure password'),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          MinLengthValidator(6,
                              errorText:
                                  "Password should be at least 6 characters"),
                          MaxLengthValidator(15,
                              errorText:
                                  "Password should be no longer than 15 chracters")
                        ]),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //forgot password screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(fontSize: 16,color: Colors.deepPurple),
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 15,),
                          ),
                          onPressed: () async {
                            if (usernameController.text != '' ||
                                passwordController.text != '') {
                              await controller.userLogin(
                                  usernameController.text,
                                  passwordController.text);
                              SharedPreferences pre =
                                  await SharedPreferences.getInstance();
                              pre.setString("user", "role");
                            } else {
                              CustomMessage.cutomToastMsg(
                                  title: 'Error',
                                  error: 'Please fill all fields',
                                  color: Colors.red);
                            }
                          },
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Does not have account?'),
                        TextButton(
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 15, color: Colors.deepPurple),
                          ),
                          onPressed: () {
                            //signup screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PetOwnerSignUp()));
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),

              //docotr
              Center(
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          'Smart Vet Care',
                          style: TextStyle(
                            color: Colors.deepPurple.shade400,
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                          ),
                        )),
                    /*Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Log In Doctor',
                          style: TextStyle(fontSize: 20),
                        )),*/
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                          controller: docusernameController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple.shade400,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: Colors.deepPurple),
                              hintText:
                                  'Enter valid email ID as abc@gmail.com'),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "* Required"),
                            EmailValidator(errorText: "Enter valid email ID"),
                          ])),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: true,
                        controller: docpasswordController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: BorderSide(
                                color: Colors.deepPurple.shade400,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.deepPurple),
                            hintText: 'Enter secure password'),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          MinLengthValidator(6,
                              errorText:
                                  "Password should be at least 6 characters"),
                          MaxLengthValidator(15,
                              errorText:
                                  "Password should be no longer than 15 chracters")
                        ]),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //forgot password screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(color: Colors.deepPurple, fontSize: 16),
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () async {
                            if (docusernameController.text != '' ||
                                docpasswordController.text != '') {
                              await controller.doctorLogin(
                                  docusernameController.text,
                                  docpasswordController.text);
                              SharedPreferences pre =
                                  await SharedPreferences.getInstance();
                              pre.setString("doctor", "role");
                            } else {
                              CustomMessage.cutomToastMsg(
                                  title: 'Error',
                                  error: 'Please fill all fields',
                                  color: Colors.red);
                            }
                          },
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Does not have account?'),
                        TextButton(
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 15, color: Colors.deepPurple),
                          ),
                          onPressed: () {
                            //signup screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DoctorSignup()));
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
