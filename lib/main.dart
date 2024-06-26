import 'package:flutter/material.dart';
import 'package:timezone/tzdata.dart';
import 'package:timezone_calculator/common.dart';
import 'package:timezone_calculator/components/timezone_card.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone_calculator/pages/timezone_selector_page.dart';
import 'package:timezone_calculator/types/timezone_card_data.dart';

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

const appName = "Timezone calculator";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TimeOfDay selectedTime;
  late tz.Location selectedLocation;

  List<TimezoneCardData> otherTimezones = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now();
    // load selected location from disk
    // if there is none, select UTC+0
    selectedLocation = tz.getLocation("UTC");
    // load other timezones from disk
    // if there are none, create a default one
    otherTimezones.add(TimezoneCardData(tz.getLocation('America/Detroit')));
  }

  List<Widget> _buildOtherZonesWidgets() {
    List<Widget> widgets = List.empty(growable: true);
    widgets.add(const Text('Other timezones'));
    for (var tzData in otherTimezones) {
      widgets.add(TimezoneCard(cardData: tzData));
    }
    return widgets;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => _selectTime(context),
                  child: Text(
                    "${selectedTime.hour.toString()}:${selectedTime.minute.toString()}",
                    style: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.w800),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final tz.Location? location = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const TimezoneSelectorPage();
                    }));
                    if (location != null) {
                      setState(() => selectedLocation = location);
                    }
                  },
                  child: Text(getTzAbbreviationWithHours(selectedLocation)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: _buildOtherZonesWidgets(),
            ),
          ),
        ],
      ),
    );
  }
}
