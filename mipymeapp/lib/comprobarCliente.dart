import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mipymeapp/actualizarCliente.dart';
import 'package:mipymeapp/inicio.dart';
import 'package:mipymeapp/main.dart';

class comprobarCliente extends StatefulWidget {
  const comprobarCliente({Key? key}) : super(key: key);

  @override
  _comprobarClienteState createState() => _comprobarClienteState();
}

class _comprobarClienteState extends State<comprobarCliente> {
  final cedula = TextEditingController();
  final clave = TextEditingController();
  CollectionReference cliente =
  FirebaseFirestore.instance.collection("Clientes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[50],
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent[200],
          title: Text("Comprobar Cliente", style: TextStyle(fontFamily: 'AbrilFatface', fontSize: 28),),
        ),
        drawer: menu(),
        body: ListView(children: [
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: cedula,
                style: TextStyle(color: Colors.red[50]),
                decoration: InputDecoration(
                    fillColor: Colors.red,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,size: 25, color: Colors.orange),
                    hintText: "Digite numero de cedula",
                    hintStyle: TextStyle(color: Colors.black54)),
              )),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: clave,
                style: TextStyle(color: Colors.red[50]),
                decoration: InputDecoration(
                    fillColor: Colors.red,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,size: 25, color: Colors.orange),
                    hintText: "Digite su contraseña",
                    hintStyle: TextStyle(color: Colors.black54)),
              )),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                QuerySnapshot ingreso = await cliente
                    .where(FieldPath.documentId, isEqualTo: cedula.text)
                    .where("clave", isEqualTo: clave.text)
                    .get();
                List listaCliente = [];
                if (ingreso.docs.length > 0) {
                  for (var cli in ingreso.docs) {
                    listaCliente.add(cli.data());
                  }
                  datosCliente dCli = datosCliente(
                      cedula.text,
                      listaCliente[0]['nombre'],
                      listaCliente[0]['direccion'],
                      listaCliente[0]['celular'],
                      listaCliente[0]['telefono'],
                      listaCliente[0]['clave']);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => actualizarCliente(cliente: dCli)));
                  Fluttertoast.showToast(msg: "Cargando Datos", fontSize: 20, backgroundColor: Colors.orange, textColor: Colors.lightGreen,
                      toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                } else {
                  Fluttertoast.showToast(msg: "Datos Incorrectos", fontSize: 20, backgroundColor: Colors.orange, textColor: Colors.lightGreen,
                      toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                }
              },
              child: Text("Verificar",
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          )
        ])
    );
  }
}

class datosCliente {

  String cedula = "";
  String nombre = "";
  String direccion = "";
  String celular = "";
  String telefono = "";
  String clave = "";

  datosCliente(cedula, nombre, direccion, celular, telefono, clave){
    this.nombre = nombre;
    this.direccion = direccion;
    this.celular = celular;
    this.telefono = telefono;
    this.clave = clave;
  }
}