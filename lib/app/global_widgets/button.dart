import 'package:flutter/material.dart';
import 'package:the_brick_of_resilience/app/utils/responsive.dart';

TextButton button(BuildContext context, Color backgroundColor, String text,
    double width, Function onPressed) {
  return TextButton(
    style: TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.all(10),
      fixedSize: Size(width, Responsive.of(context).hp(5)),
    ),
    child: Text(text),
    onPressed: () => onPressed(),
  );
}
