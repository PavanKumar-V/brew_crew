import 'package:brew_crew/screens/authenticate/signin.dart';
import 'package:brew_crew/service/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text("Sign Up to brew crew"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign in"))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (val) => val!.isEmpty ? 'Enter email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter Email', labelText: 'Email'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (val) => val!.length < 6
                            ? 'Enter password 6+ characters'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Enter Password', labelText: 'Password'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Please enter valid email';
                                loading = false;
                              });
                            }
                          }
                        },
                        color: Colors.pink,
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(error,
                          style: TextStyle(fontSize: 14.0, color: Colors.red))
                    ]),
                  ),
                )),
          );
  }
}
