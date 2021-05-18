import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      initialData: null,
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.indigo[100],
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Brew Crew'),
          backgroundColor: Colors.indigo[500],
          actions: <Widget>[
            TextButton.icon(
              label: Text('logout'),
              icon: Icon(Icons.person),
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              label: Text('settings'),
              icon: Icon(Icons.settings),
              onPressed: () => _showSettingsPanel(),
              style: TextButton.styleFrom(primary: Colors.white),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
