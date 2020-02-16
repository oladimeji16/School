import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:school/auth/auth_services.dart';
import 'package:school/days_of_the_week.dart';
import 'package:school/route_generator.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize("com.oladimeji.school");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      authResult: AuthService(),
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: "School",
        theme: ThemeData(
          fontFamily: 'Source serif pro',
          primaryColor: textColor,
          scaffoldBackgroundColor: boxColor,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }


}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 03,
      backgroundColor: boxColor,
      image: Image.asset('images/appicon.png'),
      title: Text('School', style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: textColor),),
      loaderColor: textColor,
      photoSize: 100.0,
      navigateAfterSeconds: HomeController(),
    );
  }
}
