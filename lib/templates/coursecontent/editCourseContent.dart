import 'package:flutter/material.dart';
import 'package:school/shared/constant.dart';
import 'package:school/models/courses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school/route_generator.dart';

class EditCourseContent extends StatefulWidget {
  @override
  _EditCourseContentState createState() => _EditCourseContentState();
}

class _EditCourseContentState extends State<EditCourseContent> {
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  CourseContent data = CourseContent('', '', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Course Details', style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor: Colors.blue,

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
                    initialValue: data.courseTitle,
                    onChanged: (String value) {
                      data.courseTitle = value;
                    },
                    maxLines: 1,
                    decoration: textInputDecoration.copyWith(hintText: 'Course Title',
                    ),
                  ),
                  SizedBox(height: 30.0,),
                  TextFormField(
                    initialValue: data.courseCode,
                    onChanged: (String value) {
                      data.courseCode = value;
                    },
                    maxLines: 1,
                    decoration: textInputDecoration.copyWith(hintText: 'Course Code',
                    ),
                  ),
                  SizedBox(height: 30.0,),
                  TextFormField(
                    initialValue: data.courseContent,
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
                    color: Colors.blue,
                    child: Text('Save',
                      style: TextStyle(color: Colors.white),),
                    onPressed: () async {
                      this._formKey.currentState.save();
                      if(_formKey.currentState.validate()) {
                        final uid = await Provider.of(context).authResult.getCurrentUID();
                        await db.collection('userData').document(uid).collection('courseContent').document(uid).updateData(data.toJson());
                        Navigator.of(context).pushNamed('/subjects');
                      }
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
