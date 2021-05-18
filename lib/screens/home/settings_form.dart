import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/services/database.dart';

class SettingsForm extends StatefulWidget {
  SettingsForm({Key key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LocalUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData.brew.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    onChanged: (val) => setState(() => _currentName = val),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // dropdown
                  DropdownButtonFormField(
                    value: _currentSugars ?? userData.brew.sugars,
                    decoration: textInputDecoration,
                    items: sugars
                        .map((sugar) => DropdownMenuItem(
                              value: sugar,
                              child: Text('$sugar sugars'),
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),
                  // slider
                  Slider(
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    value:
                        (_currentStrength ?? userData.brew.strength).toDouble(),
                    activeColor: Colors
                        .brown[_currentStrength ?? userData.brew.strength],
                    inactiveColor: Colors
                        .brown[_currentStrength ?? userData.brew.strength],
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  ElevatedButton(
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),
                    onPressed: () async {
                      print(_currentName);
                      print(_currentSugars);
                      print(_currentStrength);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
