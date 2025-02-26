import 'package:firebase/autenticaion/servicio_auth.dart';
import 'package:firebase/chat/servicio_chat.dart';
import 'package:firebase/componentes/item_usuario.dart';
import 'package:flutter/material.dart';

class paginainicio extends StatefulWidget {
  const paginainicio({super.key});

  @override
  State<paginainicio> createState() => _paginainicioState();
}

class _paginainicioState extends State<paginainicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[200],
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
      body: StreamBuilder(
          stream: ServicioChat().getUsuarios(),
          builder: (context, snapshot) {
            //encaso de error
            if (snapshot.hasError) {
              return Text("Error en el snapshot");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Cargando datos");
            }
            //devolviendo datos
            return ListView(
              children: snapshot.data!
                  .map<Widget>(
                      (datosUsuario) => _contruirItemUsuairo(datosUsuario))
                  .toList(),
            );
          }
          ),
    );
  }

  Widget _contruirItemUsuairo(Map<String, dynamic> datosUsuario) {
    return ItemUsuario(emailUsuaio: datosUsuario["email"]);
  }
}
