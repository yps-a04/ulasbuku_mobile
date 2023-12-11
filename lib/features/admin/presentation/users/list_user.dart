import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulas_buku_mobile/core/environments/endpoints.dart';
import 'package:ulas_buku_mobile/features/admin/models/user.dart';
import 'package:ulas_buku_mobile/features/admin/presentation/form/book_form.dart';
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

      for (var i in response) {
        User user = User.fromJson(i);
        list_user.add(user);
      }

      return list_user;
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  void _deleteUser(int id, CookieRequest cookieRequest) async {
    try {
      final response = await cookieRequest 
          .post('http://127.0.0.1:8000/show-admin/delete-user/$id/', {});
      if (response["status"] == true) {
        setState(() {
          
        });
      }
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  void _showDeleteConfirmationDialog(String username, int id, CookieRequest cookieRequest) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Apakah Anda yakin ingin menghapus user $username?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                _deleteUser(id, cookieRequest);
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.white,
                      margin: EdgeInsets.fromLTRB(width * 0.1,
                          height * 0.1, width * 0.1, height * 0.75),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            "User $username telah dihapus !",
                            style:
                                const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    bool isLightMode = true;
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
                    "Tidak ada user yang telah register.",
                    style:
                        TextStyle(color: Color(0xFFffcc80), fontSize: 20),
                ),
                SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left column with username, date joined, and last login
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data![index].username}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Date Joined: ${snapshot.data![index].dateJoined}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Last Login: ${snapshot.data![index].lastLogin}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Right column with delete button
                        Text(
                          "Delete",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteConfirmationDialog(snapshot.data![index].username, snapshot.data![index].id, request);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        }
      ),
      bottomNavigationBar: BottomNavBar(
        isLightMode: isLightMode,
        currentIndex: index,
        onTap: (value) {
          if (value == 0) {
            //navigate ke home
          } else if (value == 1) {
            // navigate ke bookmark
          } else if (value == 2) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookForm()));
          } else if (value == 3) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListUserPage()));
          }
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
