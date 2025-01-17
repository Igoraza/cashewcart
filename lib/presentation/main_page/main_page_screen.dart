import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/controllers/cart_controller.dart';
import 'package:cashew_cart/controllers/profile_controller.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/presentation/account/account_screen.dart';
import 'package:cashew_cart/presentation/cart/cart_screen.dart';
import 'package:cashew_cart/presentation/home/home_screen.dart';
import 'package:cashew_cart/presentation/my_orders/my_orders_screen.dart';
import 'package:cashew_cart/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:cashew_cart/presentation/categories/categories_screen.dart';
import 'package:cashew_cart/presentation/product_list/product_listing_screen.dart';
import 'package:cashew_cart/presentation/product_list/trending_model_product_listing_screen.dart';
import 'package:cashew_cart/presentation/shop/shop_screen.dart';
import 'package:cashew_cart/presentation/side_bar/side_bar.dart';
import 'package:cashew_cart/presentation/splash/splash_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/services.dart';

class MainPageScreen extends StatelessWidget {
  MainPageScreen({Key? key}) : super(key: key);

  AppController controller = Get.put(AppController());
  CartController cartController = Get.put(CartController());
  ProfileController profileController = Get.put(ProfileController());
  final CupertinoTabController _tabController = CupertinoTabController();

  @override
  Widget build(BuildContext context) {
    log("rebuilding main");
    // cartController.getCartList();
    // _tabController.index = controller.mainPageIndex;
    return SafeArea(
      child: CupertinoTabScaffold(
        controller: _tabController,
        tabBar: CupertinoTabBar(
          activeColor: kMainThemeColor,
          inactiveColor: Colors.grey,
          height: 50.w,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category_outlined,
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  Positioned(
                    top: 0,
                    right: 3,
                    child: CircleAvatar(
                      radius: 7,
                      child: ValueListenableBuilder(
                          valueListenable: cartCountNotifier,
                          builder: (context, value, _) {
                            return CustomTextWidget(
                              text: value.toString(),
                              fontSize: 10,
                              fontColor: Colors.black,
                              fontweight: FontWeight.w600,
                            );
                          }),
                    ),
                  )
                ],
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              label: 'Account',
            ),
          ],
          onTap: (index) async {
            if (index == 0) {
              controller.mainPageIndex = 0;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MainPageScreen()),
                (route) => false,
              );
            }
            // else if (index == 1) {
            //   controller.mainPageIndex = 1;
            //   await Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (context) => MainPageScreen()),
            //     (route) => false,
            //   );
            // }
          },
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) {
                  if (controller.circleAvatarProductsList.isEmpty && !controller.isCircleAvatarProductsLoading.value) {
                    controller.getCircleAvatarProductList();
                  }

                  if (!controller.isAlreadyLoadedAllProducts.value && !controller.isAllProductsLoading.value) {
                    //log("getting all products");
                    controller.getAllProducts();
                  }
                  if (!controller.isAlreadyLoadedBestsellers && !controller.isBestSellersLoading.value) {
                    controller.getBestSellerProducts();
                  }
                  if (!controller.isAlreadyLoadedSponserd && !controller.isSponserdLoading.value) {
                    controller.getSponserdProducts();
                  }
                  if (!controller.isAlreadyLoadedTrending && !controller.isTrendingLoading.value) {
                    controller.getTrendingProducts();
                  }

                  return CupertinoPageScaffold(child: HomeScreen());
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  if (controller.circleAvatarProductsList.isEmpty && !controller.isCircleAvatarProductsLoading.value) {
                    controller.getCircleAvatarProductList();
                  }

                  return CupertinoPageScaffold(child: CategoriesScreen());
                },
              );
            case 2:
              return CupertinoTabView(
                builder: (context) {
                  if (!cartController.isLoading.value) cartController.getCartList();
                  return CupertinoPageScaffold(child: CartScreen());
                },
              );
            case 3:
              return CupertinoTabView(
                builder: (context) {
                  // controller.getProfileDetails();
                  log("Emaill :${controller.isLoggedIn.value}");
                  if (controller.isLoggedIn.value) {
                    // if (!profileController.isLoadingProfile.value) profileController.getProfileDetails();
                    if (profileController.userName == "") {
                      profileController.getProfileDetails();
                    }
                  } else {
                    // Services().showLoginAlert(context, "Please login to access Account");
                  }

                  return CupertinoPageScaffold(child: AccountScreen());
                },
              );
            default:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: HomeScreen());
                },
              );
          }
        },
      ),
    );
  }
}
