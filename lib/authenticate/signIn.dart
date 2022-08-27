
import 'package:accounts/authenticate/auth.dart';
import 'package:accounts/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}



class _SignInState extends State<SignIn> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 2), vsync: this,);
  }

  final AuthService _auth = AuthService();
  bool loader = false;
  bool circle = false;
  String email = '';
  String password = '';
  String error = '';
  String gError = '';
  
  AnimationController _controller;


  @override
  void dispose(){
    super.initState();
    this._controller.dispose();
  }
  
  Widget _buildLoginBtn() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
          width: MediaQuery.of(context).size.width*0.65,
          child: GoogleSignInButton(
            borderRadius: 50.0,
            splashColor: Colors.purple[900],
            onPressed: () async {
              _controller.forward();
              setState(() {
                circle = false;
              });
              dynamic result = await _auth.signInWithGoogle();
              if (result == null){
                _controller.forward();
                setState(() {
                  gError = 'Could Not Sign In With Google';
                  circle = false;
                });
              } else{

              }
            },
             darkMode: true, // default: false
          ),
        ),
        SizedBox(height: 10.0,),
        Text(
          error,
          style: TextStyle(color: Colors.red, fontSize: 14.0),
        ),
      ],
    );
  }




  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    return loader ? Loader() : Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(child: Image.asset('assets/up2.jpg',fit: BoxFit.cover,),width: w,),
            Container(
              height: h,
              width: w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: h*0.281),
                  Text('Accu',style: TextStyle(fontWeight: FontWeight.bold,fontSize: h*0.1,fontFamily: 'Oxanium',color: Colors.black),textAlign: TextAlign.center,),
                  //Image.asset('assets/fp.jpg',height: h*0.08,),
                  SizedBox(height: h*0.05),
                  // Image.asset('assets/quiz.gif',height: h*0.25,),
                  SizedBox(height: h*0.047),
                  _buildLoginBtn(),
                  Text('YOUR FINANCE ON YOUR FINGERTIPS',style: TextStyle(fontWeight: FontWeight.bold,fontSize: h*0.018,fontFamily: 'Oxanium',color: Colors.black)),
                  Container(child: Image.asset('assets/sky.gif',fit: BoxFit.cover,),width: w,height: h*0.35,),

                  //Image.asset('assets/teal.jpg',height: h*0.338,fit: BoxFit.fitWidth,width: w,),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
