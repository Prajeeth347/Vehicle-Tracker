import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vehicle/loginsidemenu.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  final String lat, lng, speed;
  User(this.lat, this.lng, this.speed);
}

class vehiclehistory extends StatefulWidget {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(13.622556, 79.411155), zoom: 15);
  @override
  State<vehiclehistory> createState() => _afterloginState();
}

class _afterloginState extends State<vehiclehistory> {
  DateTime pre_backpress = DateTime.now();
  List<Marker> allMarkers = [];
  List<User> gpsdata = [];
  static var spd;
  static var latitude;
  static var longitude;
  getgpsdata() async {
    var response = await http.get(Uri.https(
        'vehicletracking001.000webhostapp.com', 'gpsflutterdata.php'));
    var jsonData = jsonDecode(response.body);
    ;
    for (var u in jsonData) {
      User user = User(u["lat"], u["lng"], u["speed"]);
      gpsdata.add(user);
    }
    List latestdata = [0.0, 0.0, 0];
    int n = gpsdata.length - 1;
    spd = int.parse(gpsdata[n].speed);
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
              content: Text('Press Back button again to Exit'),
              duration: Duration(seconds: 2),
            );

            ScaffoldMessenger.of(context).showSnackBar(snack);

            return false; // false will do nothing when back press
          } else {
            return true; // true will exit the app
          }
        },
        child: FutureBuilder(
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
                if (snapshot.data.toString()[24] == ']') {
                  sped = snapshot.data.toString()[23];
                } else if (snapshot.data.toString()[25] == ']') {
                  sped = snapshot.data.toString()[23] +
                      snapshot.data.toString()[24];
                } else {
                  sped = snapshot.data.toString()[23] +
                      snapshot.data.toString()[24] +
                      snapshot.data.toString()[25];
                }
                allMarkers.add(Marker(
                    markerId: MarkerId("Location"),
                    position: LatLng(
                      double.parse(lati),
                      double.parse(longi),
                    ),
                    infoWindow: InfoWindow(
                        title: 'Vehicle location',
                        snippet: 'Latitude : $lati, longitude : $longi')));
                Color getColor(number) {
                  if (number < 60)
                    return Colors.green;
                  else if (number >= 60 && number < 100) {
                    return Colors.orange;
                  } else
                    return Colors.red.shade900;
                }

                return Center(
                    child: Stack(
                  children: [
                    GoogleMap(
                      zoomControlsEnabled: false,
                      initialCameraPosition:
                          vehiclehistory._initialCameraPosition,
                      markers: Set.from(allMarkers),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.grey.shade300.withOpacity(0.7),
                          height: 100,
                          width: 200,
                          child: Text(
                            'Speed : ' + sped,
                            style: TextStyle(
                                color: getColor(int.parse(sped)), fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              getgpsdata();
                            });
                          },
                          child: Icon(Icons.refresh_rounded)),
                    )
                  ],
                ));
              } else {
                return Stack(
                  children: [
                    GoogleMap(
                      zoomControlsEnabled: false,
                      initialCameraPosition:
                          vehiclehistory._initialCameraPosition,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          height: 100,
                          width: 150,
                          child: Text(
                            'Speed : ',
                            style: TextStyle(color: Colors.black, fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              }
            }),
      ),
      drawer: loginsidemenu(),
    );
  }
}
