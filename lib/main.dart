import 'package:flutter/material.dart';
import 'package:google_map_search/screen/google_map/google_map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map Search Bar',
      debugShowCheckedModeBanner: false,
      home: GoogleMap(),
    );
  }
}
