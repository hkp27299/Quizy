import 'package:flutter/material.dart';
import 'auth.dart';
import 'createquiz.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'game_home.dart';

class HomePage extends StatelessWidget {
  static const routename = '/homepage';
  @override
  Widget build(BuildContext context) {
    String qname = "";
    String imgpath = "";
    return Scaffold(
      body: Container(
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
                      Navigator.of(context).pushNamed(GameHome.routename);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Text(
                    'Live Quiz Listing',
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
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                qname = 'Movie';
                imgpath = "assets/images/movie.png";
                Navigator.of(context)
                    .pushNamed(CreateQuiz.routename, arguments: {
                  'qname': qname,
                  'imgpath': imgpath,
                });
              },
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
                          const ListTile(
                            leading: Image(
                              image: AssetImage('assets/images/movie.png'),
                            ),
                            title: Text('Movie',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                qname = 'History';
                imgpath = "assets/images/history.png";
                Navigator.of(context).pushNamed(CreateQuiz.routename,
                    arguments: {'qname': qname, 'imgpath': imgpath});
              },
              child: SizedBox(
                height: 100,
                child: Container(
                  width: 350,
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
                          const ListTile(
                            leading: Image(
                              image: AssetImage('assets/images/history.png'),
                            ),
                            title: Text('History',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                qname = 'General Culture';
                imgpath = "assets/images/gc.png";
                Navigator.of(context).pushNamed(CreateQuiz.routename,
                    arguments: {'qname': qname, 'imgpath': imgpath});
              },
              child: SizedBox(
                height: 100,
                child: Container(
                  width: 350,
                  child: GradientCard(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    gradient: Gradients.coldLinear,
                    elevation: 10,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: Image(
                              image: AssetImage('assets/images/gc.png'),
                            ),
                            title: Text('General Culture',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                qname = 'Science And Technology';
                imgpath = "assets/images/sciandtech.png";
                Navigator.of(context).pushNamed(CreateQuiz.routename,
                    arguments: {'qname': qname, 'imgpath': imgpath});
              },
              child: SizedBox(
                height: 100,
                child: Container(
                  width: 350,
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
                          const ListTile(
                            leading: Image(
                              image: AssetImage('assets/images/sciandtech.png'),
                            ),
                            title: Text('Science And Technology',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
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
    );
  }
}
