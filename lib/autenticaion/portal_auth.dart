import 'package:firebase/autenticaion/login_registro.dart';
import 'package:firebase/paginas/pagInicio.dart';
import 'package:firebase/paginas/pagLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PortalAuth extends StatelessWidget {
  const PortalAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return paginainicio();
            } else {
              return LoginRegistro();
            }
          }),
    );
  }
}
