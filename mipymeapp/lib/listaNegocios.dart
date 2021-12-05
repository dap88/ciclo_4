import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mipymeapp/registrarPedido.dart';
import 'package:mipymeapp/resultadoConsulta.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mipymeapp/main.dart';

class listaNegocios extends StatefulWidget {
  final String cedula;
  const listaNegocios({required this.cedula});

  @override
  _listaNegociosState createState() => _listaNegociosState();
}

class _listaNegociosState extends State<listaNegocios> {

  List negocios=[];
  List codigos=[];

  void initState(){
    super.initState();
    getNegocios();
  }

  void getNegocios() async {
    CollectionReference negocio = FirebaseFirestore.instance.collection("Negocios");
    String id = "";
    QuerySnapshot datos = await negocio.get();
    if (datos.docs.length>0){
      for (var doc in datos.docs){
        id = doc.id.toString();
        codigos.add(id);
        negocios.add(doc.data());
      }
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text("Negocios", style: TextStyle(fontFamily: 'AbrilFatface', fontSize: 28),),
      ),
      drawer: menu(),
      body: ListView.builder(
          itemCount: negocios.length,
          itemBuilder: (BuildContext context, i){
            return ListTile(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>registrarPedido(id: codigos[i], cedula: widget.cedula)));
                },
                title: cuadroImagenes(url: negocios[i]['foto'],texto: negocios[i]['nombre']+'\n'+negocios[i]['direccion']+'\n'+negocios[i]['celular'])
            );
          }),
    );
  }
}
