import 'package:flutter/material.dart';
import 'package:school/days_of_the_week.dart';
import 'package:school/shared/constant.dart';
import 'package:school/models/courses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school/route_generator.dart';

class AddCourseContent extends StatefulWidget {
  @override
  _AddCourseContentState createState() => _AddCourseContentState();
}

class _AddCourseContentState extends State<AddCourseContent> {
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  CourseContent data = CourseContent('', '', '');

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
                  TextField(
                    onChanged: (String value) {
                      data.courseTitle = value;
                    },
                    maxLines: 1,
                    decoration: textInputDecoration.copyWith(hintText: 'Course Title',
                    ),
                  ),
                  SizedBox(height: 30.0,),
                  TextField(
                    onChanged: (String value) {
                      data.courseCode = value;
                    },
                    maxLines: 1,
                    decoration: textInputDecoration.copyWith(hintText: 'Course Code',
                    ),
                  ),
                  SizedBox(height: 30.0,),
                  TextField(
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Roboto',
                    ),
                    onChanged: (String value) {
                      data.courseContent = value;
                    },
                    maxLines: 13,
                    decoration: textInputDecoration.copyWith(hintText: 'Course Content'),
                  ),
                  SizedBox(height: 30.0,),
                  RaisedButton(
                    color: textColor,
                    child: Text('Add',
                      style: TextStyle(color: Colors.white),),
                    onPressed: () async {
                      this._formKey.currentState.save();
                      if(_formKey.currentState.validate()) {
                        final uid = await Provider.of(context).authResult.getCurrentUID();
                        await db.collection('userData').document(uid).collection('courseContent').add(data.toJson());
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
