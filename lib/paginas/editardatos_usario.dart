import 'dart:io';
import 'dart:typed_data';

import 'package:firebase/autenticaion/servicio_auth.dart';
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
      appBar: AppBar(
        title: Text("Editar Datos Usuario"),
        backgroundColor: Colors.blueGrey[200],
      ),
      body: Center(
        child: Column(
          children: [
            Text("Edita tusa datos"),

            _imatgeEnBytes != null ? Image.memory(_imatgeEnBytes!,height: 200,) : Text("No se a selecionado ninguna imagen"),

            SizedBox(height: 20,),

            ElevatedButton(onPressed: (){
              _SubirImagenes();
            }, child: Text("Subir Imagen")),

            ElevatedButton(onPressed: (){
              _recuperarImagen();
            }, child: Text("Recuperar Imagen")),
          ],
        ),
      ),
    );
  }

  Future _SubirImagenes() async {
    final imgSelecionada =
        await imagePicker.pickImage(source: ImageSource.gallery);

    //si a enconrado una imagen
    if (imgSelecionada != null) {
      //para guardar la imagen pasar a bytes
      final imgBytes = await File(imgSelecionada.path).readAsBytes();

      //pasar bytes al formato de mongodb
      final DatosBinaries = mongodb.BsonBinary.from(imgBytes);

      final collection = _db!.collection("imagenes_perfiles");

      await collection.replaceOne({
        "id_usuario_firebase": ServicioAuth().getUsuarioActual()!.uid
      }, {
        "id_usuario_firebase": ServicioAuth().getUsuarioActual()!.uid,
        "nombre_foto": "foto_perfil",
        "imagen": DatosBinaries,
        "fecha_subida": DateTime.now()
      },
          //si no encuentra el documento lo crea
          upsert: true);
      print("Imagen Subida");
    }
  }

  Future<void> _recuperarImagen() async {
    try {
      final collection = _db!.collection("imagenes_perfiles");
      final doc = await collection.findOne(
          {"id_usuario_firebase": ServicioAuth().getUsuarioActual()!.uid});

      if (doc != null && doc["imagen"] != null) {
        final imgBson = doc["imagen"] as mongodb.BsonBinary;

        setState(() {
          _imatgeEnBytes = imgBson.byteList;
        });
      }
      {
        print("Error encontrando la imagen");
      }
    } catch (e) {
      print("Error intentando recuperar la imagen");
    }
  }
}
