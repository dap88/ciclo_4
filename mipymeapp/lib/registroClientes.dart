import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mipymeapp/main.dart';

class registroClientes extends StatefulWidget {
  const registroClientes({Key? key}) : super(key: key);

  @override
  _registroClientesState createState() => _registroClientesState();
}

class _registroClientesState extends State<registroClientes> {
  final cedula=TextEditingController();
  final nombre=TextEditingController();
  final direccion=TextEditingController();
  final celular=TextEditingController();
  final telefono=TextEditingController();
  final clave=TextEditingController();

  void limpiar(){
    cedula.text=""; nombre.text=""; direccion.text=""; celular.text=""; telefono.text=""; clave.text="";
  }

  CollectionReference clientes = FirebaseFirestore.instance.collection('Clientes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text("Registro de Clientes", style: TextStyle(fontFamily: 'AbrilFatface', fontSize: 28),),
      ),
      drawer: menu(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: cedula,
              style: TextStyle(color: Colors.red[50]),
              decoration: InputDecoration(
                fillColor: Colors.red,
                filled: true,
                icon: Icon(Icons.app_registration_sharp, size: 25, color: Colors.red[900]),
                hintText: "Digite su número de cédula",
                hintStyle: TextStyle(color: Colors.black54)
              ),
            )
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: nombre,
                style: TextStyle(color: Colors.red[50]),
                decoration: InputDecoration(
                    fillColor: Colors.red,
                    filled: true,
                    icon: Icon(Icons.app_registration_sharp, size: 25, color: Colors.red[900]),
                    hintText: "Digite sus nombres y apellidos",
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
                    icon: Icon(Icons.app_registration_sharp, size: 25, color: Colors.red[900]),
                    hintText: "Digite su dirección de residencia",
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
                    icon: Icon(Icons.app_registration_sharp, size: 25, color: Colors.red[900]),
                    hintText: "Digite su número de celular",
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
                    icon: Icon(Icons.app_registration_sharp, size: 25, color: Colors.red[900]),
                    hintText: "Digite su número de teléfono fijo",
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
                    icon: Icon(Icons.app_registration_sharp, size: 25, color: Colors.red[900]),
                    hintText: "Digite una contraseña para el sistema",
                    hintStyle: TextStyle(color: Colors.black54)
                ),
              )
          ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                if(cedula.text.isEmpty || nombre.text.isEmpty || direccion.text.isEmpty || celular.text.isEmpty || telefono.text.isEmpty || clave.text.isEmpty){
                  print("Datos faltantes");
                  Fluttertoast.showToast(msg: "Campos vacios", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                } else {
                  QuerySnapshot existe = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                  if(existe.docs.length>0){
                    Fluttertoast.showToast(msg: "El numero de documento ingresado, ya existe.", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                    limpiar();
                  } else {
                    clientes.doc(cedula.text).set({
                      "nombre": nombre.text,
                      "direccion": direccion.text,
                      "celular": celular.text,
                      "telefono": telefono.text,
                      "clave": clave.text,
                    });
                    QuerySnapshot inserto = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                    limpiar();
                    if(inserto.docs.length>0){
                      Fluttertoast.showToast(msg: "Registro de cliente exitoso", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                    }else{
                      Fluttertoast.showToast(msg: "No se registro el cliente.", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                    }
                  }
                }
                setState(() {

                });
              },
              child: Text("Registrar",style: TextStyle(color: Colors.red[50], fontSize: 25)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 100.0, top: 20.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                if(cedula.text.isEmpty){
                  print("Datos faltantes");
                  Fluttertoast.showToast(msg: "Debe digitar la cédula", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                      toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                } else {
                  List lista=[];
                  var id;
                  var ced = cedula.text;
                  QuerySnapshot consulta = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                  if(consulta.docs.length>0){
                    for (var doc in consulta.docs){
                      lista.add(doc.data());
                    }
                    Fluttertoast.showToast(msg: "Cargando datos", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                        toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                    cedula.text = ced;
                    nombre.text = lista[0]['nombre'];
                    direccion.text = lista[0]['direccion'];
                    celular.text = lista[0]['celular'];
                    telefono.text = lista[0]['telefono'];
                    clave.text = lista[0]['clave'];
                  } else {
                      limpiar();
                      Fluttertoast.showToast(msg: "El cliente no encontrado.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                  }
                }
              },
              child: Text("Consultar",style: TextStyle(color: Colors.red[50], fontSize: 25)),
            ),
          ),
        ],
      ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: (){
                    if(cedula.text.isEmpty || nombre.text.isEmpty || direccion.text.isEmpty || celular.text.isEmpty || telefono.text.isEmpty || clave.text.isEmpty){
                      Fluttertoast.showToast(msg: "Campos vacios", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                    } else {
                      clientes.doc(cedula.text).update({
                        "nombre": nombre.text,
                        "direccion": direccion,
                        "celular": celular,
                        "telefono": telefono,
                        "clave": clave,
                      });
                      limpiar();
                      Fluttertoast.showToast(msg: "Actualización de datos correcta", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                    }
                  },
                  child: Text("Actualizar",style: TextStyle(color: Colors.red[50], fontSize: 25)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 100.0, top: 20.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if(cedula.text.isEmpty){
                      Fluttertoast.showToast(msg: "Datos faltantes", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    } else {
                      clientes.doc(cedula.text).delete();
                        limpiar();
                        Fluttertoast.showToast(msg: "Cliente eliminado exitosamente", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                            toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }
                  },
                  child: Text("Eliminar",style: TextStyle(color: Colors.red[50], fontSize: 25)),
                ),
              )
            ],
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>comprobarCliente()));
        },
        child: Icon(Icons.login,size: 30,color: Colors.red[50]),
      ),
    );
  }
}
