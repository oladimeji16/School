import 'package:flutter/material.dart';
import 'package:school/days_of_the_week.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:school/days_of_the_week.dart' as prefix0;
import '../days_of_the_week.dart';
import '../route_generator.dart';
import 'auth_services.dart';

// TODO move this to tone location
final primaryColor = const Color(0xFF75A2EA);

enum AuthFormType { signIn, signUp, reset, anonymous, convert }

class SignUp extends StatefulWidget {
  final AuthFormType authFormType;

  SignUp({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpState createState() =>
      _SignUpState(authFormType: this.authFormType);
}

class _SignUpState extends State<SignUp> {
  AuthFormType authFormType;

  _SignUpState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _name, _warning;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else if (state == 'home') {
      Navigator.of(context).pop();
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    if (authFormType == AuthFormType.anonymous) {
      return true;
    }
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).authResult;
        switch (authFormType) {
          case AuthFormType.signIn:
            await auth.signInWithEmailAndPassword(_email, _password);
            Navigator.of(context).pushNamed('/home');
            break;
          case AuthFormType.signUp:
            await auth.createUserWithEmailAndPassword(
                _email, _password, _name);
            Navigator.of(context).pushNamed('/home');
            break;
          case AuthFormType.reset:
            await auth.sendPasswordResetEmail(_email);
            setState(() {
              _warning = "A password reset link has been sent to $_email";
              authFormType = AuthFormType.signIn;
            });
            break;
          case AuthFormType.anonymous:
            await auth.singInAnonymously();
            Navigator.of(context).pushNamed('/home');
            break;
          case AuthFormType.convert:
            await auth.convertUserWithEmail(_email, _password, _name);
            Navigator.of(context).pop();
            break;
        }
      } catch (e) {
        print(e);
        setState(() {
          _warning = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if (authFormType == AuthFormType.anonymous) {
      submit();
      return Scaffold(
          backgroundColor: textColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitDoubleBounce(
                  color: Colors.white,
                ),
                SizedBox(height: 50.0),
                Text(
                  "Loading",
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ));
    } else {
      return Scaffold(
        body: Container(

          height: _height,
          width: _width,
          child: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      showAlert(),
                      Image(
                        image: AssetImage('images/appicon.png'),
                      ),
                      SizedBox(height: _height * 0.010),
                      buildHeaderText(),
                      SizedBox(height: _height * 0.003),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: buildInputs() + buildButtons(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

            ),
          ),
        ),
      );
    }
  }

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _warning,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signIn) {
      _headerText = "Sign In";
    } else if (authFormType == AuthFormType.reset) {
      _headerText = "Reset Password";
    } else if(authFormType == AuthFormType.convert) {
      _headerText = "Update Profile";
    } else {
      _headerText = "Create New Account";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        color: textColor,
      ),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];
    if (authFormType == AuthFormType.reset){
      textFields.add(
        TextFormField(
          validator: EmailValidator.validate,
          style: TextStyle(fontSize: 18.0),
          decoration: buildSignUpInputDecoration("Email"),
          onSaved: (value) => _email = value,
        ),
      );
      textFields.add(SizedBox(height: 10.0));
      return textFields;
    }

    // if were in the sign up state add name
    if ([AuthFormType.signUp, AuthFormType.convert].contains(authFormType)) {
      textFields.add(
        TextFormField(
          validator: NameValidator.validate,
          style: TextStyle(fontSize: 18.0),
          decoration: buildSignUpInputDecoration("Name"),
          onSaved: (value) => _name = value,
        ),
      );
      textFields.add(SizedBox(height: 10));
    }

    // add email & password
    textFields.add(
      TextFormField(
        validator: EmailValidator.validate,
        style: TextStyle(fontSize: 18.0),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
      ),
    );
    textFields.add(SizedBox(height: 10));
    textFields.add(
      TextFormField(
        validator: PasswordValidator.validate,
        style: TextStyle(fontSize: 18.0),
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );
    textFields.add(SizedBox(height: 10));

    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0)),
      contentPadding:
      const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;
    bool _showSocial = true;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = "Create New Account";
      _newFormState = "signUp";
      _submitButtonText = "Sign In";
      _showForgotPassword = true;
    } else if(authFormType == AuthFormType.reset) {
      _switchButtonText = "Return to Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Submit";
      _showSocial = false;
    } else if(authFormType == AuthFormType.convert){
      _switchButtonText = "Cancel";
      _newFormState = "home";
      _submitButtonText = "Update";

    }else {
      _switchButtonText = "Have an Account? Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Sign Up";

    }

    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: MaterialButton(
          color: textColor,
          textColor: boxColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _submitButtonText,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            ),
          ),
          onPressed: submit,
        ),
      ),
      showForgotPassword(_showForgotPassword),
      FlatButton(
        child: Text(
          _switchButtonText,
          style: TextStyle(color: prefix0.textColor),
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      ),
      buildSocialIcons(_showSocial),
    ];
  }

  Widget showForgotPassword(bool visible) {
    return Visibility(
      child: FlatButton(
        child: Text('Forgot Password ?', style: TextStyle(color: textColor),),
        onPressed: (){
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
      ),
      visible: visible,
    );
  }

  Widget buildSocialIcons(bool visible) {
    final _auth = Provider.of(context).authResult;
    return Visibility(
      child: Column(
        children: <Widget>[
          Divider(color: textColor,),
          SizedBox(height: 10,),
          GoogleSignInButton(
            onPressed: () async {
              try{
                if(authFormType == AuthFormType.convert){
                  await _auth.convertWithGoogle();
                  Navigator.of(context).pop();
                }else{
                await _auth.signInWithGoogle();
                Navigator.of(context).pushNamed('/home');
              }
              }catch(e) {
                setState(() {
                  _warning = e.message;
                });
              }
            },
          ),
        ],
      ),
      visible: visible,
    );
  }
}