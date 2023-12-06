import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulas_buku_mobile/core/environments/endpoints.dart';
import 'package:ulas_buku_mobile/features/admin/models/user.dart';
import 'package:ulas_buku_mobile/features/home/presentation/widgets/bottom_bar.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({Key? key}) : super(key: key);

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  int index = 0;

  Future<List<User>> fetchUsers(CookieRequest cookieRequest) async {
    try {
      final List<User> list_user = [];
      final response = await cookieRequest.get(EndPoints.getUser);

      // print(response);
      for (var i in response) {
        User user = User.fromJson(i);
        list_user.add(user);
      }

      return list_user;
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'List User',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Color(0xFFffcc80),
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: fetchUsers(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                Text(
                    "Tidak ada data produk.",
                    style:
                        TextStyle(color: Color(0xFFffcc80), fontSize: 20),
                ),
                SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () {
                    // Routing soon
                  },
                  // child: Dismissible(
                  //   key: Key('key'),
                  //   onDismissed:(direction) {
                      
                  //   },
                    child: Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${snapshot.data![index].username}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Date Joined: ${snapshot.data![index].dateJoined}",
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              "Last Login: ${snapshot.data![index].lastLogin}",
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Add your logic for user deletion
                                // You may want to show a confirmation dialog before deleting
                                // and then update the UI accordingly
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  // ),
                ),
              );
              
            }
          }
        }
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: index,
        onTap: (value) {
          if (value == 0) {
            //navigate ke home
          } else if (value == 1) {
            // navigate ke bookmark
          } else if (value == 2) {
            // navigate ke add book
          } else if (value == 3) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ListUserPage()
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
