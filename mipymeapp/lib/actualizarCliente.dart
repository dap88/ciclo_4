import 'package:flutter/material.dart';
import 'package:mipymeapp/comprobarCliente.dart';
import 'package:mipymeapp/inicio.dart';

class actualizarCliente extends StatefulWidget {
  final datosCliente cliente;
  const actualizarCliente({required this.cliente});

  @override
  _actualizarClienteState createState() => _actualizarClienteState();
}

class _actualizarClienteState extends State<actualizarCliente> {

  final nombre=TextEditingController();
  final direccion=TextEditingController();
  final celular=TextEditingController();
  final telefono=TextEditingController();
  final clave=TextEditingController();

  @override
  Widget build(BuildContext context) {
    String cedula = widget.cliente.cedula;
    nombre.text = widget.cliente.nombre;
    direccion.text = widget.cliente.direccion;
    celular.text = widget.cliente.celular;
    telefono.text = widget.cliente.telefono;
    clave.text = widget.cliente.clave;

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[200],
        title: Text("Actualizar Datos: "+ widget.cliente.nombre, style: TextStyle(fontFamily: 'AbrilFatface', fontSize: 28),),
      ),
      drawer: menu(),
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: nombre,
                style: TextStyle(color: Colors.red[50]),
                decoration: InputDecoration(
                    fillColor: Colors.red,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,size: 25,color: Colors.red[900]),
                    hintText: "Digite su nombre",
                    hintStyle: TextStyle(color: Colors.black54)
                ),
              )
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: direccion,
                style: TextStyle(color: Colors.red[50]),
                decoration: InputDecoration(
                    fillColor: Colors.red,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,size: 25,color: Colors.red[900]),
                    hintText: "Digite sus dirección",
                    hintStyle: TextStyle(color: Colors.black54)
                ),
              )
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: celular,
                style: TextStyle(color: Colors.red[50]),
                decoration: InputDecoration(
                    fillColor: Colors.red,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,size: 25,color: Colors.red[900]),
                    hintText: "Digite su número celuar",
                    hintStyle: TextStyle(color: Colors.black54)
                ),
              )
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: telefono,
                style: TextStyle(color: Colors.red[50]),
                decoration: InputDecoration(
                    fillColor: Colors.red,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,size: 25,color: Colors.red[900]),
                    hintText: "Digite su numero de celular",
                    hintStyle: TextStyle(color: Colors.black54)
                ),
              )
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: clave,
                style: TextStyle(color: Colors.red[50]),
                decoration: InputDecoration(
                    fillColor: Colors.red,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,size: 25,color: Colors.red[900]),
                    hintText: "Digite su contraseña de sistema",
                    hintStyle: TextStyle(color: Colors.black54)
                ),
              )
          ),
          Row(
            children: [
              ElevatedButton(onPressed: (){}, child: Text("Actualizar")),
              ElevatedButton(onPressed: (){}, child: Text("Eliminar"))
            ],
          )
        ],
      ),
    );
  }
}