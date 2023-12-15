import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulas_buku_mobile/core/theme/ub_color.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';
import 'package:ulas_buku_mobile/features/profile/checkbox_form.dart';

class PreferencePage extends StatefulWidget {
  PreferencePage({this.isLightMode = true, super.key});
  bool isLightMode;

  @override
  State<PreferencePage> createState() => _PreferenceState();
}

class _PreferenceState extends State<PreferencePage> {
  final _formKey = GlobalKey<FormState>();
  late Future<List<String>> authorsFuture;
  List<String>? authors;
  late bool isLightMode;
  
  @override
  void initState() {
    super.initState();
    final request = context.read<CookieRequest>();
    isLightMode = widget.isLightMode;
    authorsFuture = fetchAuthors(request);
    authorsFuture.then((value) {
      setState(() {
        authors = value;
      });
    });
  }
  
  Future<List<String>> fetchAuthors(CookieRequest request) async{
    try {
        final response = await request.get('https://ulasbuku-a04-tk.pbp.cs.ui.ac.id/change_pref/');
        final List<String> authors = [];
        for (var i in response['author']) {
          authors.add(i['author']);
          // ignore: avoid_print
        }
        return authors;  // Assuming 'author' is a list of strings
      } 
      catch (e) {
        throw Exception('error : $e');
      }
  }
   //List<bool> isCheckedList = List<bool>.filled(8, false);

  int index = 4;


  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    List<Color> cardColors =
        isLightMode ? UBColor.lightCardColors : UBColor.darkCardColors;

    Color textColor = isLightMode ? UBColor.darkBgColor : UBColor.lightBgColor;
    
    cardColors.shuffle();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: isLightMode ? UBColor.lightBgColor : UBColor.darkBgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffacdcf2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10), // Adjust the radius as needed
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Ulas Buku",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),

      // ignore: unnecessary_null_comparison
      body: authors != null ? Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text("Ubah Preference Author Anda!", style: TextStyle(fontSize: 24, color: textColor)),
                  ),
                  // Loop over each author and create a checkbox
                  CheckboxList(data: authors??[], isLightMode: isLightMode,),
                ],
              ),
            ) : const CircularProgressIndicator(),
      bottomNavigationBar: BottomNavBar(
        isLightMode: isLightMode,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
