import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isProfile = true;
  final formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _birth;

  Future<bool> saveStringPreference(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    return prefs.commit();
  }

  Future<String> getStringPreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key);
    return value;
  }

  saveData() async {
    final form = formKey.currentState;
    form.save();
    await saveStringPreference("Name", "$_name");
    await saveStringPreference("Email", "$_email");
    getData();
    rebuild();
  }

  getData() async {
    _name = await getStringPreference("Name");
    _email = await getStringPreference("Email");
    _birth = await getStringPreference("birthYear");
    //_birth = DateFormat("yyyy-MM-dd HH:mm:ss:ms").parse(birthString);
    setState(() {});
  }

  rebuild() {
    setState(() {
      isProfile = !isProfile;
      print(isProfile);
      //print(_birth);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (isProfile) {
      return userProfile();
    } else {
      return Form(
        key: formKey,
        child: updateUser(),
      );
    }
  }

  Widget userProfile() {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              color: Colors.deepPurple.withOpacity(0.8),
            ),
            clipper: getClipper(),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage('assets/avatar.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.deepPurple)
                      ]),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  "$_name",
                  style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "$_email",
                  style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "${_birth.substring(0, 11)}",
                  style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 50.0,
                ),
                FloatingActionButton(
                  child: Icon(Icons.edit),
                  onPressed: rebuild,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget updateUser() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Update Profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              onSaved: (value) => _name = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onSaved: (value) => _email = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25, top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: rebuild,
                  child: Text("Cancel"),
                ),
                RaisedButton(
                  onPressed: saveData,
                  child: Text("Update"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 2);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
