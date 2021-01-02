import 'package:DropBox/utilites/FirebaseRepos.dart';
import 'package:DropBox/utilites/Universal.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreenApp(),
    );
  }
}

class LoginScreenApp extends StatefulWidget {
  @override
  LoginScreenAppState createState() => LoginScreenAppState();
}

class LoginScreenAppState extends State<LoginScreenApp> {
  bool isRotating = false;
  FirebaseRepos _repos = new FirebaseRepos();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  child: Center(
                    child: dropBoxLogo(),
                  ),
                )),
                Container(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                          child:
                              showTextField(_email, 'Enter your email', false)),
                      Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 12),
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
                            Text("Not registered yet ?, ",
                                style: TextStyle(color: Colors.white)),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('register');
                              },
                              child: Text(
                                "Register",
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
                                _password.text.length > 0) {
                              _repos.checkEmail(_email.text).then((value) {
                                if (value) {
                                  setState(() {
                                    isRotating = true;
                                  });
                                  _repos
                                      .loginWithEmailAndPassword(
                                          _email.text, _password.text)
                                      .then((_) {
                                    Navigator.popAndPushNamed(
                                        context, 'homeScreen');
                                  });
                                } else {
                                  showSnackBar(context,
                                      "Account does not exists, please register!");
                                  setState(() {
                                    _email.clear();
                                    _password.clear();
                                  });
                                }
                              });
                            } else if (!EmailValidator.validate(_email.text))
                              showSnackBar(context, "Invalid Email");
                            else
                              showSnackBar(
                                  context, 'password should not be empty');
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (isRotating)
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black54,
              child: Center(child: CircularProgressIndicator()),
            ),
        ]),
      ),
    );
  }
}
