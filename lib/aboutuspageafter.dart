import 'package:flutter/material.dart';

class aboutuspageafter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black54,
      //drawer: loginsidemenu(),
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Vehicle Tracking',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(3),
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: Colors.white,
                ),
                Text(
                  ' \nAbout Us\n',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
            Text(
              'We are students of IIIT sricity and we developed this app as a part of our embedded systems project\n',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    ));
  }
}
