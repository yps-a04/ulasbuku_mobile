import 'package:flutter/material.dart';

class CheckboxList extends StatefulWidget {
  final List<String> data;

  CheckboxList({required this.data});

  @override
  _CheckboxListState createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  late List<bool> isCheckedList;

  void savePreference(List<bool> isCheckedList) async
  {

  }

  @override
  void initState() {
    super.initState();
    isCheckedList = List<bool>.filled(8, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < widget.data.length; i++)
          CheckboxListTile(
            title: Text(widget.data[i]),
            value: isCheckedList[i],
            onChanged: (bool? value) {
              setState(() {
                isCheckedList[i] = value!;
              });
              print(isCheckedList);
            },
          ),
      ],
    );
  }
}
