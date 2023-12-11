import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulas_buku_mobile/features/detail/presentation/widgets/review_card.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/book_card.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';
import 'package:ulas_buku_mobile/features/profile/change_pref.dart';
import 'package:ulas_buku_mobile/features/profile/preference.dart';
import 'package:unicons/unicons.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var user;
  var role;

  
  Future<List<String>> fetchUser(CookieRequest request) async{
    final List<String> profile = [];
    final response = await request.get('https://ulasbuku-a04-tk.pbp.cs.ui.ac.id/ret_profile/');
    response.forEach((key, value) {
      profile.add(value);
    });
    return profile;
  }

  Future<List<Preference>> fetchPref(CookieRequest request) async{
    try {
        final List<Preference> result = [];
        final response = await request.get('https://ulasbuku-a04-tk.pbp.cs.ui.ac.id/pref_json/');
        
        for (var i in response) {
          Preference pref = Preference.fromJson(i);
          result.add(pref);
        }

        return result;
      } catch (e) {
        throw Exception('error : $e');
      }

    }
  Future<Map<String, dynamic>> fetchReview(CookieRequest request) async{
    try {
        final response = await request.get('https://ulasbuku-a04-tk.pbp.cs.ui.ac.id/ret_review/');
        return response;
      } 
      catch (e) {
        throw Exception('error : $e');
      }

    }
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 1000,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center, // Center the text vertically
                      children: [
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center, // Center the text vertically
                      children: [
                        Image.asset(
                          'assets/img/profile.png', // Replace with the path to your image file
                          width: 100, // Adjust the width as needed
                          height: 100, // Adjust the height as needed
                        ),
                      ],
                    ),
                    SizedBox(height: 24,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Username", // Replace with your actual username
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12,),
                    FutureBuilder(
                      future: fetchUser(request), // Assume this is your function to fetch the role
                      builder: (context, AsyncSnapshot snapshot) 
                      {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator()); // Show a loading spinner while waiting
                          } else {
                              if (snapshot.hasError)
                                  return Text('Error: ${snapshot.error}');
                              else
                                  return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: TextField(
                                            enabled: false,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0), // Adjust the radius as needed
                                              ),
                                              labelText: snapshot.data[0],
                                              hintStyle: const TextStyle(color: Colors.grey),
                                            ),
                                            // Provide a controller when using obscureText
                                            controller: TextEditingController(),
                                          ),
                                        ),
                                      ],
                                  ); // Return your widget here once role is fetched
                            }
                        },
                    ),
                    const SizedBox(height: 24,),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Role", // Replace with your actual username
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12,),
                    FutureBuilder(
                      future: fetchUser(request), // Assume this is your function to fetch the role
                      builder: (context, AsyncSnapshot snapshot) 
                      {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator()); // Show a loading spinner while waiting
                          } else {
                              if (snapshot.hasError)
                                  return Text('Error: ${snapshot.error}');
                              else
                                  return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                          Flexible(
                                              child: TextField(
                                                  enabled: false,
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(30.0), // Adjust the radius as needed
                                                      ),
                                                      labelText: snapshot.data[1], // Use the role here
                                                  ),
                                                  // Provide a controller when using obscureText
                                                  controller: TextEditingController(),
                                              ),
                                          ),
                                      ],
                                  ); // Return your widget here once role is fetched
                            }
                        },
                    ),
                    const SizedBox(height: 24,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "My Preferences", // Replace with your actual username
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PreferencePage(),
                            ),
                          );
                        },
                        child: Text("Ubah Preference"))
                      ],
                    ),

                    const SizedBox(height: 12,),
                    
                    FutureBuilder(
                      future: fetchPref(request),
                      builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                              return const Center(child: CircularProgressIndicator());
                          } else {
                              if (!snapshot.hasData) {
                              return const Column(
                                  children: [
                                  Text(
                                      "Tidak ada preference :(",
                                      style:
                                          TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                                  ),
                                  SizedBox(height: 8),
                                  ],
                              );
                          } else {
                              return SizedBox(
                                height: height * 0.1,
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  separatorBuilder: (context, index) => const SizedBox(
                                    width: 16,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Text(
                                      "${snapshot.data![index].fields.author}",
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                      ),
                                      );
                                  },
                                ),
                              );
                              }
                          }
                      }),
                      const SizedBox(height: 12,),

                      FutureBuilder(
                      future: fetchReview(request),
                      builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                              return const Center(child: CircularProgressIndicator());
                          } else {
                              if (!snapshot.hasData) {
                              return const Column(
                                  children: [
                                  Text(
                                      "Tidak ada review :(",
                                      style:
                                          TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                                  ),
                                  SizedBox(height: 8),
                                  ],
                              );
                          } else {
                           
                              return SizedBox(
                                height: height * 0.3,
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!['title'].length,
                                  separatorBuilder: (context, index) => const SizedBox(
                                    width: 16,
                                  ),
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      // height: 0.3,
                                      // width: width * 0.75,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                child: Image.asset('assets/img/user.png'),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${snapshot.data!['title'][index]}",
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${snapshot.data!['reviewnya'][index]}",
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${snapshot.data!['author'][index]}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 6,
                                            textAlign: TextAlign.justify,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );;
                              }
                          }
                      }),

                  ],
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
          if (value == 1) {
            //navigate ke home
          } else if (value == 2) {
            // navigate ke bookmark
          } else if (value == 3) {
            // navigate ke add book
          }
          else if (value == 4)
          {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
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
