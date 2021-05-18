import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo[500],
        title: Text('Sign up to Brew Crew'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (val) => setState(() => email = val),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (val) => setState(() => password = val),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),
                  onPressed: () async {
                    print(email);
                    print(password);
                  },
                )
              ],
            ),
          )),
    );
  }
}
