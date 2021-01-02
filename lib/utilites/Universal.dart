import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

showSnackBar(BuildContext context, String text) {
  return Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: Duration(milliseconds: 3000),
  ));
}

showTextField(
    TextEditingController _controller, String _labelText, bool _obsecure) {
  return TextField(
    controller: _controller,
    obscureText: _obsecure,
    keyboardType: TextInputType.emailAddress,
    style: TextStyle(color: Colors.white, fontSize: 16),
    decoration: InputDecoration(
      labelText: _labelText,
      labelStyle: TextStyle(color: Colors.white, fontSize: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

//DropBox Logo
dropBoxLogo() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        height: 200,
        child: Image.asset('assets/dragonBall.png'),
      ),
      ColorizeAnimatedTextKit(
        text: [
          "DROP BOX",
        ],
        textStyle: GoogleFonts.audiowide(
          textStyle: TextStyle(fontSize: 50.0),
        ),
        colors: [
          Colors.purple,
          Colors.blue,
          Colors.yellow,
          Colors.green,
          Colors.white,
        ],
        textAlign: TextAlign.start,
        repeatForever: true,
        speed: Duration(milliseconds: 400),
      ),
    ],
  );
}
