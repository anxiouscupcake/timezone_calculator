import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone_calculator/common.dart';
import 'package:timezone_calculator/constants.dart';
import 'package:timezone_calculator/types/timezone_card_data.dart';

class TimezoneCard extends StatefulWidget {
  const TimezoneCard(
      {super.key, required this.cardData, required this.pointOfReference});

  final TZDateTime pointOfReference;
  final TimezoneCardData cardData;

  @override
  State<StatefulWidget> createState() => _TimezoneCardState();
}

class _TimezoneCardState extends State<TimezoneCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            timeFormat24.format(TZDateTime.from(
                widget.pointOfReference, widget.cardData.location)),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          Text(
            getTzAbbreviationWithHours(widget.cardData.location),
            style: const TextStyle(fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
