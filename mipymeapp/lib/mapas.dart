import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mipymeapp/resultadoConsulta.dart';

class mapas extends StatefulWidget {

  final datosMapa_Negocio negocio;
  const mapas({required this.negocio});

  @override
  _mapasState createState() => _mapasState();
}

class _mapasState extends State<mapas> {

  late GeoPoint pos = widget.

  @override
  Widget build(BuildContext context) {

    final posicion = CameraPosition(target: LatLng(pos.latitude, pos.longitude),
    zoom: 15
    );

    final Set<Marker> marcador = Set();
    String cedula = "123457";
    marcador.add(
      Marker(
          markerId: MarkerId("cedula"),
          position: LatLng(pos.latitude, pos.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          infoWindow: InfoWindow(
              title: widget.negocio.nombre+" "+widget.negocio.direccion,
              snippet: widget.negocio.clave
          )
      )
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Geolocalización"),
      ),
        body: ListView(
          children: [
            cuadroImagenes(url: widget.negocio.foto, texto: widget.negocio.nombre),
            Container(
              width: 400,
              height: 500,
              child: GoogleMap(
                initialCameraPosition: posicion,
                scrollGesturesEnabled: true, // Activa o descativa el poder mover el mapa
                zoomControlsEnabled: true, // Activa o desactiva los botones del zoom
                zoomGesturesEnabled: true, // Activa o desactiva el zoom con la mano
                mapType: MapType.normal, // Tipo de mapa
                markers: marcador,
              ),
            ),
          ],
        )
    );
  }
}
