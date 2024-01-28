import 'package:flutter/material.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/home/home_screen.dart';
import 'package:internship_sample/presentation/shop/widgets/custom_text_icon_button.dart';
import 'package:internship_sample/presentation/shop/widgets/size_selector_widget.dart';
import 'package:internship_sample/presentation/widgets/custom_star_rating_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

ValueNotifier<int> sizeSelectNotifier = ValueNotifier(0);

class ShopProductDetailsTile extends StatelessWidget {
  ShopProductDetailsTile({
    super.key,
    // required this.productName,
    // required this.description,
  });
  ValueNotifier<bool> readMoreClickNotifier = ValueNotifier(false);
  // final String productName;
  // final String description;

  @override
  Widget build(BuildContext context) {
    sizeSelectNotifier.value = 0;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
              valueListenable: sizeSelectNotifier,
              builder: (context, value, _) {
                return Row(
                  children: [
                    CustomTextWidget(
                      text: "Net weight: ",
                      fontweight: FontWeight.w600,
                    ),
                    for (int i = 0; i < selectedProductDetails['category'].length; i++)
                      if (value == i)
                        CustomTextWidget(
                          text: selectedProductDetails['category'][i]['weight'],
                          fontweight: FontWeight.w600,
                        ),
                  ],
                );
              }),
          SizedBox(height: 10),
          ValueListenableBuilder(
              valueListenable: sizeSelectNotifier,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < selectedProductDetails['category'].length; i++)
                      SizeSelectorWidget(
                        index: i,
                        label: selectedProductDetails['category'][i]['weight'],
                        fontColor: sizeSelectNotifier.value == i ? Colors.white : Color(0xFFFA7189),
                        backgroundColor: sizeSelectNotifier.value == i ? Color(0xFFFA7189) : Colors.white,
                      ),
                  ],
                );
              }),
          SizedBox(height: 10),
          CustomTextWidget(
            text: selectedProductDetails['name'],
            fontSize: 20,
            fontweight: FontWeight.w600,
          ),

          // SizedBox(height: 10),
          ValueListenableBuilder(
              valueListenable: sizeSelectNotifier,
              builder: (context, value, _) {
                return CustomStarRatingTile(
                  numberOfRatings: "${selectedProductDetails['category'][value]['rating']}",
                  iconAndTextSize: 18,
                );
              }),
          ValueListenableBuilder(
              valueListenable: sizeSelectNotifier,
              builder: (context, value, _) {
                return Row(
                  children: [
                    Text(
                      "₹${selectedProductDetails['category'][value]['originalPrice']}",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        color: Color(0xFF808488),
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Color(0xFF808488),
                      ),
                    ),
                    kWidth,
                    CustomTextWidget(
                      text: "₹${selectedProductDetails['category'][value]['offerPrice']}",
                      fontSize: 14,
                      fontweight: FontWeight.w400,
                    ),
                    kWidth,
                    CustomTextWidget(
                      text:
                          "${(double.parse(selectedProductDetails['category'][value]['offerPrice']) * 100 / double.parse(selectedProductDetails['category'][value]['originalPrice'])).toStringAsFixed(2)}%",
                      fontColor: Color(0xFFFE735C),
                      fontSize: 14,
                      fontweight: FontWeight.w400,
                    ),
                  ],
                );
              }),
          kHeight,
          CustomTextWidget(
            text: "Product Details",
            fontSize: 15,
            fontweight: FontWeight.w500,
          ),

          ValueListenableBuilder(
            valueListenable: readMoreClickNotifier,
            builder: (context, value, _) {
              return Wrap(
                children: [
                  ValueListenableBuilder(
                      valueListenable: sizeSelectNotifier,
                      builder: (context, value, _) {
                        return Text(
                          selectedProductDetails['category'][value]['description'],
                          maxLines: readMoreClickNotifier.value ? 10 : 5,
                          overflow: TextOverflow.ellipsis,
                        );
                      }),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(6),
                    child: GestureDetector(
                      child: Text(
                        readMoreClickNotifier.value ? "Less" : "More",
                        style: TextStyle(
                          color: Color(0xFFFE735C),
                        ),
                      ),
                      onTap: () {
                        readMoreClickNotifier.value = !(readMoreClickNotifier.value);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          ValueListenableBuilder(
              valueListenable: sizeSelectNotifier,
              builder: (context, value, _) {
                bool stock = selectedProductDetails['category'][value]['haveStock'];
                if (stock != null && stock == false) {
                  return Center(
                    child: Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red, // Set the border color
                          width: 1, // Set the border width
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: CustomTextWidget(
                          text: "Out of stock",
                          fontColor: Colors.red,
                        ),
                      ),
                    ),
                  );
                } else
                  return SizedBox();
              }),
          kHeight,
          const Row(
            children: [
              CustomTextIconButton(
                icon: Icons.location_on_outlined,
                label: "Nearest Store",
                textAndIconColor: Color(0xFF828282),
                textAndIconSize: 12,
              ),
              kWidth,
              CustomTextIconButton(
                icon: Icons.lock_outline_sharp,
                label: "VIP",
                textAndIconColor: Color(0xFF828282),
                textAndIconSize: 12,
              ),
              kWidth,
              CustomTextIconButton(
                icon: Icons.lock_outline_sharp,
                label: "Return Policy",
                textAndIconColor: Color(0xFF828282),
                textAndIconSize: 12,
              ),
            ],
          )
        ],
      ),
    );
  }
}
