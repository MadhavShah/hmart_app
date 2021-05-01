import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class Authentication {
  static Future<String> signUpUsingEmailPassword(String email, String password) async{
    await Firebase.initializeApp();
    // FirebaseAuth auth = FirebaseAuth.instance;
    // FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
    // FirebaseAuth auth = FirebaseAuth.instanceFor(app: secondaryApp);
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential.user.uid;
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  static Future<String> signInUsingEmailPassword(String email, String password)async{
    await Firebase.initializeApp();
    print('initialized');
    try {
      print(email);
      print(password);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      print('done');
      // Map<String,dynamic> responseData = jsonDecode(userCredential);
      // print(responseData);
      return userCredential.user.uid;
      // print();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      print(e);
    }
  }
}