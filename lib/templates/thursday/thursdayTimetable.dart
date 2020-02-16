import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:school/days_of_the_week.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school/route_generator.dart';


class Thursday extends StatefulWidget {
  @override
  _ThursdayState createState() => _ThursdayState();
}

class _ThursdayState extends State<Thursday> {
  static const double padding = 20.0;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Thursday', style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: Container(
          child: StreamBuilder(
            stream: getUserTimetableSnapshot(context),
            builder: (context, snapshot) {
              if(!snapshot.hasData)return Center(child: const Text('Loading...',
                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w300),));
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) =>
                      Slidable(
                        actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.20,
                          child: ThursdayCard(context, snapshot.data.documents[index]),
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
              );
            }
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: (() =>
            Navigator.of(context).pushNamed('/addThursdayTimetable'))
          ,
          backgroundColor: textColor,
          foregroundColor: boxColor,
          icon: Icon(Icons.add),
          label: Text('add'),
      ),)
    );


  }

  Stream<QuerySnapshot> getUserTimetableSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).authResult.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('thursday').snapshots();
  }

  Widget ThursdayCard(BuildContext context, DocumentSnapshot thursday) {

    return Container(

      child: Card(
        color: textColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Align(alignment: Alignment.topLeft,child: Text('${thursday['startTime']} - ${thursday['endTime']}', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300, color: boxColor),)),
              SizedBox(height: 30.0,),
              Align(alignment: Alignment.center,child: Text(thursday['course'], style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: boxColor),)),



            ],
          ),
        ),
      ),
    );
  }
}
