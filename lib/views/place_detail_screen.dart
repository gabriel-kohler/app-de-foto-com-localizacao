import 'package:flutter/material.dart';
import 'package:usando_recursos_nativos_prac/models/place.dart';
import 'package:usando_recursos_nativos_prac/views/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context).settings.arguments as Place;
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            place.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    initialLocation: place.location,
                    isReadonly: true,
                  ),
                ),
              );
            },
            icon: Icon(Icons.map),
            label: Text('Ver no mapa'),
          ),
        ],
      ),
    );
  }
}
