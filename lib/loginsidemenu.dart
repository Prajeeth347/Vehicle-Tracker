import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle/aboutuspageafter.dart';
import 'package:vehicle/afterlogin.dart';
import 'package:vehicle/contactuspageafter.dart';
import 'package:vehicle/main.dart';
import 'package:flutter/material.dart';

class loginsidemenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Color.fromRGBO(50, 75, 205, 1),
      child: ListView(
        children: <Widget>[
          Container(
              height: 70.0,
              child: DrawerHeader(
                child: Text('Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                    )),
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.only(left: 10),
              )),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => afterlogin()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
            ),
            title: Text(
              'About us',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => aboutuspageafter()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.mark_as_unread_outlined,
              color: Colors.white,
            ),
            title: Text(
              'Contact us',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => contactuspageafter()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('username');
              prefs.remove('password');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => loginpage()));
            },
          ),
        ],
      ),
    ));
  }
}
