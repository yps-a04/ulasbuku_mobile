import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';
import 'package:ulas_buku_mobile/features/profile/checkbox_form.dart';

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
  bool isLightMode = true;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    final scaffoldKey = GlobalKey<ScaffoldState>();


    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffacdcf2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10), // Adjust the radius as needed
          ),
        ),
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
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
      drawer: const Drawer(),
      body: FutureBuilder<List<String>>(
        future: fetchAuthors(request),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Center(
                    child: Text("Ubah Preference Author Anda!", style: TextStyle(fontSize: 24)),
                  ),
                  // Loop over each author and create a checkbox
                  CheckboxList(data: snapshot.data!),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
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
