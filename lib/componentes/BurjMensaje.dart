import 'package:flutter/material.dart';

class BurbujaMensaje extends StatelessWidget {
  final String mensaje;
  const BurbujaMensaje({super.key, required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:5, right: 5, top: 10),
      child: Container(
        color: const Color.fromARGB(255, 181, 213, 218),
        child: Text(mensaje),
      ),
    );
  }
}