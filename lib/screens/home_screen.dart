import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class HomeScreen extends StatefulWidget {
  final gamerName;
  HomeScreen({this.gamerName});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  String proPicImgUrl = '';
  String proName = '';
  String proView = '';
  String userLevel = '';
  String userRank = '';
  String userWins = '';

  List<String> topOpsList = [];
  //
  @override
  void initState() {
    super.initState();
    _getData(widget.gamerName);
  }

  _getData(String name) async {
    String baseUrl = 'https://r6.tracker.network/profile/pc/';
    // String username = widget.gamerName;
    String username = name;

    String url = baseUrl + username;
    var response = await http.get(url);
    dom.Document document = parser.parse(response.body);
    //profile image class
    final proPicClass = document.querySelector(
        '.trn-profile-header__content .trn-profile-header__avatar img');
    //profile name and profile views class
    final proNameClass = document.querySelector(
        "#profile > div.trn-profile-header.trn-card > div > h1 > span:nth-child(1)");
    //profile views
    final proViewClass = document.querySelector(
        "#profile > div.trn-profile-header.trn-card > div > h1 > span.trn-text--dimmed");
    //user level
    final userLevelClass =
        document.querySelector(".trn-defstat__data .trn-defstat__value");
    //user rank not working
    final userRankClass = document.querySelector(
        "#profile > div.trn-scont.trn-scont--swap > div.trn-scont__aside > div:nth-child(1) > div.trn-card__content.trn-card--light.pt8.pb8 > div > div:nth-child(2) > div > div:nth-child(1)");
    //user wins not working
    final userWinsClass = document.querySelector(
        "#profile > div.trn-scont.trn-scont--swap > div.trn-scont__content > div.trn-scont__content.trn-card.trn-card--dark-header > div.trn-card__content.pb16 > div > div:nth-child(1) > div.trn-defstat__value");
    //user top operators
    final userTopOps = document.querySelectorAll('.trn-defstat__value img');
    for (var images in userTopOps) {
      topOpsList.add(images.attributes['src'].toString());
    }
    //user average seasonal mmr not working
    final userAvgMmr = document.querySelector(
        "#profile > div.trn-scont.trn-scont--swap > div.trn-scont__content > div.trn-scont__content.trn-card.trn-card--dark-header > div.trn-card__content.pb16 > div > div:nth-child(4) > div.trn-defstat__value");
    //
    //
    //setStates for the variables
    setState(() {
      proPicImgUrl = proPicClass.attributes['src'].toString();
      proName = proNameClass.text.toString();
      proView = proViewClass.text.toString().substring(0, 2);
      userLevel = userLevelClass.text.toString();
      // userRank = userRankClass.text.toString().trim();
      // userWins = userWinsClass.text.toString().trim();
    });
    // print(userTopOps);

    print(userAvgMmr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: proPicImgUrl == '' && proName == '' && proView == ''
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                ),
                Container(
                  height: 300.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff6472d7),
                          Color(0xffac8dcd),
                        ]),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 20.0,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    height: 390,
                    width: 420,
                    color: Colors.white,
                    child: Center(
                      child: Text('bottom'),
                    ),
                  ),
                ),
                Positioned(
                  top: 210.0,
                  left: 30.0,
                  child: Container(
                    height: 150.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Top operators',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                image: NetworkImage(topOpsList[0]),
                                width: 80,
                                height: 80,
                              ),
                              SizedBox(height: 5.0),
                              Image(
                                image: NetworkImage(topOpsList[1]),
                                width: 80,
                                height: 80,
                              ),
                              SizedBox(height: 5.0),
                              Image(
                                image: NetworkImage(topOpsList[2]),
                                width: 80,
                                height: 80,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50.0,
                  left: 55.0,
                  child: Container(
                    height: 100.0,
                    width: 300.0,
                    child: Center(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(proPicImgUrl),
                            maxRadius: 50.0,
                            minRadius: 10.0,
                          ),
                          SizedBox(width: 20.0),
                          Container(
                            width: 150.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  proName,
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          userLevel.trim(),
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "LEVEL",
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          proView,
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "VIEWS",
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
