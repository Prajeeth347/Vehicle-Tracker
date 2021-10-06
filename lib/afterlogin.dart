import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vehicle/loginsidemenu.dart';
import 'package:vehicle/main.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class afterlogin extends StatelessWidget {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(13.622556, 79.411155), zoom: 12);
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
        child: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: _initialCameraPosition,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.black,
                alignment: Alignment.bottomCenter,
                height: 30,
                width: 100,
                child: Text(
                  'Speed',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            )
          ],
        ),
      ),
      drawer: loginsidemenu(),
    );
  }
}
