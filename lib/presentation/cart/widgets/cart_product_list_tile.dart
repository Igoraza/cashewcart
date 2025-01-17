import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/cart_controller.dart';
import 'package:cashew_cart/core/base_url.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/presentation/cart/cart_screen.dart';
import 'package:cashew_cart/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:cashew_cart/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/api_services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CartProductsListTile extends StatelessWidget {
  CartProductsListTile({
    super.key,
    required this.productDetails,
    required this.index,
  });
  final productDetails;
  final int index;
  late CartController unique;
  CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    unique = Get.put(CartController(), tag: index.toString());
    final String imagePath = productDetails.product.product.productImages.isNotEmpty ? productDetails.product.product.productImages[0].productImage : "";
    final String productName = productDetails.product.product.name;
    // final int selectedCategory = 1;
    ValueNotifier<int> currentProductCountNotifier = ValueNotifier(productDetails.purchaseCount);
    // print("purchase count:${productDetails.purchaseCount}");
    final String originalPrice = productDetails.product.actualPrice;
    final String offerPrice = productDetails.product.sellingPrice;
    // double price = double.parse(productDetails.total);
    double priceWithGST = double.parse(productDetails.mrp);
    // final String numberOfRatings = productDetails.;
    final String weight = productDetails.product.weightInGrams;
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.9,
      // height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 125.w,
                  width: 120.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("$baseUrl$imagePath"),
                      fit: BoxFit.fitHeight,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.r),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.5,
                        child: CustomTextWidget(
                          text: productName,
                          fontSize: 12,
                          fontweight: FontWeight.w600,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 5.w),
                      Row(
                        children: [
                          CustomTextWidget(
                            text: "Net Weight :",
                            fontSize: 12.sp,
                            fontweight: FontWeight.w500,
                          ),
                          kWidth,
                          CartProductListTileButton(
                            buttonHeight: 20.w,
                            buttonWidth: 60.w,
                            label: double.parse(weight) < 1000 ? weight + "GM" : "${double.parse(weight) / 1000} KG",
                            fontSize: 10.w,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      kHeight,
                      Row(
                        children: [
                          CartProductListTileButton(
                            buttonHeight: 30,
                            buttonWidth: 60,
                            label: "₹ ${priceWithGST.toStringAsFixed(2)}",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontColor: kMainThemeColor,
                          ),
                          kWidth,
                          if (offerPrice != originalPrice)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  text: "${(double.parse(offerPrice) * 100 / double.parse(originalPrice)).toStringAsFixed(2)}%",
                                  fontColor: Color(0xFFFE735C),
                                  fontSize: 10,
                                  fontweight: FontWeight.w400,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  originalPrice,
                                  style: const TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 15,
                                    color: Color(0xFF808488),
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Color(0xFF808488),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            kHeight,
            Divider(),
            ValueListenableBuilder(
                valueListenable: currentProductCountNotifier,
                builder: (context, newCount, _) {
                  return Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return !unique.isUpdatingCartCount.value
                            ? GestureDetector(
                                onTap: () async {
                                  if (currentProductCountNotifier.value > 1) {
                                    log("New count --- :$newCount");
                                    // cartCountNotifier.value--;
                                    // final response = await ApiServices().updateCartCount(productDetails.id.toString(), currentProductCountNotifier.value - 1);
                                    final response = await unique.updateCartProduct(productDetails.id.toString(), currentProductCountNotifier.value - 1);

                                    log(response.statusCode.toString());
                                    if (response != null && response.statusCode.toString() == "200" && currentProductCountNotifier.value > 1) {
                                      log("New count :$newCount");
                                      if (currentProductCountNotifier.value > 1) {
                                        currentProductCountNotifier.value--;
                                      }
                                      for (int i = 0; i < cartController.cartProducts.value.count; i++) {
                                        if (cartController.cartProducts.value.results[i].id == productDetails.id) {
                                          cartController.cartProducts.value.results[i].purchaseCount = cartController.cartProducts.value.results[i].purchaseCount - 1;
                                        }
                                      }
                                      CartScreen().getGrandTotal();
                                    }
                                  }
                                },
                                child: Icon(Icons.remove),
                              )
                            : Icon(
                                Icons.remove,
                                color: Colors.grey,
                              );
                      }),
                      SizedBox(width: 10.w),
                      Container(
                        height: 35.w,
                        width: 35.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: kMainThemeColor,
                        ),
                        child: Obx(() {
                          return Center(
                            child: unique.isUpdatingCartCount.value
                                ? SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomTextWidget(
                                    text: "$newCount",
                                    fontSize: 14.sp,
                                  ),
                          );
                        }),
                      ),
                      SizedBox(width: 10.w),
                      Obx(() {
                        return !unique.isUpdatingCartCount.value
                            ? GestureDetector(
                                onTap: () async {
                                  // cartCountNotifier.value++;
                                  // final response = await ApiServices().updateCartCount(productDetails.id.toString(), currentProductCountNotifier.value + 1);
                                  final response = await unique.updateCartProduct(productDetails.id.toString(), currentProductCountNotifier.value + 1);
                                  log(response.statusCode.toString());
                                  if (response != null && response.statusCode.toString() == "200") {
                                    log("Working");
                                    // cartController.getCartList();
                                    currentProductCountNotifier.value++;
                                    for (int i = 0; i < cartController.cartProducts.value.count; i++) {
                                      if (cartController.cartProducts.value.results[i].id == productDetails.id) {
                                        cartController.cartProducts.value.results[i].purchaseCount = cartController.cartProducts.value.results[i].purchaseCount + 1;
                                      }
                                    }
                                    CartScreen().getGrandTotal();
                                  }
                                },
                                child: Icon(Icons.add),
                              )
                            : Icon(
                                Icons.add,
                                color: Colors.grey,
                              );
                      }),
                      Spacer(),
                      Container(
                        child: CustomTextIconButton(
                          onPressed: () {
                            log("removing");
                            showProductRemoveWarning(context, newCount);
                          },
                          icon: Icons.delete_outline,
                          label: "Remove",
                          textAndIconColor: Colors.red,
                          textAndIconSize: 14,
                        ),
                      ),
                      Spacer(),
                      CustomTextWidget(
                        text: "₹ ${(newCount * priceWithGST).toStringAsFixed(2)}",
                        fontSize: 13.sp,
                        fontweight: FontWeight.w600,
                        textOverflow: TextOverflow.fade,
                      ),
                    ],
                  );
                }),
            Divider(
              thickness: 2,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  showProductRemoveWarning(BuildContext context, int count) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Warning",
      desc: "This item will be removed from cart",
      buttons: [
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Get.back(),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Remove",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () async {
            cartCountNotifier.value = (cartCountNotifier.value - count).toInt();
            cartProductsList.remove(productDetails);
            await cartController.removeProductFromCart(context, productDetails.product.id.toString());
            CartScreen().getGrandTotal();
            Get.back();
          },
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Color.fromARGB(255, 244, 86, 75),
            ],
          ),
        )
      ],
      closeFunction: () => Get.back(),
    ).show();
  }
}

class CartProductListTileButton extends StatelessWidget {
  const CartProductListTileButton({
    super.key,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.label,
    this.fontColor = Colors.black,
    required this.fontSize,
    required this.fontWeight,
  });

  final double buttonHeight;
  final double buttonWidth;
  final String label;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: buttonHeight,
      // width: buttonWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
        child: Center(
          child: CustomTextWidget(
            text: label,
            fontSize: fontSize,
            fontweight: fontWeight,
            fontColor: fontColor,
          ),
        ),
      ),
    );
  }
}
