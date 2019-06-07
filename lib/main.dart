import 'package:flutter/material.dart';
import 'package:trac/src/screens/rootPage.dart';
import 'package:trac/src/auth.dart';

main() => runApp(Trac());

class Trac extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Trac Application',
        theme: ThemeData(
            buttonColor: Colors.deepPurpleAccent,
            primarySwatch: Colors.deepPurple,
            primaryColor: Colors.deepPurple),
        home: RootPage(
          auth: Auth(),
        ));
  }
}
