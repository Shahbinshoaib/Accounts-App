import 'package:flutter/material.dart';
import 'package:country_list_pick/country_list_pick.dart';


class CustomerManagement extends StatefulWidget {
  @override
  _CustomerManagementState createState() => _CustomerManagementState();
}

class _CustomerManagementState extends State<CustomerManagement> {

  final _formkey = GlobalKey<FormState>();
  String _validateName(String value) {
    if (value.isEmpty)
      return 'This is required';
  }
  String _country;

  bool isBank = false;
  String _mode = 'Add';
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

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(child: Image.asset('assets/up4.jpg',fit: BoxFit.fill,),width: w,height: h,),
            ),
            _mode == 'Add' ?
            Container(
              height: h,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: h*0.05,),
                            Center(child: Text('CUSTOMER MANAGEMENT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,fontFamily: 'Oxanium',color: Colors.black))),
                            SizedBox(height: h*0.03,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RaisedButton(
                                  color: Colors.white,
                                  splashColor: Colors.white,
                                  child: Text('ADD CUSTOMER',style: TextStyle(color: Colors.teal),),
                                  onPressed: (){
                                    setState(() {
                                      _mode = 'Add';
                                    });
                                  },
                                  elevation: 5,
                                  shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(445.0)),
                                ),
                                RaisedButton(
                                  color: Colors.white70,
                                  splashColor: Colors.white70,
                                  child: Text('VIEW CUSTOMER',style: TextStyle(color: Colors.teal)),
                                  onPressed: (){
                                    setState(() {
                                      _mode = 'View';
                                    });
                                  },
                                  elevation: 5,
                                  shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(455.0)),
                                ),
                              ],
                            ),

                            SizedBox(height: h*0.02,),
                            TextFormField(
                              validator: _validateName,
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                icon: Icon(Icons.add_business_sharp),
                                labelText: 'Account Name',
                              ),
                              onChanged: (value){
                                setState(() {
                                  //_cName = value;
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
                                icon: Icon(Icons.monetization_on_outlined),
                                labelText: 'Opening Balance',
                              ),
                              onChanged: (value){
                                setState(() {
                               //   _cEmail = value;
                                });
                              },
                            ),
                            SizedBox(height: h*0.01,),
                            TextFormField(
                              validator: _validateName,
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.datetime,
                              initialValue: _selectedDate,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                icon: Icon(Icons.date_range),
                                hintText: _selectedDate ?? 'Account Creation Date',
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
                            SizedBox(height: h*0.015,),
                            isBank ?
                            RaisedButton(
                              color: Colors.white,
                              elevation: 0,
                              onPressed: (){
                                setState(() {
                                  isBank = !isBank;
                                });
                              },
                              child: Text('Bank Details',style: TextStyle(color: Colors.teal),),
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(445.0)),
                            )
                            :
                            RaisedButton(
                              color: Colors.white,
                              elevation: 5.0,
                              onPressed: (){
                                setState(() {
                                  isBank = !isBank;
                                });
                              },
                              child: Text('Bank Details',style: TextStyle(color: Colors.teal),),
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(445.0)),
                            ),
                            Divider(thickness: 1.5,),
                            isBank ?
                                Text('Hello')
                            :
                                Container(),
                            Divider(thickness: 1.5,),
                            SizedBox(height: h*0.015,),
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
                            TextFormField(
                              validator: _validateName,
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                icon: Icon(Icons.flag_outlined),
                                labelText: 'State',
                              ),
                              onChanged: (value){
                                setState(() {
                                  //   _cEmail = value;
                                });
                              },
                            ),SizedBox(height: h*0.01,),
                            TextFormField(
                              validator: _validateName,
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                icon: Icon(Icons.location_on),
                                labelText: 'Address',
                              ),
                              onChanged: (value){
                                setState(() {
                                  //   _cEmail = value;
                                });
                              },
                            ),SizedBox(height: h*0.01,),
                            TextFormField(
                              validator: _validateName,
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                icon: Icon(Icons.local_shipping),
                                labelText: 'Shipping Address',
                              ),
                              onChanged: (value){
                                setState(() {
                                  //   _cEmail = value;
                                });
                              },
                            ),
                            SizedBox(height: h*0.01,),
                            TextFormField(
                              validator: _validateName,
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                icon: Icon(Icons.phone_android),
                                labelText: 'Phone Number',
                              ),
                              onChanged: (value){
                                setState(() {
                                //  _address = value;
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
                                icon: Icon(Icons.email),
                                labelText: 'Email',
                              ),
                              onChanged: (value){
                                setState(() {
                                 // _tax = value;
                                });
                              },
                            ),
                            SizedBox(height: h*0.02,),
                            RaisedButton(
                              color: Colors.white,
                              splashColor: Colors.white,
                              child: Text('ADD',style: TextStyle(color: Colors.teal),),
                              onPressed: (){
                                setState(() {
                                  _mode = 'Add';
                                });
                              },
                              elevation: 5,
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(445.0)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ) :
            Container(
              height: h,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(height: h*0.05,),
                            Text('CUSTOMER MANAGEMENT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,fontFamily: 'Oxanium',color: Colors.black)),
                            SizedBox(height: h*0.03,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RaisedButton(
                                  color: Colors.white70,
                                  splashColor: Colors.white70,
                                  child: Text('ADD CUSTOMER',style: TextStyle(color: Colors.teal),),
                                  onPressed: (){
                                    setState(() {
                                      _mode = 'Add';
                                    });
                                  },
                                  elevation: 5,
                                  shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(445.0)),
                                ),
                                RaisedButton(
                                  color: Colors.white,
                                  splashColor: Colors.white,
                                  child: Text('VIEW CUSTOMER',style: TextStyle(color: Colors.teal)),
                                  onPressed: (){
                                    setState(() {
                                      _mode = 'View';
                                    });
                                  },
                                  elevation: 5,
                                  shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(455.0)),
                                ),
                              ],
                            ),
                            SizedBox(height: h*0.02,),
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
                                  //_cName = value;
                                });
                              },
                            ),
                            SizedBox(height: h*0.025,),
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
                                  // _phone = value;
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
                                  //   _cEmail = value;
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
                                  //   _cEmail = value;
                                });
                              },
                            ),SizedBox(height: h*0.01,),
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
                                  //   _cEmail = value;
                                });
                              },
                            ),SizedBox(height: h*0.01,),
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
                                  //   _cEmail = value;
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
                                  //  _address = value;
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
                                  // _tax = value;
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
                                  //   _tax = value;
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}