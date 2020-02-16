import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:school/days_of_the_week.dart';
import 'package:school/route_generator.dart';
import 'auth/auth_services.dart';


const String testDevice = '';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  AdmobInterstitial _admobInterstitial;

  @override
  void initState() {
    _admobInterstitial = createAd();
    super.initState();
  }
  AdmobInterstitial createAd() {
    return AdmobInterstitial(
      adUnitId: "ca-app-pub-2196105075165486/7585268759",
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if(event == AdmobAdEvent.loaded)  {
          _admobInterstitial.show();
        } else if(event == AdmobAdEvent.closed){
          _admobInterstitial.dispose();
        }
      }
    );

  }


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: textColor,
        appBar: AppBar(
          backgroundColor: boxColor,
            title: Text('School', style: TextStyle(color: textColor),),
          iconTheme: IconThemeData(color: textColor),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(accountName: null, accountEmail: null,),
              Padding(
                padding: EdgeInsets.only(top: 20,),
              ),
              GestureDetector(
                onTap: () {
                  prefix0.Navigator.pop(context);
                  Navigator.of(context).pushNamed('/convertUser');
                },
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.user,
                    color: textColor,
                  ),
                  title: Text('Update Profile', style: TextStyle(color: textColor),),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/timetable');
                },
                child: ListTile(
                  leading: Container(height: 25,width: 25,child: Image.asset('images/time.jpg')),
                  title: Text('Timetables', style: TextStyle(color: textColor),),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/subjects');
                },
                child: ListTile(
                  leading: Container(height: 25,width: 25,child: Image.asset('images/subjects.jpg')),
                  title: Text('Course Details', style: TextStyle(color: textColor),),
                ),
              ),
              Divider(),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      try {
                        AuthService auth = Provider
                            .of(context)
                            .authResult;
                        await auth.signOut();
                        print('Signed Out');
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.doorOpen,
                        color: textColor,
                      ),
                      title: Text('Logout', style: TextStyle(color: textColor),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/timetable');
                  },
                  child: ReUsableCard(
                    colour: boxColor,
                    cardChild: Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Image(
                              height: (_height * 0.17),
                              width: (_width * 0.20),
                              image: AssetImage('images/time.jpg'),
                            ),
                          ),
                          Text('Timetable',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: textColor,),
                          )
                        ],
                      ),
                    ),
                  ),
                ),),
              Padding(
                padding: const EdgeInsets.all(08.0),
                child: AdmobBanner(adUnitId: "ca-app-pub-2196105075165486/6357330450",
                  adSize: AdmobBannerSize.BANNER,
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    _admobInterstitial.load();
                    Navigator.of(context).pushNamed('/subjects');
                  },
                  child: ReUsableCard(
                    colour: boxColor,
                    cardChild: Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Image(
                                height: (_height * 0.17),
                                width: (_width * 0.20),
                                image: AssetImage('images/subjects.jpg')),

                          ),
                          Text('Course Details',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: textColor,),
                          )
                        ],
                      ),
                    ),),
                )
                ,),
              Padding(
                padding: const EdgeInsets.all(08.0),
                child: AdmobBanner(adUnitId: "ca-app-pub-2196105075165486/6357330450",
                    adSize: AdmobBannerSize.BANNER,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

class ReUsableCard extends StatelessWidget {
  ReUsableCard({@required this.colour, this.cardChild,});

  final Color colour;
  final Widget cardChild;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 200.0,
      child: cardChild,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(10.0),
      ),

    );
  }



}
