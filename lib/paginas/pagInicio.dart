import 'package:firebase/autenticaion/servicio_auth.dart';
import 'package:flutter/material.dart';

class paginainicio extends StatelessWidget {
  const paginainicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina Inicio"),
        actions: [
          IconButton(
            onPressed: () {
              ServicioAuth().hacerlogout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      body: Text("Pagina de inicio"),
    );
  }
}
