import 'package:flutter/material.dart';
import 'package:login_demo/models/user.dart';
import 'package:login_demo/pages/authenticate.dart';
import 'package:login_demo/pages/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser>(context);


    //return Authenticate();
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
