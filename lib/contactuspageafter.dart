import 'package:url_launcher/url_launcher.dart';
import 'package:vehicle/loginsidemenu.dart';
import 'package:vehicle/sidemenu.dart';
import 'package:flutter/material.dart';

class contactuspageafter extends StatelessWidget {
  void mailLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Could not launch $command');
    }
  }

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
                TextButton(
                    onPressed: () {
                      mailLaunch('mailto:group14esiiits@gmail.com?');
                    },
                    child: Text(
                      'group14esiiits@gmail.com',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                TextButton(
                    onPressed: () {
                      mailLaunch('tel:+917989772884');
                    },
                    child: Text(
                      '+91 79897 72884',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
