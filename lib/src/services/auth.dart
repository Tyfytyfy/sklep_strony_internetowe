import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/models/user.dart' as custom_user;
import 'package:sklep_strony_internetowe/src/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //utworzenie obietku User
  custom_user.User? _userFromFirebaseUser(User? user) {
    return user != null
        ? custom_user.User(uid: user.uid, email: user.email)
        : null;
  }

  // auth change user stream
  Stream<custom_user.User?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email i password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print(user);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email i password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //Tworzenie nowego dokumentu z uid dla usera
      await DatabaseService(uid: user!.uid)
          .updateUserData(user.email, user.uid);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // reset password

  Future<bool> resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      print("E-mail do resetowania hasła został wysłany.");
      return true; // Resetowanie hasła zakończone sukcesem
    } catch (e) {
      print("Błąd podczas wysyłania e-maila do resetowania hasła: $e");

      // Pokaż snackbar z błędem
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Błąd podczas resetowania hasła: $e'),
          duration: const Duration(seconds: 3),
        ),
      );

      return false; // Resetowanie hasła nie powiodło się
    }
  }

  // zmiana email
  Future updateEmail(String email, BuildContext context) async {
    try {
      _auth.currentUser?.updateEmail(email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Adres e-mail został zaktualizowany'),
        ),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Błąd podczas aktualizacji e-maila'),
        ),
      );
    }
  }
}
