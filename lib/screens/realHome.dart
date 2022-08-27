import 'package:accounts/services/database.dart';
import 'package:flutter/material.dart';
import 'package:accounts/authenticate/auth.dart';
import 'package:provider/provider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:flutter/services.dart';
import 'package:spring/enum.dart';
import 'package:spring/spring.dart';
import 'package:accounts/pages/customerManagement.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RealHome extends StatefulWidget {

  final Company company;
  RealHome({Key key, this.company}) : super(key: key);

  @override
  _RealHomeState createState() => _RealHomeState();
}

class _RealHomeState extends State<RealHome>
    with SingleTickerProviderStateMixin{

  final Duration animationDuration = Duration(milliseconds: 800);
  final Duration delay = Duration(milliseconds: 100);
   GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  GlobalKey rectGetterKey2 = RectGetter.createGlobalKey();
  GlobalKey rectGetterKey3 = RectGetter.createGlobalKey();
  GlobalKey rectGetterKey4 = RectGetter.createGlobalKey();

  dynamic result;
  final CloudStorageService _cloudStorageService = CloudStorageService();

  @override
  void initState()  {
    result = _cloudStorageService.downloadImage(widget.company.logo);
    print(result.toString());
    super.initState();
    }


  Rect rect ;

  void _onTap() async {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
      rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }
  void _onTap2() async {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey2));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
      rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }
  void _onTap3() async {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey3));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
      rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }
  void _onTap4() async {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey4));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
      rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }


  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: CustomerManagement()))
        .then((_) => setState(() => rect = null));
  }
  
  // void _onTap(){
  //   setState(() {
  //     rect = RectGetter.getRectFromKey(rectGetterKey);
  //   });
  //   Navigator.of(context).push(FadeRouteBuilder(page: NewPage()));
  // }
  double _offeset = 0;

  double get offset => _offeset;

  set offset(double offeset) {
    if(offeset < 500)
      setState(() {
        _offeset = offeset;
      });
  }

  AnimationController controller;
  ClampingScrollSimulation simulation;



  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    final user = Provider.of<User>(context);

    final drawerHeader = UserAccountsDrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFF008080),
                Color(0xFF006666),

              ])
      ),
      accountName: Text(user.username ?? '',style: TextStyle(color: Colors.white),),
      accountEmail: user.email == 'focusspoint@gmail.com' ? Text('Admin') : null,
      currentAccountPicture: CircleAvatar(
        radius: 40.0,
        backgroundImage: NetworkImage(user.photo ?? ''),
        backgroundColor: Colors.transparent,
      ),
    );
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    _showBottomSheet() {
      showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Container(
                child: ListTile(
                  title: Text("Sales Invoice"),
                  leading: Icon(Icons.attach_money,color: Colors.teal,),
                ),
              ),
              Container(
                child: ListTile(
                  title: Text("Purchase Invoice"),
                  leading: Icon(Icons.file_copy,color: Colors.teal,),
                ),
              ),
              Container(
                child: ListTile(
                  title: Text("Journal Voucher"),
                  leading: Icon(Icons.wysiwyg,color: Colors.teal,),
                ),
              ),
            ],
          ),

        );
      }
      );
    }

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.white,

            elevation: 0,
            actions: [
              CircleAvatar(
                //radius: 70.0,
                backgroundImage: NetworkImage(result.toString()),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(width: 15,),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.teal[600],
                      Colors.blue[600],
                    ])
            ),
            height: h*0.92,
            child: SingleChildScrollView(
              child: Container(
                height: h*0.91,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: h*0.05,),
                    Builder(
                      builder: (context) {
                        final GlobalKey<SlideActionState> _key = GlobalKey();
                        final _key2 = GlobalKey<SpringState>();
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              _key2.currentState.animate(motion: Motion.Play);
                            },
                            child: RectGetter(
                              key: rectGetterKey,
                              child: SlideAction(
                                key: _key,
                                height: h*0.07,
                                outerColor: Colors.white70,
                                borderRadius: h*0.1,
                                sliderButtonIcon: Spring(
                                    key: _key2,
                                    delay: Duration(milliseconds: 0),
                                    animType: AnimType.Shake,
                                    motion: Motion.Pause,
                                    animDuration: Duration(milliseconds: 200),
                                    animStatus: (status) => print(status),
                                    curve: Curves.elasticInOut,
                                    child: Icon(Icons.supervisor_account,color: Colors.teal,)),
                                innerColor: Colors.white,
                                sliderButtonIconPadding: h*0.035,
                                elevation: 8,
                                sliderButtonIconSize: h*0.04,
                                submittedIcon: Icon(Icons.stream,color: Colors.white,),
                                animationDuration: Duration(milliseconds: 200),
                                child: Text('               Customer Management',style: TextStyle(fontSize: h*0.022,color: Colors.teal[800],fontFamily: 'Oxanium',fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                                sliderButtonYOffset: -10,
                                onSubmit: ()
                                {
                                  _onTap();
                                  Future.delayed(
                                    Duration(seconds: 1),
                                        () => _key.currentState.reset(),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: h*0.05,),
                    Builder(
                      builder: (context) {
                        final GlobalKey<SlideActionState> _key3 = GlobalKey();
                        final _key4 = GlobalKey<SpringState>();
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              _key4.currentState.animate(motion: Motion.Play);
                            },
                            child: RectGetter(
                              key: rectGetterKey2,
                              child: SlideAction(
                                key: _key3,
                                height: h*0.07,
                                outerColor: Colors.white70,
                                borderRadius: h*0.1,
                                sliderButtonIcon: Spring(
                                    key: _key4,
                                    delay: Duration(milliseconds: 0),
                                    animType: AnimType.Shake,
                                    motion: Motion.Pause,
                                    animDuration: Duration(milliseconds: 200),
                                    animStatus: (status) => print(status),
                                    curve: Curves.elasticInOut,
                                    child: Icon(Icons.airport_shuttle,color: Colors.teal)),
                                innerColor: Colors.white,
                                sliderButtonIconPadding: h*0.035,
                                elevation: 8,
                                sliderButtonIconSize: h*0.04,
                                submittedIcon: Icon(Icons.stream,color: Colors.white,),
                                animationDuration: Duration(milliseconds: 200),
                                child: Text('               Supplier Management',style: TextStyle(fontSize: h*0.022,color: Colors.teal[800],fontFamily: 'Oxanium',fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                                sliderButtonYOffset: -10,
                                onSubmit: ()
                                {
                                  _onTap2();
                                  Future.delayed(
                                    Duration(seconds: 1),
                                        () => _key3.currentState.reset(),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: h*0.05,),
                    Builder(
                      builder: (context) {
                        final GlobalKey<SlideActionState> _key5 = GlobalKey();
                        final _key6 = GlobalKey<SpringState>();
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              _key6.currentState.animate(motion: Motion.Play);
                            },
                            child: RectGetter(
                              key: rectGetterKey3,
                              child: SlideAction(
                                key: _key5,
                                height: h*0.07,
                                outerColor: Colors.white70,
                                borderRadius: h*0.1,
                                sliderButtonIcon: Spring(
                                    key: _key6,
                                    delay: Duration(milliseconds: 0),
                                    animType: AnimType.Shake,
                                    motion: Motion.Pause,
                                    animDuration: Duration(milliseconds: 200),
                                    animStatus: (status) => print(status),
                                    curve: Curves.elasticInOut,
                                    child: Icon(Icons.trending_up,color: Colors.teal)),
                                innerColor: Colors.white,
                                sliderButtonIconPadding: h*0.035,
                                elevation: 8,
                                sliderButtonIconSize: h*0.04,
                                submittedIcon: Icon(Icons.stream,color: Colors.white,),
                                animationDuration: Duration(milliseconds: 200),
                                child: Text('               Product Management',style: TextStyle(fontSize: h*0.022,color: Colors.teal[800],fontFamily: 'Oxanium',fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                                sliderButtonYOffset: -10,
                                onSubmit: ()
                                {
                                  _onTap3();
                                  Future.delayed(
                                    Duration(seconds: 1),
                                        () => _key5.currentState.reset(),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: h*0.05,),
                    Builder(
                      builder: (context) {
                        final GlobalKey<SlideActionState> _key7 = GlobalKey();
                        final _key8 = GlobalKey<SpringState>();
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              _key8.currentState.animate(motion: Motion.Play);
                            },
                            child: RectGetter(
                              key: rectGetterKey4,
                              child: SlideAction(
                                key: _key7,
                                height: h*0.07,
                                outerColor: Colors.white70,
                                borderRadius: h*0.1,
                                sliderButtonIcon: Spring(
                                    key: _key8,
                                    delay: Duration(milliseconds: 0),
                                    animType: AnimType.Shake,
                                    motion: Motion.Pause,
                                    animDuration: Duration(milliseconds: 200),
                                    animStatus: (status) => print(status),
                                    curve: Curves.elasticInOut,
                                    child: Icon(Icons.attach_money,color: Colors.teal)),
                                innerColor: Colors.white,
                                sliderButtonIconPadding: h*0.035,
                                elevation: 8,
                                sliderButtonIconSize: h*0.04,
                                submittedIcon: Icon(Icons.stream,color: Colors.white,),
                                animationDuration: Duration(milliseconds: 200),
                                child: Text('  Other Accounts',style: TextStyle(fontSize: h*0.022,color: Colors.teal[800],fontFamily: 'Oxanium',fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                                sliderButtonYOffset: -10,
                                onSubmit: ()
                                {
                                  _onTap4();
                                  Future.delayed(
                                    Duration(seconds: 1),
                                        () => _key7.currentState.reset(),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          drawer: Container(
            width: w*0.55,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  drawerHeader,
                  ListTile(
                    leading: Icon(Icons.trending_up),
                    title: Text('Profit and Loss Account'),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => SubSu(),
                      // ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.assessment),
                    title: Text('Balance Sheet'),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => SubRe(),
                      // ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.wysiwyg),
                    title: Text('Trial Balance'),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => About(),
                      // ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Ledger'),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => SubSu(),
                      // ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.point_of_sale),
                    title: Text('Sales Book'),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => SubRe(),
                      // ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.monetization_on),
                    title: Text('Purchase Book'),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => About(),
                      // ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.bar_chart),
                    title: Text('Chart of Accounts'),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => SubSu(),
                      // ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.get_app_outlined),
                    title: Text('Outstanding Receivable'),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => SubRe(),
                      // ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.upload_outlined),
                    title: Text('Outstanding Payable'),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => About(),
                      // ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('LOGOUT'),
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                        //_showlogoutDialog();
                      });
                    },
                  ),
                  user.email == 'shahbinshoaib@gmail.com' ? ListTile(
                    leading: Icon(Icons.security),
                    title: Text('Admin Panel'),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => Youtubers(),
                      // ));
                    },
                  ): Container(),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(Icons.more_horiz,color: Colors.teal,),
            mini: true,
            autofocus: true,
            onPressed: (){
              _showBottomSheet();
            },
          ),
        ),
        _ripple(),
      ],
    );
  }
  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: <Color>[
            //       Colors.teal[600],
            //       Colors.blue[600],
            //     ]),
          color: Colors.white,
          shape: BoxShape.circle
        ),
      ),
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
    pageBuilder: (context, animation1, animation2) => page,
    transitionsBuilder: (context, animation1, animation2, child) {
      return FadeTransition(opacity: animation1, child: child);
    },
  );
}

class CloudStorageService{


  StorageReference reference = FirebaseStorage.instance.ref();


  Future deleteImage(String image) async{
    final StorageReference reference = FirebaseStorage.instance.ref().child(image);
    try{
      await reference.delete();
    } catch(e){
      return e.toString();
    }
  }

  Future downloadImage(String picture) async{
    try{
      String downloadAddress = await reference.child('images/${picture}.png').getDownloadURL();
      return downloadAddress;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}