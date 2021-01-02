import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMethods {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference items = FirebaseFirestore.instance.collection('items');

  //1
  Future<void> createUserWithEmailAndPassword(String _email, String _password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
    } catch (e) {
      print(e.toString());
    }
  }

//2
  Future<void> loginWithEmailAndPassword(String _email, String _password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      print('Sign in Successful');
    } catch (e) {
      print(e);
    }
  }

  //3
  Future<void> addUser(String userName, String email) async {
    await users.doc(email).set({'userName': userName, 'email': email});
  }
  
  //4
  Future<void> addUserData(String email, String itemName)
  async{
    await items.add({
      'email' :email,
      'itemName' :itemName,
      'time' : DateTime.now(),
    });
  }

  //5
  Future<bool> checkEmail(String _email)
  async{
    QuerySnapshot response= await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: _email).get();
    int len=response.docs.length;
    return len>0;
  }
}
