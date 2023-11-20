import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard(
      {super.key,
      required this.width,
      required this.height,
      required this.cardColor});

  final double width;
  final double height;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: width * 1 / 2,
      height: height * 1 / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: height * 1 / 4,
            width: width * 1 / 2,
            child: Stack(
              children: [
                Positioned(
                  top: 60,
                  left: 5,
                  right: 5,
                  child: Container(
                    height: height * 1 / 6,
                    width: width * 1 / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: cardColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 40,
                  right: 40,
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: width * 1 / 3.5,
                      height: height * 1 / 5.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.asset(
                        'assets/img/tes.jpeg',
                        fit: BoxFit.cover,
                        
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Judul Buku",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text("Penulis")
        ],
      ),
    );
  }
}
