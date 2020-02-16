import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:school/days_of_the_week.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, primaryButtonText, primaryButtonRoute, secondaryButtonText, secondaryButtonRoute;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.primaryButtonRoute,
    @required this.primaryButtonText,
    this.secondaryButtonRoute,
    this.secondaryButtonText,
  });

  static const double padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
                color: boxColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(padding),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 10.0)
                  )
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 24.00,),
                AutoSizeText(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(height: 24.00,),
                AutoSizeText(
                  description,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(height: 24.00,),
                RaisedButton(
                  color: boxColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  child: AutoSizeText(
                    primaryButtonText,
                    maxLines: 1,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed(primaryButtonRoute);
                  },
                ),
                SizedBox(height: 10.00,),
                showSecondaryButton(context),

              ],
            ),
          ),
        ],
      ),
    );
  }

  showSecondaryButton(BuildContext context) {
    if (secondaryButtonRoute != null && secondaryButtonText != null){
      return FlatButton(
        child: AutoSizeText(
          secondaryButtonText,
          maxLines: 1,
          style: TextStyle(
            color: textColor,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: (){
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(secondaryButtonRoute);
        },
      );
    } else {
      return SizedBox(height: 20.0,);
    }

  }
}
