import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mipymeapp/comprobarCliente.dart';
import 'package:mipymeapp/consultaNegocios.dart';
import 'package:mipymeapp/mapas.dart';
import 'package:mipymeapp/mensaje.dart';
import 'package:mipymeapp/pedidos.dart';
import 'package:mipymeapp/registroClientes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(const MyApp()); // Lanza la clase con un constructor vacio
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Este widget es la raíz de la aplicación.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MipymeApp',
      theme: ThemeData(
        // Este es el tema de la aplicación.
        fontFamily: 'Coiny', //Carga fuente
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'MipymeApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  // Este widget es la página de inicio de la aplicación.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // Este método se vuelve a ejecutar cada vez que se llama a setState
    return Scaffold(
        backgroundColor: Colors.lightBlue[50],
        appBar: AppBar(
          // Aquí se toma el valor del objeto MyHomePage que fue creado por el
          // método App.build y se usa para establecer el título de la barra de
          // aplicaciones.
          backgroundColor: Colors.red[700],
          centerTitle: true,
          title: Text("MipymeApp", style: TextStyle(fontFamily: 'AbrilFatface', fontSize: 35),),
        ),

        drawer: menu(),

        body:  ListView(
          children: [
            Container(
                color: Colors.blueGrey[100],
                padding: EdgeInsets.all(25.0),
                child: Image.network('https://firebasestorage.googleapis.com/v0/b/mipymeapp-c4fe9.appspot.com/o/Fondos%2FDrogueria.jpg?alt=media&token=dbb8687f-9d93-49b1-85e1-2bc3695ceaef', scale: 2.5,)
            ),
            Container(
                color: Colors.blueGrey[100],
                padding: EdgeInsets.all(25.0),
                child: Image.network('https://firebasestorage.googleapis.com/v0/b/mipymeapp-c4fe9.appspot.com/o/Fondos%2FPanaderia.jpg?alt=media&token=2de887be-d758-481e-a14b-3f9edccc042d', scale: 2.5,)
            ),
            Container(
                color: Colors.blueGrey[100],
                padding: EdgeInsets.all(25.0),
                child: Image.network('https://firebasestorage.googleapis.com/v0/b/mipymeapp-c4fe9.appspot.com/o/Fondos%2FPeluqueria.jpg?alt=media&token=8418a39c-6434-4ca4-b15e-44c9ce7e9606', scale: 2.5,)
            ),
            Container(
                color: Colors.blueGrey[100],
                padding: EdgeInsets.all(25.0),
                child: Image.network('https://firebasestorage.googleapis.com/v0/b/mipymeapp-c4fe9.appspot.com/o/Fondos%2FRestaurante.jpg?alt=media&token=b362cfdf-7cb8-4522-9b79-406e3a45eb20', scale: 2.5,)
            )
          ],
        )
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
                color: Colors.red[700]
            ),
            child: Image.network('https://firebasestorage.googleapis.com/v0/b/mipymeapp-c4fe9.appspot.com/o/Fondos%2FBuscador-Google-Maps-Negocios.jpg?alt=media&token=d889d066-2d2b-4e67-8cd5-d78643fd1fae'),
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.storefront, size: 30, color: Colors.red[900],),
                title: Text("Consulta Negocios", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>consultaNegocios()));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add, size: 30, color: Colors.red[900],),
                enabled: true,
                title: Text("Regístrate", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>registroClientes()));
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart, size: 30, color: Colors.red[900],),
                enabled: true,
                title: Text("Comprar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>pedidos()));
                },
              ),
              ListTile(
                leading: Icon(Icons.email, size: 30, color: Colors.red[900],),
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
