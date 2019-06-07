import 'package:flutter/material.dart';
import 'package:trac/src/auth.dart';
import 'package:trac/src/screens/login.dart';
import 'package:trac/src/screens/home.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return Login(
          auth: widget.auth,
          onSignIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return Home(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
    return Scaffold(
      body: Center(
        child: Text("Something went Wrong"),
      ),
    );
  }
}
