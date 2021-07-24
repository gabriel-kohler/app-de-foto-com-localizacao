import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:usando_recursos_nativos_prac/models/place.dart';
import 'package:usando_recursos_nativos_prac/utils/database_util.dart';

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
            location: null,
          ),
        )
        .toList();
    notifyListeners();
  }

  void removePlace(String id) async {
    _items.removeWhere((item) => item.id == id);
    DatabaseUtil.remove(id);
    notifyListeners();
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: null,
    );

    _items.add(newPlace);

    DatabaseUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
    notifyListeners();
  }
}
