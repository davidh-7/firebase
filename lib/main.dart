import 'package:firebase/paginas/pagRegristro.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: paginaregristro(),
    );
  }
}



//Node.js
// Firebase: - Autentication, -FireStore BBDD,
//Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
//VS Code cmd: npm install -g firebase-tools
//firebase login 
//flutter pub global activate flutterfire_cli
//C:\Users\d.hernandez\AppData\Local\Pub\Cache\bin\flutterfire configure
