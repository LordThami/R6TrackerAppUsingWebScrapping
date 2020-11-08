import 'package:flutter/material.dart';
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

  //
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    String baseUrl = 'https://r6.tracker.network/profile/pc/';
    String username = widget.gamerName;
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
        "#profile > div.trn-scont.trn-scont--swap > div.trn-scont__content > div.trn-scont__content.trn-card.trn-card--dark-header > div.trn-card__content.trn-card--light.trn-defstats-grid > div:nth-child(3) > div.trn-defstat__value");
    //user wins not working
    final userWinsClass = document.querySelector(
        "#profile > div.trn-scont.trn-scont--swap > div.trn-scont__content > div.trn-scont__content.trn-card.trn-card--dark-header > div.trn-card__content.pb16 > div > div:nth-child(1) > div.trn-defstat__value");
    //
    //
    //setStates for the variables
    setState(() {
      proPicImgUrl = proPicClass.attributes['src'].toString();
      proName = proNameClass.text.toString().trim();
      proView = proViewClass.text.toString().trim();
      userLevel = userLevelClass.text.toString().trim();
      // userRank = userRankClass.text.toString().trim();
      // userWins = userWinsClass.text.toString().trim();
    });
    // print(userWinsClass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              proPicImgUrl == '' && proName == '' && proView == ''
                  ? CircularProgressIndicator()
                  : Image(
                      image: NetworkImage(proPicImgUrl),
                    ),
              SizedBox(height: 10.0),
              Text(proName),
              SizedBox(height: 10.0),
              Text(proView),
              SizedBox(height: 10.0),
              Text(userLevel),
              // SizedBox(height: 10.0),
              // Text("Rank: " + userRank),
            ],
          ),
        ),
      ),
    );
  }
}
