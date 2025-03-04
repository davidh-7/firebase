import 'package:cloud_firestore/cloud_firestore.dart';

class Mesaje {
  final String idAutor;
  final String emailAutor;
  final String idReceptor;
  final String mensaje;
  final Timestamp timestamp;

  Mesaje({
      required this.idAutor,
      required this.emailAutor,
      required this.idReceptor,
      required this.mensaje,
      required this.timestamp
      });

Map<String, dynamic> devuelveMensaje(){
  return {
    "idAutor": idAutor,
    "emailAutor": emailAutor,
    "idReceptor": idReceptor,
    "mensaje": mensaje,
    "timestamp": timestamp
  };
}



}
