import 'package:flutter/material.dart';
import 'leaderboard.dart';
import 'package:cloud_functions/cloud_functions.dart';

final HttpsCallable callable =
    CloudFunctions.instance.getHttpsCallable(functionName: 'getScore');

class History extends StatefulWidget {
  static const routename = '/history';
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context).settings.arguments;
    List data = arg;
  
    String gameid = '';
    var ll;

    Future _getdata() async {
      try {
        final HttpsCallableResult result =
            await callable.call(<String, dynamic>{'quizId': gameid});
        ll = result.data;
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

    Widget _chk() {
      if (data != null) {
        return Column(
          children: [
            Text(
              'History of all quiz',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          gameid = data[index]['quizId'];
                        });
                        _getdata().whenComplete(() => Navigator.of(context)
                            .pushNamed(LeaderBoard.routename, arguments: ll));
                      },
                      child: new Card(
                        color: Color.fromRGBO(109, 38, 158, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            height: 75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Text(
                                    (index + 1).toString() + '.',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Nunito',
                                        color: Colors.white),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 190,
                                      child: Text(
                                        data[index]['quiz'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      data[index]['lastPlayed'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Text(
                                  data[index]['quizStatus'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito',
                                    color: data[index]['quizStatus'] == 'ACTIVE'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No history for this user',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
    }

    return Scaffold(
      body: Container(
          color: Color.fromRGBO(21, 12, 92, 1.0),
          padding: EdgeInsets.all(30),
          width: MediaQuery.of(context).size.width,
          child: _chk()),
    );
  }
}
