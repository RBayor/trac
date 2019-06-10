import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trac/src/auth.dart';
import 'package:trac/src/screens/info.dart';
import 'package:trac/src/screens/profile.dart';
import 'package:onesignal/onesignal.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

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
  DateTime nextPeriod = DateTime.now();
  DateTime _fertile = DateTime.now();
  DateTime _ovulationStart = DateTime.now();
  DateTime _ovulationEnd = DateTime.now();
  DateTime _periodStart = DateTime.now();
  DateTime _periodEnd = DateTime.now();
  handleNewDate(DateTime date) {}

  sendPush() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    var playerId = status.subscriptionStatus.userId;

    var response = await OneSignal.shared.postNotificationWithJson({
      "include_player_ids": [playerId],
      "contents": {"en": "Your Period will be on $_periodStart"}
    });

    print("!!!!!!!!!!!push res $response !!!!!!!!!!!!!!!!!!");
  }

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

  changePeriod() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now());

    if (picked != null && picked != _periodStart) {
      print("Period reset to $_periodStart");
      var week = Duration(days: 6);
      var end = Duration(days: 10);
      var duration = Duration(days: periodLength);
      DateTime periodStart = picked;
      DateTime ovulationEnd = periodStart.subtract(end);
      DateTime ovulationStart = ovulationEnd.subtract(week);
      DateTime periodEnd = periodStart.add(duration);
      setState(() {
        _ovulationStart = ovulationStart;
        _ovulationEnd = ovulationEnd;
        _periodStart = periodStart;
        _periodEnd = periodEnd;
      });
    }
  }

  calculateFertility(DateTime lastPeriod, DateTime birthyear, int periodLength,
      int cycleLength) {
    if (periodLength == null) periodLength = 5;
    if (cycleLength == null) cycleLength = 27;
    var week = Duration(days: 6);
    var end = Duration(days: 10);
    var duration = Duration(days: periodLength);
    DateTime ovulationStart = lastPeriod.add(week);
    DateTime ovulationEnd = ovulationStart.add(end);
    DateTime periodStart = ovulationEnd.add(end);
    DateTime periodEnd = periodStart.add(duration);

    setState(() {
      _ovulationStart = ovulationStart;
      _ovulationEnd = ovulationEnd;
      _periodStart = periodStart;
      _periodEnd = periodEnd;
    });
    print("last period $lastPeriod");
    print("Ovulation $ovulationStart");
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext contetxt) {
          return AlertDialog(
            title: Text("Logout"),
            content: Text("Are you sure you want to logout?"),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  _signOut();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _signOut() async {
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

  notify() {
    print(
        "!!!!!!!!!!! now ${_periodStart.compareTo(DateTime.now())}!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!! next P $_periodStart !!!!!!!!!!!!!!!!!");
    if (_periodStart.compareTo(DateTime.now()) == 0 ||
        _periodStart.compareTo(DateTime.now()) == 1) {
      Future.delayed(Duration(seconds: 5)).then((onValue) => sendPush());
    }
  }

  void refresh() async {
    try {
      this.lastPeriod = DateTime.parse(await getStringPreference("lastPeriod"));
      this.birthYear = DateTime.parse(await getStringPreference("birthYear"));
      this.periodLength = await getIntPreference("periodLength");
      this.cycleLength = await getIntPreference("cycleLength");
      calculateFertility(lastPeriod, birthYear, periodLength, cycleLength);
    } catch (e) {
      print("No Saved data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Track Your Period'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Log Data',
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Info()));
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Refresh Data',
            onPressed: refresh,
          ),
          IconButton(
            icon: Icon(Icons.person_pin),
            tooltip: 'Profile Page',
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
          IconButton(
            tooltip: 'Logout',
            icon: Icon(Icons.exit_to_app),
            onPressed: _showDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
                elevation: 8.0,
                margin: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                      title: Text(
                        "Calendar",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Container(
                        child: Calendar(
                          showTodayAction: false,
                          isExpandable: false,
                          initialCalendarDateOverride: _fertile,
                          onDateSelected: (_today) => handleNewDate(
                                _today,
                              ),
                        ),
                      )),
                )),
            Card(
              elevation: 8.0,
              margin: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(
                  "Ovulation",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Start ${_ovulationStart.day} / ${_ovulationStart.month} / ${_ovulationStart.year}",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "End ${_ovulationEnd.day} / ${_ovulationEnd.month} / ${_ovulationEnd.year}",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 8.0,
              margin: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(
                  "Period",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Start: ${_periodStart.day} / ${_periodStart.month} / ${_periodStart.year}",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "End: ${_periodEnd.day} / ${_periodEnd.month} / ${_periodEnd.year}",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FloatingActionButton(
              tooltip: "Log Period",
              elevation: 10.0,
              child: Icon(Icons.calendar_today),
              onPressed: changePeriod),
          SizedBox(
            height: 60,
            width: 40,
            child: IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Icon(
                Icons.notification_important,
                size: 60,
                color: Colors.deepPurple,
              ),
              onPressed: notify,
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
