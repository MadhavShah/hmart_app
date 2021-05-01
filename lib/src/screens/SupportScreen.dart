import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hmart_app/src/screens/ProductCatalog.dart';
class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {


  @override
  Widget build(BuildContext context) {
    return ProductCatalog();
  }
}
