import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulas_buku_mobile/features/home/presentation/bloc/home_bloc.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/book_card.dart';

class BookListView extends StatelessWidget {
  const BookListView({
    super.key,
    required this.bloc,
    required this.cardColors,
  });

  final List<Color> cardColors;
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: SizedBox(
        height: height * 1.5,
        child: Column(
          children: [
            const TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "Explore"),
                  Tab(text: "Newest"),
                  Tab(text: "Most Reviewed"),
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
                      GridView.builder(
                        padding: const EdgeInsets.all(0),
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:
                                (height * 1 / 6) / (width * 1 / 2),
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          cardColors.shuffle();
                          Color cardColor = cardColors[index % 5];
                          return BookCard(
                            cardColor: cardColor,
                            book: state.books[index],
                          );
                        },
                      ),
                      GridView.builder(
                        padding: const EdgeInsets.all(0),
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:
                                (height * 1 / 6) / (width * 1 / 2),
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          cardColors.shuffle();
                          Color cardColor = cardColors[index % 5];
                          return BookCard(
                            cardColor: cardColor,
                            book: state.books[index],
                          );
                        },
                      ),
                      GridView.builder(
                        padding: const EdgeInsets.all(0),
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:
                                (height * 1 / 6) / (width * 1 / 2),
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          cardColors.shuffle();
                          Color cardColor = cardColors[index % 5];
                          return BookCard(
                            cardColor: cardColor,
                            book: state.books[index],
                          );
                        },
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
