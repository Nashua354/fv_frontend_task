import 'package:flutter/material.dart';

Widget priceWithSuperScript(String price, double fontSize,
    {Color color = Colors.black}) {
  return RichText(
    text: TextSpan(children: [
      TextSpan(
          text: price.split('.').first,
          style: TextStyle(color: color, fontSize: fontSize)),
      WidgetSpan(
        child: Transform.translate(
          offset: const Offset(1, -5),
          child: Text(
            ".${price.split('.').last}",
            //superscript is usually smaller in size
            // textScaleFactor: 0.7,
            textScaler: const TextScaler.linear(0.7),
            style: TextStyle(color: color),
          ),
        ),
      )
    ]),
  );
}

String intToMonth(int month) {
  const List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  if (month < 1 || month > 12) {
    return 'Invalid month'; // Handle invalid month numbers
  }

  return months[month - 1]; // Subtract 1 because list is 0-indexed
}
