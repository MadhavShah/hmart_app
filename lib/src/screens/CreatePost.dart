import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hmart_app/src/shared/colors.dart';
import 'package:hmart_app/src/shared/inputFields.dart';
import 'package:hmart_app/src/shared/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String product_Image;

  // String product_Name;
  int price;

  // String brand_Id;
  // String quantity_In_Stock;
  // String description;
  int no_of_Comments = 0;
  int no_of_Likes = 0;
  String uid;
  String pid;
  List<String> comments = [];
  List<String> likes = [];
  File _imageFile;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController productNameController =
      new TextEditingController();
  final TextEditingController priceController = new TextEditingController();
  final TextEditingController descriptionController =
      new TextEditingController();
  final TextEditingController quantityInStockController =
      new TextEditingController();

  Future<void> updateBrandIdPostList(String postId) async{
    CollectionReference brands =
        FirebaseFirestore.instance.collection('Brand_Details');
    DocumentSnapshot snapshot = await brands.doc(uid).get() ;
    print(snapshot.toString());
    print(snapshot.data());

    if(snapshot.data()==null){
      return brands.doc(uid).set({
        'Posts' : [postId]
      });
    } else
      return brands.doc(uid).update({
      'Posts': FieldValue.arrayUnion([postId])
    });
  }

  Future<void> addPost(pid) {
    CollectionReference post_Details =
        FirebaseFirestore.instance.collection('Post_Details');
    // Call the user's CollectionReference to add a new user
    return post_Details.add({
      'Product_Id': pid, // John Doe
      'No_of_Comments': no_of_Comments, // Stokes and Sons
      'No_of_Likes': no_of_Likes,
      'Comments': comments,
      'Likes': likes
    }).then((value) {
      print("Post Added");
      updateBrandIdPostList(value.id);
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> createProduct() {
    CollectionReference product_Details =
        FirebaseFirestore.instance.collection('Product_Details');
    product_Details
        .add({
          'Product_Name': productNameController.text, // John Doe
          'Product_Image': product_Image, // Stokes and Sons
          'Price': priceController.text,
          'Brand_Id': uid,
          'Quantity_In_Stock': quantityInStockController.text,
          'Description': descriptionController.text // 42
        })
        .then((value) => {print("User Added"), pid = value.id, addPost(pid)})
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                Text('Create the Post', style: h3),
                Text('Let\'s get started', style: taglineText),
                martTextInput('Product Name',
                    controller: productNameController),
                martNumberInput('Price', controller: priceController),
                martNumberInput('Quantity',
                    controller: quantityInStockController),
                martTextInput('Description', controller: descriptionController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upload Image',
                      style: h3,
                    ),
                    IconButton(
                        icon: Icon(Icons.image),
                        onPressed: () async {
                          final picker = ImagePicker();
                          final pickedFile = await picker.getImage(
                            source: ImageSource.gallery,
                          );

                          setState(() {
                            _imageFile = File(pickedFile.path);
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      onPressed: () async {
                        try {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          setState(() {
                            uid = prefs.getString("uid");
                          });
                          await FirebaseStorage.instance
                              .ref(
                                  '${uid}/products/${productNameController.text}')
                              .putFile(_imageFile);
                          String downloadURL = await FirebaseStorage.instance
                              .ref(
                                  '${uid}/products/${productNameController.text}')
                              .getDownloadURL();
                          setState(() {
                            product_Image = downloadURL;
                          });
                          await createProduct();
                          print(downloadURL);
                        } on FirebaseException catch (e) {
                          print(e);
                          // e.g, e.code == 'canceled'
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
    );
  }
}
