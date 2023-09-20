import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_vet_care/model/chat_doctor.dart';
import 'package:smart_vet_care/model/chat_messages_model.dart';
import 'package:smart_vet_care/screen/LoginScreen.dart';

import '../Widget/custom_message.dart';
import '../model/chat_user.dart';
import '../screen/doctor_screens/DocBottomNav.dart';
import '../screen/pet_owner_screens/BottomNav.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  RxBool loadingUserSignup = false.obs;
  RxBool loadingDoctorSignup = false.obs;
  RxBool loadingUserlogin = false.obs;

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static ChatUser me = ChatUser(
      image: user.photoURL.toString(),
      uid: user.uid,
      firstname: user.displayName.toString(),
      isOnline: false,
      userName: '',
      email: user.email.toString(),
      lastname: '');

  static ChatDoctor docme = ChatDoctor(
      speciality: '',
      uid: user.uid,
      firstname: user.displayName.toString(),
      hosptialName: '',
      isOnline: false,
      userName: '',
      email: user.email.toString(),
      lastname: '',
      image: user.photoURL.toString());

  static User get user => auth.currentUser!;

  CollectionReference<Map<String, dynamic>> firebaseFirestore =
      FirebaseFirestore.instance.collection('doctors');

  CollectionReference<Map<String, dynamic>> firebaseFirestoreuser =
      FirebaseFirestore.instance.collection('users');

  String errormessage = '';
  String errormessageLogin = '';

  Future<void> userSignup(
    String email,
    String password,
    String fname,
    String lname,
    String userName,
  ) async {
    try {
      loadingUserSignup.value = true;
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => firebaseFirestoreuser.doc(value.user!.uid).set({
                "firstname": fname,
                "lastname": lname,
                "userName": userName,
                "email": email,
                "uid": auth.currentUser!.uid,
              }))
          .then((value) async {
        Get.offAll(() => BottomNav());
      });
      loadingUserSignup.value = false;
    } on FirebaseAuthException catch (e) {
      errormessage = e.message!;
      CustomMessage.cutomToastMsg(
          title: 'Error', error: errormessage, color: Colors.red);
      loadingUserSignup.value = false;
    }
  }

  Future<void> doctorSignup(
    String email,
    String password,
    String fname,
    String dob,
    String speciality,
    String hosptialName,
    String lname,
    String userName,
  ) async {
    try {
      loadingDoctorSignup.value = true;
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => firebaseFirestore.doc(value.user!.uid).set({
                "firstname": fname,
                "lastname": lname,
                "userName": userName,
                "email": email,
                'speciality': speciality,
                'hosptialName': hosptialName,
                "uid": auth.currentUser!.uid,
              }))
          .then((value) async {
        Get.offAll(() => const DoctorNavBar());
      });
      loadingDoctorSignup.value = false;
    } on FirebaseAuthException catch (e) {
      errormessage = e.message!;
      CustomMessage.cutomToastMsg(
          title: 'Wrong email or password!', error: errormessage, color: Colors.red.shade800);
      loadingDoctorSignup.value = false;
    }
  }

  Future<void> userLogin(String email, String password) async {
    try {
      loadingUserlogin.value = true;
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.offAll(() => BottomNav());
        loadingUserlogin.value = false;
      });
    } on FirebaseAuthException catch (e) {
      errormessage = e.message!;
      CustomMessage.cutomToastMsg(
          icon: const Icon(Icons.error),
          title: 'Wrong email or password!',
          error: errormessageLogin,
          color: Colors.red.shade800);
      loadingUserlogin.value = false;
    }
  }

  Future<void> doctorLogin(String email, String password) async {
    try {
      loadingUserlogin.value = true;
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.offAll(() => const DoctorNavBar());
        loadingUserlogin.value = false;
      });
    } on FirebaseAuthException catch (e) {
      errormessage = e.message!;
      CustomMessage.cutomToastMsg(
          icon: const Icon(Icons.error),
          title: 'Error',
          error: errormessageLogin,
          color: Colors.red);
      loadingUserlogin.value = false;
    }
  }

  //for getting all doctors from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllDocInfo() {
    return firestore
        .collection('doctors')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  static Future<void> createDoctor() async {
    final doc = ChatDoctor(
        speciality: '',
        uid: user.uid,
        firstname: user.displayName.toString(),
        hosptialName: '',
        isOnline: false,
        userName: '',
        email: user.email.toString(),
        lastname: '',
        image: user.photoURL.toString());
    return await firestore
        .collection('doctors')
        .doc(user.uid)
        .set(doc.toJson());
  }

  //for getting current doctors
  static Future<void> getSelfDocInfo() async {
    await firestore.collection('doctors').doc(user.uid).get().then((user) {
      if (user.exists) {
        docme = ChatDoctor.fromJson(user.data()!);
        log('My Data: ${user.data()}');
      } else {
        createDoctor().then((value) => getSelfDocInfo());
      }
    });
  }

  //for getting current users
  static Future<void> getSelfUserInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        log('My Data: ${user.data()}');
      } else {
        createUser().then((value) => getSelfUserInfo());
      }
    });
  }

  //for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUserInfo() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  static Future<void> createUser() async {
    final chatUser = ChatUser(
        image: user.photoURL.toString(),
        uid: user.uid,
        firstname: user.displayName.toString(),
        isOnline: false,
        userName: '',
        email: user.email.toString(),
        lastname: '');
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  //for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatDoctor doctor) {
    return firestore
        .collection('doctors')
        .where('id', isEqualTo: doctor.uid)
        .snapshots();
  }

  //update user online status
  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore
        .collection('doctors')
        .doc(user.uid)
        .update({'isOnline': isOnline});
  }

  static String getConversationId(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  //for sending and receiving messages from user side
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUserMessages(
      ChatDoctor doctor) {
    return firestore
        .collection('chats/${getConversationId(doctor.uid)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  //get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastUserMessages(
      ChatDoctor doctor) {
    return firestore
        .collection('chats/${getConversationId(doctor.uid)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  static Future<void> sendUserMessage(ChatDoctor doctor, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final Message message = Message(
        msg: msg,
        toId: doctor.uid,
        read: '',
        type: Type.text,
        sent: time,
        fromId: user.uid);

    final ref = firestore
        .collection('chats/${getConversationId(doctor.uid)}/messages/');
    await ref.doc().set(message.toJson());
  }

  // for sending and receiving messages from doctor side
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllDocMessages(
      ChatUser chatUser) {
    return firestore
        .collection('chats/${getConversationId(chatUser.uid)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastDocMessages(
      ChatUser chatUser) {
    return firestore
        .collection('chats/${getConversationId(chatUser.uid)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  static Future<void> sendDocMessage(ChatUser chatUser, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final Message message = Message(
        msg: msg,
        toId: chatUser.uid,
        read: '',
        type: Type.text,
        sent: time,
        fromId: user.uid);

    final ref = firestore
        .collection('chats/${getConversationId(chatUser.uid)}/messages/');
    await ref.doc().set(message.toJson());
  }

  //update read status
  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationId(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  void sigOut() async {
    await auth.signOut();
    Get.offAll(const Login());
  }
}
