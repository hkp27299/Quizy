import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import '../widget/loading.dart';
import 'game_home.dart';
import 'leaderboard.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../widget/shareing.dart';
import 'package:flutter/rendering.dart';
import '../widget/buttonInkwithimage.dart';
import '../widget/buttonInk.dart';
final HttpsCallable callable =
    CloudFunctions.instance.getHttpsCallable(functionName: 'getScore');

class UserResult extends StatefulWidget {
  static const routename = '/userresult';

  @override
  _UserResultState createState() => _UserResultState();
}

class _UserResultState extends State<UserResult> {
  @override
  Widget build(BuildContext context) {
    GlobalKey _containerKey = GlobalKey();

    final arg =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    String gameid = arg['gameid'];
    int score = arg['score'];
    var data;

    final GlobalKey<State> _keyLoader = new GlobalKey<State>();
    Future _getdata() async {
      try {
        Dialogs.showLoadingDialog(context, _keyLoader);
        final HttpsCallableResult result =
            await callable.call(<String, dynamic>{'quizId': gameid});
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        data = result.data;
        print(gameid);
        print(data);
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

    Future _goback() async {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: new Text("You finished the quiz"),
            content: new Text("Go back to play again"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Ok"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pushNamed(GameHome.routename);
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          _goback();
        },
        child: RepaintBoundary(
          key: _containerKey,
          child: Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(21, 12, 92, 1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Invite Your Friends',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: SizedBox(
                    height: 80,
                    child: Container(
                      width: 500,
                      child: GradientCard(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        gradient: Gradients.hotLinear,
                        elevation: 10,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text(gameid,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      convertWidgetToImage(
                          'Beat my score $score join with id : $gameid \nYou can get game here : https://play.google.com/store/apps/details?id=com.superbros.quizzy',
                          _containerKey);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: buttonInkWithIcon('Sahre',Icons.share)
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Your Score',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 80,
                  child: Container(
                    width: 200,
                    child: GradientCard(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      gradient: Gradients.hotLinear,
                      elevation: 10,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                score.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      _getdata().whenComplete(() => Navigator.of(context)
                          .pushNamed(LeaderBoard.routename, arguments: data));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: buttonInk('LeaderBoard')
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
