import 'package:firebase/autenticaion/servicio_auth.dart';
import 'package:firebase/chat/servicio_chat.dart';
import 'package:firebase/componentes/item_usuario.dart';
import 'package:firebase/paginas/editardatos_usario.dart';
import 'package:firebase/paginas/pagChat.dart';
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
        title: Text(ServicioAuth().getUsuarioActual()!.email.toString()),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditardatosUsario(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              ServicioAuth().hacerlogout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: ServicioChat().getUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error en el snapshot");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Cargando datos");
          }
          return ListView(
            children: snapshot.data!
                .map<Widget>((datosUsuario) =>
                    _contruirItemUsuairo(datosUsuario, context))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _contruirItemUsuairo(
      Map<String, dynamic> datosUsuario, BuildContext context) {
    if (datosUsuario["email"] == ServicioAuth().getUsuarioActual()!.email) {
      return Container();
    }

    return ItemUsuario(
      emailUsuaio: datosUsuario["email"],
      imagenPerfil: datosUsuario["imagenPerfil"],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Paginachat(
              idReceptor: datosUsuario["uid"],
            ),
          ),
        );
      },
    );
  }
}