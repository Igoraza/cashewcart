import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_sample/controllers/app_controller.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/main.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_item_skeleton.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:internship_sample/presentation/place_order/multiple_item_place_order_screen.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:internship_sample/services/api_services.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

List cartProductsList = [];
ValueNotifier<double> grantTotalNotifier = ValueNotifier(0);

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    grantTotalNotifier.value = 0;

    final screenSize = MediaQuery.of(context).size;
    // grantTotalNotifier.value = 0;
    controller.getCartList();

    print("building");
    // print("product name :::::${controller.cartProducts.value.results[0].product.product.name}");
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // bottomNavbarIndexNotifier.value = previousPageIndexes.last;
            // if (previousPageIndexes.length > 1) {
            //   previousPageIndexes.removeLast();
            // }
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_rounded),
        ),
        centerTitle: true,
        title: CustomTextWidget(
          text: "Cart",
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
              Obx(() {
                getGrandTotal();
                print("cart count ${controller.cartProducts.value.count}");
                if (controller.isLoadingCart.value) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return CartItemSkeleton();
                    },
                    itemCount: 3,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  );
                } else {
                  return controller.cartProducts.value.count == 0
                      ? Column(
                          children: [
                            CustomTextWidget(
                              text: "Your cart is empty. Please add items to continue purchase.",
                              fontSize: 14.sp,
                              fontweight: FontWeight.w600,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: screenSize.height * 0.25),
                            SizedBox(
                              child: Lottie.asset("lib/core/assets/lottie/cart_empty.json"),
                            ),
                          ],
                        )
                      : controller.cartProducts.value.count != 0
                          ? Column(
                              children: [
                                Container(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          kHeight,
                                          CartProductsListTile(
                                            productDetails: controller.cartProducts.value.results[index],
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: controller.cartProducts.value.count,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomTextWidget(
                                      text: "Grant Total : ",
                                      fontweight: FontWeight.w600,
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable: grantTotalNotifier,
                                        builder: (context, grandTotal, _) {
                                          return CustomTextWidget(
                                            text: grandTotal.toStringAsFixed(2),
                                            fontweight: FontWeight.w600,
                                          );
                                        })
                                  ],
                                ),
                                kHeight,
                                GestureDetector(
                                  onTap: () async {
                                    if (grantTotalNotifier.value <= 500) {
                                      const snackBar = SnackBar(
                                        content: Text('Minimum order amount is Rs 500 and above'),
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(20),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    } else {
                                      await controller.getUserAddresses();
                                      Get.to(
                                        () => MultipleItemPlaceOrderScreen(
                                          productList: controller.cartProducts.value.results,
                                          grandTotal: grantTotalNotifier.value,
                                        ),
                                      );
                                    }
                                  },
                                  child: CustomElevatedButton(
                                    label: "Buy Now",
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            )
                          : SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  getGrandTotal() {
    // controller.getCartList();
    double grandTotal = 0;
    print("grand total fn");
    print(controller.cartProducts.value);
    for (int i = 0; i < controller.cartProducts.value.count; i++) {
      // final int selectedCategory = cartProductsList[i]['category'];
      final String price = controller.cartProducts.value.results[i].product.sellingPrice.toString();
      final int count = controller.cartProducts.value.results[i].purchaseCount;
      final double total = double.parse(price) * count;
      print("prices are ${price} * ${count}== ${total}");
      grandTotal += total;
      // grantTotalNotifier.value = grantTotalNotifier.value + total;
      // log(grantTotalNotifier.value.toString());
    }
    grantTotalNotifier.value = grandTotal;
    return grandTotal;
  }
}
