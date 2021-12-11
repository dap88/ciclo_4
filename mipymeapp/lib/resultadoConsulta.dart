import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mipymeapp/inicio.dart';
import 'package:mipymeapp/negocios.dart';
import 'main.dart';

class resultadoConsulta extends StatefulWidget {
  final String criterio;
  const resultadoConsulta(this.criterio,{Key? key}) : super(key: key);

  @override
  _resultadoConsultaState createState() => _resultadoConsultaState();
}

class _resultadoConsultaState extends State<resultadoConsulta> {
  List productosLista = [];
  List negociosLista = [];
  void initState(){
    super.initState();
    getCriterio();
  }

  void getCriterio() async{
    CollectionReference datos = FirebaseFirestore.instance.collection("Productos");
    QuerySnapshot productos = await datos.where("nombre",isEqualTo:widget.criterio).get();
    if(productos.docs.length!=0){
      for(var ne in productos.docs){
        print(ne.data());
        setState(() {
          productosLista.add(ne);
        });
      }
    }
    String id;
    CollectionReference datos2 = FirebaseFirestore.instance.collection("Negocios");
    for(var i=0;i<productosLista.length;i++){
      id=productosLista[i]['negocio'];
      QuerySnapshot negocio = await datos2.where(FieldPath.documentId, isEqualTo: id).get();
      if(negocio.docs.length>0){
        for(var negoc in negocio.docs){
          setState(() {
            negociosLista.add(negoc.data());
            print(negoc.data());
          });
        }
      } else {
        print('No encontraron negocios que ofrezcan ese producto/servicio');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[200],
        title: Text("Producto: "+ widget.criterio, style: TextStyle(fontFamily: 'AbrilFatface', fontSize: 25),),
      ),
      drawer: menu(),
      body: ListView.builder(
          itemCount: negociosLista.length,
          itemBuilder: (BuildContext context, j){
            return ListTile(
              onTap: (){
                print(negociosLista[j]);
                datosNegocio n = datosNegocio(negociosLista[j]['nombre'], negociosLista[j]['direccion'], negociosLista[j]['categoria'],negociosLista[j]['telefono'], negociosLista[j]['celular'], negociosLista[j]['paginaweb'], negociosLista[j]['logo'], negociosLista[j]['foto'], negociosLista[j]['posicion']);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>negocios(negocio: n)));
              },
              title: cuadroImagenes(url: negociosLista[j]['logo'],texto: negociosLista[j]['categoria']+'\n'+negociosLista[j]['nombre']+'\n'+negociosLista[j]['celular'].toString()+" - "+negociosLista[j]['telefono'].toString())
            );
          }),
    );
  }
}

class cuadroImagenes extends StatelessWidget {
  final String url;
  final String texto;

  const cuadroImagenes({required this.url, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      margin: EdgeInsets.all(20),
      elevation: 10,
      color: Colors.blueGrey[200],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Column(
          children: [
            Image.network(url),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.blueGrey[200],
              child: Text(texto,style: TextStyle(fontSize: 20, color: Colors.red[900]),textAlign: TextAlign.center)
            )
          ],
        ),
      ),
    );
  }
}

class datosNegocio{
  String nombre = "";
  String direccion = "";
  String categoria = "";
  int telefono = 0;
  int celular = 0;
  String paginaweb = "";
  String logo = "";
  String foto = "";
  late GeoPoint posicion;

  datosNegocio(nombre, direccion, categoria, telefono, celular, paginaweb, logo, foto, posicion){
    this.nombre = nombre;
    this.direccion = direccion;
    this.categoria = categoria;
    this.telefono = telefono;
    this.celular = celular;
    this.paginaweb = paginaweb;
    this.logo = logo;
    this.foto = foto;
    this.posicion = posicion;
  }
}