import 'package:DropBox/utilites/FirebaseRepos.dart';
import 'package:DropBox/utilites/Universal.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterScreenApp(),
    );
  }
}

class RegisterScreenApp extends StatefulWidget {
  @override
  RegisterScreenAppState createState() => RegisterScreenAppState();
}

class RegisterScreenAppState extends State<RegisterScreenApp> {
  FirebaseRepos _repos = new FirebaseRepos();
  bool isRotating = false;
  TextEditingController _userName = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    child: Center(child: dropBoxLogo()),
                  )),
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: showTextField(_userName, 'Username', false)),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: showTextField(
                                _email, 'Enter your email', false)),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: showTextField(_password, 'Password', true)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already registered ?, ",
                                  style: TextStyle(color: Colors.white)),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('login');
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width - 50,
                          height: 40,
                          child: RaisedButton(
                            onPressed: () {
                              if (EmailValidator.validate(_email.text) &&
                                  _userName.text.length >= 4 &&
                                  _password.text.length >= 6) {
                                _repos.checkEmail(_email.text).then((value) {
                                  if (!value) {
                                    setState(() {
                                      isRotating = true;
                                    });
                                    _repos
                                        .createUserWithEmailAndPassword(
                                            _email.text, _password.text)
                                        .then((value) {
                                      _repos
                                          .addUser(_userName.text, _email.text)
                                          .then((value) {
                                        Navigator.of(context)
                                            .popAndPushNamed('homeScreen');
                                      });
                                    });
                                  } else {
                                    showSnackBar(context,
                                        "Account already exists, please Login!");
                                    setState(() {
                                      _email.clear();
                                      _userName.clear();
                                      _password.clear();
                                    });
                                  }
                                });
                              } else if (!EmailValidator.validate(_email.text))
                                showSnackBar(context, "Invalid Email");
                              else if (_userName.text.length < 4)
                                showSnackBar(context,
                                    'username must be minimum of length 4');
                              else
                                showSnackBar(context,
                                    'password should be minimum of length 6');
                            },
                            child: Text("Register",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          if (isRotating)
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black54,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
