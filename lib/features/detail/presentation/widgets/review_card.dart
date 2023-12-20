import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    required this.reviewer,
    required this.reviewDate,
    required this.title,
    required this.text,
    required this.textColor,
    super.key,
  });

  final String reviewer;
  final String reviewDate;
  final String title;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 0.3,
      width: width * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'assets/img/user.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reviewer,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: textColor)),
                  Text(
                    reviewDate,
                    style: TextStyle(color: textColor),
                  )
                ],
              )
            ],
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
          Text(
            text,
            style: TextStyle(color: textColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 6,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
