import 'package:flutter/material.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/presentation/widgets/custom_star_rating_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class ProductsListItemTile extends StatelessWidget {
  const ProductsListItemTile({
    super.key,
    required this.imageList,
    required this.heading,
    this.description = "",
    required this.price,
    this.originalPrice = "",
    this.offerPercentage = "",
    this.numberOfRatings = "",
  });
  final List<String> imageList;
  final String heading;
  final String description;
  final String price;
  final String originalPrice;
  final String offerPercentage;
  final String numberOfRatings;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.4,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: screenSize.width * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageList[0]),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: heading,
                      fontSize: 12,
                      fontweight: FontWeight.w500,
                    ),
                    SizedBox(height: 5),
                    CustomTextWidget(
                      text: description,
                      fontSize: 10,
                      fontweight: FontWeight.w400,
                    ),
                    CustomTextWidget(
                      text: price,
                      fontSize: 12,
                      fontweight: FontWeight.w500,
                    ),
                    Row(
                      children: [
                        Text(
                          originalPrice,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            color: Color(0xFF808488),
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Color(0xFF808488),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomTextWidget(
                          text: offerPercentage,
                          fontColor: Color(0xFFFE735C),
                          fontSize: 10,
                          fontweight: FontWeight.w400,
                        )
                      ],
                    ),
                    CustomStarRatingTile(
                      numberOfRatings: numberOfRatings,
                      iconAndTextSize: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
