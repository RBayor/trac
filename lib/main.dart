import 'package:flutter/material.dart';
import 'package:trac/src/screens/rootPage.dart';
import 'package:trac/src/auth.dart';
import 'package:onesignal/onesignal.dart';

main() {
  OneSignal.shared.init("b57b8bd6-09f6-4bdd-9752-8fbc73b9bdc3");
  runApp(Trac());
}

class Trac extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
