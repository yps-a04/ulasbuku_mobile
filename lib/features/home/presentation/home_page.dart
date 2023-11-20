import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/book_card.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';
import 'package:unicons/unicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int index = 0;
    final scaffoldKey = GlobalKey<ScaffoldState>();

    List<Color> cardColors = [
      Color(0xffacdcf2),
      Color(0xffFf9bbd0),
      Color(0xffb2dfdc),
      Color(0xFFffcc80),
      Color(0xffc5cae8),
    ];

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Ulas Buku",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: height * 1 / 2.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Bookmark",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          "Show All",
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 1 / 3,
                      width: width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          cardColors.shuffle();
                          Color cardColor = cardColors[index % 5];
                          return BookCard(
                            width: width,
                            height: height,
                            cardColor: cardColor,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 1 / 2,
                child: Column(
                  children: [
                    DefaultTabController(
                      initialIndex: 0,
                      length: 3,
                      child: TabBar(
                          indicatorColor: Colors.black,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(text: "Explore"),
                            Tab(text: "Newest"),
                            Tab(text: "Most Reviewed"),
                          ]),
                    ),
                    Expanded(
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:
                                (height * 1 / 6) / (width * 1 / 2),
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          cardColors.shuffle();
                          Color cardColor = cardColors[index % 5];
                          return BookCard(
                            width: width,
                            height: height,
                            cardColor: cardColor,
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
