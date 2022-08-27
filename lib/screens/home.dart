import 'dart:io';

import 'package:accounts/authenticate/auth.dart';
import 'package:accounts/loader.dart';
import 'package:accounts/screens/realHome.dart';
import 'package:accounts/services/database.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();


  final _formkey = GlobalKey<FormState>();
  String _validateName(String value) {
    if (value.isEmpty)
      return 'This is required';
  }

  File _imageFile;

  final FirebaseStorage _storage = FirebaseStorage(
      storageBucket: 'gs://accounts-manager-20ed2.appspot.com/');


  Future<void> _pickImage(ImageSource source) async{
    // ignore: deprecated_member_use
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }


  void _clear(){
    setState(() {
      _imageFile = null;
    });
  }

  int _state = 1;
  StorageUploadTask _uploadTask;

  final snackBar = SnackBar(content: Text('Question added'));
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  DateTime date;
  String _cName ;
  String _phone ;
  String _cEmail ;
  String _country = 'Pakistan';
  String _type;
  String _address;
  String _currency;
  int _pin;
  bool loader = false;
  String _selectedDate;
  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980,8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _selectedDate = '${selectedDate.toLocal()}'.split(' ')[0];
        print(_selectedDate);

      });
  }

  final List<String> type = ['General Billing & Accounting','Accounting/Financial Services',
    'Automobile','Book Store','Computer/Hardware Store','Mobile Store','Consultant/Doctor/Lawyer/Professional','Manufacturing'
  ,'Pharma/Chemist','Personal Accounts','Retail/Supermarket/Grocery/Wholesale','Contract Accounting','Others'];

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    Future<void> _showlogoutDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Logout'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure you want to logout?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL', style: TextStyle(color: Colors.blue),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('LOGOUT', style: TextStyle(color: Colors.red),),
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }




    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy.MM.dd').format(now);
    dynamic currentTime = DateFormat.Hms().format(DateTime.now());
    String _date = '$formattedDate-$currentTime';
    String filePath;

    return loader ? Loader() : Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(child: Image.asset('assets/up.jpg',fit: BoxFit.cover,),width: w,),
              Container(
                height: h,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          SizedBox(height: h*0.08,),
                          Text('REGISTER YOUR COMPANY',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,fontFamily: 'Oxanium',color: Colors.black)),
                          SizedBox(height: h*0.03,),
                          Container(
                            width: 140,
                            height: 140,
                            child: _imageFile == null ?
                            RaisedButton(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_a_photo,color: Colors.teal,size: 30,),
                                  SizedBox(height: 10,),
                                  Text('Company Logo',style: TextStyle(color: Colors.teal,fontSize: 15),),
                                ],
                              ),
                              color: Colors.white,
                              elevation: 10.0,
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(455.0)),
                              onPressed: () {
                                _pickImage(ImageSource.gallery);
                              },
                            ) :
                            Stack(
                              children: [
                                GestureDetector(
                                  child: Hero(
                                      tag: '',
                                      child: CircleAvatar(
                                        radius: 70.0,
                                        backgroundImage: FileImage(_imageFile),
                                        backgroundColor: Colors.transparent,
                                      ),),
                                  onTap: () => _showZoomImage(context),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: new IconButton(
                                    icon: Icon(Icons.delete_forever,color: Colors.teal,size: 50,),
                                    onPressed: (){
                                      setState(() {
                                        _imageFile = null;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: h*0.015,),
                          TextFormField(
                            validator: _validateName,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.add_business_sharp),
                              labelText: 'Company Name',
                            ),
                            onChanged: (value){
                              setState(() {
                                _cName = value;
                              });
                            },
                          ),
                          SizedBox(height: h*0.025,),
                          CountryListPick(
                            // if you need custome picker use this
                            pickerBuilder: (context, CountryCode countryCode){
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        countryCode.flagUri,
                                        package: 'country_list_pick',height: h*0.025,
                                      ),
                                      SizedBox(width: 15,),
                                      Text(countryCode.name),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Divider(thickness: 1.0,color: Colors.black45,),
                                ],
                              );
                            },
                            initialSelection: '+92',
                            // To disable option set to false
                            theme: CountryTheme(
                              isShowFlag: true,
                              isShowTitle: true,
                              isDownIcon: true,
                              showEnglishName: true,
                            ),
                            // Set default value
                            onChanged: (CountryCode code) {
                              setState(() {
                                _country = code.name;
                              });
                              print(code.name);
                              print(code.code);
                              print(code.dialCode);
                              print(code.flagUri);
                            },
                          ),
                          SizedBox(height: h*0.00,),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.datetime,
                            initialValue: _selectedDate,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.date_range),
                              hintText: _selectedDate ?? 'Financial Year From',
                              suffix: IconButton(
                                onPressed: (){
                                  _selectDate(context);
                                },
                                icon: Icon(Icons.date_range),
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                _selectedDate = value;
                              });
                            },
                          ),
                          SizedBox(height: h*0.01,),
                          DropdownButtonFormField(
                            validator: _validateName,
                            decoration: InputDecoration(
                              labelText: 'Business Type',
                            ),
                            value: _type,
                            items: type.map((course) {
                              return DropdownMenuItem(
                                value: course,
                                child: Text('$course'),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _type = val;
                              });
                            },
                          ),
                          SizedBox(height: h*0.01,),
                          TextFormField(
                            validator: _validateName,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.smartphone),
                              labelText: 'Phone Number',
                            ),
                            onChanged: (value){
                              setState(() {
                                _phone = value;
                              });
                            },
                          ),
                          SizedBox(height: h*0.01,),
                          TextFormField(
                            validator: _validateName,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.email),
                              labelText: 'Email Id',
                            ),
                            onChanged: (value){
                              setState(() {
                                _cEmail = value;
                              });
                            },
                          ),
                          SizedBox(height: h*0.01,),
                          TextFormField(
                            validator: _validateName,
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.home),
                              labelText: 'Address',
                            ),
                            onChanged: (value){
                              setState(() {
                                _address = value;
                              });
                            },
                          ),
                          SizedBox(height: h*0.01,),
                          TextFormField(
                            validator: _validateName,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.attach_money),
                              labelText: 'Currency Unit (INR,\$,PKR,NPR,GBP) ',
                            ),
                            onChanged: (value){
                              setState(() {
                                _currency = value;
                              });
                            },
                          ),
                          SizedBox(height: h*0.01,),
                          TextFormField(
                            validator: _validateName,
                            obscureText: true,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.security),
                              labelText: '4 digit Pin',
                            ),
                            onChanged: (value){
                              setState(() {
                                _pin = int.parse(value);
                              });
                            },
                          ),
                          SizedBox(height: h*0.02,),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
        onPressed: ()async{
          if(_formkey.currentState.validate()){
            print('fdgsgs');
            setState(() {
              filePath = 'images/${_date}-${_cName}.png';
              _uploadTask = _storage.ref().child(filePath).putFile(_imageFile);
              loader = true;
            });
            print('hello');
            await DatabaseService().updateCompanyData('${_date}-${_cName}', _cName, _country, _selectedDate, _type, _phone, _cEmail, _address, _currency, _pin, user.email, user.username, user.photo);
            Navigator.of(context).push(RealHome1());
            setState(() {
              loader = false;
            });
          }
        },
      ),
    );
  }
  void _showZoomImage(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => Scaffold(
            body: Hero(
              tag: '',
              child: PhotoView(
                imageProvider: FileImage(_imageFile),
                maxScale: 10.0,
              ),
              //child: Image.file(_imageFile),
            ),
          ),
        )
    );
  }
}
class RealHome1 extends MaterialPageRoute<Null> {
  RealHome1()
      : super(builder: (BuildContext context) {


    return Scaffold(

      body: RealHome(),
    );
  });
}
