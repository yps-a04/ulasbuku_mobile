import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ulas_buku_mobile/core/widgets/ub_button.dart';
import 'package:ulas_buku_mobile/features/detail/presentation/pages/detail_page.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.cardColor, required this.book});

  final Color cardColor;
  final Book book;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          context: context,
          builder: (context) {
            return SizedBox(
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
                            SizedBox(
                              width: width * 0.4,
                              height: height * 0.25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  'https://covers.openlibrary.org/b/isbn/${book.fields!.isbn}-M.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: book.fields!.averageRating!,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.black,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                          width: width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width * 0.4,
                                child: Text(
                                  book.fields!.title!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                book.fields!.author!,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${book.fields!.textReviewCount} times reviewed ",
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Text(
                                "tes",
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              UBButton(
                                height: 50,
                                width: width * 0.4,
                                text: "More details",
                                primaryColor: cardColor,
                                secondaryColor: Colors.white,
                                icon: Icons.arrow_forward_ios,
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    book: book,
                                    bgColor: cardColor,
                                  ),
                                )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    UBButton(
                      width: width,
                      height: 50,
                      primaryColor: cardColor,
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
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        width: width * 1 / 2,
        height: height * 1 / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
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
                        width: width * 1 / 3,
                        height: height * 1 / 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://covers.openlibrary.org/b/isbn/${book.fields!.isbn}-M.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              book.fields!.title!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              book.fields!.author!,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
