import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mipymeapp/registroClientes.dart';
import 'package:mipymeapp/resultadoConsulta.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mipymeapp/mapas.dart';
import 'main.dart';

class negocios extends StatelessWidget {

  final datosNegocio negocio;
  const negocios({required this.negocio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text("Detalle Negocio:"+negocio.nombre, style: TextStyle(fontFamily: 'AbrilFatface', fontSize: 28)),
      ),
      drawer: menu(),
      body: ListView(
        children: [
          cuadroImagenes(url: negocio.foto, texto: negocio.categoria+'\n'+negocio.nombre+'\n'+negocio.direccion+'\n'+negocio.celular.toString()+" - "+negocio.telefono.toString(),),
          ElevatedButton(
            onPressed: (){
              launch(negocio.paginaweb.toString());
            },
            child: Text("Pagina web")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>registroClientes()));
        },
        child: Icon(Icons.person_add, size: 30, color: Colors.red[50]),
      ),
    );
  }
}
