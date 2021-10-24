import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:vehicle/afterlogin.dart';
import 'package:vehicle/sidemenu.dart';
import 'package:flutter/material.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.android;
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
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
            nextScreen: loginpage()),
      ),
    );
  }
}

class loginpage extends StatefulWidget {
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  DateTime pre_backpress = DateTime.now();
  bool _isObscure = true;
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Vehicle Tracking',
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
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.center,
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Vehicle location and speed tracker',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: usernamecontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: 'Username',
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      obscureText: _isObscure,
                      style: TextStyle(color: Colors.white),
                      controller: passwordcontroller,
                      keyboardType: TextInputType.streetAddress,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  /*
                  Container(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => forgotPasswordpage(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 50,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          if (usernamecontroller.text ==
                                  'group14esiiits@gmail.com' &&
                              passwordcontroller.text == 'Group14') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => afterlogin()));
                          } else if (usernamecontroller.text == '') {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('No Username entered'),
                                      content:
                                          const Text('Enter a valid Username'),
                                    ));
                          } else if (passwordcontroller.text == '') {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('No Password entered'),
                                      content:
                                          const Text('Enter a valid Password'),
                                    ));
                          } else if (usernamecontroller.text == '' ||
                              passwordcontroller.text == '') {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('No Details entered'),
                                      content: const Text(
                                          'Enter a valid Username/Password'),
                                    ));
                          } else {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('Invalid Credentials'),
                                      content: const Text(
                                          'Please check the details and retry'),
                                    ));
                          }
                        },
                        child: Text('Login',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: SideMenu(),
    );
  }
}
