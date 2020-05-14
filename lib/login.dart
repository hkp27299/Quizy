import 'package:flutter/material.dart';
import 'package:quizzy/game_home.dart';
import 'auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class LogIn extends StatefulWidget {
  static const routename = '/login';
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Future<String> st;
  void _checklogin() {
    st = signInWithGoogle().then((st) {
      if (st.toString() != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return GameHome();
            },
          ),
        );
      }
      setState(() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('uid', st);
      });
    });
  }

  Function quit() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: new Text("Quit game ?"),
          content: new Text('Are you sure you want to quit game?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    Widget _signInButton() {
      return RaisedButton(
        splashColor: Colors.white,
        onPressed: () {
          _checklogin();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                    image: AssetImage("assets/images/google_logo.png"),
                    height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          quit();
        },
        child: Container(
          color: Color.fromRGBO(21, 12, 92, 1.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage("assets/images/quizzy_logo.png"),
                  height: 200,
                  width: 300,
                ),
                _signInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
