import 'package:flutter/material.dart';
import 'package:quizzy/history.dart';
import 'package:quizzy/join_quiz.dart';
import 'package:quizzy/play_quiz.dart';
import 'package:quizzy/user_result.dart';
import 'login.dart';
import 'createquiz.dart';
import 'homepage.dart';
import 'game_home.dart';
import 'leaderboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile.dart';
import 'share.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final key = new GlobalKey<ScaffoldState>();
  String u;

  @override
  void initState() {
    super.initState();
    _loaduser();
  }

  _loaduser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      u = (prefs.getString('uid'));
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
      ),
      home: u == null ? LogIn() : GameHome(),
      routes: {
        CreateQuiz.routename: (ctx) => CreateQuiz(),
        HomePage.routename: (ctx) => HomePage(),
        PlayQuiz.routename: (ctx) => PlayQuiz(),
        UserResult.routename: (ctx) => UserResult(),
        JoinQuiz.routename: (ctx) => JoinQuiz(),
        GameHome.routename: (ctx) => GameHome(),
        LeaderBoard.routename: (ctx) => LeaderBoard(),
        History.routename: (ctx) => History(),
        Profile.routename: (ctx) => Profile(),
        LogIn.routename: (ctx) => LogIn(),
        Share.routename: (ctx) => Share(),
      },
    );
  }
}
