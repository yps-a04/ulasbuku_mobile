// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:ulas_buku_mobile/core/environments/endpoints.dart';
import 'package:ulas_buku_mobile/core/theme/ub_color.dart';
import 'package:ulas_buku_mobile/core/widgets/ub_button.dart';
import 'package:ulas_buku_mobile/features/detail/presentation/pages/detail_page.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';

class BookmarkCard extends StatefulWidget {
  BookmarkCard({super.key, required this.book, this.isLightMode = true});
  Book book;
  bool isLightMode;
  @override
  State<StatefulWidget> createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard> {
  bool pressed = true;

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

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
    } else {
      // If the server returns an error response,
      // then throw an exception.
      throw Exception('Failed to send data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor:
              widget.isLightMode ? UBColor.lightBgColor : UBColor.darkBgColor,
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
                                  'https://covers.openlibrary.org/b/isbn/${widget.book.fields!.isbn}-M.jpg',
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
                                  rating: widget.book.fields!.averageRating!,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
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
                                  widget.book.fields!.title!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                widget.book.fields!.author!,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${widget.book.fields!.textReviewCount} times reviewed ",
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              UBButton(
                                height: 50,
                                width: width * 0.4,
                                text: "More details",
                                primaryColor: Colors.white,
                                secondaryColor: Colors.white,
                                icon: Icons.arrow_forward_ios,
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    isLightMode: widget.isLightMode,
                                    book: widget.book,
                                    bgColor: Colors.white,
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
                      primaryColor: Colors.white,
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
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://covers.openlibrary.org/b/isbn/${widget.book.fields!.isbn}-L.jpg', // URL gambar dari ISBN
                  width: 70,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 4, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.book.fields!.title ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          widget.book.fields!.author ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      RatingBarIndicator(
                        rating: widget.book.fields!.averageRating!,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                    deleteBookmark();
                  });
                },
                icon: Icon(
                  Icons.bookmark,
                  color: (pressed == true) ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
