import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:ulas_buku_mobile/features/home/presentation/widgets/book_card.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final scaffoldKey = GlobalKey<ScaffoldState>();

    List<Color> cardColors = [
      const Color(0xffacdcf2),
      // ignore: use_full_hex_values_for_flutter_colors
      const Color(0xffff9bbd0),
      const Color(0xffb2dfdc),
      const Color(0xFFffcc80),
      const Color(0xffc5cae8),
    ];

    cardColors.shuffle();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height * 2,
          width: width,
          child: Stack(
            children: <Widget>[
              Container(
                // Background
                decoration: BoxDecoration(
                    color: cardColors[0],
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.elliptical(30, 30))),
                height: height * 0.25,
                width: width,
                // Background
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                        onPressed: (() {
                          scaffoldKey.currentState!.openDrawer();
                        }),
                      ),
                      const Text(
                        "Ulas Buku",
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Container(), // Required some widget in between to float AppBar

              Positioned(
                // To take AppBar Size only
                top: height * 0.25 - 30,
                left: 25.0,
                right: 25.0,
                child: AppBar(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                  ),
                  primary: false,
                  title: const TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey))),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Positioned(
                top: height * 0.35,
                right: 20,
                left: 20,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 1 / 2.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Row(
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
                              physics: const BouncingScrollPhysics(),
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
                    DefaultTabController(
                      length: 3,
                      child: SizedBox(
                        height: height * 1.5,
                        child: Column(
                          children: [
                            TabBar(
                                indicatorColor: Colors.black,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                tabs: [
                                  Tab(text: "Explore"),
                                  Tab(text: "Newest"),
                                  Tab(text: "Most Reviewed"),
                                ]),
                            SizedBox(
                              height: height * 1.2,
                              child: TabBarView(children: [
                                GridView.builder(
                                  padding: const EdgeInsets.all(0),
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: (height * 1 / 6) /
                                              (width * 1 / 2),
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
                                GridView.builder(
                                  padding: const EdgeInsets.all(0),
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: (height * 1 / 6) /
                                              (width * 1 / 2),
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
                                GridView.builder(
                                  padding: const EdgeInsets.all(0),
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: (height * 1 / 6) /
                                              (width * 1 / 2),
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
                              ]),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
