import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


const boxColor = Colors.white;
const textColor = Colors.lightBlue;
const grayColor =  Colors.blueGrey;

class DaysOfTheWeek extends StatefulWidget {

  @override
  _DaysOfTheWeekState createState() => _DaysOfTheWeekState();
}

class _DaysOfTheWeekState extends State<DaysOfTheWeek> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: boxColor,
        appBar: AppBar(
            centerTitle: true,
            title: Text('Days of the week', style: TextStyle(color: Colors.white),
            ),
        ),

         body: Column(
          children: <Widget>[
            Expanded(child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _admobInterstitial.load();
                      Navigator.of(context).pushNamed('/monday');
                    },
                    child: ReUsableCard(
                      colour: textColor,
                      cardChild: Center(
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage('images/monday.png'),
                            ),
                            SizedBox(height: 10.0,),
                            Text('Monday',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: boxColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _admobInterstitial.load();
                      Navigator.of(context).pushNamed('/tuesday');
                    },
                    child: ReUsableCard(
                      colour: textColor,
                      cardChild: Center(
                        child: Column(
                          children: <Widget>[

                            Image(
                              image: AssetImage('images/tuesday.png'),
                            ),
                            SizedBox(height: 10.0,),
                            Text('Tuesday',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: boxColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ),
            Padding(
              padding: const EdgeInsets.all(08.0),
              child: AdmobBanner(adUnitId: "ca-app-pub-2196105075165486/6357330450",
                adSize: AdmobBannerSize.BANNER,
              ),
            ),
            Expanded(child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _admobInterstitial.load();
                      Navigator.of(context).pushNamed('/wednesday');
                    },
                    child: ReUsableCard(
                      colour: textColor,
                      cardChild: Center(
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage('images/wednesday.png'),
                            ),
                            SizedBox(height: 10.0,),
                            Text('Wednesday',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: boxColor,

                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _admobInterstitial.load();
                      Navigator.of(context).pushNamed('/thursday');
                    },
                    child: ReUsableCard(
                      colour: textColor,
                      cardChild: Center(
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage('images/thursday.png'),
                            ),
                            SizedBox(height: 10.0,),
                            Text('Thursday',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: boxColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ),
            Padding(
              padding: const EdgeInsets.all(08.0),
              child: AdmobBanner(adUnitId: "ca-app-pub-2196105075165486/6357330450",
                adSize: AdmobBannerSize.BANNER,
              ),
            ),
            Expanded(child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _admobInterstitial.load();
                      Navigator.of(context).pushNamed('/friday');
                    },
                    child: ReUsableCard(
                      colour: textColor,
                      cardChild: Center(
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage('images/friday.png'),
                            ),
                            SizedBox(height: 10.0,),
                            Text('Friday',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: boxColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _admobInterstitial.load();
                      Navigator.of(context).pushNamed('/saturday');
                    },
                    child: ReUsableCard(
                      colour: textColor,
                      cardChild: Center(
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage('images/saturday.png'),
                            ),
                            SizedBox(height: 10.0,),
                            Text('Saturday',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: boxColor,

                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ),
          ],
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
      child: cardChild,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(10.0),
      ),

    );
  }
}

