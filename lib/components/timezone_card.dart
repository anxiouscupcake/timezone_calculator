import 'package:flutter/material.dart';

class TimezoneCard extends StatefulWidget {
  const TimezoneCard({super.key});

  @override
  State<StatefulWidget> createState() => _TimezoneCardState();
}

class _TimezoneCardState extends State<TimezoneCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "15:45",
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          Text(
            "UTC+05",
            style: const TextStyle(fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
