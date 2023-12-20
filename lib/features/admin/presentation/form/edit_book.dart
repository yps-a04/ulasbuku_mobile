// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulas_buku_mobile/features/admin/presentation/users/list_user.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';
import 'package:ulas_buku_mobile/features/home/presentation/pages/home_page.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';

class EditBookPage extends StatefulWidget {
  const EditBookPage({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  _EditBookPageState createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  bool isLightMode = true;
  String? _title = "";
  String? _author = "";
  double? _averageRating = 0.0;
  String? _isbn = "";
  String? _isbn13 = "";
  String? _languageCode = "";
  int? _numPages = 0;
  int? _ratingCount = 0;
  int? _textReviewCount = 0;
  String? _publicationDate = "";
  String? _publisher = "";

  int index = 0;
  @override
  void initState() {
    super.initState();
    _title = widget.book.fields!.title;
    _author = widget.book.fields!.author;
    _averageRating = widget.book.fields!.averageRating;
    _isbn = widget.book.fields!.isbn;
    _isbn13 = widget.book.fields!.isbn13;
    _languageCode = widget.book.fields!.languageCode;
    _numPages = widget.book.fields!.numPages;
    _ratingCount = widget.book.fields!.ratingCount;
    _textReviewCount = widget.book.fields!.textReviewCount;
    _publicationDate = "";
    _publisher = widget.book.fields!.publisher;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Edit Book',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: const Color(0xffc5cae8),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.book.fields!.title,
                decoration: InputDecoration(
                  labelText: "Title",
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
                initialValue: widget.book.fields!.author,
                decoration: InputDecoration(
                  labelText: "Author",
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
                initialValue: widget.book.fields!.averageRating.toString(),
                decoration: InputDecoration(
                  labelText: "Average Rating (dalam float)",
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
                initialValue: widget.book.fields!.isbn,
                decoration: InputDecoration(
                  labelText: "ISBN",
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
                initialValue: widget.book.fields!.isbn13,
                decoration: InputDecoration(
                  labelText: "ISBN13",
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
                initialValue: widget.book.fields!.languageCode,
                decoration: InputDecoration(
                  labelText: "Language Code (max 10 char)",
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
                initialValue: widget.book.fields!.numPages.toString(),
                decoration: InputDecoration(
                  labelText: "Num Pages",
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
                initialValue: widget.book.fields!.ratingCount.toString(),
                decoration: InputDecoration(
                  labelText: "Rating Count",
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
                initialValue: widget.book.fields!.textReviewCount.toString(),
                decoration: InputDecoration(
                  labelText: "Text Review Count",
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
                initialValue: widget.book.fields!.publicationDate,
                decoration: InputDecoration(
                  labelText: "Publication Date",
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
                initialValue: widget.book.fields!.publisher,
                decoration: InputDecoration(
                  labelText: "Publisher",
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
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                  ),
                  onPressed: () async {
                    final response = await request.postJson(
                    // "https://ulasbuku-a04-tk.pbp.cs.ui.ac.id//show-admin/edit-flutter/${widget.book.pk}",
                    "http://10.0.2.2:8000/show-admin/edit-flutter/${widget.book.pk}",
                    jsonEncode(<String, String>{
                        'title': _title!,
                        'author': _author!,
                        'averageRating': _averageRating!.toString(),
                        'isbn': _isbn!,
                        'isbn13': _isbn13!,
                        'languageCode': _languageCode!,
                        'numPages': _numPages!.toString(),
                        'ratingCount': _ratingCount!.toString(),
                        'textReviewCount': _textReviewCount!.toString(),
                        'publicationDate': _publicationDate!,
                        'publisher': _publisher!,
                    }));
                    if (response['status'] == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                        content: Text("Buku baru berhasil disimpan!"),
                        ));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage(isAdmin: true)),
                        );
                    } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            content:
                                Text("Terdapat kesalahan, silakan coba lagi."),
                        ));
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 16 ,color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}