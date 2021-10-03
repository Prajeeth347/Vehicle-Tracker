import 'package:flutter/material.dart';
import 'package:vehicle/loginsidemenu.dart';

class afterlogin extends StatelessWidget {
  DateTime pre_backpress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    theme:
    ThemeData.dark();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Vehicle Tracker',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);

          final cantExit = timegap >= Duration(seconds: 2);

          pre_backpress = DateTime.now();

          if (cantExit) {
            //show snackbar
            final snack = SnackBar(
              content: Text('Press Back button again to Logout'),
              duration: Duration(seconds: 2),
            );

            ScaffoldMessenger.of(context).showSnackBar(snack);

            return false; // false will do nothing when back press
          } else {
            return true; // true will exit the app
          }
        },
        child: Text('Map'),
      ),
      drawer: loginsidemenu(),
    );
  }
}
