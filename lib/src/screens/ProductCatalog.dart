import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCatalog extends StatefulWidget {
  @override
  _ProductCatalogState createState() => _ProductCatalogState();
}

class _ProductCatalogState extends State<ProductCatalog> {
  List<Posts> postList = [];
  String uid;

  Future<List<Posts>> getPosts() async {
    //Getting list of following brands
    List<Posts> postList = [];
    CollectionReference users =
        FirebaseFirestore.instance.collection('Customer_Details');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("uid");
    DocumentSnapshot userSnapshot = await users.doc(uid).get();
    print(userSnapshot.data()['Following']);

    userSnapshot.data()['Following'].forEach((brandId) async {
      CollectionReference brands =
          FirebaseFirestore.instance.collection('Brand_Details');
      DocumentSnapshot snapshot = await brands.doc(brandId).get();
      print(brandId);
      print(snapshot.data());
      // postIds = snapshot.data()['posts'];

      snapshot.data()['posts'].forEach((postId) async {
        CollectionReference posts =
            FirebaseFirestore.instance.collection('Post_Details');
        DocumentSnapshot postSnapshot = await posts.doc(postId).get();
        String productId = postSnapshot.data()['Product_Id'];
        CollectionReference products =
            FirebaseFirestore.instance.collection('Product_Details');
        DocumentSnapshot productSnapshot = await products.doc(productId).get();
        // print(productSnapshot.data());

        Product product = new Product(
            productSnapshot.data()['Product_Image'],
            productSnapshot.data()['Product_Name'],
            double.parse(productSnapshot.data()['Price']),
            productSnapshot.data()['Brand_Id'],
            int.parse(productSnapshot.data()['Quantity_In_Stock']),
            productSnapshot.data()['Description']);
        // print(product.product_Image);
        Posts newPost = new Posts(
            product,
            productId,
            postSnapshot.data()['No_of_Comments'],
            postSnapshot.data()['No_of_Likes'],
            postSnapshot.data()['Comments'].cast<String>(),
            postSnapshot.data()['Likes'].cast<String>());
        postList.add(newPost);
        print(postList.length);
      });
    });
    print(postList.length);
    return postList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        else if (snapshot.connectionState == ConnectionState.done)
          {
            print(snapshot.data.toString());
            return Center(
              child: Text('DOne'),
            );
          }

        else
          return Center(
            child: Text('Error Occured'),
          );
      },
      future: getPosts(),
    );
  }
}

class Posts {
  Product product;
  String productId;
  int no_of_Comments = 0;
  int no_of_Likes = 0;
  List<String> comments = [];
  List<String> likes = [];

  Posts(this.product, this.productId, this.no_of_Comments, this.no_of_Likes,
      this.comments, this.likes);
}

class Product {
  String product_Image;
  String product_Name;
  double price;
  String brand_Id;
  int quantity_In_Stock;
  String description;

  Product(this.product_Image, this.product_Name, this.price, this.brand_Id,
      this.quantity_In_Stock, this.description);
}
