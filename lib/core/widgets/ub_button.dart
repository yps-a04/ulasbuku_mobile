import 'package:flutter/material.dart';

class UBButton extends StatelessWidget {
  const UBButton({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.primaryColor,
    required this.secondaryColor,
    this.onTap,
    this.alignment,
    this.icon,
  });

  final double width;
  final double height;
  final String text;
  final IconData? icon;
  final Color primaryColor;
  final Color secondaryColor;
  final MainAxisAlignment? alignment; //default spaceBetween
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment:
                alignment == null ? MainAxisAlignment.spaceBetween : alignment!,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: secondaryColor, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
