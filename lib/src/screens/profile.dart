import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("More"),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.deepPurple),
                    title: Text("Profile"),
                    onTap: () {},
                  ),
                ),
                Card(
                  elevation: 8.0,
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.healing, color: Colors.deepPurple),
                    title: Text("Health Profile"),
                    onTap: () {},
                  ),
                ),
                Card(
                  elevation: 8.0,
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.deepPurple),
                    title: Text("Cycle & Ovulation"),
                    onTap: () {},
                  ),
                ),
                Card(
                  elevation: 8.0,
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.report, color: Colors.deepPurple),
                    title: Text("Graphs & Reports"),
                    onTap: () {},
                  ),
                ),
                Card(
                  elevation: 8.0,
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading:
                        Icon(Icons.pregnant_woman, color: Colors.deepPurple),
                    title: Text("Pregnancy Mode"),
                    onTap: () {},
                  ),
                ),
                Card(
                  elevation: 8.0,
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.alarm_on, color: Colors.deepPurple),
                    title: Text("Reminders"),
                    onTap: () {},
                  ),
                ),
                Card(
                  elevation: 8.0,
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.lock_open, color: Colors.deepPurple),
                    title: Text("Access Code"),
                    onTap: () {},
                  ),
                ),
                Card(
                  elevation: 8.0,
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.settings, color: Colors.deepPurple),
                    title: Text("Settings"),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
