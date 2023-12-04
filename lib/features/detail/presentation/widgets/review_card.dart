import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    required this.reviewer,
    required this.reviewDate,
    required this.title,
    required this.text,
    super.key,
  });

  final String reviewer;
  final String reviewDate;
  final String title;
  final String text;

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
                child: Image.asset('assets/img/user.png'),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reviewer, style: const TextStyle(fontWeight: FontWeight.w500)),
                  Text(reviewDate)
                ],
              )
            ],
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 6,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
