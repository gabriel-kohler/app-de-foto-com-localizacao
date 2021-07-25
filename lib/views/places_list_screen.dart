import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usando_recursos_nativos_prac/providers/great_places_provider.dart';
import 'package:usando_recursos_nativos_prac/utils/app_routes.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Lugares'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlacesProvider>(context, listen: false)
            .loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlacesProvider>(
                builder: (ctx, greatPlaces, child) =>
                    greatPlaces.itemsCount == 0
                        ? child
                        : ListView.builder(
                            itemCount: greatPlaces.itemsCount,
                            itemBuilder: (ctx, index) {
                              final place = greatPlaces.items[index];
                              return ListTile(
                                title: Text(place.title),
                                subtitle: Text(place.location.address),
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(place.image),
                                ),
                                onTap: () => Navigator.of(context).pushNamed(
                                  AppRoutes.PLACE_DETAIL,
                                  arguments: place,
                                ),
                              );
                            }),
                child: Center(
                  child: Text('Nenhum local cadastrado'),
                ),
              ),
      ),
    );
  }
}
