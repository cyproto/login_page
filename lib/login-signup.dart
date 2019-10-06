import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginSignUpState();
}

enum form {signup , login}
var _formKey = GlobalKey<FormState>();
var _form = form.login;
var _errorMsg;
var _email = "";
var _password = "";

class _LoginSignUpState extends State<LoginSignUp>{
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('Flutter login template', textAlign: TextAlign.center,),
      ),
      body: Stack(
        children: <Widget>[
          _body(height,width),
          //_showProgress(),
        ],
      ),
    );
  }
}

changeState c = new changeState();
Widget _body(double height, double width){
  return new Container(
    child: new Form(
      key: _formKey,
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          _showAvatar(height,width),
          _emailField(height,width),
          _passwordField(height,width),
          _loginBut(height,width),
          c._toggleSignupAndLogin(height,width),
          _showErrMsg(),
        ],
      )
    ),
  );
}

Widget _showAvatar(double height, double width){
  return new Hero(tag: 'hero',
      child: Padding(padding: EdgeInsets.fromLTRB(width*0.5-70, 50, width*0.5-70, 0.0),
        child: CircleAvatar(
          radius: 70,
          backgroundImage: ExactAssetImage('assets/images/avatar.png'),
          backgroundColor: Colors.transparent,
        ),
      )
  );
}

Widget _emailField(double height, double width){
  return Padding(
    padding: EdgeInsets.fromLTRB(width*0.05,50 ,width*0.05, 0),
    child: new TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: new InputDecoration(
          prefixIcon: new Icon(
            Icons.email,
            color: Colors.black,
          ),
        hintText: 'Email',
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(50.0)
          )
        ),
        filled: true,
        hintStyle: new TextStyle(color: Colors.grey),
        fillColor: Colors.white54
      ),
      validator: (value) => value.isEmpty ? "Email can\'t be empty." : null,
      onSaved: (value) => _email = value.trim(),
    ),
  );
}

Widget _passwordField(double height, double width){
  return Padding(
    padding: EdgeInsets.fromLTRB(width*0.05, 20, width*0.05, 20),
    child: TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.text,
      obscureText: true,
      autofocus: false,
      decoration: new InputDecoration(
        prefixIcon: new Icon(
          Icons.lock,
          color: Colors.black,
        ),
        hintText: 'Password',
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(50.0)
          )
        ),
        filled: true,
        hintStyle: new TextStyle(color: Colors.grey),
        fillColor: Colors.white54,
      ),
      validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
      onSaved: (value) => _password = value.trim(),
    ),
  );
}

Widget _loginBut(double height, double width){
  return Padding(
    padding: EdgeInsets.fromLTRB(width*0.25, 20, width*0.25, 10),
    child: ButtonTheme(
      height: 50,
    child: new RaisedButton(
      onPressed: () {},
      textColor: Colors.white54,
      color: Colors.red,
      child: _form != form.login ? new Text('Login',
        style: new TextStyle(fontSize: 20, color: Colors.white
        )): new Text('Create Account',
        style: new TextStyle(fontSize: 20, color: Colors.white)),
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50)),
    ),
    ),
  );
}

class changeState extends State<LoginSignUp> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);
  Widget _toggleSignupAndLogin(double height, double width) {
    _LoginSignUpState l = new _LoginSignUpState();
    return new Padding(
      padding: EdgeInsets.fromLTRB(width * 0.15, 10, width * 0.15, 20),
      child: FlatButton(
        child: _form != form.login
            ? new Text('Create account',
            style: new TextStyle(fontSize: 20, color: Colors.red))
            : new Text('Already have an account?',
            style: new TextStyle(fontSize: 20, color: Colors.red)),
        onPressed: _form == form.login
            ? _changeToLogin
            : _changeToSignup,
      ),
    );
  }
  void _changeToLogin(){
    _formKey.currentState.reset();
    _errorMsg = "";
    setState(() {
      _form = form.login;
    });
  }
  void _changeToSignup(){
    _formKey.currentState.reset();
    _errorMsg = "";
    setState((){
      _form = form.signup;
    });
  }
}

Widget _showErrMsg(){
  if( _errorMsg != null) {
      return new Text(
        _errorMsg,
        style: TextStyle(
          fontSize: 15,
          color: Colors.red,
          height: 2,
        ),
      );
    }
  else{
    return new Container(
      height: 0,
    );
  }
}
//Widget _showProgress() {

//if(_isLoading) {
//  return Center(child: CircularProgressIndicator());
//} return Container(height: 0.0,width: 0.0,);
//}