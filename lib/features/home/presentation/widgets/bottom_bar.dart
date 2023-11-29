import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black, // Set the selected item color to purple
      items: const [
        BottomNavigationBarItem(
          icon: Icon(UniconsLine.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(UniconsLine.bookmark),
          label: 'Bookmarked',
        ),
        BottomNavigationBarItem(
          icon: Icon(UniconsLine.plus_circle),
          label: 'Add book',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              UniconsLine.user_check,
            ),
            label: "Edit User"),
        BottomNavigationBarItem(
          icon: Icon(UniconsLine.user),
          label: 'Profile',
        ),
      ],
    );
  }
}
