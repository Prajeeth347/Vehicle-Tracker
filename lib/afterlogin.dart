import 'dart:convert';
import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vehicle/loginsidemenu.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class afterloginapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            splash: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 35,
                ),
                Text(
                  'Vehicle Tracker',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 29,
                  ),
                ),
              ],
            )),
            duration: 3000,
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.grey.shade900,
            nextScreen: afterlogin()),
      ),
    );
  }
}

class User {
  final String lat, lng, speed;
  User(this.lat, this.lng, this.speed);
}

class afterlogin extends StatefulWidget {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(13.622556, 79.411155), zoom: 15);
  @override
  State<afterlogin> createState() => _afterloginState();
}

class _afterloginState extends State<afterlogin> {
  DateTime pre_backpress = DateTime.now();
  List<Marker> allMarkers = [];
  static var spd;
  static var latitude;
  static var longitude;
  getgpsdata() async {
    var response = await http
        .get(Uri.https('gpstrack01.000webhostapp.com', 'gpsflutterdata.php'));
    var jsonData = jsonDecode(response.body);
    List<User> gpsdata = [];
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

  int selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.locationArrow),
              label: 'Live Location'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.history), label: 'Location History'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        backgroundColor: Colors.grey.shade900,
        unselectedItemColor: Colors.white24,
        onTap: _onItemtapped,
      ),
      body: selectindex(context),
      drawer: loginsidemenu(),
    );
  }

  void _onItemtapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  selectindex(BuildContext context) {
    if (selectedIndex == 0) {
      return Livelocation(context);
    } else {
      return googleuserinfo();
    }
  }

  Center Livelocation(BuildContext context) {
    return Center(
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
                sped =
                    snapshot.data.toString()[23] + snapshot.data.toString()[24];
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
                    initialCameraPosition: afterlogin._initialCameraPosition,
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
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              getgpsdata();
                            });
                          },
                          child: Icon(Icons.refresh_rounded)),
                    ),
                  ), /*
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 48, right: 8),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Icon(FontAwesomeIcons.locationArrow,
                              color: Colors.blue),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                        ),
                      ))*/
                ],
              ));
            } else {
              return Stack(
                children: [
                  GoogleMap(
                    zoomControlsEnabled: false,
                    initialCameraPosition: afterlogin._initialCameraPosition,
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
    );
  }
}

class googleuserinfo extends StatefulWidget {
  @override
  _UserinfoState createState() => _UserinfoState();
}

class _UserinfoState extends State<googleuserinfo> {
  final Stream<QuerySnapshot> _collegesstream =
      FirebaseFirestore.instance.collection('vehicle_history').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _collegesstream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                leading: Icon(
                  Icons.book_outlined,
                  color: Colors.white,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  data['created_date'],
                  style: TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          );
        });
  }
}
