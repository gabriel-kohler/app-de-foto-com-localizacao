import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:usando_recursos_nativos_prac/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadOnly;

  MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
    ),
    this.isReadOnly = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedPosition = LatLng(
    37.422,
    -122.084,
  );

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione'),
        actions: <Widget>[
          IconButton(
            onPressed: _pickedPosition == null
                ? null
                : () {
                    Navigator.of(context).pop(_pickedPosition);
                  },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13,
        ),
        onTap: widget.isReadOnly ? null : _selectPosition,
        markers: _pickedPosition == null
            ? null
            : {
                Marker(
                  markerId: MarkerId('p1'),
                  position: _pickedPosition,
                ),
              },
      ),
    );
  }
}
