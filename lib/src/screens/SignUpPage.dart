import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hmart_app/src/ApiCall/Auth.dart';
import 'package:hmart_app/src/screens/BrandOrCustomer.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/inputFields.dart';
import 'package:page_transition/page_transition.dart';
import './SignInPage.dart';
import './Dashboard.dart';

class SignUpPage extends StatefulWidget {
  final String pageTitle;

  SignUpPage({Key key, this.pageTitle}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController pinCodeController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController contactController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          title: Text('Sign Up',
              style: TextStyle(
                  color: Colors.grey, fontFamily: 'Poppins', fontSize: 15)),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                // Navigator.of(context).pushReplacementNamed('/signin');
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: SignInPage()));
              },
              child: Text('Sign In', style: contrastText),
            )
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Welcome to H-Mart', style: h3),
                    Text('Let\'s get started', style: taglineText),
                    martTextInput('Full Name', controller: nameController),
                    martNumberInput('Phone No.', controller: contactController),
                    martEmailInput('Email Address',
                        controller: emailController),
                    martPasswordInput('Password',
                        controller: passwordController),
                    martNumberInput('Pincode', controller: pinCodeController),
                    martTextInput('Address', controller: addressController),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              print(nameController.text);
                              print(emailController.text);
                              print(passwordController.text);
                              print(contactController.text);
                              print(addressController.text);
                              try {
                                String uid = await Authentication
                                    .signUpUsingEmailPassword(
                                        emailController.text,
                                        passwordController.text);
                                try {
                                  CollectionReference users = FirebaseFirestore
                                      .instance
                                      .collection('Customer_Details');
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  String uid = "";
                                  if (auth.currentUser != null) {
                                    uid = auth.currentUser.uid;
                                  }
                                  users
                                      .doc(uid)
                                      .set({
                                        'Name': nameController.text, // John Doe
                                        'Email_Id': emailController.text, // Stokes and Sons
                                        'Address': addressController.text, // 42
                                        'Phone_No': contactController.text,
                                        'Is_Brand': false,
                                        'Pincode': pinCodeController.text,
                                    'Following' : []
                                      })
                                      .then((value) => print("User Added"))
                                      .catchError((error) =>
                                          print("Failed to add user: $error"));
                                } catch (e) {
                                  print("in user addition error");
                                  print(e);
                                }
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: BrandOrCustomer()));
                              } catch (e) {
                                print('in catch block');
                                print(e);
                              }
                            }
                          },
                          color: primaryColor,
                          padding: EdgeInsets.all(13),
                          shape: CircleBorder(),
                          child: Icon(Icons.arrow_forward, color: white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              // height: 490,

              width: double.infinity,
              decoration: authPlateDecoration,
            ),
          ],
        ));
  }
}
