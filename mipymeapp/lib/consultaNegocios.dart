import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mipymeapp/resultadoConsulta.dart';
import 'main.dart';

class consultaNegocios extends StatelessWidget {
  TextEditingController dato= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text('Buscar', style: TextStyle(fontFamily: 'AbrilFatface', fontSize: 28),),
      ),
      drawer: menu(),
      body: Column(
        children: [
          Container(
            child:
            TextField(controller: dato,),
          ),
          Container(
            child: ElevatedButton(onPressed: (){
              print(dato.text);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> resultadoConsulta(dato.text)));;
            },child: Text('Consultar', style: TextStyle(fontFamily: 'AbrilFatface', fontSize: 17),),),
          ),
        ],
      ),
    );
  }
}