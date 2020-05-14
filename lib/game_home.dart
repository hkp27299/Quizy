import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'join_quiz.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'auth.dart';
import 'history.dart';
import 'package:flutter/services.dart';
import 'profile.dart';

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
    Future _history() async {
      try {
        final HttpsCallableResult result =
            await callable.call(<String, dynamic>{
          'uid': uidd,
        });
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                    Text(
                      'Welcome',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          color: Colors.white),
                    ),
                    _img(),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  print(uidd);
                  Navigator.of(context).pushNamed(HomePage.routename);
                },
                child: SizedBox(
                  height: 100,
                  child: Container(
                    width: 300,
                    child: GradientCard(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      gradient: Gradients.rainbowBlue,
                      elevation: 10,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              title: Text('Create quiz',textAlign: TextAlign.center,
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
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(JoinQuiz.routename);
                },
                child: SizedBox(
                  height: 100,
                  child: Container(
                    width: 300,
                    child: GradientCard(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      gradient: Gradients.backToFuture,
                      elevation: 10,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text('Join Quiz',textAlign: TextAlign.center,
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
                height: 50,
              ),
              InkWell(
                onTap: () {
                  _history().whenComplete(
                    () => Navigator.of(context)
                        .pushNamed(History.routename, arguments: history),
                  );
                },
                child: SizedBox(
                  height: 100,
                  child: Container(
                    width: 300,
                    child: GradientCard(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      gradient: Gradients.cosmicFusion,
                      elevation: 10,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text('History',textAlign: TextAlign.center,
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
            ],
          ),
        ),
      ),
    );
  }
}
