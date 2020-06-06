import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../services/auth.dart';
import 'play_quiz.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widget/loading.dart';
import '../widget/buttonInk.dart';
final HttpsCallable callable =
    CloudFunctions.instance.getHttpsCallable(functionName: 'checkQuiz');

class JoinQuiz extends StatefulWidget {
  static const routename = '/joinquiz';

  @override
  _JoinQuizState createState() => _JoinQuizState();
}

class _JoinQuizState extends State<JoinQuiz> {
  String status;
  List que = [];

  TextEditingController gameidController;
  initState() {
    gameidController = new TextEditingController();

    super.initState();
  }
final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String quizid = '';
  Future _checkQuiz() async {
    try {
        Dialogs.showLoadingDialog(context, _keyLoader);
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{'quizId': quizid, 'uid': uidd},
      ); Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
      print(result.data);
      status = result.data['result'];
      
      if (status == 'SUCCESS') {
        que = result.data['data'];
        Navigator.of(context).pushNamed(PlayQuiz.routename,
            arguments: {'que': que, 'gameid': quizid});
      } else {
        if (status == 'ERROR') {
          Fluttertoast.showToast(
              msg: "Wrong Quiz Id",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.indigo,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          if (status == 'FAILURE') {
            Fluttertoast.showToast(
                msg: "Quiz Is Closed",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.indigo,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            if (status == 'ALREADY PLAYED') {
              Fluttertoast.showToast(
                  msg: "You Already Attempt Quiz",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.indigo,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        }
      }
    } on CloudFunctionsException catch (e) {
      print('caught firebase functions exception');
      print(e.code);
      print(e.message);
      print(e.details);
    } catch (e) {
      print('caught generic exception');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(21, 12, 92, 1.0),
        padding: EdgeInsets.all(40),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new TextField(
              controller: gameidController,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.black),
                  hintText: "Enter Game Id",
                  fillColor: Colors.white),
            ),
            Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    quizid = gameidController.text;
                  });
                  _checkQuiz();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: buttonInk('Join Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
