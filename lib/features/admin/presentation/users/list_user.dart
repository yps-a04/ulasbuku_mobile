import 'package:flutter/material.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({super.key});

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  // Replace the following with your logic to fetch and display the list of users
  List<String> userList = ['User1', 'User2', 'User3']; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'User',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Delete',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: userList
                    .map(
                      (user) => DataRow(
                        cells: [
                          DataCell(
                            Text(user),
                          ),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Add your logic for user deletion
                                // You may want to show a confirmation dialog before deleting
                                // and then update the UI accordingly
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
