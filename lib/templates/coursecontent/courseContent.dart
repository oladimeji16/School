import 'package:admob_flutter/admob_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:school/days_of_the_week.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school/models/courses.dart';
import 'package:school/route_generator.dart';


class Subjects extends StatefulWidget {
  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  final db = Firestore.instance;
  CourseContent data = CourseContent('', '', '');
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

  static const double padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Course Details', style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          child: StreamBuilder(
            stream: getUserTimetableSnapshot(context),
            builder: (context, snapshot) {
              if(!snapshot.hasData)return Center(child: const Text('Loading...',
                style: TextStyle(color: textColor, fontSize: 25, fontWeight: FontWeight.w300),));
              return Container(
                child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) =>
                        Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.20,
                            child: CourseContentCard(context, snapshot.data.documents[index]),
                          actions: <Widget>[
                            IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () async {
                                try{
                                  return await snapshot.data.documents[index].reference.delete();
                                } catch(e){
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(padding),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        AutoSizeText('Error deleting course details', style: TextStyle(color: grayColor,fontSize: 25.0), maxLines: 1, ),
                                        AutoSizeText('Please check internet connectivity', style: TextStyle(color: grayColor, fontSize: 25.0), maxLines: 1,),
                                      ],
                                    ),
                                  );
                                }

                              },
                            ),
                          ],
                        ),
                ),
              );
            }
          ),
        ),



        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _admobInterstitial.load();
            Navigator.of(context).pushNamed('/addCourseContent');
          },
          backgroundColor: textColor,
          foregroundColor: boxColor,
          icon: Icon(Icons.add),
          label: Text('add'),
      ),)
    );
  }

  Stream<QuerySnapshot> getUserTimetableSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).authResult.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('courseContent').snapshots();
  }

  Widget CourseContentCard(BuildContext context, DocumentSnapshot courseContent) {
    return Container(
      child: Card(
        color: textColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Align(alignment: Alignment.topCenter,
                  child: Text('${courseContent['courseCode']}',
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300, color: boxColor),)
              ),
              SizedBox(height: 30.0,),
              Align(alignment: Alignment.center,child: Text(courseContent['courseTitle'],
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: boxColor),)),
              SizedBox(height: 30.0,),
              Align(alignment: Alignment.bottomLeft,child: Text('${courseContent['courseContent']}',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300, color: boxColor),)),
            ]
          ),
        ),
      ),
    );
  }



}
