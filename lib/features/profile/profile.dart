
// ignore_for_file: prefer_typing_uninitialized_variables, curly_braces_in_flow_control_structures, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulas_buku_mobile/core/theme/ub_color.dart';
import 'package:ulas_buku_mobile/features/home/presentation/pages/home_page.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';
import 'package:ulas_buku_mobile/features/profile/change_pref.dart';
import 'package:ulas_buku_mobile/features/profile/preference.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  ProfilePage({this.isLightMode = true, super.key});
  bool isLightMode;
  
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  var user;
  var role;
  late bool isLightMode;
  @override
  void initState() {
    super.initState();
    isLightMode = widget.isLightMode;
  }

  
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
    try 
    {
      final response = await request.get('https://ulasbuku-a04-tk.pbp.cs.ui.ac.id/ret_review/');
      return response;
    } 
    
    catch (e) {
      throw Exception('error : $e');
    }

  }
  int index = 4;
  
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    List<Color> cardColors =
        isLightMode ? UBColor.lightCardColors : UBColor.darkCardColors;

    Color textColor = isLightMode ? UBColor.darkBgColor : UBColor.lightBgColor;
    double height = MediaQuery.of(context).size.height;
    cardColors.shuffle();
    final scaffoldKey = GlobalKey<ScaffoldState>();


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
        leading: IconButton(
          icon: Icon(
            isLightMode ? Icons.light_mode : Icons.dark_mode,
            color: Colors.black,
          ),
          onPressed: (() {
            setState(() {
              isLightMode = !isLightMode;
            });
          }),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // ignore: sized_box_for_whitespace
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
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24,),

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
                    const SizedBox(height: 24,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Username", // Replace with your actual username
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12,),
                    FutureBuilder(
                      future: fetchUser(request), // Assume this is your function to fetch the role
                      builder: (context, AsyncSnapshot snapshot) 
                      {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator()); // Show a loading spinner while waiting
                          } else {
                              if (snapshot.hasError)
                                  // ignore: curly_braces_in_flow_control_structures
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
                                              labelStyle: TextStyle(color: textColor),
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Role", // Replace with your actual username
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12,),
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
                                                      labelStyle: TextStyle(color: textColor),
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
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PreferencePage(isLightMode: isLightMode,),
                            ),
                          );
                        },
                        child: const Text("Ubah Preference"))
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
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
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
                                            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
                                          ),
                                          Text(
                                            "${snapshot.data!['reviewnya'][index]}",
                                            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
                                          ),
                                          Text(
                                            "${snapshot.data!['author'][index]}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 6,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(color: textColor),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
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
                builder: (context) => ProfilePage(isLightMode: isLightMode,),
              ),
            );
          }

          else if (value == 0)
          {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(isLightMode: isLightMode,),
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
