import 'package:firebase/firebase_options.dart';
import 'package:firebase/paginas/pagRegristro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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

//dependecias:
//flutter pub add firebase_core y firabase_auth