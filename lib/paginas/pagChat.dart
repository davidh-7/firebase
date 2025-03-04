import 'package:firebase/chat/servicio_chat.dart';
import 'package:flutter/material.dart';

class Paginachat extends StatefulWidget {
  final String idReceptor;
  const Paginachat({super.key, required this.idReceptor});

  @override
  State<Paginachat> createState() => _PaginachatState();
}

class _PaginachatState extends State<Paginachat> {
  final TextEditingController tecMensaje = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text("Sala chat"),
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
      child: Text("1"),
    );
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
              fillColor: Colors.blueAccent[100],
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
    }
  }
}
