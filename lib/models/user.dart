import 'package:brew_crew/models/brew.dart';

class LocalUser {
  final String uid;

  LocalUser({this.uid}); // Name paramerter using { }
}

class UserData {
  final String uid;
  final Brew brew;

  UserData({this.uid, this.brew});
}
