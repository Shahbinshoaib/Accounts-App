import 'package:accounts/authenticate/auth.dart';
import 'package:accounts/authenticate/authenticate.dart';
import 'package:accounts/screens/wrapper%202.dart';
import 'package:accounts/services/database.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return either home or authenticate
    if (user == null){
      return Authenticate();
    } else {
      return StreamProvider<Company>.value(
        value: DatabaseService(gmail: user.email).companyData,
          child: Wrapper2()
      );
    }
  }
}
