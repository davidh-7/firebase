import 'package:firebase_auth/firebase_auth.dart';

class ServicioAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//hacer regristro
  Future<UserCredential> regristroEmailPass(String email, password) async {
    try {
      UserCredential crendencialUsuario = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return crendencialUsuario;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
