import 'package:flutter/material.dart';
import 'package:google_map_search/model/suggestion_model.dart';
import 'package:google_map_search/rest_api/place_provider/rest_api.dart';

class GoogleMap extends StatefulWidget {
  @override
  GoogleMapState createState() => GoogleMapState();
}

class GoogleMapState extends State<GoogleMap> {
  TextEditingController searchController = TextEditingController();
  String placeName = '';
  PlaceApiProvider apiClient = PlaceApiProvider();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextFormField(
              controller: searchController,
              onChanged: (value) {
                placeName = value;
                setState(() {});
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: placeName == ""
                    ? null
                    : apiClient.fetchSuggestions(placeName),
                builder: (context, AsyncSnapshot<dynamic> snapshot) =>
                    placeName == ''
                        ? Container(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Enter your address'),
                          )
                        : snapshot.hasData
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => ListTile(
                                  title: Text(
                                      (snapshot.data[index] as Suggestion)
                                          .description),
                                  onTap: () {
                                    Navigator.pop(context,
                                        snapshot.data[index] as Suggestion);
                                  },
                                ),
                                itemCount: snapshot.data.length,
                              )
                            : Container(child: Text('Loading...')),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  print('Place Name --> $placeName');
                },
                child: Container(
                  color: Colors.red,
                  child: Text('$placeName'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
