// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlertWidget extends StatelessWidget {
  AlertWidget({super.key, required this.eventdata});

  List<Map<String, dynamic>> eventdata;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: eventdata.length,
      itemBuilder: (context, index) {
        final event = eventdata[index];
        final title = event["title"];
        final category = event["category"];
        var start = event["start"];
        DateTime dateTime = DateTime.parse(start);
        start = DateFormat('yyyy-MM-dd').format(dateTime);
        final active = event["state"];
        final timezone = event["timezone"];
        final location = event["location"];
        final country = event["country"];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: $title'),
                Text('Category: $category'),
                Text('Start: $start'),
                Text('Status: $active'),
                Text('Timezone: $timezone'),
                Text('Location: $location'),
                Text('Country: $country'),
              ],
            ),
          ),
        );
      },
    );
  }
}
