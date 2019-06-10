import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
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
                  "Jane Doe",
                  style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "janedoe@email.com",
                  style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "12/01/1998",
                  style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 50.0,
                ),
                FloatingActionButton(
                  child: Icon(Icons.edit),
                  onPressed: () {},
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
    return null;
  }
}
