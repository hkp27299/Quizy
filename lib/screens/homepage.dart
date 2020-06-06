import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'createquiz.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'game_home.dart';
import '../widget/homepagecards.dart';

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
              child: homePageCards(
                  'Movie', 'assets/images/movie.png', Gradients.rainbowBlue),
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
                child: homePageCards('History', 'assets/images/history.png',
                    Gradients.backToFuture)),
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
                child: homePageCards('General Culture', 'assets/images/gc.png',
                    Gradients.coldLinear)),
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
                child: homePageCards('Science And Technology',
                    'assets/images/sciandtech.png', Gradients.cosmicFusion)),
          ],
        ),
      ),
    );
  }
}
