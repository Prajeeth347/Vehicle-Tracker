import 'dart:ffi';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://gpstrack01.000webhostapp.com/'));
  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final Float lat;
  final Float lng;
  final int speed;
  Album({
    required this.lat,
    required this.lng,
    required this.speed,
  });
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(lat: json['lat'], lng: json['lng'], speed: json['speed']);
  }
}
