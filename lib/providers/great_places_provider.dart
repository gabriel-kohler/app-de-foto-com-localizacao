import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:usando_recursos_nativos_prac/models/place.dart';
import 'package:usando_recursos_nativos_prac/utils/database_util.dart';
import 'package:usando_recursos_nativos_prac/utils/location_util.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  Future<void> loadPlaces() async {
    final dataList = await DatabaseUtil.getData('places');
    _items = dataList
        .map(
          (data) => Place(
            id: data['id'],
            title: data['title'],
            image: File(data['image']),
            location: PlaceLocation(
              latitude: data['latitude'],
              longitude: data['longitude'],
              address: data['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }


  void addPlace(String title, File image, LatLng position) async {
    String address = await LocationUtil.getAddressFrom(position);
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
    );

    _items.add(newPlace);

    DatabaseUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address,
    });
    notifyListeners();
  }
}
