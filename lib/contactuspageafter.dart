import 'package:vehicle/loginsidemenu.dart';
import 'package:vehicle/sidemenu.dart';
import 'package:flutter/material.dart';

class contactuspageafter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black54,
      drawer: loginsidemenu(),
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
            Text(
              'Contact Us\n',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Row(
              children: [
                Icon(
                  Icons.mail_outline_outlined,
                  color: Colors.white,
                ),
                Text(
                  ' group14esiiits@gmail.com',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
