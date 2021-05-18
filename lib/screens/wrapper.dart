import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Return either Home or Authenicate widget depending on the user state if logged in or not
    return StreamProvider<LocalUser>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: AnotherWrapper(),
      ),
    );
  }
}

class AnotherWrapper extends StatelessWidget {
  const AnotherWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LocalUser>(context);

    return user == null ? Authenticate() : Home();
  }
}
