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
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          context: context,
          builder: (context) {
            return Container(
              width: width,
              height: height * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: width * 0.4,
                              height: height * 0.25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/img/tes.jpeg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("4.5/5"),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.star)
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Judul",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Penulis"),
                            Text("1.321 times reviewed "),
                            Text("22-5-2070"),
                            SizedBox(
                              height: 30,
                            ),
                            UBButton(
                              height: 50,
                              width: width * 0.4,
                              text: "More details",
                              primaryColor: Colors.black,
                              secondaryColor: Colors.white,
                              icon: Icons.arrow_forward_ios,
                            )
                          ],
                        )
                      ],
                    ),
                    UBButton(
                      width: width,
                      height: 50,
                      primaryColor: Colors.black,
                      secondaryColor: Colors.white,
                      text: "Add a review",
                      icon: Icons.edit,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
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
                    left: 35,
                    right: 35,
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: width * 1 / 3.5,
                        height: height * 1 / 5.25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/img/tes.jpeg',
                            fit: BoxFit.cover,
                          ),
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
      ),
    );
  }
}

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
