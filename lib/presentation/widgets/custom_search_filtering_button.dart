import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class CustomSearchFilteringButton extends StatelessWidget {
  const CustomSearchFilteringButton({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 24,
        width: 61,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Row(
          children: [
            CustomTextWidget(
              text: label,
              fontSize: 12,
              fontweight: FontWeight.w400,
            ),
            Icon(
              icon,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
