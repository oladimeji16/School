import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:school/days_of_the_week.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school/route_generator.dart';


class Monday extends StatefulWidget {
  @override
  _MondayState createState() => _MondayState();
}

class _MondayState extends State<Monday> {
static const double padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: textColor,
          title: Text('Monday', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
                          child: MondayCard(context, snapshot.data.documents[index]),
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
                        ],),
              );
            }
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: (() =>
            Navigator.of(context).pushNamed('/addMondayTimetable'))
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
    yield* Firestore.instance.collection('userData').document(uid).collection('monday').snapshots();
  }

  Widget MondayCard(BuildContext context, DocumentSnapshot monday) {

    return Container(

      child: Card(
        color: textColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Align(alignment: Alignment.topLeft,child: Text('${monday['startTime']} - ${monday['endTime']}', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300, color: boxColor),)),
              SizedBox(height: 30.0,),
              Align(alignment: Alignment.center,child: Text(monday['course'], style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: boxColor),)),



            ],
          ),
        ),
      ),
    );
  }
}
