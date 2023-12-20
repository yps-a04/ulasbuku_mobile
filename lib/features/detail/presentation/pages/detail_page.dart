import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulas_buku_mobile/core/environments/endpoints.dart';
import 'package:ulas_buku_mobile/core/theme/ub_color.dart';
import 'package:ulas_buku_mobile/features/detail/data/review_model.dart';
import 'package:ulas_buku_mobile/features/detail/presentation/widgets/review_card.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';
import 'package:ulas_buku_mobile/features/home/presentation/pages/home_page.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  DetailPage(
      {this.isLightMode = true,
      required this.bgColor,
      required this.book,
      super.key});

  Book book;
  Color bgColor;
  bool isLightMode;

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<void> deleteBookmark() async {
    final request = context.read<CookieRequest>();
    final user = await request.get('http://localhost:8000/ret_profile/');
    final List<String> profile = [];
    user.forEach((key, value) {
      profile.add(value);
    });
    final response = await request.postJson(
        "${EndPoints.baseUrl}/b/${profile[0]}/delete/",
        jsonEncode({"pk": widget.book.pk}));

    if (response.statusCode != 200) {
      throw Exception('Failed to send data.');
    }
  }

  Future<List<Data>> fetchReview(int pk, CookieRequest request) async {
    try {
      final response = await request.get('${EndPoints.getReview}$pk');

      // print(response);
      final data = Review.fromJson(response);
      return data.data ?? [];
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool? isBookmarked = widget.book.fields!.isBookmarked;
    final Color textColor =
        widget.isLightMode ? UBColor.darkBgColor : UBColor.lightBgColor;
    final request = context.watch<CookieRequest>();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: widget.bgColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 28,
            )),
      ),
      backgroundColor: widget.bgColor,
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
                    color: widget.isLightMode
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
                        'https://covers.openlibrary.org/b/isbn/${widget.book.fields!.isbn}-L.jpg',
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
                            widget.book.fields!.title!,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                deleteBookmark();
                                isBookmarked = !isBookmarked!;
                              });
                            },
                            icon: Icon(
                              Icons.bookmark,
                              color: (isBookmarked!)
                                  ? Colors.black
                                  : Colors.grey,
                              size: 28,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: widget.book.fields!.averageRating!,
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
                          "${widget.book.fields!.averageRating!}/5",
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
                      'Author : ${widget.book.fields!.author!} \n'
                      'ISBN13 :  ${widget.book.fields!.isbn13!} \n'
                      'ISBN :  ${widget.book.fields!.isbn!}\n'
                      'Reviews Count  :  ${widget.book.fields!.textReviewCount!}\n'
                      'Publisher  :  ${widget.book.fields!.publisher!}\n'
                      'Published Date : ${widget.book.fields!.publicationDate}',
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
                    FutureBuilder(
                      future: fetchReview(widget.book.pk!, request),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          if (snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text("Belum ada review untuk buku ini :("),
                            );
                          }
                          return SizedBox(
                            height: height * 0.3,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 16,
                              ),
                              itemBuilder: (context, index) {
                                return ReviewCard(
                                    textColor: textColor,
                                    reviewer: snapshot.data![index].user!,
                                    reviewDate: "",
                                    title: snapshot.data![index].title!,
                                    text: snapshot.data![index].review!);
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text(
                                "Terjadi kesalahan saat mengambil data review..."),
                          );
                        }
                      },
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
