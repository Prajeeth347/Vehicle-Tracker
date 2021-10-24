import 'package:vehicle/main.dart';
import 'package:flutter/material.dart';

class forgotPasswordpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(3),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'UserName',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => loginpage()));
              },
              child: Text(
                'Go back to login page',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Conformation'),
                    content: const Text('Do you want to change your password?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => loginpage()))
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => forgotPasswordpage())),
                        child: const Text('No'),
                      ),
                    ],
                  ),
                ),
                child: const Text(
                  'Reset password to default',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            )
          ],
        ),
      ),
    ));
  }
}
