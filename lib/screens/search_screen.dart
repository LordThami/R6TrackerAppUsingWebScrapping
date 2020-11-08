import 'package:R6Tracker/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //
  TextEditingController usernameController = TextEditingController();

  //
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
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              style: TextStyle(
                decoration: TextDecoration.none,
              ),
              controller: usernameController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                labelText: 'Gamer Name',
              ),
            ),
            SizedBox(height: 10.0),
            MaterialButton(
              minWidth: 100.0,
              height: 40.0,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => HomeScreen(
                      gamerName: usernameController.text,
                    ),
                  ),
                );
              },
              child: Text(
                'Search',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
