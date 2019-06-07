import 'package:flutter/material.dart';
import 'package:trac/src/auth.dart';

class Login extends StatefulWidget {
  Login({this.auth, this.onSignIn});
  final BaseAuth auth;
  final VoidCallback onSignIn;
  @override
  _LoginState createState() => _LoginState();
}

enum FormType { login, register }

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool isloading = false;
  FormType _formType = FormType.login;
  String _email;
  String _password;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          print("trying to login");
          String userId =
              await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Sigined in as $userId');
        } else {
          print("trying to register");
          String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);
          print('Registered as $userId');
        }
        widget.onSignIn();
      } catch (e) {
        print('Error $e');
      }
    }
  }

  void loginPage() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  void registerPage() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildInputs() + buildButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    if (_formType == FormType.login) {
      return [
        CircleAvatar(
          maxRadius: 40,
          minRadius: 20,
          child: Image.asset('assets/avatar.png'),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
            validator: (value) =>
                value.isEmpty ? "Please input an email" : null,
            onSaved: (value) => _email = value,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) =>
                value.isEmpty ? "Please input a password" : null,
            onSaved: (value) => _password = value,
          ),
        ),
      ];
    } else {
      return [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            autofocus: true,
            decoration: InputDecoration(labelText: 'Email Address'),
            validator: (value) =>
                value.isEmpty ? "Please input an email" : null,
            onSaved: (value) => _email = value,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) =>
                value.isEmpty ? "Please input a password" : null,
            onSaved: (value) => _password = value,
          ),
        ),
      ];
    }
  }

  List<Widget> buildButtons() {
    if (_formType == FormType.login) {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("Create account"),
                onPressed: () {
                  registerPage();
                },
              ),
              RaisedButton(
                  color: Colors.deepPurpleAccent,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: validateAndSubmit),
            ],
          ),
        )
      ];
    } else {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("Already have an account? Login"),
                onPressed: loginPage,
              ),
              RaisedButton(
                color: Colors.deepPurpleAccent,
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: validateAndSubmit,
              )
            ],
          ),
        )
      ];
    }
  }
}
