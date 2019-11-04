import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
    @override
    State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType{
  Login,
  Register
  }

class _LoginPageState extends State<LoginPage>{
  
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.Login;

  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.Register; 
    });
  }

  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.Login;  
    });
  } 

  bool validAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void validAndSubmit() async{
    if(validAndSave()){
      try {
        if(_formType == FormType.Login) {
          FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
          print('Signed in: ${user.uid}');
        }
        else {
          FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
          print('Registered user: ${user.uid}');
        }
      }
      catch(e) { 
        print(e);
      }
    }
  }

    @override 
    Widget build(BuildContext context){
      List<Widget> buildInputs(){
        return [
          new TextFormField(
            decoration: new InputDecoration(labelText: 'Email'),
            validator: (value) => value.isEmpty ? 'Email cannot be empty' : null,
            onSaved: (value) => _email = value,
          ),
          new TextFormField(
            decoration: new InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) => value.isEmpty ? 'Password cannot be Empty' : null,
            onSaved: (value) => _password = value,
          )
        ];
      }

      List<Widget> buildOutputs(){
        if (_formType == FormType.Login) {
          return [
            new RaisedButton(
              child: new Text('Login', style: new TextStyle(fontSize: 20.0), ),
              onPressed: validAndSave,
            ),
            new FlatButton(
              child: new Text('Create account here', style: new TextStyle(fontSize: 10.0),),
              onPressed: moveToRegister,
            )
          ];
        }
        else {
          return [
            new RaisedButton(
              child: new Text('Register', style: new TextStyle(fontSize: 20.0), ),
              onPressed: validAndSave,
            ),
            new FlatButton(
              child: new Text('Already have an account? Log in', style: new TextStyle(fontSize: 10.0),),
              onPressed: moveToLogin,
            )
          ];
        }
      }
      
      return Scaffold(
        appBar: new AppBar(
          title: new Text('Sign-in page'),
        ),
        body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildInputs() + buildOutputs(),
            ),
          ),
        ),
      );


      
    } 
}



