import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/bew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/service/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPannel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew?>?>.value(
      catchError: (_, ___) => null,
      initialData: [],
      value: DatabaseService(uid: '').brews,
      child: Scaffold(
          backgroundColor: Colors.brown[40],
          appBar: AppBar(
            title: Text("Brew Crew"),
            backgroundColor: Colors.brown[400],
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text("logout"),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('settings'),
                onPressed: () {
                  _showSettingsPannel();
                },
              )
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )),
            child: BrewList(),
          )),
    );
  }
}
