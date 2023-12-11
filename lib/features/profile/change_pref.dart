import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/book_card.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';
import 'package:ulas_buku_mobile/features/profile/checkbox_form.dart';
import 'package:unicons/unicons.dart';

class PreferencePage extends StatefulWidget {
  const PreferencePage({super.key});

  @override
  State<PreferencePage> createState() => _PreferenceState();
}

class _PreferenceState extends State<PreferencePage> {
  final _formKey = GlobalKey<FormState>();
  
  Future<List<String>> fetchAuthors(CookieRequest request) async{
    try {
        final response = await request.get('https://ulasbuku-a04-tk.pbp.cs.ui.ac.id/change_pref/');
        final List<String> authors = [];
        for (var i in response['author']) {
          authors.add(i['author']);
          print(i['author']);
        }
        return authors;  // Assuming 'author' is a list of strings
      } 
      catch (e) {
        throw Exception('error : $e');
      }
  }
   //List<bool> isCheckedList = List<bool>.filled(8, false);

  int index = 4;
  bool isLightMode = true;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    final scaffoldKey = GlobalKey<ScaffoldState>();

    List<Color> cardColors = [
      Color(0xffacdcf2),
      Color(0xffFf9bbd0),
      Color(0xffb2dfdc),
      Color(0xFFffcc80),
      Color(0xffc5cae8),
    ];

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffacdcf2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10), // Adjust the radius as needed
          ),
        ),
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Ulas Buku",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer: Drawer(),
      body: FutureBuilder<List<String>>(
        future: fetchAuthors(request),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text("Ubah Preference Author Anda!", style: TextStyle(fontSize: 24)),
                  ),
                  // Loop over each author and create a checkbox
                  CheckboxList(data: snapshot.data!),
                  
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
                          Navigator.pop(context); // This line will navigate to the previous screen.
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
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
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
