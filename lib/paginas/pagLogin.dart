import 'package:firebase/autenticaion/servicio_auth.dart';
import 'package:firebase/componentes/Btn_auten.dart';
import 'package:firebase/componentes/TxtFld_auten.dart';
import 'package:flutter/material.dart';

class paginalogin extends StatelessWidget {
    final Function()? hacerClick;

  const paginalogin({super.key,required this.hacerClick});

  void HacerLogin(BuildContext context, String email, String password) async {
    String? error = await ServicioAuth().loginEmailPass(email, password);
    if (error != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 132, 113, 240),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text("[ERROR]"),
          content: Text(error),
        ),
      );
    } else{
      print("login hecho");
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController tecEmail = TextEditingController();
    final TextEditingController tecPasw = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 124, 185, 241),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(
                  Icons.fireplace,
                  size: 120,
                  color: const Color.fromARGB(255, 245, 123, 66),
                ),

                SizedBox(
                  height: 25,
                ),

                //frase
                Text(
                  "Bienvenido de neuvo",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 25,
                ),

                //text divisor
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: const Color.fromARGB(255, 99, 45, 247),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "Hacer login",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: const Color.fromARGB(255, 99, 45, 247),
                        ),
                      ),
                    ],
                  ),
                ),

                //mail
                TxtFld_auten(
                    controller: tecEmail,
                    hintTxt: "Escribe tu Email",
                    obscureTxt: false),
                //pasword
                TxtFld_auten(
                    controller: tecPasw,
                    hintTxt: "Escribe la contraseña",
                    obscureTxt: true),
                //no eta regristrado
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Todavia no eres miembro"),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: hacerClick,
                        child: Text(
                          "Registrate",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                //Boton regristro
                BtnAuten(
                  Txt: 'Login',
                  onTap: () => HacerLogin(context, tecEmail.text, tecPasw.text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
