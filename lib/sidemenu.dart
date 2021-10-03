import 'package:vehicle/aboutuspage.dart';
import 'package:vehicle/contactuspage.dart';
import 'package:vehicle/main.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
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
                  .push(MaterialPageRoute(builder: (context) => loginpage()));
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => aboutuspage()));
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => contactuspage()));
            },
          ),
        ],
      ),
    ));
  }
}
