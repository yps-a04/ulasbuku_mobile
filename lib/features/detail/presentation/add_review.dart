import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ulas_buku_mobile/core/widgets/ub_button.dart';

// ignore: must_be_immutable
class AddReview extends StatelessWidget {
 AddReview({required this.bgColor, super.key});

 final TextEditingController _titleController = TextEditingController();
 final TextEditingController _reviewController = TextEditingController();

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
            icon: const Icon(
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
                top: height * 0.1,
                right: 0,
                left: 0,
                child: Container(
                  height: height * 1.25,
                  width: width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height * 0.14,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text(
                          "Tambahkan Review",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: "Review Title",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: _reviewController,
                      maxLines: 10,
                      style: TextStyle(height: 1.5), // Adjust as needed
                      decoration: InputDecoration(
                        labelText: "Write Your Review Here",
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    UBButton(
                      width: width,
                      height: 50,
                      primaryColor: bgColor,
                      secondaryColor: Colors.white,
                      text: "Submit Review",
                      icon: Icons.arrow_forward_ios,
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