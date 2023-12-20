import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ulas_buku_mobile/core/theme/ub_color.dart';
import 'package:ulas_buku_mobile/core/widgets/ub_button.dart';
import 'package:ulas_buku_mobile/features/admin/presentation/form/edit_book.dart';
import 'package:ulas_buku_mobile/features/detail/presentation/pages/detail_page.dart';
import 'package:ulas_buku_mobile/features/detail/presentation/add_review.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';
import 'package:ulas_buku_mobile/features/home/presentation/bloc/home_bloc.dart';

class BookCard extends StatelessWidget {
  const BookCard(
      {super.key,
      required this.isAdmin,
      required this.cardColor,
      required this.textColor,
      required this.book,
      this.isLightMode = true});
  final bool isAdmin;
  final Color textColor;
  final Color cardColor;
  final Book book;
  final bool isLightMode;

  void _deleteBook(int id, CookieRequest cookieRequest) async {
    try {
      // ignore: unused_local_variable
      final response = await cookieRequest 
          // .post('https://ulasbuku-a04-tk.pbp.cs.ui.ac.id//show-admin/delete-flutter/$id/', {});
          .post('http://10.0.2.2:8000/show-admin/delete-flutter/$id/', {});
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor:
              isLightMode ? UBColor.lightBgColor : UBColor.darkBgColor,
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
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: textColor,
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
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                book.fields!.author!,
                                style: TextStyle(color: textColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${book.fields!.textReviewCount} times reviewed ",
                                style: TextStyle(color: textColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "tes",
                                style: TextStyle(color: textColor),
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
                                    isLightMode: isLightMode,
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
                    if (!isAdmin) ...[
                      UBButton(
                        width: width,
                        height: 50,
                        primaryColor: cardColor,
                        secondaryColor: Colors.white,
                        text: "Add a review",
                        icon: Icons.edit,
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddReview(
                            book: book,
                            bgColor: cardColor,
                            isLightMode: true,
                          ),
                        )),
                      )
                    ],
                    if (isAdmin) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          UBButton(
                            width: width * 0.4,
                            height: 50,
                            primaryColor: cardColor,
                            secondaryColor: Colors.white,
                            text: "Edit",
                            icon: Icons.edit,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditBookPage(book: book, isLightMode: isLightMode,)));
                            },
                          ),
                          UBButton(
                            width: width * 0.4,
                            height: 50,
                            primaryColor: cardColor,
                            secondaryColor: Colors.white,
                            text: "Delete",
                            icon: Icons.delete,
                            onTap: () => showDialog(
                              context: context, 
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete Book'),
                                  content: Text('Apakah Anda yakin ingin menghapus buku ${book.fields!.title!}?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        _deleteBook(book.pk!, request);
                                        Navigator.of(context).pop(); // Close the dialog
                                        context.read<HomeBloc>().add(HomeLoadDataEvent(request: request));
                                        Navigator.of(context).pop(); 
                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(
                                            SnackBar(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(24),
                                              ),
                                              behavior: SnackBarBehavior.floating,
                                              backgroundColor: Colors.white,
                                              margin: EdgeInsets.fromLTRB(width * 0.1,
                                                  height * 0.1, width * 0.1, height * 0.75),
                                              content: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.check,
                                                    color: Colors.green,
                                                  ),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Buku ${book.fields!.title!} telah dihapus !",
                                                      overflow: TextOverflow.ellipsis,
                                                      style:
                                                          const TextStyle(color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      )
                    ],
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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                  color: textColor),
            ),
            Text(
              book.fields!.author!,
              style: TextStyle(color: textColor, fontSize: 9.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
