import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:ulas_buku_mobile/features/home/presentation/bloc/home_bloc.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/book_card.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/scroll_parent.dart';

class BookListView extends StatelessWidget {
  const BookListView({
    super.key,
    required this.bloc,
    required this.cardColors,
    required this.textColor,
    required this.homeScrollController,
    required this.isLightMode,
    required this.isAdmin,
  });
  final bool isAdmin;
  final bool isLightMode;
  final ScrollController homeScrollController;
  final Color textColor;
  final List<Color> cardColors;
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 3,
      child: SizedBox(
        height: height * 1.5,
        child: Column(
          children: [
            TabBar(
                indicatorColor: textColor,
                labelColor: textColor,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "Explore"),
                  Tab(text: "Most Reviews"),
                  Tab(text: "Preferences"),
                ]),
            BlocBuilder<HomeBloc, HomeState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is HomeError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state is HomeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xffacdcf2),
                    ),
                  );
                }
                if (state is HomeLoaded) {
                  return SizedBox(
                    height: height * 1.2,
                    child: TabBarView(children: [
                      ScrollParent(
                        controller: homeScrollController,
                        child: GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.allBooks.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 40.w / 33.h,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            cardColors.shuffle();
                            Color cardColor = cardColors[index % 5];

                            return BookCard(
                              isAdmin: isAdmin,
                              isLightMode: isLightMode,
                              textColor: textColor,
                              cardColor: cardColor,
                              book: state.allBooks[index],
                            );
                          },
                        ),
                      ),
                      ScrollParent(
                        controller: homeScrollController,
                        child: GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.mostReviewedBooks.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 40.w / 33.h,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            cardColors.shuffle();
                            Color cardColor = cardColors[index % 5];
                            return BookCard(
                              isAdmin: isAdmin,
                              isLightMode: isLightMode,
                              textColor: textColor,
                              cardColor: cardColor,
                              book: state.mostReviewedBooks[index],
                            );
                          },
                        ),
                      ),
                      ScrollParent(
                        controller: homeScrollController,
                        child: GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.byPrefBooks.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 40.w / 33.h,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            cardColors.shuffle();
                            Color cardColor = cardColors[index % 5];
                            return BookCard(
                              isAdmin: isAdmin,
                              isLightMode: isLightMode,
                              textColor: textColor,
                              cardColor: cardColor,
                              book: state.byPrefBooks[index],
                            );
                          },
                        ),
                      ),
                    ]),
                  );
                }

                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
