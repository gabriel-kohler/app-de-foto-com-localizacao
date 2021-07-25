import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usando_recursos_nativos_prac/providers/great_places_provider.dart';
import 'package:usando_recursos_nativos_prac/utils/app_routes.dart';
import 'package:usando_recursos_nativos_prac/views/place_detail_screen.dart';
import 'package:usando_recursos_nativos_prac/views/place_form_screen.dart';
import 'package:usando_recursos_nativos_prac/views/places_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlacesProvider(),
      child: MaterialApp(
        title: 'Prac APP',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        routes: {
          AppRoutes.PLACES_LIST : (context) => PlacesListScreen(),
          AppRoutes.PLACE_FORM : (context) => PlaceFormScreen(),
          AppRoutes.PLACE_DETAIL : (context) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
