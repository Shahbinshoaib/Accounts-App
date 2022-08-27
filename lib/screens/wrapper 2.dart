import 'package:accounts/screens/home.dart';
import 'package:accounts/screens/realHome.dart';
import 'package:accounts/services/database.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'realHome.dart';

class Wrapper2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final company = Provider.of<Company>(context) ;

    // return either home or authenticate
    if (company == null){
      return Home();
    } else {
      return RealHome(company: company,);
    }
  }
}
