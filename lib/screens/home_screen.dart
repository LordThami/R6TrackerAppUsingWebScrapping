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
    _getData();
  }

  _getData() async {
    String baseUrl = 'https://r6.tracker.network/profile/pc/';
    // String username = widget.gamerName;
    String username = 'AB____';

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
      proView = proViewClass.text.toString();
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
      appBar: AppBar(
        title: Text(
          "R6 Tracker",
          style: GoogleFonts.ptSerif(
            textStyle: TextStyle(
              fontSize: 28.0,
            ),
          ),
        ),
        toolbarHeight: 100.0,
      ),
      body: proPicImgUrl == '' && proName == '' && proView == ''
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    height: 120.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xfff9f9f9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(2, 9),
                          blurRadius: 20.0,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(proPicImgUrl),
                          maxRadius: 50.0,
                          minRadius: 10.0,
                        ),
                        SizedBox(width: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              proName,
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 24.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              proView,
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey.withOpacity(0.7),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    height: 150.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xfff9f9f9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(2, 9),
                          blurRadius: 20.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "OVERVIEW",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'LEVEL',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  userLevel.trim(),
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 40.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RANK',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  userRank.trim(),
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 40.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TOP OPERATORS',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Image(
                                      image: NetworkImage(topOpsList[0]),
                                      width: 50,
                                      height: 50,
                                    ),
                                    SizedBox(height: 5.0),
                                    Image(
                                      image: NetworkImage(topOpsList[1]),
                                      width: 50,
                                      height: 50,
                                    ),
                                    SizedBox(height: 5.0),
                                    Image(
                                      image: NetworkImage(topOpsList[2]),
                                      width: 50,
                                      height: 50,
                                    ),
                                  ],
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
    );
  }
}

// Container(
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               proPicImgUrl == '' && proName == '' && proView == ''
//                   ? CircularProgressIndicator()
//                   : Image(
//                       image: NetworkImage(proPicImgUrl),
//                     ),
//               SizedBox(height: 10.0),
//               Text(proName),
//               SizedBox(height: 10.0),
//               Text(proView),
//               SizedBox(height: 10.0),
//               Text(userLevel),
//               // SizedBox(height: 10.0),
//               // Text("Rank: " + userRank),
//             ],
//           ),
//         ),
//       ),
