import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hmart_app/src/ApiCall/Auth.dart';
import 'package:hmart_app/src/screens/BrandOrCustomer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/inputFields.dart';
import 'package:page_transition/page_transition.dart';
import './SignUpPage.dart';
import './Dashboard.dart';

class SignInPage extends StatefulWidget {
  final String pageTitle;

  SignInPage({Key key, this.pageTitle}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = new TextEditingController(text: "hritik@test.com");
  final TextEditingController passwordController = new TextEditingController(text:"hritik123");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          title: Text('Sign In',
              style: TextStyle(
                  color: Colors.grey, fontFamily: 'Poppins', fontSize: 15)),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                // Navigator.of(context).pushReplacementNamed('/signup');
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: SignUpPage()));
              },
              child: Text('Sign Up', style: contrastText),
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
                    Text('Welcome Back!', style: h3),
                    Text('Howdy, let\'s authenticate', style: taglineText),
                    martTextInput('Username',controller: emailController),
                    martPasswordInput('Password',controller: passwordController),
                    FlatButton(
                      onPressed: () {},
                      child: Text('Forgot Password?', style: contrastTextBold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              try{
                                print('...............');
                                String uid = await Authentication.signInUsingEmailPassword(
                                    emailController.text,
                                    passwordController.text);
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.setString("uid", uid);
                                CollectionReference users = FirebaseFirestore.instance.collection('Customer_Details');
                                DocumentSnapshot snapshot = await users.doc(uid).get();
                                await prefs.setBool("isBrand", snapshot.data()['Is_Brand']);
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: BrandOrCustomer()));
                              } catch (e){
                                print("in Error Block");
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
                  ],
                ),
              ),
              // height: 300,
              width: double.infinity,
              decoration: authPlateDecoration,
            ),
          ],
        ));
  }
}
