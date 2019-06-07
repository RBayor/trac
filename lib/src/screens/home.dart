import 'package:flutter/material.dart';
import 'package:trac/src/auth.dart';

class Home extends StatefulWidget {
  Home({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print('Error signing out $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Track Your Period'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _signOut,
          )
        ],
      ),
    );
  }
}
