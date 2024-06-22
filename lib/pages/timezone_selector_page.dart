import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class TimezoneSelectorPage extends StatefulWidget {
  const TimezoneSelectorPage({super.key});

  @override
  State<StatefulWidget> createState() => _TimezoneSelectorPageState();
}

class _TimezoneSelectorPageState extends State<TimezoneSelectorPage> {
  String searchString = "";

  List<Widget> _buildTimezoneChildren() {
    List<Widget> widgets = List.empty(growable: true);
    widgets.add(Container(
      height: 70,
    ));
    for (var location in tz.timeZoneDatabase.locations.entries) {
      ListTile tile = ListTile(
        title: Text(location.value.name),
        subtitle: Text(location.value.currentTimeZone.abbreviation),
        onTap: () => Navigator.pop(context, location.value),
      );
      widgets.add(tile);
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Select timezone")),
        body: Stack(
          children: [
            ListView(
              children: _buildTimezoneChildren(),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.all(8),
              child: TextField(
                maxLines: 1,
                expands: false,
                decoration: const InputDecoration(
                    hintText: "Search", suffixIcon: Icon(Icons.search)),
                onChanged: (value) => setState(() => searchString = value),
              ),
            ),
          ],
        ));
  }
}
