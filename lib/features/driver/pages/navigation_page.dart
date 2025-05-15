import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> delivery = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final LatLng destination = const LatLng(-19.9227, -43.9451); 

    return Scaffold(
      appBar: AppBar(title: Text('Rota para: ${delivery['address']}')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: destination, zoom: 14),
        markers: {
          Marker(markerId: MarkerId('destino'), position: destination),
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/driver/update-status', arguments: delivery);
        },
        label: Text('Atualizar Status'),
        icon: Icon(Icons.check),
      ),
    );
  }
}
