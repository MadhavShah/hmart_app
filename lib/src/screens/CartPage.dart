import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hmart_app/src/shared/Order.dart';
import 'package:hmart_app/src/shared/buttons.dart';
import 'package:hmart_app/src/shared/colors.dart';
import 'package:hmart_app/src/shared/fryo_icons.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Order> items = [
    Order(
        name: "Coca-Cola",
        image: "images/6.png",
        price: "\$45.12",
        userLiked: true,
        discount: 2,
        quantity: 4),
    Order(
        name: "Lemonade",
        image: "images/5.png",
        price: "\$28.00",
        userLiked: false,
        discount: 5.2,
        quantity: 4),
    Order(
        name: "item 3",
        image: "images/6.png",
        price: "\$78.99",
        userLiked: false,
        quantity: 4),
    Order(
        name: "item 5",
        image: "images/6.png",
        price: "\$168.99",
        userLiked: true,
        discount: 3.4,
        quantity: 4)
  ];

  @override
  Widget build(BuildContext context) {
    String documentId = "8QE5n5d17ThW2JKt0UagkqVW05E2";
    CollectionReference users = FirebaseFirestore.instance.collection('Customer_Details');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("User  does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          if(data["Is_Brand"])
            return Center(child: Text('Brand hu Main'),);
          else return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:25,top:20.0,),
                      child: Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                  ],
                ),
                Column(
                  children: items
                      .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 6),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: primaryColor)),
                      child: ListTile(
                          leading: Container(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                item.image,
                                fit: BoxFit.fitHeight,
                              )),
                          title: Text(item.name),
                          isThreeLine: true,
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Price - ${item.price}"),
                              Text("savings - ${item.discount}%"),
                              Text("Quantity - ${item.quantity}"),
                            ],
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.delete_forever),
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  items.remove(item);
                                });
                              })),
                    ),
                  ))
                      .toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                items.length == 0
                    ? Center(
                  child: Text('Please Add the Product'),
                )
                    :  Container(
                  width: 200,
                  margin: EdgeInsets.only(bottom: 0),
                  child: froyoFlatBtn('Checkout', () {
                    String uid = "8QE5n5d17ThW2JKt0UagkqVW05E2";

                  }),
                )
              ],
            ),
          );
        }

        return Text("loading");
      },
    );
    return ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(color: primaryColor)),
          child: ListTile(
              leading: Container(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    items[index].image,
                    fit: BoxFit.fitHeight,
                  )),
              title: Text(items[index].name),
              isThreeLine: true,
              subtitle: Wrap(
                children: [
                  Text("Price - ${items[index].price}"),
                  Text("savings - ${items[index].discount}%"),
                  Text("Quantity - ${items[index].quantity}"),
                ],
              ),
              trailing: IconButton(
                  icon: Icon(Icons.delete_forever),
                  color: Colors.red,
                  onPressed: () {})),
        ),
      ),
      itemCount: items.length,
    );
  }
}
