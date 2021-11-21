import 'package:android_midterm/models/location.dart';
import 'package:android_midterm/provider/picker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatefulWidget {
  SearchBox({Key? key}) : super(key: key);

  @override
  _SearchBox createState() => _SearchBox();
}

class _SearchBox extends State<SearchBox> {
  @override
  Widget build(BuildContext conteat) {
    var _picker_provider = Provider.of<PickerProvider>(context);
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(30),
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(25.7),
                    borderSide: const BorderSide(color: Colors.white),
                  ))),
          noItemsFoundBuilder: (context) => const SizedBox.shrink(),
          suggestionsCallback: (pattern) async {
            return await _picker_provider.search(pattern);
          },
          itemBuilder: (BuildContext context, Location location) {
            return ListTile(
              leading: const Icon(
                Icons.location_on,
                color: Colors.redAccent,
              ),
              title: Container(
                margin: const EdgeInsets.only(bottom: 7),
                child: Text(location.name,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    )),
              ),
              subtitle: Text(location.formattedAddress),
            );
          },
          onSuggestionSelected: (Location location) {
            _picker_provider.setLocationByMovingMap(location);
          },
        ),
      ),
    );
  }
}
