import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/screens/shared/loading.dart';
import 'package:brew_crew/screens/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({Key key, this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.indigo[100],
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.indigo[500],
              title: Text('Sign in to Brew Crew'),
              actions: <Widget>[
                TextButton.icon(
                  label: Text('Register'),
                  icon: Icon(Icons.person),
                  style: TextButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        onChanged: (val) => setState(() => email = val),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        onChanged: (val) => setState(() => password = val),
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ElevatedButton(
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.pinkAccent),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic res = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (res == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Could not sign in with those credentials';
                                });
                              }
                            }
                          }),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                )),
          );
  }
}
