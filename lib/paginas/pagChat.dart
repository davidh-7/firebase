import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/autenticaion/servicio_auth.dart';
import 'package:firebase/chat/servicio_chat.dart';
import 'package:firebase/componentes/BurjMensaje.dart';
import 'package:flutter/material.dart';

class Paginachat extends StatefulWidget {
  final String idReceptor;
  const Paginachat({super.key, required this.idReceptor});

  @override
  State<Paginachat> createState() => _PaginachatState();
}

class _PaginachatState extends State<Paginachat> {
  final TextEditingController tecMensaje = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  FocusNode Teclado = FocusNode();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Teclado.addListener(() {
      Future.delayed(Duration(milliseconds: 500), () {
        hacerScrollAbajo();
      });
    });

    Future.delayed(Duration(milliseconds: 500), () {
      hacerScrollAbajo();
    });
  }

  void hacerScrollAbajo() {
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String Correo = ServicioAuth().getUsuarioActual()!.email.toString();
    final String Nombre = ServicioAuth().getNombreUsuarioActual().toString();
    //final String Nombre = FirebaseFirestore;

    Future<void> _titolChat() async{
      String nomTitol;
      if(Nombre.isEmpty){
        setState(() {
          nomTitol = Correo.toString();
        });
      }else{
        setState(() {
          nomTitol = Nombre.toString();
        });
      }
    }

    

  

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("Usuarios")
              .doc(widget.idReceptor)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Cargando...");
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text("Sin nombre");
            }

            final datos = snapshot.data!.data() as Map<String, dynamic>;
            final nom = datos["nom"];
            final email = datos["email"];
            return Text(
              (nom != null && nom.toString().trim().isNotEmpty) ? nom : email ?? "Sin nombre",
              style: const TextStyle(color: Colors.black87),
            );
          },
        ),
        //Text(_titolChat().toString()),

      ),
      body: Column(
        children: [
          //zona mensajes
          _crearZonaMostarMensajes(),
          //zona escribir
          _crearZonaEscribirMensajes(),
        ],
      ),
    );
  }

  Widget _crearZonaMostarMensajes() {
    return Expanded(
      child: StreamBuilder(
          stream: ServicioChat().getMensajes(
              ServicioAuth().getUsuarioActual()!.uid, widget.idReceptor),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error Cargando Datos...");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Cargando Mensaje....");
            }

            return ListView(
              controller: _scrollController,
              children: snapshot.data!.docs
                  .map((document) => _construirItemMensaje(document))
                  .toList(),
            );
          }),
    );
  }

  Widget _construirItemMensaje(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return BurbujaMensaje(
      mensaje: data["mensaje"],
      idAutor: data["idAutor"],
      Fecha: data["timestamp"],
    );
    //Text(data["mensaje"]);
  }

  Widget _crearZonaEscribirMensajes() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: tecMensaje,
            decoration: InputDecoration(
              hintText: "escribe tu mensaje....",
              filled: true,
              fillColor: const Color.fromARGB(255, 139, 235, 219),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: enviarMensaje,
          icon: Icon(Icons.send),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.grey),
          ),
        ),
      ],
    );
  }

  void enviarMensaje() {
    if (tecMensaje.text.isNotEmpty) {
      ServicioChat().enviarMensaje(widget.idReceptor, tecMensaje.text);

      tecMensaje.clear();
      Future.delayed(Duration(milliseconds: 50), () {
        hacerScrollAbajo();
      });
    }
  }
}
