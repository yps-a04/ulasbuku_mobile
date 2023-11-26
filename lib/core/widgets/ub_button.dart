import 'package:flutter/material.dart';

class UBButton extends StatelessWidget {
  const UBButton({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.primaryColor,
    required this.secondaryColor,
    this.icon,
  });

  final double width;
  final double height;
  final String text;
  final IconData? icon;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style:
                  TextStyle(color: secondaryColor, fontWeight: FontWeight.bold),
            ),
            if (icon != null) ...[
              Icon(
                icon,
                color: secondaryColor,
              )
            ]
          ],
        ),
      ),
    );
  }
}
