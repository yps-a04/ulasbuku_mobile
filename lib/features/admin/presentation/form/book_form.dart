import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulas_buku_mobile/core/theme/ub_color.dart';
import 'package:ulas_buku_mobile/features/admin/presentation/users/list_user.dart';
import 'package:ulas_buku_mobile/features/home/presentation/pages/home_page.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';

// ignore: must_be_immutable
class BookForm extends StatefulWidget {
  BookForm({this.isLightMode = true, super.key});
  bool isLightMode;

  @override
  // ignore: library_private_types_in_public_api
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  late bool isLightMode;
  @override
  void initState() {
    super.initState();
    isLightMode = widget.isLightMode;
  }
  String _title = "";
  String _author = "";
  double _averageRating = 0.0;
  String _isbn = "";
  String _isbn13 = "";
  String _languageCode = "";
  int _numPages = 0;
  int _ratingCount = 0;
  int _textReviewCount = 0;
  String _publicationDate = "";
  String _publisher = "";

  int index = 2;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Color backgroundColor = widget.isLightMode ? UBColor.lightBgColor : UBColor.darkBgColor;
    Color secondaryColor = !widget.isLightMode ? UBColor.lightBgColor : UBColor.darkBgColor;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Add New Book',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: secondaryColor,
      ),
      backgroundColor: backgroundColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: secondaryColor),
                  decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: TextStyle(color: secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Title tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: secondaryColor),
                  decoration: InputDecoration(
                    labelText: "Author",
                    labelStyle: TextStyle(color: secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      // _title = int.parse(value!);
                      _author = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Author tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: secondaryColor),
                  decoration: InputDecoration(
                    labelText: "Average Rating (dalam float)",
                    labelStyle: TextStyle(color: secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _averageRating = double.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Average Rating tidak boleh kosong!";
                    }
                    if (double.tryParse(value) == null) {
                      return "Average Rating harus berupa double!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: secondaryColor),
                  decoration: InputDecoration(
                    labelText: "ISBN",
                    labelStyle: TextStyle(color: secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _isbn = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "ISBN tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: secondaryColor),
                  decoration: InputDecoration(
                    labelText: "ISBN13",
                    labelStyle: TextStyle(color: secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _isbn13 = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "ISBN13 tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: secondaryColor),
                  decoration: InputDecoration(
                    labelText: "Language Code (max 10 char)",
                    labelStyle: TextStyle(color: secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _languageCode = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Language Code tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: secondaryColor),
                  decoration: InputDecoration(
                    labelText: "Num Pages",
                    labelStyle: TextStyle(color: secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _numPages = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Num Pages tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Num Pages harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: secondaryColor),
                  decoration: InputDecoration(
                    labelText: "Rating Count",
                    labelStyle: TextStyle(color: secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _ratingCount = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Rating Count tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Rating Count harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: secondaryColor),
                  decoration: InputDecoration(
                    labelText: "Text Review Count",
                    labelStyle: TextStyle(color: secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _textReviewCount = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Text Review Count tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Text Review Count harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: secondaryColor),
                  decoration: InputDecoration(
                    labelText: "Publication Date",
                    labelStyle: TextStyle(color: secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _publicationDate = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Publication Date tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: secondaryColor),
                  decoration: InputDecoration(
                    labelText: "Publisher",
                    labelStyle: TextStyle(color: secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _publisher = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Publisher tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                          final response = await request.postJson(
                          "http://ulasbuku-a04-tk.pbp.cs.ui.ac.id/show-admin/create-flutter/",
                          // "http://10.0.2.2:8000/show-admin/create-flutter/",
                          jsonEncode(<String, String>{
                              'title': _title,
                              'author': _author,
                              'averageRating': _averageRating.toString(),
                              'isbn': _isbn,
                              'isbn13': _isbn13,
                              'languageCode': _languageCode,
                              'numPages': _numPages.toString(),
                              'ratingCount': _ratingCount.toString(),
                              'textReviewCount': _textReviewCount.toString(),
                              'publicationDate': _publicationDate,
                              'publisher': _publisher,
                          }));
                          if (response['status'] == 'success') {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                              content: Text("Buku baru berhasil disimpan!"),
                              ));
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomePage(isAdmin: true)),
                              );
                          } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                  content:
                                      Text("Terdapat kesalahan, silakan coba lagi."),
                              ));
                          }
                        }
                    },
                    child: Text(
                      "Add Book",
                      style: TextStyle(fontSize: 16 ,color: backgroundColor),
                    ),
                  ),
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
          if (value == 0) {
            //navigate ke home
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(isLightMode: isLightMode, isAdmin: true),
              ),
            );
          } else if (value == 1) {
            // navigate ke bookmark
          } else if (value == 2) {
            // di add book
          } else if (value == 3) {
            // navigate ke list user
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ListUserPage(isLightMode: isLightMode,)
              )
            );
          }
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}