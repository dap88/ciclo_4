import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mipymeapp/inicio.dart';
import 'package:mipymeapp/resultadoConsulta.dart';


class consultaNegocios extends StatelessWidget {
  TextEditingController dato= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[200],
        title: Text('Buscar', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'AbrilFatface', fontSize: 28),),
      ),
      drawer: menu(),
      body: Column(
        children: [
          Container(
            //padding: EdgeInsets.all(20.0),
            child: TextField(
                onChanged: (dato){
                    controller: dato;
                },
              autofocus: false,
              keyboardType: TextInputType.name,
              textInputAction:  TextInputAction.search,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.orange),
              ),
            ),
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