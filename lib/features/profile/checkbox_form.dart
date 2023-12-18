// ignore_for_file: use_build_context_synchronously, sort_child_properties_last, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulas_buku_mobile/core/theme/ub_color.dart';
import 'package:ulas_buku_mobile/features/profile/profile.dart';

// ignore: must_be_immutable
class CheckboxList extends StatefulWidget {
  final List<String> data;

  // ignore: use_key_in_widget_constructors
  CheckboxList({this.isLightMode = true, required this.data});
  bool isLightMode;

  @override
  // ignore: library_private_types_in_public_api
  _CheckboxListState createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  late bool isLightMode;

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
      final response = await request.postJson(
        "https://ulasbuku-a04-tk.pbp.cs.ui.ac.id/set_pref/", jsonEncode(<String, List<String>?>{'valid': validNya}));
        if (response['status'] == 'success') {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(
            content: Text("Berhasil mengubah preference!"),
            ));
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfilePage(isLightMode: isLightMode,),
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
    isLightMode = widget.isLightMode;
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = isLightMode ? UBColor.darkBgColor : UBColor.lightBgColor;
    Color textRevert = !isLightMode ? UBColor.darkBgColor : UBColor.lightBgColor;
    for (int i = 0; i< widget.data.length; i++)
    {
      listNama!.add(widget.data[i]);
    }
    return Column(
      children: <Widget>[
        for (int i = 0; i < widget.data.length; i++)
          CheckboxListTile(
            title: Text(widget.data[i], style: TextStyle(color:textColor)),
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
                child: const Text('Kembali'),
                style: ElevatedButton.styleFrom(
                  primary: textRevert,
                  onPrimary: Colors.blue,
                  side: const BorderSide(color: Color(0xffacdcf2), width: 2),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  savePreference();
                },
                child: const Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  primary: textRevert,
                  onPrimary: Colors.blue,
                  side: const BorderSide(color: Color(0xffacdcf2), width: 2),
                ),
              ),
            ],
          ),
          
      ],
    );
  }
}
