import 'package:flutter/material.dart';
import 'package:timezone/tzdata.dart';
import 'package:timezone_calculator/components/timezone_card.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone_calculator/pages/timezone_selector_page.dart';

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
  late Location selectedTimezone;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now();
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
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return const TimezoneSelectorPage();
                  })),
                  child: Text("UTC"),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                const Text("Other timezones"),
                TimezoneCard(),
                TimezoneCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
