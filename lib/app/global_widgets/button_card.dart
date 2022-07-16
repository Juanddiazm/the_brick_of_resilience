import 'package:flutter/material.dart';
import 'package:the_brick_of_resilience/app/utils/responsive.dart';

class ButtonCard extends StatelessWidget {
  final List<Color> colors;
  final Color shadowColor;
  final String text;
  final String iconTag;
  final Icon icon;
  final Function onPressed;
  const ButtonCard({
    Key? key,
    required this.colors,
    required this.shadowColor,
    required this.text,
    required this.iconTag,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: GestureDetector(
        onTap: () => onPressed(),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              height: 150,
              width: Responsive.of(context).wp(100),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: colors,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(1, 3),
                    blurRadius: 7,
                    spreadRadius: 5,
                    color: shadowColor,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Hero(tag: iconTag, child: icon),
          ],
        ),
      ),
    );
  }
}
