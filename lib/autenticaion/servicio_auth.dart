import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ServicioAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//usuario actual
  User? getUsuarioActual() {
    return _auth.currentUser;
  }

Future<String> getNombreUsuarioActual() async{
  String? email = _auth.currentUser!.email;
  final QuerySnapshot querySnapshot = await _firestore.collection("Usuarios").where("email", isEqualTo: email).get();

if(querySnapshot.docs.first["nom"] is Null){
  return "es nulo";
} else{
  return querySnapshot.docs.first["nom"];
}

  
}

Future<String> setNombreUsuarioActual(TextEditingController nombreUsuario) async{
  String? email = _auth.currentUser!.email;
  

  String? uiduser = _auth.currentUser!.uid;
  _firestore.collection("Usuarios").doc(uiduser).set({
        "uid": uiduser,
        "email": email,
        "nom": nombreUsuario.text,
      });
      
      return "";
}
 
//hacer logout
  Future<void> hacerlogout() async {
    return await _auth.signOut();
  }

//hacer Login
  Future<String?> loginEmailPass(String email, String password) async {
    try {
      UserCredential crendencialUsuario = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      //comprueba si el usario esta dado de alta
      final QuerySnapshot querySnapshot = await _firestore.collection("Usuarios").where("email", isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
         _firestore.collection("Usuarios").doc(crendencialUsuario.user!.uid).set({
        "uid": crendencialUsuario.user!.uid,
        "email": email,
        "nom": "",
      });
      }

      return null;

    } on FirebaseAuthException catch (e) {
      return "Error: ${e.message}";
    }
  }

//hacer regristro
  Future<String?> regristroEmailPass(String email, password) async {
    try {
      UserCredential crendencialUsuario = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      _firestore.collection("Usuarios").doc(crendencialUsuario.user!.uid).set({
        "uid": crendencialUsuario.user!.uid,
        "email": email,
        "nom": "",
      });

      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "Ya hay un usuario con este email";

        case "invalid-email":
          return "Email no valido";

        case "opertaion-not-allowed":
          return "Email i/o Password no habilitats";

        case "weak-password":
          return "hace falta una contraseña mas robusta";

        default:
          return "Error ${e.message}";
      }
    } catch (e) {
      return "Error $e";
    }
  }
}
