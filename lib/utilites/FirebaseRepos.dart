import 'package:DropBox/utilites/FirebaseMEthods.dart';

class FirebaseRepos
{
  FirebaseMethods methods=new FirebaseMethods();
  Future<void> createUserWithEmailAndPassword(String _email,String _password)=>methods.createUserWithEmailAndPassword(_email, _password);
  Future<void> loginWithEmailAndPassword(String _email, String _password) =>methods.loginWithEmailAndPassword(_email, _password);
  Future<void> addUser(String userName, String email) =>methods.addUser(userName, email);
  Future<void> addUserData(String email, String itemName)=>methods.addUserData(email, itemName);
  Future<bool> checkEmail(String _email)=> methods.checkEmail(_email);
}