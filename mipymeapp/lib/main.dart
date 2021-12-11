import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mipymeapp/inicio.dart';

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
        primarySwatch: Colors.orange,
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          // Aquí se toma el valor del objeto MyHomePage que fue creado por el
          // método App.build y se usa para establecer el título de la barra de
          // aplicaciones.
          backgroundColor: Colors.orangeAccent[200],
          centerTitle: true,
          title: Text("MipymeApp", style: TextStyle(fontFamily: 'AbrilFatface', fontSize: 35),),
        ),
        body:  PageView(
          physics: BouncingScrollPhysics(),
          children: [
            imagen(url: 'https://firebasestorage.googleapis.com/v0/b/mipymeapp-c4fe9.appspot.com/o/Fondos%2Fsplash_1.png?alt=media&token=960de486-85d0-400d-8200-bc4ff0b02c0b'),
            imagen(url: 'https://firebasestorage.googleapis.com/v0/b/mipymeapp-c4fe9.appspot.com/o/Fondos%2Fsplash_2.png?alt=media&token=305a808b-37f9-449c-a7e5-3dfd93bcf150'),
            imagen(url: 'https://firebasestorage.googleapis.com/v0/b/mipymeapp-c4fe9.appspot.com/o/Fondos%2Fsplash_3.png?alt=media&token=f4dcc977-2ebb-44c1-9ace-36ee06b58bd0'),
          ],
        )
    );
  }
}

class imagen extends StatelessWidget {

  final String url;

  const imagen({required this.url});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.network(url),
        ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>inicio())); // Llamado a la pantalla inicio
          }, child: Text("Empezar"),
        )
      ],
    );
  }
}

class principal extends StatelessWidget {
  const principal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(

        )
      ],
    );
  }
}