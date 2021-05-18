import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Container(
      child: StreamProvider<List<Brew>>.value(
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
              )
            ],
          ),
          body: BrewList(),
        ),
      ),
    );
  }
}
