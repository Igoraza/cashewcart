import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/models/orders_list_model.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/my_orders/widgets/my_orders_list_tile.dart';
import 'package:internship_sample/presentation/order_tracking/order_tracking_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/presentation/widgets/products_list_item_tile.dart';
import 'package:skeletonizer/skeletonizer.dart';

List recentOrdersList = [];
List productCountsList = [];
List productDetailsList1 = [];

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({super.key});
  int numberOfRecentOrders = recentOrdersList.length;
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    controller.getOrdersList();
    final recentOrdersListRev = recentOrdersList.reversed.toList();
    print(numberOfRecentOrders);
    //log("Recent orders List :${recentOrdersList.toString()}");
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackgroundColor,
      // appBar: AppBar(
      //   scrolledUnderElevation: 0,
      //   leading: IconButton(
      //     onPressed: () {
      //       bottomNavbarIndexNotifier.value = previousPageIndexes.last;
      //       previousPageIndexes.removeLast();
      //     },
      //     icon: Icon(Icons.arrow_back_ios_new),
      //   ),
      //   centerTitle: true,
      //   title: CustomTextWidget(
      //     text: "Orders",
      //     fontSize: 18,
      //     fontweight: FontWeight.w600,
      //   ),
      // ),
      appBar: AppBar(
        // backgroundColor: kMainThemeColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              // bottomNavbarIndexNotifier.value = 3;
              Get.off(() => MainPageScreen());
            }
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: CustomTextWidget(
          text: "Orders",
          fontSize: 18,
          fontweight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight,
              const CustomTextWidget(
                text: "Recent Orders",
                fontweight: FontWeight.w600,
              ),
              kHeight,
              Obx(() {
                return Container(
                  // color: Colors.white,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      print("Orders values :${controller.ordersList[index].items.length}");
                      final OrdersListModel currentItem = controller.ordersList[index];
                  

                      return Skeletonizer(
                        enabled: controller.isLoadingMyproducts.value,
                        child: GestureDetector(
                          onTap: () => Get.to(() => OrderTrackingScreen(orderDetails: currentItem)),
                          child: MyOrdersListTile(
                            currentItem: currentItem,
                          ),
                        ),

                      );
                    },
                    itemCount: controller.ordersList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                );
                // }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
