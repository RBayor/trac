import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trac/src/auth.dart';
import 'package:trac/src/screens/info.dart';

class Home extends StatefulWidget {
  Home({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime lastPeriod;
  DateTime birthYear;
  int periodLength;
  int cycleLength;

  Future<String> getStringPreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key);
    return value;
  }

  Future<int> getIntPreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(key);
    return value;
  }

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print('Error signing out $e');
    }
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    this.lastPeriod = DateTime.parse(await getStringPreference("lastPeriod"));
    this.birthYear = DateTime.parse(await getStringPreference("birthYear"));
    this.periodLength = await getIntPreference("periodLength");
    this.cycleLength = await getIntPreference("cycleLength");

    print(
        "LP is $lastPeriod, BY is $birthYear, PL is $periodLength, CL is $cycleLength");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Track Your Period'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Info()));
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refresh,
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: refresh,
          ),
          IconButton(
            icon: Icon(Icons.person_pin),
            onPressed: refresh,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Log Period",
        elevation: 10.0,
        child: Icon(Icons.calendar_today),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
