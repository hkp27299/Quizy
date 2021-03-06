import 'package:flutter/material.dart';
import 'game_home.dart';
import '../services/auth.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import '../widget/shareing.dart';
import 'package:flutter/rendering.dart';
import '../widget/buttonInkwithimage.dart';

class LeaderBoard extends StatefulWidget {
  static const routename = '/leaderboad';
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  GlobalKey _containerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context).settings.arguments;
    List data = arg;

    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushNamed(GameHome.routename);
        },
        child: RepaintBoundary(
          key: _containerKey,
          child: Container(
            color: Color.fromRGBO(21, 12, 92, 1.0),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(GameHome.routename);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Text(
                        'Top winners',
                        style: TextStyle(
                            fontSize: 30,
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
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 150,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        child: new Card(
                          color: Color.fromRGBO(1, 6, 51, 1.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 30,
                                width: 100,
                                decoration: new BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius:
                                        new BorderRadius.circular(20)),
                                child: Text(
                                  'Rank : ' + (i + 1).toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nunito',
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        data[i]['imageURL'],
                                      ),
                                      radius: 50,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        data[i]['name'],
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito',
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Score : ' +
                                            data[i]['score'].toString(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito',
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    pagination: new SwiperPagination(),
                    control: new SwiperControl(),
                    indicatorLayout: PageIndicatorLayout.COLOR,
                    itemCount: data.length >= 3 ? 3 : data.length,
                    viewportFraction: 0.7,
                    scale: 0.8,
                    autoplay: false,
                    loop: false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Overall Result',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      color: Colors.white),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return new Card(
                          color: uidd == data[index]['uid']
                              ? Colors.green
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          data[index]['imageURL'],
                                        ),
                                        radius: 50,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      data[index]['name'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Score',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          color: Colors.black),
                                    ),
                                    Text(
                                      data[index]['score'].toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          color: Colors.black),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      convertWidgetToImage(
                          'Checkout the leaderboard \nYou can get game here : https://play.google.com/store/apps/details?id=com.superbros.quizzy',
                          _containerKey);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: buttonInkWithIcon('Share',Icons.share)                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
