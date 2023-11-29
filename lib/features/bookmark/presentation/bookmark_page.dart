import 'package:flutter/material.dart';
import 'package:ulas_buku_mobile/features/home/presentation/pages/home_page.dart';

import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  // Dummy bookmark data
  final List<String> bookmarks = [
    "Bookmark 1",
    "Bookmark 2",
    "Bookmark 3",
    // Add more dummy bookmarks as needed
  ];

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int index = 1;

    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height * 2,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              Text(
                "User's Bookmark",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: bookmarks.length,
                  itemBuilder: (context, idx) {
                    return ListTile(
                      title: Text(bookmarks[idx]),
                      onTap: () {
                        // Handle bookmark tap
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: index,
        onTap: (value) {
          if (value == 0) {
            // Navigate to homepage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (value == 2) {
            // Navigate to add book page
            // Implement navigation logic
          } else if (value == 3) {
            // Navigate to profile page
          }
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
