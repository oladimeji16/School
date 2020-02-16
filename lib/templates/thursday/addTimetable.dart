import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:school/days_of_the_week.dart';
import 'package:school/shared/constant.dart';
import 'package:school/models/courses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school/route_generator.dart';

class AddThursdayTimetable extends StatefulWidget {
  @override
  _AddThursdayTimetableState createState() => _AddThursdayTimetableState();
}

class _AddThursdayTimetableState extends State<AddThursdayTimetable> {
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  Courses data = Courses('', '', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Course', style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold,),),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    textAlign: TextAlign.center,
                    initialValue: data.start,
                    decoration: textInputDecoration.copyWith(hintText: 'Start Time'),
                    validator: (val) => val.isEmpty ? 'Enter start time of course' : null,
                    onSaved: (val) => setState(() => data.start = val ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(08.0),
                    child: AdmobBanner(adUnitId: "ca-app-pub-2196105075165486/6357330450",
                      adSize: AdmobBannerSize.BANNER,
                    ),
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    initialValue: data.end,
                    decoration: textInputDecoration.copyWith(hintText: 'End Time'),
                    validator: (val) => val.isEmpty ? 'Enter End time of course' : null,
                    onSaved: (val) => setState(() => data.end = val ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(08.0),
                    child: AdmobBanner(adUnitId: "ca-app-pub-2196105075165486/6357330450",
                      adSize: AdmobBannerSize.BANNER,
                    ),
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    initialValue: data.course,
                    decoration: textInputDecoration.copyWith(hintText: 'Course Code'),
                    validator: (val) => val.isEmpty ? 'Please enter course code' : null,
                    onSaved: (val) => setState(() => data.course = val ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(08.0),
                    child: AdmobBanner(adUnitId: "ca-app-pub-2196105075165486/6357330450",
                      adSize: AdmobBannerSize.BANNER,
                    ),
                  ),
                  RaisedButton(
                    color: textColor,
                    child: Text('Add',
                      style: TextStyle(color: Colors.white),),
                    onPressed: () async {
                      this._formKey.currentState.save();
                      if(_formKey.currentState.validate()) {
                        final uid = await Provider.of(context).authResult.getCurrentUID();
                        await db.collection('userData').document(uid).collection('thursday').add(data.toJson());
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
