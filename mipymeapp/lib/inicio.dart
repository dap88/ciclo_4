import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mipymeapp/consultaNegocios.dart';
import 'package:mipymeapp/listaNegocios.dart';
import 'package:mipymeapp/mapas.dart';
import 'package:mipymeapp/mensaje.dart';
import 'package:mipymeapp/pedidos.dart';
import 'package:mipymeapp/registroClientes.dart';

class inicio extends StatefulWidget {

  @override
  _inicioState createState() => _inicioState();
}

class _inicioState extends State<inicio> {
  List datos_negocios =[];

  void initState(){
    super.initState();
    getNegocios();
  }

  void getNegocios() async {
    CollectionReference datos= FirebaseFirestore.instance.collection("Negocios"); //Conecta a la collección
    QuerySnapshot negocios= await datos.get(); //Traer todas los negocios

    if(negocios.docs.length>0){ //Trae datos
      print("Trae datos");
      for(var doc in negocios.docs){
        print(doc.data());
        setState(() {
          datos_negocios.add(doc.data());
        });
      }
    } else{
      print("Ha fallado...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Listado de negocios"),
      ),
      drawer: menu(),
      body: Center(
        child: ListView.builder(
          itemCount: datos_negocios.length,
          itemBuilder: (BuildContext context,i){
            return ListTile(
              title: Text(datos_negocios[i]['nombre'].toString()+" - "+datos_negocios[i]['categoria'].toString()),
              onTap: (){
                print(datos_negocios[i]['posicion']);
                datosMapa_Negocio mn = datosMapa_Negocio(datos_negocios[i]['nombre'], datos_negocios[i]['categoria'], datos_negocios[i]['direccion'], datos_negocios[i]['celular'],
                    datos_negocios[i]['telefono'], datos_negocios[i]['logo'], datos_negocios[i]['paginaweb'], datos_negocios[i]['geolocalizacion']);
                print(datos_negocios[i]['geolocalizacion']);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>mapas(negocio: mn))); // Llamado a la pantalla mapas
              },
            );
          },
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.orangeAccent[200]
            ),
            child: Image.network('https://firebasestorage.googleapis.com/v0/b/mipymeapp-c4fe9.appspot.com/o/Fondos%2FBuscador-Google-Maps-Negocios.jpg?alt=media&token=d889d066-2d2b-4e67-8cd5-d78643fd1fae'),
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.home, size: 30, color: Colors.orange,),
                title: Text("Inicio", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>inicio()));
                },
              ),
              ListTile(
                leading: Icon(Icons.storefront, size: 30, color: Colors.orange,),
                title: Text("Consulta Negocios", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>consultaNegocios()));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add, size: 30, color: Colors.orange,),
                enabled: true,
                title: Text("Regístrate", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>registroClientes()));
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart, size: 30, color: Colors.orange,),
                enabled: true,
                title: Text("Comprar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>pedidos()));
                },
              ),
              ListTile(
                leading: Icon(Icons.email, size: 30, color: Colors.orange,),
                enabled: true,
                title: Text("Notificaciones", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>mensaje()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class datosMapa_Negocio{
  String nombre = "";
  String categoria = "";
  String direccion = "";
  int celular = 0;
  int telefono = 0;
  String logo = "";
  String paginaweb = "";
  late GeoPoint posicion;

  datosMapa_Negocio(this.nombre, this.categoria, this.direccion, this.celular, this.telefono, this.logo, this.paginaweb, this.posicion);
}