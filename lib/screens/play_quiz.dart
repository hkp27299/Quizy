import 'dart:async';
import '../widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'game_home.dart';
import 'user_result.dart';
import '../services/auth.dart';

final HttpsCallable callable =
    CloudFunctions.instance.getHttpsCallable(functionName: 'addScore');

class PlayQuiz extends StatefulWidget {
  static const routename = '/playquiz';
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {
  int qindex = 0;
  int score = 0;
  int _selectedIndex;
  String ans;
  TextEditingController ansctrl;
  initState() {
    ansctrl = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    List que = arg['que'];
    String gameid = arg['gameid'];
    final GlobalKey<State> _keyLoader = new GlobalKey<State>();
    void _showDialog() {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: new Text("Quit Game ?"),
            content: new Text("Are you sure you want to quit the game ?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Yes"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pushNamed(GameHome.routename);
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

    Future _quizdone() async {
      try {
        Dialogs.showLoadingDialog(context, _keyLoader);
        final HttpsCallableResult result = await callable.call(
            <String, dynamic>{'uid': uidd, 'score': score, 'quizId': gameid});

        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        print(result.data);
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

    Widget checkoption() {
      if (que[qindex]['options'].length == 0) {
        return Expanded(
          child: Center(
            child: new TextField(
              controller: ansctrl,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.black),
                  hintText: "Enter Your Answer",
                  fillColor: Colors.white),
            ),
          ),
        );
      } else {
        return Expanded(
          child: ListView.builder(
              itemCount: que[qindex]['options'].length,
              itemBuilder: (BuildContext ctxt, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                      ans = que[qindex]['options'][index];
                    });
                  },
                  child: new Card(
                    color: _selectedIndex != null && _selectedIndex == index
                        ? Colors.red
                        : Color.fromRGBO(137, 15, 171, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        que[qindex]['options'][index],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            color: Colors.white),
                      ),
                    ),
                  ),
                );
              }),
        );
      }
    }

    Widget checkimg() {
      if (que[qindex]['imageURL'].length != 0) {
        return Image.network(
          que[qindex]['imageURL'],
          height: 200,
          width: 200,
        );
      } else {
        return Text('');
      }
    }

    Widget qscreen() {
      return Container(
        child: Column(
          children: [
            Card(
              color: Color.fromRGBO(209, 8, 185, 1.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  que[qindex]['title'],
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      color: Colors.white),
                ),
              ),
            ),
            checkimg()
          ],
        ),
      );
    }

    void _scorecount() {
      print(ans);
      print(ansctrl.text);

      if (ans == que[qindex]['answer'] ||
          ansctrl.text == que[qindex]['answer']) {
        setState(() {
          score += 10;
        });
      }
    }

    void _nextquestion() {
      if (qindex < que.length - 2) {
        setState(() {
          _selectedIndex = null;
          ans = null;
          ansctrl.text = null;
          qindex++;
        });
      } else {
        _quizdone().whenComplete(() => Navigator.of(context).pushNamed(
            UserResult.routename,
            arguments: {'gameid': gameid, 'score': score}));
      }
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          _showDialog();
        },
        child: Container(
          color: Color.fromRGBO(21, 12, 92, 1.0),
          padding: EdgeInsets.all(17),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _showDialog();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Text(
                    (qindex + 1).toString() + '/' + (que.length - 1).toString(),
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              qscreen(),
              checkoption(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        _nextquestion();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(30, 186, 142, 1.0),
                                Color.fromRGBO(30, 142, 186, 1.0)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 120.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Skip",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        _scorecount();
                        _nextquestion();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(30, 186, 142, 1.0),
                                Color.fromRGBO(30, 142, 186, 1.0)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 120.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Next",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
