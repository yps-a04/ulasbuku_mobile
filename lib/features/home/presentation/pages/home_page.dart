import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sizer/sizer.dart';
import 'package:ulas_buku_mobile/core/environments/endpoints.dart';
import 'package:ulas_buku_mobile/core/theme/ub_color.dart';
import 'package:ulas_buku_mobile/features/authentication/presentation/login/login_page.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';
import 'package:ulas_buku_mobile/features/home/presentation/bloc/home_bloc.dart';
// ignore: unnecessary_import
import 'package:ulas_buku_mobile/features/home/presentation/widgets/book_card.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/book_list_view.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';
import 'package:ulas_buku_mobile/features/bookmark/presentation/pages/bookmark_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  bool isLightMode = true;
  ScrollController homeController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();

    final scaffoldKey = GlobalKey<ScaffoldState>();

    List<Color> cardColors =
        isLightMode ? UBColor.lightCardColors : UBColor.darkCardColors;

    Color textColor = isLightMode ? UBColor.darkBgColor : UBColor.lightBgColor;
    cardColors.shuffle();

    final request = context.watch<CookieRequest>();

    bloc.add(HomeLoadDataEvent(request: request));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: isLightMode ? UBColor.lightBgColor : UBColor.darkBgColor,
      drawer: const Drawer(),
      body: SingleChildScrollView(
        controller: homeController,
        child: SizedBox(
          height: 200.h,
          width: 100.w,
          child: Stack(
            children: <Widget>[
              Container(
                // Background
                decoration: BoxDecoration(
                    color: cardColors[0],
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.elliptical(30, 30))),
                height: 25.h,
                width: 100.w,
                // Background
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          isLightMode ? Icons.light_mode : Icons.dark_mode,
                          color: Colors.black,
                        ),
                        onPressed: (() {
                          setState(() {
                            isLightMode = !isLightMode;
                          });
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
                        onPressed: () async {
                          final response =
                              await request.logout(EndPoints.logout);
                          if (response['status']) {
                            String uname = response["username"];
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.white,
                                  margin: EdgeInsets.fromLTRB(
                                      10.w, 10.h, 10.w, 75.h),
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
                                      Text(
                                        "Sampai jumpa, $uname.",
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(),
              Positioned(
                top: 25.h - 30,
                left: 25.0,
                right: 25.0,
                child: Container(
                  height: 7.5.h,
                  width: 75.w,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFAF9F6),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60.w,
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "Search by name/author/ISBN",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              border: InputBorder.none,
                            ),
                            onTap: () {},
                            onChanged: (value) {
                              bloc.add(
                                HomeSearchEvent(
                                  request: request,
                                  query: value.toString(),
                                ),
                              );
                            },
                          ),
                        ),
                        const Icon(Icons.search, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 35.h,
                right: 20,
                left: 20,
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeSearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    }

                    if (state is HomeSearchError) {
                      return const Center(
                        child: Text(
                            "Terjadi Kesalahan. Cek kembali koneksi internet anda."),
                      );
                    }

                    if (state is HomeSearchLoaded) {
                      if (state.results.isEmpty) {
                        return const Center(
                          child: Text("Buku tidak ditemukan :("),
                        );
                      }
                      return SizedBox(
                        height: 75.h,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(0),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: state.results.length,
                          itemBuilder: (context, index) {
                            return BookCard(
                                textColor: textColor,
                                cardColor: cardColors[index % 5],
                                book: state.results[index]);
                          },
                        ),
                      );
                    }
                    return Column(
                      children: [
                        SizedBox(
                          height: 40.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Your Bookmark",
                                    style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BookmarkPage()));
                                    },
                                    child: const Text(
                                      "Show All",
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 33.h,
                                width: 100.w,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return BookCard(
                                      cardColor: cardColors[index % 5],
                                      textColor: textColor,
                                      book: Book(
                                        fields: Fields(
                                            title: "ini bookmarked book",
                                            author: "ini bookmarked book "),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        BookListView(
                            isLightMode: isLightMode,
                            homeScrollController: homeController,
                            bloc: bloc,
                            cardColors: cardColors,
                            textColor: textColor)
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        isLightMode: isLightMode,
        currentIndex: index,
        onTap: (value) {
          if (value == 1) {
            //navigate ke bookmark
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookmarkPage(),
                ));
          } else if (value == 2) {
            // navigate ke add book
          } else if (value == 3) {
            // navigate ke edit profile
          }
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
