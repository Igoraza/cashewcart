import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/product_list/product_listing_screen.dart';
import 'package:internship_sample/presentation/side_bar/widgets/side_bar_item_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class ExpandableProductsSideBarItem extends StatelessWidget {
  ExpandableProductsSideBarItem({super.key});
  ValueNotifier<bool> expandNotifier = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.shopping_bag_outlined,
              ),
              kWidth,
              CustomTextWidget(
                text: "Products",
                fontSize: 18,
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  expandNotifier.value = !expandNotifier.value;
                },
                child: ValueListenableBuilder(
                    valueListenable: expandNotifier,
                    builder: (context, expanded, _) {
                      return expanded
                          ? Icon(
                              Icons.keyboard_double_arrow_up_rounded,
                              color: kMainThemeColor,
                            )
                          : Icon(
                              Icons.keyboard_double_arrow_down_rounded,
                              color: kMainThemeColor,
                            );
                    }),
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: expandNotifier,
          builder: (context, expanded, _) {
            return expanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          productDisplayList = cashewsPlaneList;
                          previousPageIndex = 0;

                          bottomNavbarIndexNotifier.value = 5;
                          Navigator.of(context).pop();
                        },
                        child: ExpandableSideBarInnerItem(label: "Cashews Plane Premium"),
                      ),
                      GestureDetector(
                        onTap: () {
                          productDisplayList = roastedCashewsList;
                          previousPageIndex = 0;
                          bottomNavbarIndexNotifier.value = 7;
                          Navigator.of(context).pop();
                        },
                        child: ExpandableSideBarInnerItem(label: "Roasted And Salted"),
                      ),
                      GestureDetector(
                        onTap: () {
                          productDisplayList = valueAddedProducts;
                          previousPageIndex = 0;
                          bottomNavbarIndexNotifier.value = 8;
                          Navigator.of(context).pop();
                        },
                        child: ExpandableSideBarInnerItem(label: "Value Added Products"),
                      ),
                    ],
                  )
                : SizedBox();
          },
        ),
        Divider(
          thickness: 0.3,
          color: Colors.grey,
        )
      ],
    );
  }
}

class ExpandableSideBarInnerItem extends StatelessWidget {
  const ExpandableSideBarInnerItem({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        children: [
          Divider(
            thickness: 0.3,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                kWidth,
                CustomTextWidget(text: label, fontSize: 14),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: kMainThemeColor,
                  size: 14,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}