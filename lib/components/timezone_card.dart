import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone_calculator/common.dart';
import 'package:timezone_calculator/constants.dart';
import 'package:timezone_calculator/types/timezone_card_data.dart';

class TimezoneCard extends StatefulWidget {
  const TimezoneCard(
      {super.key, required this.cardData, required this.pointOfReference});

  final tz.TZDateTime pointOfReference;
  final TimezoneCardData cardData;

  @override
  State<StatefulWidget> createState() => _TimezoneCardState();
}

class _TimezoneCardState extends State<TimezoneCard> {
  late tz.Location location;

  @override
  void initState() {
    super.initState();
    location = tz.getLocation(widget.cardData.location);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  timeFormat24.format(
                      tz.TZDateTime.from(widget.pointOfReference, location)),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w600),
                ),
                Text(
                  getTzAbbreviationWithHours(location),
                  style: const TextStyle(fontWeight: FontWeight.w400),
                )
              ],
            ),
            Text(location.name),
          ],
        ));
  }
}
