import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/profile/profile_screen.dart';
import 'package:internship_sample/presentation/side_bar/widgets/expandable_side_bar_item.dart';
import 'package:internship_sample/presentation/side_bar/widgets/side_bar_item_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class SideBar extends StatelessWidget {
  SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    // bottomNavbarIndexNotifier.value = 0;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              ),
              child: CircleAvatar(
                radius: 60,
                child: Image.asset("lib/core/assets/images/avatar.jpeg"),
              ),
            ),
            SizedBox(height: 20),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            GestureDetector(
              onTap: () {
                previousPageIndex = 3;
                bottomNavbarIndexNotifier.value = 6;
              },
              child: SideBarItemTile(
                icon: Icons.shopping_bag_outlined,
                label: "My Orders",
              ),
            ),
            ExpandableProductsSideBarItem(),
            SideBarItemTile(
              icon: Icons.info_outline,
              label: "About KSCDC",
            ),
            SideBarItemTile(
              icon: Icons.star_rate_outlined,
              label: "Rate Us",
            ),
            SideBarItemTile(
              icon: Icons.share,
              label: "Share App",
            ),
          ],
        ),
      ),
    );
  }
}