import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/mesaje.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/mongodb/db_conf.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;
import 'dart:typed_data';

class ServicioChat {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  mongodb.Db? _db;

  ServicioChat() {
    _conectarConMongoDb();
  }

  Future<void> _conectarConMongoDb() async {
    try {
      if (_db == null || !_db!.isConnected) {
        _db = await mongodb.Db.create(DBCOnf().connectionString);
        await _db!.open();
        print("Conexión a MongoDB establecida");
      }
    } catch (e) {
      print("Error al conectar con MongoDB: $e");
    }
  }

  Future<Uint8List?> _obtenerImagenUsuario(String uid) async {
    try {
      await _conectarConMongoDb();
      final collection = _db!.collection("imagenes_perfiles");
      final doc = await collection.findOne({"id_usuario_firebase": uid});

      if (doc != null && doc["imagen"] != null) {
        final imgBson = doc["imagen"] as mongodb.BsonBinary;
        return imgBson.byteList;
      }
      return null;
    } catch (e) {
      print("Error al obtener imagen para UID $uid: $e");
      return null;
    }
  }

  Stream<List<Map<String, dynamic>>> getUsuarios() {
    return _firestore.collection("Usuarios").snapshots().asyncMap((event) async {
      List<Map<String, dynamic>> usuarios = [];
      for (var doc in event.docs) {
        Map<String, dynamic> data = doc.data();
        if (data['uid'] != null) {
          data['imagenPerfil'] = await _obtenerImagenUsuario(data['uid']);
        }
        usuarios.add(data);
      }
      return usuarios;
    });
  }

  Future<void> enviarMensaje(String idReceptor, String mensaje) async {
    String idUsuarioActual = _auth.currentUser!.uid;
    String emailUsuaioActual = _auth.currentUser!.email!;
    Timestamp timestamp = Timestamp.now();

    Mesaje nuevoMensaje = Mesaje(
        idAutor: idUsuarioActual,
        emailAutor: emailUsuaioActual,
        idReceptor: idReceptor,
        mensaje: mensaje,
        timestamp: timestamp);

    List<String> idUsuarios = [idUsuarioActual, idReceptor];
    idUsuarios.sort();
    String idSalaChat = idUsuarios.join("_");

    await _firestore
        .collection("SalasChat")
        .doc(idSalaChat)
        .collection("Mensajes")
        .add(nuevoMensaje.devuelveMensaje());
  }

  Stream<QuerySnapshot> getMensajes(String idUsuarioActual, String idReceptor) {
    List<String> idUsuarios = [idUsuarioActual, idReceptor];
    idUsuarios.sort();
    String idSalaChat = idUsuarios.join("_");

    return _firestore
        .collection("SalasChat")
        .doc(idSalaChat)
        .collection("Mensajes")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}