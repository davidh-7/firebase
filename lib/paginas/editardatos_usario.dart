import 'dart:typed_data';

import 'package:firebase/mongodb/db_conf.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;

class EditardatosUsario extends StatefulWidget {
  const EditardatosUsario({super.key});

  @override
  State<EditardatosUsario> createState() => _EditardatosUsarioState();
}

class _EditardatosUsarioState extends State<EditardatosUsario> {


mongodb.Db? _db;
Uint8List? _imatgeEnBytes;
final ImagePicker imagePicker = ImagePicker();


@override
  void dispose() {
    // TODO: implement dispose
    _db?.close();
    super.dispose();
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _connectarConMongoDB().then((_) => print("Conectar con MongoDB"));
  }

Future _connectarConMongoDB() async {

  _db = await mongodb.Db.create(DBCOnf().connectionString);

  await _db!.open();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Datos Usuario"), backgroundColor: Colors.blueGrey[200],),
      body: Center(
        child: Column(
          children: [
            Text("Edita tusa datos"),
          ],
        ),
      ),
    );
  }
}
