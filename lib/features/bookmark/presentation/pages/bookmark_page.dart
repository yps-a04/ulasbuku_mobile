// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:ulas_buku_mobile/features/bookmark/presentation/widget/bookmark_card.dart';
import 'package:ulas_buku_mobile/features/home/presentation/pages/home_page.dart';
import 'package:ulas_buku_mobile/features/bookmark/data/data_source/bookmark_remote_data_source.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key, this.isLightMode = true});
  final bool isLightMode;
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<Book>? bookmarkedBooks;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Bookmarks',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(isAdmin: true),
                ));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.tune_rounded,
              color: Colors.black,
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
                    color: Colors.black,
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
                child: (bookmarkedBooks == null)
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: bookmarkedBooks!.length,
                            itemBuilder: (context, index) {
                              return BookmarkCard(
                                  book: bookmarkedBooks![index]);
                            },
                          ),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}
