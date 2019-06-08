import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data {
  final DateTime lastPeriod;
  final DateTime birthYear;
  final int periodLength;
  final int cycleLength;

  Data(this.lastPeriod, this.birthYear, this.periodLength, this.cycleLength);
}

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  DateTime _lastPeriod = DateTime.now();
  DateTime _yearBorn = DateTime.now();

  //bool _check = false;
  int periodCount;
  int cycleCount;

  List<DropdownMenuItem<int>> _dropDownPeriod() {
    List<int> items = [4, 5, 6, 7, 8, 9, 10, 11, 12];

    return items
        .map((periodVal) => DropdownMenuItem(
              value: periodVal,
              child: Text("$periodVal"),
            ))
        .toList();
  }

  List<DropdownMenuItem<int>> _dropDownCycle() {
    List<int> items = [21, 22, 23, 24, 25, 26, 27, 28, 29];

    return items
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text("$value"),
            ))
        .toList();
  }

  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _lastPeriod,
        firstDate: DateTime(2018),
        lastDate: DateTime(2020));

    if (picked != null && picked != _lastPeriod) {
      print("You selected $_lastPeriod");
      setState(() {
        _lastPeriod = picked;
      });
    }
  }

  Future _selectYear(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(1998),
        firstDate: DateTime(1990),
        lastDate: DateTime(20011));

    if (picked != null && picked != _yearBorn) {
      print("You selected $_yearBorn");
      setState(() {
        _yearBorn = picked;
      });
    }
  }

  Future<bool> saveStringPreference(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    return prefs.commit();
  }

  Future<bool> saveIntPreference(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
    return prefs.commit();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Info Your Period"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
            child: ListTile(
              leading: Icon(
                Icons.face,
                color: Colors.deepPurpleAccent,
              ),
              title: Text(
                'Tell us a little about yourself',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text("Tap the calendar icons to select dates. Save After."),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8.0,
            margin: EdgeInsets.only(
                left: 12.0, right: 12.0, top: 15.0, bottom: 5.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'When was your last period?',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    /* Text(
                      "forgot?",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Checkbox(
                      onChanged: (bool e) => myCheckState(),
                      value: _check,
                    ),*/
                    Text(
                        "Selected: ${_lastPeriod.day.toString()}/${_lastPeriod.month.toString().padLeft(2, '0')}/${_lastPeriod.year.toString().padLeft(2, '0')}"),
                  ],
                ),
                leading: IconButton(
                  icon: Icon(Icons.calendar_today),
                  color: Colors.deepPurpleAccent,
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8.0,
            margin: EdgeInsets.only(
                left: 12.0, right: 12.0, top: 15.0, bottom: 5.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'Date of birth',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                    "Selected ${_yearBorn.year.toString().padLeft(2, '0')}"),
                leading: IconButton(
                  icon: Icon(Icons.calendar_today),
                  color: Colors.deepPurpleAccent,
                  onPressed: () {
                    _selectYear(context);
                  },
                ),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8.0,
            margin: EdgeInsets.only(
                left: 12.0, right: 12.0, top: 15.0, bottom: 5.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'Averagely how long does your period last?',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: DropdownButton(
                  hint: Text("Select a number"),
                  value: periodCount,
                  items: _dropDownPeriod(),
                  onChanged: (value) {
                    setState(() {
                      periodCount = value;
                    });
                  },
                ),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8.0,
            margin: EdgeInsets.only(
                left: 12.0, right: 12.0, top: 15.0, bottom: 5.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'How long is your cycle?',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: DropdownButton(
                  hint: Text("Select a number"),
                  value: cycleCount,
                  items: _dropDownCycle(),
                  onChanged: (value) {
                    setState(() {
                      cycleCount = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: RaisedButton(
        child: Text(
          "Save",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.deepPurpleAccent,
        onPressed: saveData,
      ),
    );
  }

  void saveData() {
    Data data = Data(_lastPeriod, _yearBorn, periodCount, cycleCount);
    print("Here is the data !!!!!!!!!!!!!!!!!!!!!!! ${data.periodLength}");
    saveStringPreference("lastPeriod", data.lastPeriod.toString());
    saveStringPreference("birthYear", data.birthYear.toString());
    saveIntPreference("periodLength", data.periodLength);
    saveIntPreference("cycleLength", data.cycleLength);
  }
  /*myCheckState() {
    setState(() {
      if (_check) {
        _check = !_check;
        print(_check);
      } else {
        _check = !_check;
        print(_check);
      }
    });
  }*/
}
