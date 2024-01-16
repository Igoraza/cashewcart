import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/checkout/checkout_screen.dart';
import 'package:internship_sample/presentation/cart/widgets/cart_product_list_tile.dart';
import 'package:internship_sample/presentation/place_order/place_order_dropdown.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_elevated_button.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

List<String> weightList = ["65GM", "100GM", "250GM", "500GM", "1KG"];
List<String> quantityList = ["1N", "2N", "3N", "4N", "5N"];

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.productDescription,
    required this.price,
  });
  final String imagePath;
  final String productName;
  final String productDescription;
  final String price;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Place Order",
      ),
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 125,
                          width: screenSize.width * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imagePath),
                              fit: BoxFit.fitWidth,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 250,
                              child: CustomTextWidget(
                                text: productName,
                                fontweight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: screenSize.width * 0.6,
                              child: CustomTextWidget(
                                text: productDescription,
                                fontSize: 13,
                                fontweight: FontWeight.w400,
                              ),
                            ),
                            kHeight,
                            kHeight,
                            Row(
                              children: [
                                Container(
                                  color: Color(0xFFF2F2F2),
                                  height: 35,
                                  child: Row(
                                    children: [
                                      CustomTextWidget(text: "Wt:"),
                                      SizedBox(width: 5),
                                      PlaceOrderDropDown(itemsList: weightList),
                                    ],
                                  ),
                                ),
                                kWidth,
                                Container(
                                  color: Color(0xFFF2F2F2),
                                  height: 35,
                                  child: Row(
                                    children: [
                                      CustomTextWidget(text: "Qty: "),
                                      SizedBox(width: 5),
                                      PlaceOrderDropDown(itemsList: quantityList),
                                    ],
                                  ),
                                ),
                                kWidth,
                              ],
                            ),
                            kHeight,
                            Row(
                              children: [
                                CustomTextWidget(
                                  text: "Delivery by",
                                  fontSize: 13,
                                  fontweight: FontWeight.w400,
                                ),
                                kWidth,
                                CustomTextWidget(
                                  text: "10 May 2XXX",
                                  fontSize: 13,
                                  fontweight: FontWeight.w600,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  kHeight,
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(CupertinoIcons.ticket),
                      kWidth,
                      CustomTextWidget(
                        text: "Apply Coupons",
                        fontSize: 16,
                        fontweight: FontWeight.w500,
                      ),
                      Spacer(),
                      CustomTextWidget(
                        text: "Select",
                        fontColor: kMainThemeColor,
                        fontweight: FontWeight.w600,
                      )
                    ],
                  ),
                  kHeight,
                  Divider(),
                  SizedBox(height: 20),
                  CustomTextWidget(
                    text: "Order Payment Details",
                    fontSize: 17,
                    fontweight: FontWeight.w500,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: "Order Amounts",
                        fontSize: 16,
                        fontweight: FontWeight.w400,
                      ),
                      CustomTextWidget(
                        text: "₹ $price",
                        fontSize: 16,
                        fontweight: FontWeight.w600,
                      )
                    ],
                  ),
                  kHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: "Convenience",
                        fontSize: 16,
                        fontweight: FontWeight.w400,
                      ),
                      SizedBox(width: 20),
                      CustomTextWidget(
                        text: "Know More",
                        fontColor: kMainThemeColor,
                        fontweight: FontWeight.w600,
                      ),
                      Spacer(),
                      CustomTextWidget(
                        text: "Apply Coupon",
                        fontColor: kMainThemeColor,
                        fontweight: FontWeight.w600,
                      ),
                    ],
                  ),
                  kHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: "Delivery Fee",
                        fontSize: 16,
                        fontweight: FontWeight.w400,
                      ),
                      CustomTextWidget(
                        text: "Free",
                        fontColor: kMainThemeColor,
                        fontweight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: "Order Total",
                        fontSize: 17,
                        fontweight: FontWeight.w600,
                      ),
                      CustomTextWidget(
                        text: "₹ $price",
                        fontSize: 16,
                        fontweight: FontWeight.w600,
                      )
                    ],
                  ),
                  kHeight,
                  Row(
                    children: [
                      CustomTextWidget(
                        text: "EMI Available",
                        fontSize: 16,
                        fontweight: FontWeight.w400,
                      ),
                      SizedBox(width: 20),
                      CustomTextWidget(
                        text: "Details",
                        fontColor: kMainThemeColor,
                        fontweight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        margin: EdgeInsets.all(20),
        height: 55,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CustomTextWidget(
                  text: "₹ ${price}.00",
                  fontSize: 16,
                  fontweight: FontWeight.w600,
                ),
                CustomTextWidget(
                  text: "View Details",
                  fontColor: kMainThemeColor,
                  fontweight: FontWeight.w600,
                ),
              ],
            ),
            Container(
              height: 55,
              width: 250,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(price: int.parse(price), shippingCost: 30),
                  ),
                ),
                child: CustomElevatedButton(label: "Proceed to Payment"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
