import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'play_quiz.dart';
import 'package:flutter/rendering.dart';
import '../widget/shareing.dart';
import '../widget/buttonInkwithimage.dart';
class Share extends StatefulWidget {
  static const routename = '/share';

  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> {
  GlobalKey _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    List que = args['que'];
    String gameid = args['gameid'];
    String qname = args['qname'];
    String imgpath = args['imgpath'];

    return Scaffold(
      body: RepaintBoundary(
        key: _containerKey,
        child: Container(
          color: Color.fromRGBO(21, 12, 92, 1.0),
          padding: EdgeInsets.all(30),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: SizedBox(
                  height: 100,
                  child: Container(
                    width: 350,
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
                            ListTile(
                              leading: Image(
                                image: AssetImage(imgpath),
                              ),
                              title: Text(qname,
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
                height: 100,
              ),
              Text(
                'Game Id',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: 300,
                height: 40,
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Color.fromRGBO(255, 43, 230, 1.0),
                ),
                child: Text(
                  gameid,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    convertWidgetToImage(
                        'Connect Quiz with id : $gameid \nYou can get game here : https://play.google.com/store/apps/details?id=com.superbros.quizzy',
                        _containerKey);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: buttonInkWithIcon('Share',Icons.share)
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(PlayQuiz.routename, arguments: {
                      'que': que,
                      'gameid': gameid,
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: buttonInkWithIcon('Start',Icons.play_arrow),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
