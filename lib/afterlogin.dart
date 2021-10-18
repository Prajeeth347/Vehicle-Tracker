import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vehicle/loginsidemenu.dart';
import 'package:vehicle/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  final String lat, lng, Speed;
  User(this.lat, this.lng, this.Speed);
}

class afterlogin extends StatefulWidget {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(13.622556, 79.411155), zoom: 12);
  @override
  State<afterlogin> createState() => _afterloginState();
}

class _afterloginState extends State<afterlogin> {
  DateTime pre_backpress = DateTime.now();
  List<Marker> allMarkers = [];
  List<User> gpsdata = [];
  static var spd;
  static var latitude;
  static var longitude;
  getgpsdata() async {
    var response = await http
        .get(Uri.https('gpstrack01.000webhostapp.com', 'gpsflutterdata.php'));
    var jsonData = jsonDecode(response.body);
    List latestdata = [0.0, 0.0, 0];
    for (var u in jsonData) {
      User user = User(u["lat"], u["lng"], u["Speed"]);
      gpsdata.add(user);
    }
    int n = gpsdata.length - 1;
    spd = int.parse(gpsdata[n].Speed);
    latitude = double.parse(gpsdata[n].lat);
    longitude = double.parse(gpsdata[n].lng);
    latestdata = [latitude, longitude, spd];
    print('Speed : ' + "$spd");
    print('Latitude : ' + "$latitude");
    print('Longitude : ' + "$longitude");
    return latestdata;
  }

  var lati;
  var longi;
  var sped;
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
      body: FutureBuilder(
          future: getgpsdata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              lati = snapshot.data.toString()[1] +
                  snapshot.data.toString()[2] +
                  snapshot.data.toString()[3] +
                  snapshot.data.toString()[4] +
                  snapshot.data.toString()[5] +
                  snapshot.data.toString()[6] +
                  snapshot.data.toString()[7] +
                  snapshot.data.toString()[8] +
                  snapshot.data.toString()[9];
              longi = snapshot.data.toString()[11] +
                  snapshot.data.toString()[12] +
                  snapshot.data.toString()[13] +
                  snapshot.data.toString()[14] +
                  snapshot.data.toString()[15] +
                  snapshot.data.toString()[16] +
                  snapshot.data.toString()[17] +
                  snapshot.data.toString()[18] +
                  snapshot.data.toString()[19] +
                  snapshot.data.toString()[20];
              if (snapshot.data.toString()[23] == ']') {
                sped = snapshot.data.toString()[22];
              } else if (snapshot.data.toString()[24] == ']') {
                sped =
                    snapshot.data.toString()[22] + snapshot.data.toString()[23];
              } else {
                sped = snapshot.data.toString()[22] +
                    snapshot.data.toString()[23] +
                    snapshot.data.toString()[24];
              }
              allMarkers.add(Marker(
                  markerId: MarkerId("Location"),
                  position: LatLng(double.parse(lati), double.parse(longi))));
              return Center(
                  child: Stack(
                children: [
                  GoogleMap(
                    zoomControlsEnabled: false,
                    initialCameraPosition: afterlogin._initialCameraPosition,
                    markers: Set.from(allMarkers),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.black,
                      alignment: Alignment.bottomCenter,
                      height: 30,
                      width: 150,
                      child: Text(
                        'Speed : ' + sped,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  )
                ],
              ));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      drawer: loginsidemenu(),
    );
  }
}
