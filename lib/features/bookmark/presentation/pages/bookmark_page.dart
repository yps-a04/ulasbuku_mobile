import 'package:flutter/material.dart';
import 'package:ulas_buku_mobile/features/bookmark/presentation/widget/bookmark_card.dart';
import 'package:ulas_buku_mobile/features/home/presentation/pages/home_page.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';
import 'package:ulas_buku_mobile/features/profile/profile.dart';
import 'package:ulas_buku_mobile/core/theme/ub_color.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage(
      {super.key, this.isLightMode = true, required this.bookmarkedBooks});
  final bool isLightMode;
  final List<Book>? bookmarkedBooks;
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.isLightMode ? UBColor.lightBgColor : UBColor.darkBgColor,
        title: const Text(
          'Bookmarks',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: widget.isLightMode ? UBColor.lightBgColor : UBColor.darkBgColor,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.tune_rounded,
              color: widget.isLightMode ? UBColor.lightBgColor : UBColor.darkBgColor,
              size: 24,
            ),
            onPressed: () {},
          ),
        ],
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
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: widget.isLightMode ? UBColor.darkBgColor:UBColor.lightBgColor ,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                        size: 24,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Search bookmarks...',
                              labelStyle: TextStyle(
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 0, 4),
              child: Text(
                'My Bookmarks',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: (widget.bookmarkedBooks == null)
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: widget.bookmarkedBooks!.length,
                            itemBuilder: (context, index) {
                              return BookmarkCard(
                                  book: widget.bookmarkedBooks![index],
                                  bookmarkedBooks: widget.bookmarkedBooks,);
                            },
                          ),
                        ),
                      )),
          ],
        ),
      ), 
      bottomNavigationBar: BottomNavBar(
        isLightMode: widget.isLightMode,
        currentIndex: index,

        onTap: (value) {
          print(value);
          if (value == 0) {
            //navigate ke bookmark
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
          } else if (value == 2) {
            // navigate ke add book
          } else if (value == 3) {
            // navigate ke add book
          }
          else if (value == 4)
          {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          }
          setState(() {
            index = value;
          });
        },
      ),
    
    );
  }
}
