import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'join_quiz.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../services/auth.dart';
import 'history.dart';
import 'package:flutter/services.dart';
import 'profile.dart';
import '../widget/loading.dart';
import '../widget/gamehomecards.dart';
import '../widget/text.dart';
final HttpsCallable callable =
    CloudFunctions.instance.getHttpsCallable(functionName: 'getUserLog');

class GameHome extends StatefulWidget {
  static const routename = '/gamehome';

  @override
  _GameHomeState createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> {
  List history;

  Widget _img() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Profile.routename);
      },
      child: Container(
        height: 45,
        width: 45,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            imageUrl == null
                ? 'https://miro.medium.com/max/560/1*MccriYX-ciBniUzRKAUsAw.png'
                : imageUrl,
          ),
          radius: 60,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    signInWithGoogle();
    new Future<String>.delayed(
            new Duration(seconds: 3), () => '["123", "456", "789"]')
        .then((String value) {
      setState(() {
        imageUrl = imageUrl;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<State> _keyLoader = new GlobalKey<State>();

    Future _history(BuildContext context) async {
      try {
        Dialogs.showLoadingDialog(context, _keyLoader);
        final HttpsCallableResult result =
            await callable.call(<String, dynamic>{
          'uid': uidd,
        });
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        history = result.data;

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

    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          quit();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Color.fromRGBO(21, 12, 92, 1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        quit();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    text('Welcome',30),
                    _img(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(HomePage.routename);
                      },
                      child: gameHomeCard('Create quiz',Gradients.rainbowBlue),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(JoinQuiz.routename);
                      },
                      child: gameHomeCard('Join quiz',Gradients.backToFuture),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        _history(context).whenComplete(
                          () => Navigator.of(context)
                              .pushNamed(History.routename, arguments: history),
                        );
                      },
                      child: gameHomeCard('History',Gradients.cosmicFusion),
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
