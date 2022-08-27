import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String gmail;

  final CollectionReference companyCollection = Firestore.instance.collection('Company Data');

  DatabaseService({this.gmail});

  Future updateCompanyData(String logo, String cName, String country, String year, String type, String phone, String email, String address, String currency, int pin, String gmail, String name, String pic) async{
    return await companyCollection.document(gmail).setData({
      'Logo' : logo,
      'Company Name': cName,
      'Country' : country,
      'Year': year,
      'Type': type,
      'Phone': phone,
      'Email':email,
      'Address':address,
      'Currency':currency,
      'Pin':pin,
      'Gmail':gmail,
      'Name':name,
      'Pic':pic,
    });
  }



  Company _companyFromSnapshot(DocumentSnapshot snapshot){
      return Company(
        logo: snapshot.data['Logo'] ?? '',
        cName: snapshot.data['Company Name'] ?? '',
        country: snapshot.data['Country'] ?? '',
        year: snapshot.data['Year'] ?? '',
        type: snapshot.data['Type'] ?? '',
        phone:snapshot.data['Phone'] ?? '',
        email: snapshot.data['Email'] ?? '',
        address: snapshot.data['Address']?? '',
        currency: snapshot.data['Currency'] ?? '',
        pin: snapshot.data['Pin'] ?? '',
	      gmail: snapshot.data['Gmail'] ?? '',
	      name: snapshot.data['Name'] ?? '',
	      pic: snapshot.data['Pic'] ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/220px-User_icon_2.svg.png',
      );
  }


  Stream<Company> get companyData{
    return companyCollection.document(gmail).snapshots()
        .map(_companyFromSnapshot);
  }

}

class Company{

  final String logo;
  final String cName;
  final String country;
  final String year;
  final String type;
  final String phone;
  final String email;
  final String address;
  final String currency;
  final int pin;
  final String gmail;
  final String name;
  final String pic;

  Company({this.logo, this.cName, this.country, this.year, this.type, this.phone, this.email, this.address, this.currency, this.pin, this.gmail, this.name, this.pic});

}
