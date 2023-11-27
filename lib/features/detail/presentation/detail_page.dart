import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatelessWidget {
  DetailPage({required this.bgColor, super.key});

  Color bgColor;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 28,
            )),
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height * 1.2,
          child: Stack(
            children: [
              Positioned(
                top: height * 0.2,
                right: 0,
                left: 0,
                child: Container(
                  height: height * 1.25,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: width * 0.25,
                right: width * 0.25,
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: height * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        "assets/img/tes.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height * 0.35,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Judul Buku",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark,
                              color: Colors.grey,
                              size: 28,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: 3.5,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.black,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "4.5/5",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Text(
                      "Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(thickness: 1),
                    Text(
                      'Author : Morbius\n'
                      'ISBN13 : 12345678\n'
                      'ISBN : 12321312\n'
                      'Reviews Count  : 2.222\n'
                      'Publisher  : Morbes\n'
                      'Published Date : 20/20/2020',
                      style: TextStyle(letterSpacing: 1, height: 2),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Text(
                      "Reviews",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: height * 0.3,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (context, index) => SizedBox(
                          width: 16,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 0.3,
                            width: width * 0.75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: Image.asset('assets/img/user.png'),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Username Reviewer",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                        Text("22/22/22")
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  "Title",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                  ' Etiam egestas quam eget orci imperdiet hendrerit. Nulla ultricies'
                                  ' dignissim risus nec feugiat. Aliquam eget fringilla mi, in pulvinar'
                                  ' lectus. Pellentesque facilisis accumsan lorem, vitae suscipit ligula '
                                  'fermentum vel. Sed efficitur arcu ac lectus porttitor, vel bibendum '
                                  'turpis sollicitudin. Sed laoreet quam ac orci congue, a mattis magna'
                                  ' pretium. Integer et dui sit amet odio auctor porta id nec lectus.',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 6,
                                )
                              ],
                            ),
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
    );
  }
}
