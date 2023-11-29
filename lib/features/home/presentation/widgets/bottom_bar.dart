import 'package:flutter/material.dart';
import 'package:ulas_buku_mobile/features/home/presentation/home_page.dart';
import 'package:unicons/unicons.dart';
import 'package:ulas_buku_mobile/features/profile/profile.dart';
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
      onTap: (index) {
        onTap(index); // call the provided onTap function
        if (index == 0)
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
        if (index == 3) { // index of 'Profile' item
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        }
        // handle other indices if necessary
      },
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
