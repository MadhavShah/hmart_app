import 'package:flutter/material.dart';
import 'package:hmart_app/src/screens/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BrandOrCustomer extends StatefulWidget {
  @override
  _BrandOrCustomerState createState() => _BrandOrCustomerState();
}

class _BrandOrCustomerState extends State<BrandOrCustomer> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> isBrand;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isBrand = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('isBrand');
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return const CircularProgressIndicator();
        default:
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Dashboard(isBrand: true,);
          }
      }
    },future: isBrand,);
  }
}
