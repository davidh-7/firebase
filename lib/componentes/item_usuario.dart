import 'dart:typed_data';
import 'package:flutter/material.dart';

class ItemUsuario extends StatelessWidget {
  final Function()? onTap;
  final String emailUsuaio;
  final Uint8List? imagenPerfil;

  const ItemUsuario({
    super.key,
    required this.emailUsuaio,
    required this.onTap,
    this.imagenPerfil,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 140, 191, 233),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (imagenPerfil != null)
                ClipOval(
                  child: Image.memory(
                    imagenPerfil!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                )
              else
                const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                ),
              const SizedBox(width: 12),
              Text(emailUsuaio),
            ],
          ),
        ),
      ),
    );
  }
}