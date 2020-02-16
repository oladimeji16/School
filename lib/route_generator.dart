import 'package:flutter/material.dart';
import 'package:school/auth/auth_services.dart';
import 'package:school/days_of_the_week.dart';
import 'package:school/home.dart';
import 'package:school/initial_page.dart';
import 'package:school/templates/coursecontent/addCourseContent.dart';
import 'package:school/templates/coursecontent/courseContent.dart';
import 'package:school/templates/coursecontent/editCourseContent.dart';
import 'package:school/templates/friday/addTimetable.dart';
import 'package:school/templates/friday/fridayTimetable.dart';
import 'package:school/templates/monday/addTimetable.dart';
import 'package:school/templates/saturday/addTimetable.dart';
import 'package:school/templates/saturday/saturdayTimetable.dart';
import 'package:school/templates/thursday/addTimetable.dart';
import 'package:school/templates/thursday/thursdayTimetable.dart';
import 'package:school/templates/tuesday/addTimetable.dart';
import 'package:school/templates/tuesday/tuesdayTimetable.dart';
import 'package:school/templates/wednesday/addTimetable.dart';
import 'package:school/templates/wednesday/wednesdayTimetable.dart';
import 'auth/sign_up.dart';
import 'main.dart';
import 'notifications.dart';
import 'templates/monday/mondayTimetable.dart';


class RouteGenerator {

  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final user = Provider.of<User>(context);
    // print(user);

    // final args = settings.arguments;

    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/homehome':
        return MaterialPageRoute(builder: (_) => HomeController());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeController());
      case '/notify':
        return MaterialPageRoute(builder: (_) => Notify());
      case '/subjects':
        return MaterialPageRoute(builder: (_) => Subjects());
      case '/timetable':
        return MaterialPageRoute(builder: (_) => DaysOfTheWeek());
      case '/signUp':
        return MaterialPageRoute(builder: (_) => SignUp(authFormType: AuthFormType.signUp,));
      case '/signIn':
        return MaterialPageRoute(builder: (_) => SignUp(authFormType: AuthFormType.signIn,));
      case'/signinAnon':
        return MaterialPageRoute(builder: (_) => SignUp(authFormType: AuthFormType.anonymous,));
      case'/convertUser':
        return MaterialPageRoute(builder: (_) => SignUp(authFormType: AuthFormType.convert,));
      case'/monday':
        return MaterialPageRoute(builder: (_) => Monday());
      case'/tuesday':
        return MaterialPageRoute(builder: (_) => Tuesday());
      case'/wednesday':
        return MaterialPageRoute(builder: (_) => Wednesday());
      case'/thursday':
        return MaterialPageRoute(builder: (_) => Thursday());
      case'/friday':
        return MaterialPageRoute(builder: (_) => Friday());
      case'/saturday':
        return MaterialPageRoute(builder: (_) => Saturday());
      case '/addMondayTimetable':
        return MaterialPageRoute(builder: (_) => AddMondayTimetable());
      case '/addTuesdayTimetable':
        return MaterialPageRoute(builder: (_) => AddTuesdayTimetable());
      case '/addWednesdayTimetable':
        return MaterialPageRoute(builder: (_) => AddWednesdayTimetable());
      case '/addThursdayTimetable':
        return MaterialPageRoute(builder: (_) => AddThursdayTimetable());
      case '/addFridayTimetable':
        return MaterialPageRoute(builder: (_) => AddFridayTimetable());
      case '/addSaturdayTimetable':
        return MaterialPageRoute(builder: (_) => AddSaturdayTimetable());
      case '/addCourseContent':
        return MaterialPageRoute(builder: (_) => AddCourseContent());
      case '/editCourseDetail':
        return MaterialPageRoute(builder: (_) => EditCourseContent());

    }
  }

}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).authResult;
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.active){
            final bool signedIn = snapshot.hasData;
            return signedIn ? Home() : InitialView();
          }
          return CircularProgressIndicator();
        }
    );
  }
}

class Provider extends InheritedWidget {
  final AuthService authResult;
  Provider({Key key, Widget child, this.authResult}): super(key: key, child : child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
  static Provider of(BuildContext context) => (context.inheritFromWidgetOfExactType(Provider) as Provider);
}
