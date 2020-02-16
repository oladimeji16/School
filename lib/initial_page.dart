import 'package:flutter/material.dart';
import 'package:school/days_of_the_week.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:school/shared/custom_dialog.dart';

class InitialView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: textColor,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: _height * 0.25,),
                  AutoSizeText('Welcome', style: TextStyle(fontSize: 44.0, color: boxColor), maxLines: 1,),
                  SizedBox(height: _height * 0.030,),
                  AutoSizeText('Let\'s start scheduling your study time',
                    style: TextStyle(
                      fontSize: 28.0, color: boxColor,),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: _height * 0.020,),
                  RaisedButton(
                    color: boxColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.00)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 30.0, left: 30.0),
                      child: Text('Get Started', style: TextStyle(color: textColor, fontSize: 28.0, fontWeight: FontWeight.w200),),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog(
                            title: "Would you like to create a new account?",
                            description: "With an account, your data will be secured savely, allowing you to access it from multiple devices.",
                            primaryButtonText: "Create My Account",
                            primaryButtonRoute: "/signUp",
                            secondaryButtonText: "Maybe Later?",
                            secondaryButtonRoute: "/signinAnon",
                          ),
                      );
                    },
                  ),
                  SizedBox(height: _height * 0.030,),
                  FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.00)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 30.0, left: 30.0),
                      child: Text('Sign In', style: TextStyle(color: boxColor, fontSize: 25.0, fontWeight: FontWeight.w200),),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/signIn');

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
