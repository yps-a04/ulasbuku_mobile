import 'package:flutter/material.dart';
import 'package:ulas_buku_mobile/core/theme/ub_color.dart';
import 'package:unicons/unicons.dart';
import 'package:ulas_buku_mobile/features/profile/profile.dart';
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isLightMode,
  });
  final bool isLightMode;
  final int currentIndex;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {

    Color bgColor = isLightMode ? UBColor.lightBgColor : UBColor.darkBgColor;
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: bgColor,
      ),
      child: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor:
            isLightMode ? UBColor.darkBgColor : UBColor.lightBgColor,
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
      ),
    );
  }
}
