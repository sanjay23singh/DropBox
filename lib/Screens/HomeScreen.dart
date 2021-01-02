import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../utilites/FirebaseRepos.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageApp(),
    );
  }
}

class HomePageApp extends StatefulWidget {
  @override
  _HomePageAppState createState() => _HomePageAppState();
}

class _HomePageAppState extends State<HomePageApp> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseRepos _repos = new FirebaseRepos();
  List<String> myItems = [];
  String userName = 'Hello';
  String email = FirebaseAuth.instance.currentUser.email;


  Future<File> pickFiles() async {
    File file= await FilePicker.getFile();
    return file;
  //  FilePickerResult result=  await FilePicker.platform.pickFiles();
  //  if(result!=null)
  //   return File(result.files.single.path);

  //   return null;
  }

  alertDialog(String name, BuildContext context) {
    return AlertDialog(
      title: Text("Upload File"),
      content: Text(name),
      actions: [
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Upload"),
          onPressed: () {
            // Navigator.of(context).pop();
            _repos.addUserData(email, name).then((value) {
              Navigator.of(context).pop();
            });
          },
        ),
      ],
    );
  }

  singleTile(List<QueryDocumentSnapshot> list, int index) {
    return ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: Image.asset('assets/dragonBall.png')),
        title: Text(
          list[index].data()['itemName'],
          style: GoogleFonts.robotoMono(
            textStyle: TextStyle(color: Colors.white),
          ),
        ));
  }

  bodyApp(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('items')
          .where('email', isEqualTo: email)
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return ListView.builder(
          itemBuilder: (context, index) {
            if (snapshot.hasData && snapshot.data != null) {
              return singleTile(snapshot.data.docs, index);
            } else {
              return Container(
                height: 0,
              );
            }
          },
          itemCount: snapshot.data == null ? 0 : snapshot.data.docs.length,
        );
      },
    );
  }

  initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get()
        .then((value) {
      setState(() {
        userName = 'Hello ${value.data()['userName']} !!'.toLowerCase();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(userName, style: GoogleFonts.hind()),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).popAndPushNamed('login');
                });
              }),
        ],
      ),
      body: bodyApp(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickFiles().then((File file) {
            if (file != null) {
              print(file.path);
              List<String> li = file.uri.path.split('/');
              String name=li[li.length-1];
              print(name);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alertDialog(name, context);
                },
              );
            }
            else print("I dont haba any file");
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
