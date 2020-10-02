import 'package:flutter/material.dart';
import 'package:login_demo/services/auth.dart';

class LogIn extends StatefulWidget {

  final Function toggleView;
  LogIn({ this.toggleView });

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Form(
            key: _formKey,
          child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.0),
              // FlutterLogo(
              //   size: 100.0,
              // ),
              Image.network(
                'https://ak.picdn.net/shutterstock/videos/1013663273/thumb/7.jpg',
              ),
              Text(
                'SOUND FLEX',
                style: TextStyle(color: Colors.lightBlueAccent[400], fontSize: 40.0, fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                  fontFamily: 'Righteous',
                ),
              ),
              SizedBox(height: 100.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 20.0),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    fillColor: Colors.grey[350],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[100], width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[100], width:2.0)
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter a valid e-mail' : null,
                onChanged: (val) {
                  setState(() => email = val);
                }
                // decoration: InputDecoration(
                //   labelText: 'E-mail',
                //   hintText: 'Enter E-mail',
                ),
              //   keyboardType: TextInputType.emailAddress,
              // ),
              SizedBox(height: 10.0),
              TextFormField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.grey[350],
                    filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple[200], width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple[200], width:2.0)
                    ),
                  ),
                  validator: (val) => val.length < 5 ? 'Please enter at least 5 characters' : null,
                //obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                }
                // decoration: InputDecoration(
                //   labelText: 'Password',
                //   hintText: 'Enter Password',
                ),
              //   keyboardType: TextInputType.text,
              //   obscureText: true,
              // ),
              SizedBox(height: 20.0),
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: Colors.cyan[400],
                textColor: Colors.white,
                minWidth: 400.0,
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Text('Log In',
                style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() => error = 'Could not sign in');
                    }
                  }
                },
              ),
              MaterialButton (
                child: Text('Register',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.lightBlueAccent[400],
                )),
                onPressed: () {
                  widget.toggleView();
                },
              ),

              SizedBox(height: 10.0),
              // Text(
              //   error,
              //   style: TextStyle(color: Colors.red, fontSize: 14.0),
              // ),
            ],
        ),
          )
        )
      )
    );
  }
}
