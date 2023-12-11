import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulas_buku_mobile/features/profile/profile.dart';

class CheckboxList extends StatefulWidget {
  final List<String> data;

  CheckboxList({required this.data});

  @override
  _CheckboxListState createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  List<bool>? isCheckedList;
  List<String>? listNama = [];
  List<String>? validNya = [];
  bool flag = false;

  void savePreference() async
  {
    final request = context.read<CookieRequest>();
    for (int i = 0; i < widget.data.length; i++)
    {
      if (isCheckedList?[i] == true)
      {
        validNya?.add(listNama![i]);
        flag = true;
      }
    }

    if (flag == false)
    {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
      content: Text("Tidak ada yang disimpan!"),
      ));
      Navigator.pop(context);
    }

    else
    {
      print(validNya);
      final response = await request.postJson(
        "https://ulasbuku-a04-tk.pbp.cs.ui.ac.id/set_pref/", jsonEncode(<String, List<String>?>{'valid': validNya}));
        print("Masuk lo");
        if (response['status'] == 'success') {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(
            content: Text("Berhasil mengubah preference!"),
            ));
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
        } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(
                content:
                    Text("Terdapat kesalahan, silakan coba lagi."),
            ));
        }
    }
  }

  @override
  void initState() {
    super.initState();
    isCheckedList = List<bool>.filled(8, false);
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i< widget.data.length; i++)
    {
      listNama!.add(widget.data[i]);
    }
    return Column(
      children: <Widget>[
        for (int i = 0; i < widget.data.length; i++)
          CheckboxListTile(
            title: Text(widget.data[i]),
            value: isCheckedList?[i],
            onChanged: (bool? value) {
              setState(() {
                isCheckedList?[i] = value!;
              });
            },
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // This line will navigate to the previous screen.
                },
                child: Text('Kembali'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.blue,
                  side: BorderSide(color: Color(0xffacdcf2), width: 2),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  savePreference();
                },
                child: Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.blue,
                  side: BorderSide(color: Color(0xffacdcf2), width: 2),
                ),
              ),
            ],
          ),
          
      ],
    );
  }
}
