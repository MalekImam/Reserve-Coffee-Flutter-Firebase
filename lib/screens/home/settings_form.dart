import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

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
            decoration: textInputDecoration.copyWith(hintText: 'Name'),
            onChanged: (val) => setState(() => _currentName = val),
            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
          ),
          SizedBox(
            height: 20.0,
          ),
          // dropdown
          DropdownButtonFormField(
            value: _currentSugars ?? '0',
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
            activeColor: Colors.brown[_currentStrength ?? 100],
            inactiveColor: Colors.brown[_currentStrength ?? 100],
            value: (_currentStrength ?? 100).toDouble(),
            onChanged: (val) => setState(() => _currentStrength = val.round()),
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
  }
}