import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/core/base_url.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/main.dart';
import 'package:cashew_cart/models/product_model.dart';
// import 'package:cashew_cart/models/cart_product_model.dart';
import 'package:cashew_cart/presentation/home/home_screen.dart';
import 'package:cashew_cart/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:cashew_cart/presentation/shop/shop_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/services.dart';
import 'package:lottie/lottie.dart';

class SlidingImageTile extends StatelessWidget {
  SlidingImageTile({
    super.key,
    required this.productDetails,
  });
  final ProductModel productDetails;
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    String imagePath = "";
    if (productDetails != null) {
      imagePath = productDetails.product.productImages.isNotEmpty
          ? "$baseUrl${productDetails.product.productImages[0].productImage}"
          : "https://t3.ftcdn.net/jpg/05/04/28/96/240_F_504289605_zehJiK0tCuZLP2MdfFBpcJdOVxKLnXg1.jpg";
    }

    // print("Image path : $imagePath");

    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Container(
            width: screenSize.width,
            height: screenSize.width * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.fitHeight,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // CustomTextWidget(
                //   text: "50-70% OFF",
                //   fontSize: 20,
                //   fontColor: kMainThemeColor.withOpacity(0.6),
                //   fontweight: FontWeight.w700,
                // ),
                // CustomTextWidget(
                //   text: "Now in different",
                //   fontSize: 12,
                //   fontColor: kMainThemeColor.withOpacity(0.6),
                //   fontweight: FontWeight.w500,
                // ),
                // CustomTextWidget(
                //   text: "quantities",
                //   fontSize: 12,
                //   fontColor: kMainThemeColor.withOpacity(0.6),
                //   fontweight: FontWeight.w500,
                // ),
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: kMainThemeColor.withOpacity(0.6),
                        side: BorderSide(width: 1, color: kMainThemeColor.withOpacity(0.6)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          // controller.productDetails.results[0].value = await productDetails.results[0];
                          final String productId = productDetails.product.productId.toString();
                          Services().getProductDetailsAndGotoShopScreen(context, productId);
                          // await controller.getProductDetails(productId);
                          // controller.getProductReviews(productId);
                          // controller.getSimilarProducts(productDetails, 0);
                          // controller.productDetailsList.add(controller.productDetails.value!);
                          // previousPageIndexes.add(bottomNavbarIndexNotifier.value);
                          // bottomNavbarIndexNotifier.value = 4;
                        },
                        child: Container(
                          width: 90,
                          child: Row(
                            children: [
                              CustomTextWidget(
                                text: "Shop Now",
                                fontSize: 12,
                                fontColor: kMainThemeColor.withOpacity(0.6),
                                fontweight: FontWeight.w600,
                              ),
                              Icon(
                                Icons.arrow_forward_outlined,
                                color: kMainThemeColor.withOpacity(0.6),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            left: 25.w,
            child: SizedBox(
              height: 80.w,
              child: Lottie.asset(
                "lib/core/assets/lottie/new_product.json",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
