import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;

  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('Name = $nameString, Email = $emailString, Pass = $passwordString');
        }
      },
    );
  }

  Widget nameTextFormField() {
    return Container(
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Name :',
            hintText: 'Request',
          ),
          validator: (String value) {
            if (value.length == 0) {
              return 'Please Fill Name In Blank';
            }
          },
          onSaved: (String value) => nameString = value,
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return Container(
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Email :',
            hintText: 'you@abc.com',
          ),
          validator: (String value) {
            if (!((value.contains('@')) && (value.contains('.')))) {
              return 'Please Type Email Format';
            }
          },
          onSaved: (String value) {
            emailString = value;
          },
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Container(
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Password :',
            hintText: 'More 6 Charactor',
          ),
          validator: (String value) {
            if (value.length <= 5) {
              return 'More 6 Charactor';
            }
          },
          onSaved: (String value) => passwordString = value,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Register'),
        actions: <Widget>[uploadButton()],
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(top: 80.0),
          alignment: Alignment(0, -1),
          child: Column(
            children: <Widget>[
              nameTextFormField(),
              emailTextFormField(),
              passwordTextFormField(),
            ],
          ),
        ),
      ),
    );
  }
}
