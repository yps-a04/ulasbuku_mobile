import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ulas_buku_mobile/core/theme/ub_color.dart';
import 'package:ulas_buku_mobile/features/detail/presentation/widgets/review_card.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  DetailPage(
      {this.isLightMode = true,
      required this.bgColor,
      required this.book,
      super.key});

  Book book;
  Color bgColor;
  bool isLightMode;

  @override
  Widget build(BuildContext context) {
    final Color textColor =
        isLightMode ? UBColor.darkBgColor : UBColor.lightBgColor;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 28,
            )),
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height * 1.4,
          child: Stack(
            children: [
              Positioned(
                top: height * 0.2,
                right: 0,
                left: 0,
                child: Container(
                  height: height * 1.25,
                  width: width,
                  decoration: BoxDecoration(
                    color: isLightMode
                        ? UBColor.lightBgColor
                        : UBColor.darkBgColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: width * 0.25,
                right: width * 0.25,
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(30),
                  child: SizedBox(
                    height: height * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        'https://covers.openlibrary.org/b/isbn/${book.fields!.isbn}-L.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height * 0.35,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.7,
                          child: Text(
                            book.fields!.title!,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.bookmark,
                              color: Colors.grey,
                              size: 28,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: book.fields!.averageRating!,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: textColor,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${book.fields!.averageRating!}/5",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(
                      thickness: 1,
                      color: textColor,
                    ),
                    Text(
                      "Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: textColor,
                    ),
                    Text(
                      'Author : ${book.fields!.author!} \n'
                      'ISBN13 :  ${book.fields!.isbn13!} \n'
                      'ISBN :  ${book.fields!.isbn!}\n'
                      'Reviews Count  :  ${book.fields!.textReviewCount!}\n'
                      'Publisher  :  ${book.fields!.publisher!}\n'
                      'Published Date : 20/20/2020',
                      style: TextStyle(
                          letterSpacing: 1, height: 2, color: textColor),
                    ),
                    Divider(
                      thickness: 1,
                      color: textColor,
                    ),
                    Text(
                      "Reviews",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: textColor,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: height * 0.3,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 16,
                        ),
                        itemBuilder: (context, index) {
                          return ReviewCard(
                            textColor: textColor,
                            reviewer: "Reviewer Name",
                            reviewDate: "22/22/2222",
                            title: "Title",
                            text:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                ' Etiam egestas quam eget orci imperdiet hendrerit. Nulla ultricies'
                                ' dignissim risus nec feugiat. Aliquam eget fringilla mi, in pulvinar'
                                ' lectus. Pellentesque facilisis accumsan lorem, vitae suscipit ligula '
                                'fermentum vel. Sed efficitur arcu ac lectus porttitor, vel bibendum '
                                'turpis sollicitudin. Sed laoreet quam ac orci congue, a mattis magna'
                                ' pretium. Integer et dui sit amet odio auctor porta id nec lectus.',
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
