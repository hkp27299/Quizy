import 'package:flutter/material.dart';
import 'package:quizzy/homepage.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'share.dart';

final HttpsCallable callable =
    CloudFunctions.instance.getHttpsCallable(functionName: 'createQuiz');

class CreateQuiz extends StatefulWidget {
  static const routename = '/createquiz';

  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  var sliderValue = 15.0;
  var mm = 15;
  var hh = 0;
  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    String qname = args['qname'];
    String imgpath = args['imgpath'];
    String gameid = '';
    List que = [];
    Future _getid() async {
      try {
        final HttpsCallableResult result = await callable.call(
          <String, dynamic>{
            'uid': uidd,
            'endTime': sliderValue,
            'name': name,
            'quiz': qname
          },
        );
        gameid = result.data['id'];
        que = result.data['questionsData'];
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

    return Scaffold(
      key: key,
      body: Container(
        padding: EdgeInsets.all(30),
        color: Color.fromRGBO(21, 12, 92, 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(HomePage.routename);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Text(
                    'Start Game',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        color: Colors.white),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        imageUrl,
                      ),
                      radius: 60,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
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
              height: 200,
            ),
            Text(
              'Select Time Limit',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Nuniyo',
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              height: 15,
            ),
            SliderTheme(
              data: SliderThemeData(
                  trackHeight: 20,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 20.0,
                  )),
              child: Slider(
                activeColor: Color.fromRGBO(218, 9, 222,1.0),
                min: 15.0,
                max: 480.0,
                divisions: 31,
                value: sliderValue,
                onChanged: (newValue) {
                  setState(() {
                    sliderValue = newValue;
                    mm = (sliderValue % 60).toInt();
                    hh = (sliderValue ~/ 60).toInt();
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Text(
              hh.toString() + ' : ' + mm.toString() + ' Hours',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Nuniyo',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  _getid().whenComplete(() => Navigator.of(context)
                          .pushNamed(Share.routename, arguments: {
                        'que': que,
                        'gameid': gameid,
                        'qname': qname,
                        'imgpath':imgpath,
                        
                      }));
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
                        BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Start",
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
        ),
      ),
    );
  }
}
