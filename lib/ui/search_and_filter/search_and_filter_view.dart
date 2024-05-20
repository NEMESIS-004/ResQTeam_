// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchAndFilterScreen extends StatefulWidget {
  const SearchAndFilterScreen({super.key});

  @override
  _SearchAndFilterScreenState createState() => _SearchAndFilterScreenState();
}

class _SearchAndFilterScreenState extends State<SearchAndFilterScreen> {
  final TextEditingController _searchController = TextEditingController();
  List _allResults = [];
  List _resultsList = [];
  late Future resultsLoad;
  getAgencySnapsot() async {
    var data = await FirebaseFirestore.instance
        .collection('Agency_Total_Data')
        .orderBy('Agency Name')
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
    return "complete";
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoad = getAgencySnapsot();
  }

  _onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var res in _allResults) {
        var title = res['Agency Name'].toString().toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(res);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Nearby Rescue Agency',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                // Handle search text changes here
              },
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              itemCount: _resultsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    elevation: 1,
                    child: ListTile(
                      title: Text(
                        _resultsList[index]['Agency Name'],
                        style: GoogleFonts.poppins(
                            textStyle: Theme.of(context).textTheme.titleLarge,
                            color:
                                Theme.of(context).textTheme.titleLarge!.color),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                _resultsList[index]['Agency_Contact_Number'],
                                style: GoogleFonts.poppins(
                                    textStyle:
                                        Theme.of(context).textTheme.titleMedium,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .color),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text(
                                  _resultsList[index]['Agency_District'] +
                                      ", " +
                                      _resultsList[index]['Agency_State'],
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.poppins(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.circle_notifications),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
