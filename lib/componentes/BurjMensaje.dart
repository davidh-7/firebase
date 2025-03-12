import 'package:firebase/autenticaion/servicio_auth.dart';
import 'package:flutter/material.dart';

class BurbujaMensaje extends StatelessWidget {
  final String mensaje;
  final String idAutor;
  const BurbujaMensaje({super.key, required this.mensaje, required this.idAutor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Align(
        alignment: idAutor == ServicioAuth().getUsuarioActual()!.uid ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: idAutor == ServicioAuth().getUsuarioActual()!.uid? const Color.fromARGB(255, 166, 250, 201) : const Color.fromARGB(255, 181, 213, 218),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(mensaje),
          ),
        ),
      ),
    );
  }
}
