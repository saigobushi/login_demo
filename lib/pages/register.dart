import 'package:flutter/material.dart';
import 'package:login_demo/pages/login.dart';
import 'package:login_demo/services/auth.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  bool _obscureText = true;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
  ]);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
        title: Text('Register'),
      ),
        body: Container(
            padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
            child: Form(
              key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey[400],
                        filled: true,
                      ),
                      validator: (val) => val.isEmpty ? 'Enter a valid e-mail' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[400],
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          )
                        ),
                        //obscureText: true,
                        onChanged: (val) => password = val,
                          validator: passwordValidator,
                    ),
                    SizedBox(height: 3.0),
                    Text('Password must be:',
                        style: TextStyle(
                          color: Colors.grey[350],
                        )
                    ),
                    Text('  At least 8 characters long',
                      style: TextStyle(
                        color: Colors.grey[350],
                      )
                    ),
                    Text('  At least 1 special character',
                        style: TextStyle(
                          color: Colors.grey[350],
                        )
                    ),

                    SizedBox(height: 10.0),
                    Text(
                      'Confirm Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      obscureText: _obscureText,
                      validator: (val) => MatchValidator(errorText: 'passwords do not match').validateMatch(val, password),
                        decoration: InputDecoration(
                          fillColor: Colors.grey[400],
                          filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            )
                        ),
                        //obscureText: true,
                    ),
                    SizedBox(height: 20.0),
                    MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        color: Colors.cyan[400],
                      textColor: Colors.white,
                        minWidth: 400.0,
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                      child: Text('Register'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()){
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if(result == null) {
                            setState(() => error = 'Please enter a valid e-mail');
                          }
                        }
                      }
                    ),
                    SizedBox(height: 10.0),
                    MaterialButton (
                      minWidth: 400.0,
                      child: Text('Go Back to Log In',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.lightBlueAccent[400],
                      )),
                      onPressed: () {
                        widget.toggleView();
                      },
                    ),
                  ],
                ),
            ),
        ),
    );
  }
}
