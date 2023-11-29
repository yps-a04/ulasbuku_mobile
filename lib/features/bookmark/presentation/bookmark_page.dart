import 'package:flutter/material.dart';

import 'package:ulas_buku_mobile/features/home/presentation/widgets/book_card.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});
  @override
  State<StatefulWidget> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    int index = 1;

    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: BottomNavBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
