import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usando_recursos_nativos_prac/providers/great_places_provider.dart';
import 'package:usando_recursos_nativos_prac/widgets/image_input.dart';
import 'package:usando_recursos_nativos_prac/widgets/location_input.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _submitForm() {
    if (_titleController.text.isEmpty || _pickedImage == null) return;

    Provider.of<GreatPlacesProvider>(context, listen: false).addPlace(_titleController.text, _pickedImage);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Título'),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(this._selectImage),
                    SizedBox(height: 10),
                    LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => _submitForm(),
            icon: Icon(Icons.add),
            label: Text('Adicionar'),
            style: ElevatedButton.styleFrom(elevation: 0),
          ),
        ],
      ),
    );
  }
}
