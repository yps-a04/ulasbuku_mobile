// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ulas_buku_mobile/features/bookmark/presentation/widget/bookmark_card.dart';
import 'package:ulas_buku_mobile/features/home/presentation/pages/home_page.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';
import 'package:ulas_buku_mobile/core/widgets/bottom_bar.dart';
import 'package:ulas_buku_mobile/features/profile/profile.dart';
import 'package:ulas_buku_mobile/core/theme/ub_color.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulas_buku_mobile/features/bookmark/data/data_source/bookmark_remote_data_source.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:ulas_buku_mobile/core/environments/endpoints.dart';
import 'package:ulas_buku_mobile/features/admin/presentation/form/book_form.dart';



class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key, this.isLightMode = true, required this.isAdmin});
  final bool isLightMode;
  final bool isAdmin;

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  int index = 1;
  late bool isLightMode;
  List<Book> bookmarkedBooks = []; 
  
  @override
  void initState() {
    super.initState();
    isLightMode = widget.isLightMode;
    fetchBookmark();
  }

  Future<void> fetchBookmark() async {
    final request = context.read<CookieRequest>();
    final dataSource = BookmarkListRemoteDataSource(request: request);

    try {
      final books = await dataSource.fetchBooks();
      setState(() {
        bookmarkedBooks = books;
      });
    } catch (e) {
      // ignore: avoid_print
      print('error : $e');
    }
  }


  Future<void> searchBooks(String query) async {
    final request = context.read<CookieRequest>();
    try { 
      await fetchBookmark();
      final List<Book> result = [];
      final response = await request.get('${EndPoints.search}?q=$query');
      for (var i in response) {
        Book book = Book();
        book.model = 'main.book';
        book.pk = i['pk'];
        book.fields = Fields.fromJson(i);
        for (var j in bookmarkedBooks) {
          if (j.pk == book.pk) {
            result.add(book);
          }
        }
      }
      setState(() {
        bookmarkedBooks = result;
      });
    } catch (e) {
      throw Exception('error : $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    Color textColor = isLightMode ? UBColor.lightBgColor : UBColor.darkBgColor ;
    Color textColorInverse = isLightMode ?  UBColor.darkBgColor : UBColor.lightBgColor ;

    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffacdcf2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10), // Adjust the radius as needed
          ),
        ),
        title: const Text(
          'Bookmarks',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: UBColor.darkBgColor,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(isAdmin: true, isLightMode: isLightMode,),
                ));
          },
        ),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: (isLightMode) ?Colors.grey[200] : UBColor.darkBgColor,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: widget.isLightMode
                        ? UBColor.darkBgColor
                        : UBColor.lightBgColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                        size: 24,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Search bookmarks...',
                              labelStyle: TextStyle(
                              fontSize: 16,
                              color: textColorInverse,
                              ),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            onSubmitted: (value) {
                              searchBooks(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 0, 4),
              child: Text(
                'My Bookmarks',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColorInverse,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Expanded(
                  child: SizedBox(
                    height: 60.h,
                    child: ListView.builder(
                      itemCount: bookmarkedBooks.length,
                      itemBuilder: (context, index) {
                        return BookmarkCard(
                            book: bookmarkedBooks[index]
                            , isAdmin: widget.isAdmin,
                            );
                      },
                    ),
          )),
        )],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        isLightMode: isLightMode,
        currentIndex: index,
        isAdmin: widget.isAdmin,
        onTap: (value) {
          // print(value);
          if (!widget.isAdmin)
          {
            if (value == 1)
            {
            }

            else if (value == 2)
            {
              Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  isAdmin: widget.isAdmin,
                  isLightMode: isLightMode,
                ),
              ),
            );
            }
          }

          else
          {
            if (value == 1) {
              
            } else if (value == 2) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BookForm(isLightMode: isLightMode,)));
            } else if (value == 3) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BookForm(isLightMode: isLightMode,)));
            }
            else if (value == 4)
            {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    isAdmin: widget.isAdmin,
                    isLightMode: isLightMode,
                  ),
                ),
              );
            }
          }
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
